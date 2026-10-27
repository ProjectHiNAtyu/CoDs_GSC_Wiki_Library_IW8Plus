// scripts\mp\common\killstreaks\combat_bow.gsc  (hash_130e4c0385bce7cd.gscc) (size: 11370 Bytes / 0x2c6a / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xde67f0d4 (3731353812)
// size ...... 11370 (0x2c6a)
// includes .. 9   (offset: 0x2b3e)
// strings ... 13  (offset: 0x2b86)
// dev strs .. 3   (offset: 0x2c42)
// exports ... 34  (offset: 0x1b3a)
// cseg ...... 0x137 + 0x1a03 (0x1b3a)
// imports ... 94  (offset: 0x208a)
// animtree1 . 0   (offset: 0x2c6a)
// animtree2 . 0   (offset: 0x2c6a)
#using script_16ea1b94f0f381b3;
#using scripts\common\bots\bots_util;
#using scripts\common\damage_effects;
#using scripts\common\killstreaks\killstreak_shared;
#using scripts\common\trace;
#using scripts\common\utility;
#using scripts\common\vehicle;
#using scripts\mp\common\killstreaks\killstreaks;
#using scripts\mp\common\utility\player;

#namespace combat_bow;

// Namespace combat_bow
// Params 0, eflags: 0x1
// Checksum 0x31ef804d, Offset: 0x155
// Size: 0x17
function autoexec main()
{
    killstreak_shared::registerkillstreakinitfunction( #"combat_bow", &init );
}

// Namespace combat_bow
// Params 0
// Checksum 0xfcea21e1, Offset: 0x174
// Size: 0x2a7
function init()
{
    weaponname = utility::get_scripted_weapon_name( #"combat_bow" );
    
    if ( !weaponname )
    {
        return;
    }
    
    killstreaks::registerkillstreak( "combat_bow", &function_206a9486e227868f, &onavailable, undefined, &onend );
    killstreaks::registerkillstreakstowableweapon( "combat_bow", weaponname, undefined, "launcherWeapon" );
    killstreaks::registerkillstreakdamagedealingweapon( "combat_bow", weaponname, #"low" );
    var_b3d3f83b5d5388ae = level.streakglobals.streakbundles[ "combat_bow" ];
    level.var_efe04b415d20bbee = { #tuning:{}, #var_f67a2b31caecb3d:[] };
    level.var_efe04b415d20bbee.tuning.var_cbd4e751b0123b66 = var_b3d3f83b5d5388ae.var_cbd4e751b0123b66 ?? 35;
    level.var_efe04b415d20bbee.tuning.var_642ea3a57a1ff511 = var_b3d3f83b5d5388ae.var_642ea3a57a1ff511 ?? 100;
    level.var_efe04b415d20bbee.tuning.var_1694297001896a09 = var_b3d3f83b5d5388ae.var_1694297001896a09 ?? 10;
    level.var_efe04b415d20bbee.tuning.var_a9f8b1dc4524262[ 0 ] = var_b3d3f83b5d5388ae.var_a9fc91dc452cabc ?? 1;
    level.var_efe04b415d20bbee.tuning.var_a9f8b1dc4524262[ 1 ] = var_b3d3f83b5d5388ae.var_a9fcc1dc452d155 ?? 2;
    level.var_efe04b415d20bbee.tuning.var_a9f8b1dc4524262[ 2 ] = var_b3d3f83b5d5388ae.var_a9fcb1dc452cf22 ?? 3;
    level.var_efe04b415d20bbee.tuning.var_b987c0fbc8e0b7ce[ 0 ] = var_b3d3f83b5d5388ae.var_5598dc0a616d2921 ?? 250;
    level.var_efe04b415d20bbee.tuning.var_b987c0fbc8e0b7ce[ 1 ] = var_b3d3f83b5d5388ae.var_5598d90a616d2288 ?? 500;
    level.var_efe04b415d20bbee.tuning.var_b987c0fbc8e0b7ce[ 2 ] = var_b3d3f83b5d5388ae.var_5598da0a616d24bb ?? 500;
    level.var_efe04b415d20bbee.tuning.var_396a8dae53778878 = trace::create_contents( 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0 );
    utility::flag_set( "combat_bow_initialized" );
}

// Namespace combat_bow
// Params 1
// Checksum 0xedec3d72, Offset: 0x423
// Size: 0x17c
function function_206a9486e227868f( streakinfo )
{
    self.streakname = "combat_bow";
    streakinfo.streakname = "combat_bow";
    weaponname = utility::get_scripted_weapon_name( #"combat_bow" );
    self.var_ec0bb630fbaa253a[ weaponname ] = streakinfo;
    var_b3d3f83b5d5388ae = level.streakglobals.streakbundles[ "combat_bow" ];
    streakinfo.var_b7f22211336c491a = var_b3d3f83b5d5388ae.var_b7f22211336c491a ?? 0;
    childthread function_1b7cf54b4f161d63( streakinfo );
    childthread watchplayerdeath( streakinfo );
    var_32dbca3143d9c4a5 = level.sharedfuncs[ #"killstreak" ][ #"hash_bace3d7e3e8f0b39" ];
    
    if ( isdefined( var_32dbca3143d9c4a5 ) )
    {
        self [[ var_32dbca3143d9c4a5 ]]( streakinfo );
    }
    
    var_32dbca3143d9c4a5 = level.sharedfuncs[ #"hud" ][ #"teamplayercardsplash" ];
    
    if ( isdefined( var_32dbca3143d9c4a5 ) )
    {
        level [[ var_32dbca3143d9c4a5 ]]( "used_combat_bow", self );
    }
    
    var_32dbca3143d9c4a5 = level.sharedfuncs[ #"killstreak" ][ #"addtoactivekillstreaklist" ];
    
    if ( isdefined( var_32dbca3143d9c4a5 ) )
    {
        self [[ var_32dbca3143d9c4a5 ]]( streakinfo.streakname, "Killstreak_Ground", self );
    }
    
    var_32dbca3143d9c4a5 = level.sharedfuncs[ #"sound" ][ #"playkillstreakdeploydialog" ];
    
    if ( isdefined( var_32dbca3143d9c4a5 ) )
    {
        self [[ var_32dbca3143d9c4a5 ]]( streakinfo.streakname );
    }
}

// Namespace combat_bow
// Params 1
// Checksum 0x4a925b91, Offset: 0x5a7
// Size: 0xc
function onavailable( streakitem )
{
    
}

// Namespace combat_bow
// Params 1
// Checksum 0xd66fa5c1, Offset: 0x5bb
// Size: 0x52
function watchplayerdeath( streakinfo )
{
    self notify( #"hash_95b30c9ba559bc18" );
    self endon( #"hash_95b30c9ba559bc18" );
    self endon( #"combat_bow_complete" );
    self waittill( #"death", attacker );
    thread cleanup( streakinfo );
}

// Namespace combat_bow
// Params 2
// Checksum 0xd1e5f9bd, Offset: 0x615
// Size: 0x1e
function onend( streakitem, streakinfo )
{
    cleanup( streakinfo );
}

// Namespace combat_bow
// Params 1
// Checksum 0xa87dd4cc, Offset: 0x63b
// Size: 0x4d
function cleanup( streakinfo )
{
    self notify( #"streak_end" );
    self notify( #"combat_bow_complete" );
    
    if ( streakinfo && killstreaks::function_86ffe5755d194a83( streakinfo, "t10_ks_compound_mp" ) )
    {
        namespace_9d8e359c3b1041e5::recordkillstreakendstatssharedfunc( streakinfo );
    }
    
    self.streakname = undefined;
}

// Namespace combat_bow
// Params 1, eflags: 0xc
// Checksum 0xa3415b1, Offset: 0x690
// Size: 0x5c
function private function_6e612f9e355a1ab7( streakinfo )
{
    self notify( #"hash_a28b8d45c425823a" );
    self endon( #"hash_a28b8d45c425823a" );
    level endon( #"game_ended" );
    self endon( #"death_or_disconnect" );
    streakinfo waittill( #"killstreak_finished_with_deploy_weapon" );
    wait 3;
    self notify( #"hash_264f5f264b2b4b67" );
}

// Namespace combat_bow
// Params 1, eflags: 0xc
// Checksum 0xabe6ae45, Offset: 0x6f4
// Size: 0x103
function private function_1b7cf54b4f161d63( streakinfo )
{
    self notify( #"hash_74566d9be1a21bee" );
    self endon( #"hash_74566d9be1a21bee" );
    level endon( #"game_ended" );
    self endon( #"death_or_disconnect" );
    self endon( #"hash_c43cf6466bff2ea8" );
    thread function_6e612f9e355a1ab7( streakinfo );
    
    while ( true )
    {
        self waittill( #"bullet_first_impact", impacts );
        
        if ( impacts[ 0 ].weapon != streakinfo.weaponstruct )
        {
            continue;
        }
        
        if ( impacts[ 0 ].hitent.var_aa82c7f64e626133 )
        {
            continue;
        }
        
        function_58265476ec1cf83( impacts[ 0 ].weapon, impacts[ 0 ].hitent, impacts[ 0 ].hitpos, impacts[ 0 ].surfacenormal, impacts[ 0 ].surfacetype, impacts[ 0 ].hitdir );
    }
}

// Namespace combat_bow
// Params 6, eflags: 0x4
// Checksum 0x9e8e4d15, Offset: 0x7ff
// Size: 0x2be
function private function_58265476ec1cf83( weaponobj, hitent, hitpos, surfacenormal, surfacetype, hitdir )
{
    attacker = self;
    stuckto = undefined;
    scriptablename = %"equip_combat_bow_fire_pool_mp";
    
    if ( isplayer( hitent ) || isagent( hitent ) )
    {
        var_4927622b21cb2671 = trace::ray_trace( hitpos, hitpos - ( 0, 0, 130 ), [ hitent ], level.var_efe04b415d20bbee.tuning.var_396a8dae53778878 );
        
        if ( var_4927622b21cb2671[ "fraction" ] >= 1 || !( isdefined( var_4927622b21cb2671[ "position" ] ) && isdefined( var_4927622b21cb2671[ "normal" ] ) ) )
        {
            /#
                if ( getdvarint( @"hash_6c65e774c991df1c", 0 ) )
                {
                    sphere( hitpos, 130, ( 0, 0, 1 ), 0, int( utility::function_4b74c15943231980( 0.25 ) ) );
                }
            #/
            
            return;
        }
        
        surfacenormal = var_4927622b21cb2671[ "normal" ];
        hitpos = var_4927622b21cb2671[ "position" ];
    }
    
    var_3dc0958623ca1749 = function_f349a2383e4a935( surfacenormal, hitdir );
    
    /#
        if ( getdvarint( @"hash_6c65e774c991df1c", 0 ) )
        {
            up = hitpos + anglestoup( var_3dc0958623ca1749 ) * 15;
            forward = hitpos + anglestoforward( var_3dc0958623ca1749 ) * 15;
            right = hitpos + anglestoright( var_3dc0958623ca1749 ) * 15;
            line( hitpos, up, ( 0, 1, 0 ), 1, 0, 500 );
            line( hitpos, forward, ( 1, 0, 0 ), 1, 0, 500 );
            line( hitpos, right, ( 0, 0, 1 ), 1, 0, 500 );
        }
    #/
    
    var_24eb5c865d79d7b0 = vectordot( surfacenormal, ( 0, 0, 1 ) );
    
    if ( var_24eb5c865d79d7b0 <= -0.81915 )
    {
        orientation = #"hash_d9951890fd6d7e88";
    }
    else if ( var_24eb5c865d79d7b0 <= 0.5 )
    {
        orientation = #"wall";
    }
    else
    {
        orientation = #"";
    }
    
    if ( hitent && hitent vehicle::is_vehicle() )
    {
        stuckto = hitent;
    }
    
    firepool = function_2b6a5b4a6d3b1d28( hitpos, var_3dc0958623ca1749, stuckto, attacker, weaponobj, gettime(), scriptablename, orientation );
    level.var_efe04b415d20bbee.var_f67a2b31caecb3d[ level.var_efe04b415d20bbee.var_f67a2b31caecb3d.size ] = firepool;
}

// Namespace combat_bow
// Params 2, eflags: 0x4
// Checksum 0x64ce81e6, Offset: 0xac5
// Size: 0xe9
function private function_f349a2383e4a935( surfacenormal, hitdir )
{
    if ( abs( surfacenormal[ 0 ] ) + abs( surfacenormal[ 1 ] ) + abs( surfacenormal[ 2 ] ) < 0.1 )
    {
        assertmsg( "<dev string:x24>" );
        surfacenormal = ( 0, 0, 1 );
    }
    
    var_195e321e9dc9ec95 = hitdir * -1;
    right = vectorcross( surfacenormal, var_195e321e9dc9ec95 );
    
    if ( lengthsquared( right ) < 0.01 )
    {
        if ( abs( surfacenormal[ 0 ] ) > 0.95 )
        {
            var_195e321e9dc9ec95 += ( 0, 0.25, 0 );
        }
        else
        {
            var_195e321e9dc9ec95 += ( 0.25, 0, 0 );
        }
        
        right = vectorcross( surfacenormal, var_195e321e9dc9ec95 );
    }
    
    forward = vectorcross( surfacenormal, right );
    var_3dc0958623ca1749 = axistoangles( forward, right, surfacenormal );
    return var_3dc0958623ca1749;
}

// Namespace combat_bow
// Params 8, eflags: 0x4
// Checksum 0x952208b3, Offset: 0xbb7
// Size: 0x145
function private function_2b6a5b4a6d3b1d28( origin, angles, stuckto, owner, inflictor, starttime, scriptablename, orientation )
{
    if ( !isdefined( level.var_efe04b415d20bbee.var_5ea22d62e5a29a50 ) )
    {
        level.var_efe04b415d20bbee.var_5ea22d62e5a29a50 = 0;
    }
    
    level.var_efe04b415d20bbee.var_5ea22d62e5a29a50++;
    var_8fd00ce814852031 = level.var_efe04b415d20bbee.var_5ea22d62e5a29a50;
    scriptable = createscriptable( origin, angles, stuckto, owner, inflictor, starttime, scriptablename, orientation );
    trigger = scriptable createtrigger( level.var_efe04b415d20bbee.tuning.var_cbd4e751b0123b66, owner, inflictor, stuckto, starttime, var_8fd00ce814852031 );
    var_fa7188770db5b20d = { #trigger:trigger, #scriptable:scriptable, #owner:owner, #starttime:starttime };
    var_fa7188770db5b20d thread function_4109d5ef5c8f1c27();
    var_fa7188770db5b20d thread function_7c04ee3da8a394fd();
    return var_fa7188770db5b20d;
}

// Namespace combat_bow
// Params 0, eflags: 0x4
// Checksum 0xe5f533f0, Offset: 0xd05
// Size: 0x33
function private function_7c04ee3da8a394fd()
{
    level endon( #"game_ended" );
    wait level.var_efe04b415d20bbee.tuning.var_1694297001896a09;
    function_7e04f654db248b1();
}

// Namespace combat_bow
// Params 0, eflags: 0x4
// Checksum 0x63524bda, Offset: 0xd40
// Size: 0x7a
function private function_7e04f654db248b1()
{
    if ( self.scriptable )
    {
        self.scriptable function_8e8c17ce34b50683();
    }
    
    if ( self.trigger.var_7f406cb56e4d92a4 )
    {
        self.trigger.var_7f406cb56e4d92a4 cleanuptrigger();
    }
    
    level.var_efe04b415d20bbee.var_f67a2b31caecb3d = arrayremove( level.var_efe04b415d20bbee.var_f67a2b31caecb3d, self );
}

// Namespace combat_bow
// Params 8, eflags: 0x4
// Checksum 0xf242774f, Offset: 0xdc2
// Size: 0x156
function private createscriptable( origin, angles, stuckto, owner, inflictor, starttime, scriptablename, orientation )
{
    genericblueprintpayload = inflictor.blueprintdefindex ? [ #"genericblueprint", inflictor.blueprintdefindex ] : undefined;
    scriptable = spawnscriptable( scriptablename, origin, angles, undefined, genericblueprintpayload );
    scriptable utility::function_8a74027bdea84771( &cleanupscriptable );
    scriptable.stuckto = stuckto;
    scriptable.owner = owner;
    scriptable.inflictor = inflictor;
    scriptable.starttime = starttime;
    scriptable.orientation = orientation;
    
    if ( isent( stuckto ) )
    {
        offset = rotatevectorinverted( origin - stuckto.origin, stuckto.angles );
        angleoffset = combineangles( invertangles( stuckto.angles ), angles );
        scriptable utility::scriptable_setparententity( stuckto, offset, angleoffset );
    }
    
    scriptable function_2bbeefe37cb0c78a();
    return scriptable;
}

// Namespace combat_bow
// Params 0, eflags: 0x4
// Checksum 0xcd747f53, Offset: 0xf21
// Size: 0x86
function private function_4109d5ef5c8f1c27()
{
    movingplatforminfo = self.scriptable utility::function_7c45b71b8e0d3cff();
    
    if ( isdefined( movingplatforminfo ) && isdefined( movingplatforminfo.groundent ) && isdefined( movingplatforminfo.localorigin ) && isdefined( movingplatforminfo.localangles ) )
    {
        self.scriptable scriptablesetparententity( movingplatforminfo.groundent, movingplatforminfo.localorigin, movingplatforminfo.localangles );
        thread function_a1d42603f07eb13e();
    }
}

// Namespace combat_bow
// Params 0, eflags: 0x4
// Checksum 0x56173c74, Offset: 0xfaf
// Size: 0x53
function private function_a1d42603f07eb13e()
{
    self.trigger endon( #"death" );
    
    while ( isdefined( self ) && isdefined( self.trigger ) )
    {
        self.trigger.origin = self.scriptable.origin;
        waitframe();
    }
}

// Namespace combat_bow
// Params 0, eflags: 0x4
// Checksum 0x9b2fcd47, Offset: 0x100a
// Size: 0x2c
function private function_8e8c17ce34b50683()
{
    self.ended = 1;
    self.dyingdown = 1;
    function_2bbeefe37cb0c78a();
    wait 1.5;
    cleanupscriptable();
}

// Namespace combat_bow
// Params 0, eflags: 0x4
// Checksum 0x5b535f77, Offset: 0x103e
// Size: 0x100
function private function_2bbeefe37cb0c78a()
{
    switch ( self.orientation )
    {
        case #"":
            statename = self.dyingdown ? #"corecenterdiedown" : #"corecenter";
            break;
        case #"wall":
            statename = self.dyingdown ? #"corecenterdiedownwall" : #"corecenterwall";
            break;
        case #"hash_d9951890fd6d7e88":
            statename = self.dyingdown ? #"corecenterdiedownceil" : #"corecenterceil";
            break;
        default:
            assertmsg( "<dev string:x52>" );
            statename = self.dyingdown ? #"corecenterdiedown" : #"corecenter";
            break;
    }
    
    self setscriptablepartstate( "effects", statename, 0 );
}

// Namespace combat_bow
// Params 0, eflags: 0x4
// Checksum 0xbad74df9, Offset: 0x1146
// Size: 0x14
function private cleanupscriptable()
{
    self notify( #"death" );
    self freescriptable();
}

// Namespace combat_bow
// Params 6, eflags: 0x4
// Checksum 0xa20987b6, Offset: 0x1162
// Size: 0x13c
function private createtrigger( radius, owner, inflictor, stuckto, starttime, var_8fd00ce814852031 )
{
    origin = self.origin;
    trigger = spawn( "noent_volume_trigger_radius", origin, 0, radius, radius );
    trigger.angles = self.angles;
    trigger.scriptable = self;
    self.trigger = trigger;
    badplace = createtriggerbadplace( origin, radius );
    trigger.var_7f406cb56e4d92a4 = { #var_8ad0f64e430211ee:[], #var_8fd00ce814852031:var_8fd00ce814852031, #starttime:starttime, #stuckto:stuckto, #inflictor:inflictor, #owner:owner, #badplace:badplace, #radius:radius, #trigger:trigger };
    trigger.var_7f406cb56e4d92a4 thread function_18ed6303cff2bfbf();
    trigger.var_7f406cb56e4d92a4 thread function_4bc1509093ed6a86();
    return trigger;
}

// Namespace combat_bow
// Params 2, eflags: 0x4
// Checksum 0x35c5ab8, Offset: 0x12a7
// Size: 0x83
function private createtriggerbadplace( origin, radius )
{
    if ( !bots_util::bot_bots_enabled_or_added() && !utility::level_supports_ai() )
    {
        return;
    }
    
    if ( level.var_3d90777bfb7fc504 )
    {
        badplace = function_30c25bea1909556f( origin, ( radius, radius, radius ), ( 0, 0, 0 ), level.var_3d90777bfb7fc504 );
    }
    else
    {
        badplace = createnavbadplacebybounds( origin, ( radius, radius, radius ), ( 0, 0, 0 ) );
    }
    
    return badplace;
}

// Namespace combat_bow
// Params 0, eflags: 0x4
// Checksum 0xdba4fe5f, Offset: 0x1333
// Size: 0xe7
function private function_18ed6303cff2bfbf()
{
    level endon( #"game_ended" );
    self.inflictor endon( #"death" );
    self.trigger endon( #"death" );
    self.owner endon( #"disconnect" );
    self.owner endon( #"joined_team" );
    
    while ( true )
    {
        self.trigger waittill( #"trigger", entity );
        
        if ( !isplayer( entity ) && !isagent( entity ) )
        {
            continue;
        }
        
        if ( !player::isreallyalive( entity ) )
        {
            continue;
        }
        
        entnum = entity getentitynumber();
        
        if ( self.var_8ad0f64e430211ee[ entnum ] )
        {
            continue;
        }
        
        function_a2ba5c046c141ca7( entity );
        self.var_8ad0f64e430211ee[ entnum ] = entity;
    }
}

// Namespace combat_bow
// Params 0, eflags: 0x4
// Checksum 0xddb7c8c6, Offset: 0x1422
// Size: 0x90
function private function_4bc1509093ed6a86()
{
    level endon( #"game_ended" );
    self.trigger endon( #"death" );
    
    while ( true )
    {
        /#
            if ( getdvarint( @"hash_6c65e774c991df1c", 0 ) )
            {
                sphere( self.trigger.origin, self.radius, ( 1, 0, 0 ), 0, int( utility::function_4b74c15943231980( 0.25 ) ) );
            }
        #/
        
        function_c1317ed5a687940();
        function_86e75e9079ab6e5a();
        wait 0.25;
    }
}

// Namespace combat_bow
// Params 0, eflags: 0x4
// Checksum 0x49e59773, Offset: 0x14ba
// Size: 0x7b
function private function_c1317ed5a687940()
{
    foreach ( burntarget in self.var_8ad0f64e430211ee )
    {
        function_a2ba5c046c141ca7( burntarget );
    }
}

// Namespace combat_bow
// Params 1, eflags: 0x4
// Checksum 0xfe293419, Offset: 0x153d
// Size: 0x200
function private function_a2ba5c046c141ca7( burntarget )
{
    if ( !burntarget )
    {
        return;
    }
    
    if ( isplayer( burntarget ) && !player::isreallyalive( burntarget ) )
    {
        burntarget.var_a87960e6ce4660d1 = undefined;
        return;
    }
    
    if ( !burntarget isonground() && !burntarget isswimming() )
    {
        return;
    }
    
    if ( burntarget isswimunderwater() )
    {
        return;
    }
    
    if ( !isdefined( burntarget.var_a87960e6ce4660d1 ) )
    {
        burntarget.var_a87960e6ce4660d1 = [];
    }
    
    if ( !isdefined( burntarget.var_a87960e6ce4660d1[ self.var_8fd00ce814852031 ] ) )
    {
        burntarget.var_a87960e6ce4660d1[ self.var_8fd00ce814852031 ] = { #burnlevel:0, #lastburntime:0, #var_efcf65df4ecdb254:gettime() };
    }
    
    burninfo = burntarget.var_a87960e6ce4660d1[ self.var_8fd00ce814852031 ];
    burninterval = function_d8aad00d1a3e1b36( burninfo.burnlevel );
    
    while ( function_fea945a060e2366b( burninfo.lastburntime, burninterval ) )
    {
        burninfo.burnlevel = function_fb9d9000cb81e153( burninfo.var_efcf65df4ecdb254, burninfo.lastburntime );
        var_a77a7baed79d52a2 = function_4b2c1291db8968ba( burninfo.burnlevel, burntarget );
        burntarget dodamage( var_a77a7baed79d52a2, self.trigger.origin, self.owner, self.owner, "MOD_FIRE", self.inflictor, "torso_upper" );
        
        if ( burninfo.lastburntime == 0 )
        {
            burninfo.lastburntime = burninfo.var_efcf65df4ecdb254;
            continue;
        }
        
        burninfo.lastburntime += burninterval;
    }
    
    if ( !isai( burntarget ) && isplayer( burntarget ) )
    {
        burntarget thread damage_effects::enableburnfxfortime( 0.25 );
    }
}

// Namespace combat_bow
// Params 2, eflags: 0x4
// Checksum 0xc14ebe58, Offset: 0x1745
// Size: 0x90
function private function_fb9d9000cb81e153( var_1cc3bada5ad0c0f8, var_f63122e6b94184da )
{
    elapsedtimems = max( 0, var_f63122e6b94184da - var_1cc3bada5ad0c0f8 );
    
    if ( elapsedtimems <= level.var_efe04b415d20bbee.tuning.var_b987c0fbc8e0b7ce[ 0 ] )
    {
        burnlevel = 0;
    }
    else if ( elapsedtimems <= level.var_efe04b415d20bbee.tuning.var_b987c0fbc8e0b7ce[ 1 ] )
    {
        burnlevel = 1;
    }
    else
    {
        burnlevel = 2;
    }
    
    return burnlevel;
}

// Namespace combat_bow
// Params 2, eflags: 0x4
// Checksum 0x91951b0d, Offset: 0x17de
// Size: 0xf8
function private function_4b2c1291db8968ba( burnlevel, burntarget )
{
    if ( burnlevel == 0 )
    {
        damage = level.var_efe04b415d20bbee.tuning.var_a9f8b1dc4524262[ 0 ];
    }
    else if ( burnlevel == 1 )
    {
        damage = level.var_efe04b415d20bbee.tuning.var_a9f8b1dc4524262[ 1 ];
    }
    else if ( burnlevel >= 2 )
    {
        damage = level.var_efe04b415d20bbee.tuning.var_a9f8b1dc4524262[ 2 ];
    }
    else
    {
        assertmsg( "<dev string:x67>" );
        damage = level.var_efe04b415d20bbee.tuning.var_a9f8b1dc4524262[ 0 ];
    }
    
    if ( burntarget ismeatshieldvictim() && level.meatshieldhealthscale )
    {
        damage *= level.meatshieldhealthscale;
    }
    
    return damage;
}

// Namespace combat_bow
// Params 1, eflags: 0x4
// Checksum 0x27e987c0, Offset: 0x18df
// Size: 0xcb
function private function_49e362f444012217( burnlevel )
{
    if ( burnlevel == 0 )
    {
        duration = level.var_efe04b415d20bbee.tuning.var_b987c0fbc8e0b7ce[ 0 ];
    }
    else if ( burnlevel == 1 )
    {
        duration = level.var_efe04b415d20bbee.tuning.var_b987c0fbc8e0b7ce[ 1 ];
    }
    else if ( burnlevel >= 2 )
    {
        duration = level.var_efe04b415d20bbee.tuning.var_b987c0fbc8e0b7ce[ 2 ];
    }
    else
    {
        assertmsg( "<dev string:x67>" );
        duration = level.var_efe04b415d20bbee.tuning.var_b987c0fbc8e0b7ce[ 0 ];
    }
    
    return duration;
}

// Namespace combat_bow
// Params 1, eflags: 0x4
// Checksum 0x92ccaa61, Offset: 0x19b3
// Size: 0x29
function private function_d8aad00d1a3e1b36( burnlevel )
{
    return level.var_efe04b415d20bbee.tuning.var_642ea3a57a1ff511;
}

// Namespace combat_bow
// Params 2, eflags: 0x4
// Checksum 0xf297aa28, Offset: 0x19e5
// Size: 0x32, Type: bool
function private function_fea945a060e2366b( lastburntime, var_3d15369638f48412 )
{
    currenttime = gettime();
    
    if ( currenttime > lastburntime + var_3d15369638f48412 )
    {
        return true;
    }
    
    return false;
}

// Namespace combat_bow
// Params 0, eflags: 0x4
// Checksum 0x5587502e, Offset: 0x1a20
// Size: 0xdc
function private function_86e75e9079ab6e5a()
{
    foreach ( entnum, entity in self.var_8ad0f64e430211ee )
    {
        if ( isplayer( entity ) && !player::isreallyalive( entity ) )
        {
            entity.var_a87960e6ce4660d1 = undefined;
            self.var_8ad0f64e430211ee[ entnum ] = undefined;
            continue;
        }
        
        if ( entity istouching( self.trigger ) )
        {
            continue;
        }
        
        entity.var_a87960e6ce4660d1 = undefined;
        self.var_8ad0f64e430211ee[ entnum ] = undefined;
    }
    
    function_5713d46873b29625( self.var_8ad0f64e430211ee );
}

// Namespace combat_bow
// Params 0, eflags: 0x4
// Checksum 0xff7fdef7, Offset: 0x1b04
// Size: 0x36
function private cleanuptrigger()
{
    if ( self.badplace )
    {
        destroynavobstacle( self.badplace );
    }
    
    if ( self.trigger )
    {
        self.trigger delete();
    }
}

