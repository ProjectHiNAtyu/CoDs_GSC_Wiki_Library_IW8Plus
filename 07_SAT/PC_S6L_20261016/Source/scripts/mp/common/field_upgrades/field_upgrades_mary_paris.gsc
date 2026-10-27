// scripts\mp\common\field_upgrades\field_upgrades_mary_paris.gsc  (hash_2dbbe09cc1906d63.gscc) (size: 13119 Bytes / 0x333f / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x7a5720f0 (2052530416)
// size ...... 13119 (0x333f)
// includes .. 14  (offset: 0x2f2f)
// strings ... 56  (offset: 0x2f9f)
// dev strs .. 5   (offset: 0x3303)
// exports ... 19  (offset: 0x2043)
// cseg ...... 0x4a1 + 0x1ba2 (0x2043)
// imports ... 95  (offset: 0x233b)
// animtree1 . 0   (offset: 0x333f)
// animtree2 . 0   (offset: 0x333f)
#using script_16ea1b94f0f381b3;
#using scripts\common\ai\aitypes\shared\zombie\zombie_attractor_manager;
#using scripts\common\ai\aitypes\shared\zombie\zombie_knockdown;
#using scripts\common\ai\aitypes\shared\zombie\zombie_stun;
#using scripts\common\ai\aitypes\shared\zombie\zombie_utils;
#using scripts\common\callbacks;
#using scripts\common\devgui;
#using scripts\common\system;
#using scripts\common\trace;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\common\vehicle;
#using scripts\mp\common\field_upgrades\field_upgrades;
#using scripts\mp\supers;

#namespace field_upgrades_mary_paris;

// Namespace field_upgrades_mary_paris
// Params 0, eflags: 0x5
// Checksum 0x59c64b03, Offset: 0x4bf
// Size: 0x19
function private autoexec __init__system__()
{
    system::register( #"mary_paris", undefined, undefined, &init );
}

// Namespace field_upgrades_mary_paris
// Params 0
// Checksum 0x2686d9a6, Offset: 0x4e0
// Size: 0x14b
function init()
{
    superbundle = field_upgrades::function_1fcc83f10e7752e5( "super_mary_paris" );
    
    if ( !isdefined( superbundle ) )
    {
        return;
    }
    
    level._effect[ "mary_paris_amb" ] = loadfxasset( "vfx_t10_zm_mister_peeks_body_amb" );
    level._effect[ "mary_paris_spawn" ] = loadfxasset( "vfx_t10_zm_mister_peeks_spawn" );
    level._effect[ "mary_paris_disappear" ] = loadfxasset( "vfx_t10_zm_mister_peeks_disappear" );
    level._effect[ "mary_paris_attack_trail" ] = loadfxasset( "vfx_t10_zm_mister_peeks_moving_trail" );
    level._effect[ "mary_paris_spawn_trail" ] = loadfxasset( "vfx_t10_zm_mister_peeks_spawn_trail" );
    level._effect[ "mary_paris_impact" ] = loadfxasset( "vfx_t10_zm_mister_peeks_hit_impact" );
    utility::flag_wait( "supers_initialized" );
    supers_mp::function_48aaa60b2ce7b8a1( "super_mary_paris", &set_mary_paris, &unset_mary_paris, &begin_use_mary_paris, &function_cfdb71427e89ce4f, undefined, &set_mary_paris );
    callback::add( #"hash_9741c7ee14b21924", &remove_player_fx );
    callback::add( #"player_laststand_revived", &on_revived );
    
    /#
        devgui::function_9082edeb5db93280( "<dev string:x24>" );
        devgui::add_devgui_command( "<dev string:x3a>", "<dev string:x4a>" );
        devgui::add_devgui_command( "<dev string:x76>", "<dev string:x89>" );
        devgui::function_77df7fe7dd273e10();
    #/
}

// Namespace field_upgrades_mary_paris
// Params 0
// Checksum 0xb05eb3c2, Offset: 0x633
// Size: 0x2
function set_mary_paris()
{
    
}

// Namespace field_upgrades_mary_paris
// Params 0
// Checksum 0xca66674a, Offset: 0x63d
// Size: 0x36
function unset_mary_paris()
{
    if ( isdefined( self.var_87e9b1896b9a4e5f ) )
    {
        self.super.staticdata.usetime = self.var_87e9b1896b9a4e5f;
    }
}

// Namespace field_upgrades_mary_paris
// Params 0
// Checksum 0xf8ab6671, Offset: 0x67b
// Size: 0x90, Type: bool
function begin_use_mary_paris()
{
    if ( isdefined( level.field_upgrade_bundles[ "super_mary_paris" ] ) )
    {
        var_266493faa440f098 = level.field_upgrade_bundles[ "super_mary_paris" ].offhandweapon;
        deploysuccess = field_upgrades::field_upgrade_play_gesture( var_266493faa440f098, "super_mary_paris" );
        
        if ( deploysuccess )
        {
            currentweapon = self getcurrentweapon();
            
            if ( !currentweapon.isdualwield )
            {
                utility::function_7c10ea82c1e305b8( "wand_fx", "wand_on_mp" );
            }
            
            thread run_mary_paris();
            return true;
        }
    }
    
    return false;
}

// Namespace field_upgrades_mary_paris
// Params 2
// Checksum 0xebf248ce, Offset: 0x714
// Size: 0x16, Type: bool
function function_cfdb71427e89ce4f( fromdeath, attacker )
{
    return false;
}

// Namespace field_upgrades_mary_paris
// Params 1
// Checksum 0x5e4ddf34, Offset: 0x733
// Size: 0xba
function function_dfea4dcb9882c788( finalpos )
{
    if ( utility::issharedfuncdefined( #"zombie", #"hash_bad01cbc996e3dba" ) )
    {
        if ( !utility::callsharedfunc( #"zombie", #"hash_bad01cbc996e3dba", finalpos ) )
        {
            forward = anglestoforward( self.angles );
            forward = vectornormalize( forward );
            forward *= 128;
            droppos = self.origin - forward;
            finalpos = getclosestpointonnavmesh( droppos );
        }
        
        if ( !utility::callsharedfunc( #"zombie", #"hash_bad01cbc996e3dba", finalpos ) )
        {
            finalpos = getclosestpointonnavmesh( self.origin );
        }
    }
    
    return finalpos;
}

// Namespace field_upgrades_mary_paris
// Params 0
// Checksum 0x58154134, Offset: 0x7f6
// Size: 0x70a
function run_mary_paris()
{
    if ( !isplayer( self ) || !isalive( self ) )
    {
        return;
    }
    
    if ( isdefined( self.mary_paris_mdl ) )
    {
        var_3bfc1a88b1fd428a = ( self.mary_paris_mdl.origin[ 0 ], self.mary_paris_mdl.origin[ 1 ], self.mary_paris_mdl.origin[ 2 ] + 4 );
        self.mary_paris_mdl thread delete_bunny( var_3bfc1a88b1fd428a );
    }
    
    forward = anglestoforward( self.angles );
    forward = vectornormalize( forward );
    forward *= 128;
    bunnyangles = ( self.angles[ 0 ], self.angles[ 1 ] + 180, self.angles[ 2 ] );
    droppos = self.origin + forward;
    return_ent = utility::spawn_model( %"tag_origin", droppos, bunnyangles );
    movingplatforminfo = return_ent utility::function_7c45b71b8e0d3cff();
    
    if ( isdefined( movingplatforminfo ) && isdefined( movingplatforminfo.groundent ) && isdefined( movingplatforminfo.localorigin ) && isdefined( movingplatforminfo.localangles ) && !movingplatforminfo.groundent vehicle::is_vehicle() )
    {
        return_ent linkto( movingplatforminfo.groundent );
    }
    else
    {
        return_ent delete();
    }
    
    finalpoint = getclosestpointonnavmesh( droppos );
    finalpoint = function_dfea4dcb9882c788( finalpoint );
    startpos = ( finalpoint[ 0 ], finalpoint[ 1 ], finalpoint[ 2 ] + 256 );
    var_9348ab4b28e58ab8 = 0;
    tracecontents = trace::create_contents( 0, 1, 1, 1, 1, 1, 1, 0, 1, 0, 1 );
    traceresults = trace::ray_trace( finalpoint, startpos, level.players, tracecontents );
    
    if ( traceresults[ "fraction" ] < 1 )
    {
        startpos = traceresults[ "position" ] + ( 0, 0, -32 );
        var_9348ab4b28e58ab8 = 1;
    }
    
    if ( var_9348ab4b28e58ab8 )
    {
        var_33bc801eccfa2774 = distancesquared( startpos, finalpoint );
    }
    
    mary_paris_mdl = function_91822968828d3804( startpos, bunnyangles );
    mary_paris_mdl.var_c256a5dce9297dce = 1;
    
    if ( isdefined( return_ent ) )
    {
        mary_paris_mdl.returnent = return_ent;
    }
    
    if ( utility::callsharedfunc( #"zombie", #"player_has_augment", #"mary_paris_party_animal" ) )
    {
        self playsoundtoplayer( "eqp_fug_mus_mary_paris_dance_mix_17s", self, mary_paris_mdl );
    }
    else
    {
        self playsoundtoplayer( "eqp_fug_mus_mary_paris_dance_mix", self, mary_paris_mdl );
    }
    
    if ( isdefined( level._effect[ "mary_paris_spawn_trail" ] ) )
    {
        var_d8463c532dddccad = playfxontag( utility::getfx( "mary_paris_spawn_trail" ), mary_paris_mdl, "tag_origin" );
    }
    
    mary_paris_mdl motionwarpcancel();
    var_33bc801eccfa2774 = 65536;
    droptime = var_33bc801eccfa2774 / 360000;
    droptime *= droptime;
    droptime = clamp( droptime, 0.2, 2 );
    var_15ec1da330890eb8 = droptime + 0.15;
    mary_paris_mdl moveto( finalpoint, droptime, 0.2 );
    wait var_15ec1da330890eb8;
    
    if ( isdefined( mary_paris_mdl.returnent ) )
    {
        mary_paris_mdl.origin = mary_paris_mdl.returnent.origin;
        mary_paris_mdl.angles = bunnyangles;
        mary_paris_mdl linkto( mary_paris_mdl.returnent, "tag_origin", ( 0, 0, 4 ), ( 0, 0, 0 ) );
    }
    
    if ( isdefined( var_d8463c532dddccad ) )
    {
        stopfxontag( var_d8463c532dddccad, mary_paris_mdl, "tag_origin" );
    }
    
    if ( isdefined( level._effect[ "mary_paris_spawn" ] ) )
    {
        playfx( level._effect[ "mary_paris_spawn" ], mary_paris_mdl.origin );
    }
    
    if ( isdefined( level._effect[ "mary_paris_blast" ] ) )
    {
        playfx( utility::getfx( "mary_paris_blast" ), mary_paris_mdl.origin );
    }
    
    var_82e6ab94f6c4a3f3 = istrue( utility::callsharedfunc( #"zombie", #"player_has_augment", #"mary_paris_dance_party" ) );
    
    if ( !var_82e6ab94f6c4a3f3 )
    {
        nearbyenemies = getaiarrayinradius( mary_paris_mdl.origin, 256 );
        
        if ( utility::issharedfuncdefined( #"zm", #"hash_275603844e04e7ac" ) )
        {
            nearbyenemies = level [[ utility::getsharedfunc( #"zm", #"hash_275603844e04e7ac" ) ]]( nearbyenemies, self );
        }
        
        foreach ( zombie in nearbyenemies )
        {
            if ( isdefined( zombie.team ) && zombie.team != self.team )
            {
                if ( zombie.aicategory == "normal" )
                {
                    zombie zombie_knockdown::function_6fc167d4a3590991( mary_paris_mdl.origin );
                    continue;
                }
                
                if ( zombie.aicategory == "special" )
                {
                    zombie zombie_stun::stun_ai( 2 );
                }
            }
        }
    }
    
    if ( isdefined( level._effect[ "mary_paris_amb" ] ) )
    {
        playfxontag( utility::getfx( "mary_paris_amb" ), mary_paris_mdl, "tag_origin" );
    }
    
    nearbyplayers = getplayersinradius( finalpoint, 512 );
    
    foreach ( player in nearbyplayers )
    {
        player earthquakeforplayer( 0.5, 0.75, finalpoint, 512 );
    }
    
    if ( !var_82e6ab94f6c4a3f3 )
    {
        wait 1;
    }
    
    sparams = spawnstruct();
    sparams.misterpeeks = mary_paris_mdl;
    callback::callback( "mary_paris_started", sparams );
    
    if ( self.fn_mary_paris_started )
    {
        self [[ self.fn_mary_paris_started ]]( mary_paris_mdl );
        
        if ( !self || self.sessionstate != "playing" )
        {
            if ( mary_paris_mdl )
            {
                mary_paris_mdl delete();
            }
            
            return;
        }
    }
    
    if ( utility::callsharedfunc( #"zombie", #"player_has_augment", #"mary_paris_dance_party" ) )
    {
        callback::callback( "dance_party_started", sparams );
        mary_paris_mdl thread function_e6a660bd7743fd4c( self );
        return;
    }
    
    mary_paris_mdl thread function_c381382681688be1( self );
}

// Namespace field_upgrades_mary_paris
// Params 1
// Checksum 0x4c1691d4, Offset: 0xf08
// Size: 0x128
function function_e6a660bd7743fd4c( player )
{
    self endon( #"death" );
    self.originalpos = self.origin;
    self.originalangles = self.angles;
    duration = field_upgrades::function_5f728868b18ef0c0( "super_mary_paris", #"hash_201bcdd4eba63761" ) ?? 10;
    
    if ( player utility::callsharedfunc( #"zombie", #"player_has_augment", #"mary_paris_party_animal" ) )
    {
        duration += level.zombie_augments[ #"mary_paris_party_animal" ].var_444f194b8666c901 ?? 5;
    }
    
    thread function_15955a244d0d7f8c( player );
    wait duration;
    sparams = spawnstruct();
    sparams.misterpeeks = self;
    player callback::callback( "mary_paris_end", sparams );
    player remove_player_fx();
    var_3bfc1a88b1fd428a = ( self.origin[ 0 ], self.origin[ 1 ], self.origin[ 2 ] + 4 );
    delete_bunny( var_3bfc1a88b1fd428a );
}

// Namespace field_upgrades_mary_paris
// Params 2
// Checksum 0xe4fa8010, Offset: 0x1038
// Size: 0x52, Type: bool
function function_3d230fffdb166053( attractor, ai )
{
    return isdefined( ai ) && ( ai.aicategory == "normal" || ai.aicategory == "special" ) && !ai.var_840153567385cc6b;
}

// Namespace field_upgrades_mary_paris
// Params 1
// Checksum 0x6415114f, Offset: 0x1093
// Size: 0x108
function function_15955a244d0d7f8c( player )
{
    self endon( #"death" );
    attraction_range = field_upgrades::function_5f728868b18ef0c0( "super_mary_paris", #"hash_135fb4c9874b80b7" ) ?? 512;
    
    if ( player utility::callsharedfunc( #"zombie", #"player_has_augment", #"mary_paris_social_butterfly" ) )
    {
        attraction_range += attraction_range * ( level.zombie_augments[ #"mary_paris_social_butterfly" ].var_e25ca8b26eaae360 ?? 0.5 );
    }
    
    self.bunny_attractor = zombie_attractor_manager::add_attractor( self, 1, attraction_range, 0, undefined, &function_3d230fffdb166053, 0, undefined, 1 );
    self.bunny_attractor.var_9bc09bc79f28a18e = 1;
    attraction_duration = field_upgrades::function_5f728868b18ef0c0( "super_mary_paris", #"hash_3fdab064ed5a0836" ) ?? 5;
    wait attraction_duration;
    
    if ( isdefined( self.bunny_attractor ) )
    {
        zombie_attractor_manager::remove_attractor( self.bunny_attractor );
    }
}

// Namespace field_upgrades_mary_paris
// Params 1
// Checksum 0x6ef2a65, Offset: 0x11a3
// Size: 0x376
function function_c381382681688be1( player )
{
    self endon( #"death" );
    self.originalpos = self.origin;
    self.originalangles = self.angles;
    duration = field_upgrades::function_5f728868b18ef0c0( "super_mary_paris", #"hash_201bcdd4eba63761" ) ?? 10;
    
    if ( player utility::callsharedfunc( #"zombie", #"player_has_augment", #"mary_paris_party_animal" ) )
    {
        duration += level.zombie_augments[ #"mary_paris_party_animal" ].var_444f194b8666c901 ?? 5;
    }
    
    var_a7c29cfa649167e0 = field_upgrades::function_5f728868b18ef0c0( "super_mary_paris", #"hash_30529658626346f6" ) ?? 256;
    var_8d2325a3c1b80415 = field_upgrades::function_5f728868b18ef0c0( "super_mary_paris", #"hash_fac5194509c03945" ) ?? 2;
    round_difficulty = namespace_9d8e359c3b1041e5::function_57de0ca2e80536a1( self.origin );
    zombie_base_health = namespace_9d8e359c3b1041e5::function_870440d8340968c0( "zombie_base", round_difficulty );
    damage = var_8d2325a3c1b80415 * zombie_base_health;
    duration *= 1000;
    start_time = gettime();
    total_time = start_time;
    self.mary_paris_start_time = start_time;
    thread function_15955a244d0d7f8c( player );
    var_9a6d2d9abe4788c3 = 0;
    
    while ( total_time - start_time < duration && !level.fake_peeks )
    {
        zombies = getaiarrayinradius( self.origin, var_a7c29cfa649167e0 );
        filterzombies = [];
        
        foreach ( zombie in zombies )
        {
            if ( !zombie zombie_utils::function_bf1464d09f4e4b40() && zombie.aicategory != "boss" && !zombie.b_ignore_mary_paris && player.team != zombie.team )
            {
                filterzombies[ filterzombies.size ] = zombie;
            }
        }
        
        if ( utility::issharedfuncdefined( #"zm", #"hash_275603844e04e7ac" ) )
        {
            filterzombies = level [[ utility::getsharedfunc( #"zm", #"hash_275603844e04e7ac" ) ]]( filterzombies, player );
        }
        
        zombies = filterzombies;
        
        if ( zombies.size > 0 )
        {
            var_9a6d2d9abe4788c3 = bunny_attack( zombies, damage, player, duration );
        }
        else
        {
            var_9a6d2d9abe4788c3 = 0;
        }
        
        if ( !var_9a6d2d9abe4788c3 )
        {
            wait 0.2;
        }
        
        total_time = gettime();
    }
    
    sparams = spawnstruct();
    sparams.misterpeeks = self;
    player callback::callback( "mary_paris_end", sparams );
    player callback::callback( "field_upgrade_ended", { #ref:"super_mary_paris" } );
    wait 1;
    self.isleaving = 1;
    player remove_player_fx();
    var_3bfc1a88b1fd428a = ( self.origin[ 0 ], self.origin[ 1 ], self.origin[ 2 ] + 4 );
    delete_bunny( var_3bfc1a88b1fd428a );
}

// Namespace field_upgrades_mary_paris
// Params 1, eflags: 0x4
// Checksum 0x9dde3287, Offset: 0x1521
// Size: 0xc
function private remove_player_fx( sparams )
{
    
}

// Namespace field_upgrades_mary_paris
// Params 1, eflags: 0x4
// Checksum 0xceb9d618, Offset: 0x1535
// Size: 0xc
function private on_revived( sparams )
{
    
}

// Namespace field_upgrades_mary_paris
// Params 1, eflags: 0x4
// Checksum 0xe3284ac6, Offset: 0x1549
// Size: 0xef
function private delete_bunny( pos )
{
    self endon( #"death" );
    
    if ( isdefined( self.bunny_attractor ) )
    {
        zombie_attractor_manager::remove_attractor( self.bunny_attractor );
    }
    
    if ( utility::cointoss() )
    {
        utility::function_7c10ea82c1e305b8( "animation", "leaving1" );
    }
    else
    {
        utility::function_7c10ea82c1e305b8( "animation", "leaving2" );
    }
    
    timeout = 5000;
    state = self getscriptablepartstate( "animation" );
    lasttime = gettime();
    timenow = gettime();
    
    while ( state != "off" || timenow - lasttime > timeout )
    {
        timenow = gettime();
        state = self getscriptablepartstate( "animation" );
        waitframe();
    }
    
    if ( isdefined( self.returnent ) )
    {
        self.returnent delete();
    }
    
    self delete();
}

// Namespace field_upgrades_mary_paris
// Params 1, eflags: 0x4
// Checksum 0xc0744739, Offset: 0x1640
// Size: 0x102
function private function_94c296a9bc53ce5f( zombies )
{
    specialzombies = [];
    elitezombies = [];
    
    foreach ( zombie in zombies )
    {
        if ( isalive( zombie ) )
        {
            if ( zombie.aicategory == "special" )
            {
                specialzombies[ specialzombies.size ] = zombie;
            }
            
            if ( zombie.aicategory == "elite" || zombie.aicategory == "hvt" )
            {
                elitezombies[ elitezombies.size ] = zombie;
            }
        }
    }
    
    if ( elitezombies.size > 0 )
    {
        zombies = elitezombies;
    }
    
    if ( elitezombies.size == 0 && specialzombies.size > 0 )
    {
        zombies = specialzombies;
    }
    
    return zombies;
}

// Namespace field_upgrades_mary_paris
// Params 4, eflags: 0x4
// Checksum 0xcbc5d950, Offset: 0x174b
// Size: 0x86c
function private bunny_attack( zombies, damage, player, duration = 0 )
{
    self endon( #"death" );
    var_a7c29cfa649167e0 = field_upgrades::function_5f728868b18ef0c0( "super_mary_paris", #"hash_30529658626346f6" ) ?? 256;
    var_578d71b7c00fc4ba = field_upgrades::function_5f728868b18ef0c0( "super_mary_paris", #"hash_834ffbc68a482dca" ) ?? 125;
    var_9a6d2d9abe4788c3 = 0;
    currentstate = self getscriptablepartstate( "animation" );
    var_266493faa440f098 = level.field_upgrade_bundles[ "super_mary_paris" ].offhandweapon;
    
    if ( isdefined( level.weaponmetadata[ %"mary_paris" ] ) )
    {
        if ( !isdefined( level.weaponmetadata[ %"mary_paris" ].weaponobj ) )
        {
            var_266493faa440f098 = makeweapon( level.weaponmetadata[ %"mary_paris" ].weapon );
            level.weaponmetadata[ %"mary_paris" ].weaponobj = var_266493faa440f098;
        }
        else
        {
            var_266493faa440f098 = level.weaponmetadata[ %"mary_paris" ].weaponobj;
        }
    }
    
    if ( isdefined( self.returnent ) )
    {
        self unlink();
    }
    
    if ( currentstate != "attack" )
    {
        utility::function_7c10ea82c1e305b8( "animation", "idle_to_attack" );
    }
    
    if ( isarray( zombies ) )
    {
        if ( player utility::callsharedfunc( #"zombie", #"player_has_augment", #"mary_paris_apex_hunter" ) )
        {
            var_8d2325a3c1b80415 = level.zombie_augments[ #"mary_paris_apex_hunter" ].var_65626b99be82d688 ?? 3;
            zombies = function_94c296a9bc53ce5f( zombies );
            round_difficulty = namespace_9d8e359c3b1041e5::function_57de0ca2e80536a1( self.origin );
            zombie_base_health = namespace_9d8e359c3b1041e5::function_870440d8340968c0( "zombie_base", round_difficulty );
            damage = var_8d2325a3c1b80415 * zombie_base_health;
        }
        
        var_375c3e35770652f = 0;
        
        foreach ( zombie in zombies )
        {
            self setscriptablepartstate( "particle", "attack" );
            targetpos = zombie.origin;
            
            if ( zombie tagexists( "head" ) )
            {
                targetpos = zombie gettagorigin( "head" );
            }
            else
            {
                targetpos = zombie getcentroid();
            }
            
            var_929d0623891294a1 = distance2dsquared( targetpos, self.origin );
            attacktime = var_929d0623891294a1 / 360000;
            attacktime *= attacktime;
            attacktime = clamp( attacktime, 0.2, 2 );
            var_9f11e6ceea53353d = attacktime + 0.15;
            launchorigin = self.origin;
            rotatetoangle = vectortoangles( targetpos - self.origin );
            rotatetoangle = ( rotatetoangle[ 0 ] + 45, rotatetoangle[ 1 ], rotatetoangle[ 2 ] );
            playsoundatpos( self.origin, "eqp_fug_mary_paris_mrpeeks_dash" );
            self rotateto( rotatetoangle, 0.3, 0.1 );
            
            if ( isdefined( self.returnent ) )
            {
                self moveto( targetpos, attacktime / 2, 0.05 );
                
                if ( isalive( zombie ) )
                {
                    targetpos = zombie.origin;
                    
                    if ( zombie tagexists( "head" ) )
                    {
                        targetpos = zombie gettagorigin( "head" );
                    }
                    else
                    {
                        targetpos = zombie getcentroid();
                    }
                }
                
                self moveto( targetpos, attacktime / 2, 0 );
            }
            else
            {
                self moveto( targetpos, attacktime, 0.2 );
            }
            
            wait var_9f11e6ceea53353d;
            params = { #zombie:zombie };
            player callback::callback( "mary_paris_attack_hit", params );
            utility::function_7c10ea82c1e305b8( "sound", "attack" );
            
            if ( damage < var_578d71b7c00fc4ba )
            {
                damage = var_578d71b7c00fc4ba;
            }
            
            if ( damage >= zombie.health && !isplayer( zombie ) )
            {
                zombie utility::ent_flag_init( "mary_paris_kill" );
                zombie utility::ent_flag_set( "mary_paris_kill" );
                zombie val::set( "insta_kill", "kill_on_damage", 1 );
                zombie val::set( "zm_allow_give_super_point", "allow_give_super_point", 0 );
            }
            
            zombie dodamage( damage, self.origin, player, self, "MOD_UNKNOWN", var_266493faa440f098, "none", undefined, 1610678272 );
            
            if ( !isalive( zombie ) && !zombie.var_33df89471a965163 )
            {
                zombie.var_33df89471a965163 = 1;
                v_dir = zombie.origin - launchorigin;
                v_dir = vectornormalize( v_dir );
                var_24ed309d808c077a = zombie getcorpseentity();
                
                if ( var_375c3e35770652f < 5 )
                {
                    if ( isdefined( var_24ed309d808c077a ) )
                    {
                        launchx = clamp( v_dir[ 0 ] * 5000, -5000, 5000 );
                        launchy = clamp( v_dir[ 1 ] * 5000, -5000, 5000 );
                        launchz = clamp( ( v_dir[ 2 ] + 150 ) * 5000, 0, 5000 );
                        v_launch = ( launchx, launchy, launchz );
                        var_24ed309d808c077a startragdollfromimpact( "torso_lower", v_launch );
                        var_375c3e35770652f++;
                    }
                }
            }
            
            if ( isdefined( level._effect[ "mary_paris_impact" ] ) )
            {
                playfx( utility::getfx( "mary_paris_impact" ), targetpos );
                playsoundatpos( targetpos, "eqp_fug_mary_paris_mrpeeks_attack" );
            }
            
            wait 0.15;
            
            if ( gettime() - self.mary_paris_start_time >= duration )
            {
                break;
            }
        }
        
        if ( isdefined( self.returnent ) )
        {
            return_pos = self.returnent.origin;
        }
        else
        {
            return_pos = self.originalpos;
        }
        
        if ( zombies.size == 1 && isalive( zombies[ 0 ] ) && isdefined( zombies[ 0 ].origin ) )
        {
            var_da240dd623954f38 = getaiarrayinradius( self.originalpos, var_a7c29cfa649167e0 );
            
            if ( utility::issharedfuncdefined( #"zm", #"hash_275603844e04e7ac" ) )
            {
                var_da240dd623954f38 = level [[ utility::getsharedfunc( #"zm", #"hash_275603844e04e7ac" ) ]]( var_da240dd623954f38, player );
            }
            
            if ( player utility::callsharedfunc( #"zombie", #"player_has_augment", #"mary_paris_apex_hunter" ) )
            {
                var_da240dd623954f38 = function_94c296a9bc53ce5f( var_da240dd623954f38 );
            }
            
            if ( var_da240dd623954f38.size == 1 && !var_da240dd623954f38[ 0 ] zombie_utils::function_bf1464d09f4e4b40() )
            {
                return_pos = utility::function_8ae0ea62537eafc5( targetpos, 64 );
                return_pos = ( return_pos[ 0 ], return_pos[ 1 ], targetpos[ 2 ] );
                var_9a6d2d9abe4788c3 = 1;
            }
            else
            {
                var_9a6d2d9abe4788c3 = 0;
            }
        }
        
        self notify( #"end_spin" );
        attacktime = var_929d0623891294a1 / 360000;
        attacktime *= attacktime;
        attacktime = clamp( attacktime, 0.2, 2 );
        var_9f11e6ceea53353d = attacktime + 0.15;
        playsoundatpos( self.origin, "eqp_fug_mary_paris_mrpeeks_dash" );
        
        if ( isdefined( self.returnent ) )
        {
            self moveto( return_pos, attacktime / 2, 0.05 );
            return_pos = self.returnent.origin;
            self moveto( return_pos, attacktime / 2, 0 );
        }
        else
        {
            self moveto( return_pos, attacktime, 0.2 );
        }
        
        wait var_9f11e6ceea53353d;
        
        if ( isdefined( self.returnent ) )
        {
            self.origin = self.returnent.origin;
            self linkto( self.returnent, "tag_origin", ( 0, 0, 4 ), ( 0, 0, 0 ) );
        }
        
        utility::function_7c10ea82c1e305b8( "particle", "off" );
        utility::function_7c10ea82c1e305b8( "animation", "attack_to_idle" );
        self notify( #"attack_finished" );
        waitframe();
        self.angles = self.originalangles;
    }
    
    return var_9a6d2d9abe4788c3;
}

// Namespace field_upgrades_mary_paris
// Params 2, eflags: 0x4
// Checksum 0x9c73f87a, Offset: 0x1fc0
// Size: 0x82
function private function_91822968828d3804( origin, angles )
{
    self.mary_paris_mdl = utility::spawn_model( %"t10_zm_mystery_box_plinth_bunny_fxanim_super", origin, angles );
    self.mary_paris_mdl.owner = self;
    self.mary_paris_mdl utility::function_7c10ea82c1e305b8( "animation", "idle" );
    self.mary_paris_mdl utility::function_7c10ea82c1e305b8( "sound", "activate" );
    return self.mary_paris_mdl;
}

