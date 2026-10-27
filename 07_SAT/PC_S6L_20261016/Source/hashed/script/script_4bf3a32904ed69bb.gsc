// script_4bf3a32904ed69bb  (hash_4bf3a32904ed69bb.gscc) (size: 4650 Bytes / 0x122a / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x7b413f55 (2067873621)
// size ...... 4650 (0x122a)
// includes .. 7   (offset: 0x11b2)
// strings ... 3   (offset: 0x11ea)
// dev strs .. 1   (offset: 0x121e)
// exports ... 13  (offset: 0xb76)
// cseg ...... 0xaa + 0xacc (0xb76)
// imports ... 37  (offset: 0xd7e)
// animtree1 . 0   (offset: 0x122a)
// animtree2 . 0   (offset: 0x122a)
#using scripts\common\callbacks;
#using scripts\common\math;
#using scripts\common\utility;
#using scripts\mp\common\utility\killstreak_utility;
#using scripts\mp\common\utility\perk;
#using scripts\mp\common\utility\player;
#using scripts\mp\common\utility\player_utility;

#namespace specialty_ping_enemy_after_kill;

// Namespace specialty_ping_enemy_after_kill
// Params 0, eflags: 0x1
// Checksum 0xd78a450a, Offset: 0xc8
// Size: 0x18
function autoexec main()
{
    level callback::add( #"register_perk", &registerperk );
}

// Namespace specialty_ping_enemy_after_kill
// Params 1
// Checksum 0x8447b256, Offset: 0xe8
// Size: 0xef
function registerperk( params )
{
    bundle = level.perkbundles[ "specialty_ping_enemy_after_kill" ];
    
    if ( !isdefined( bundle ) )
    {
        return;
    }
    
    specialties = [];
    
    foreach ( specialty in bundle.specialties )
    {
        specialties[ specialties.size ] = specialty.bundle;
    }
    
    if ( isdefined( params.var_a2358848c4408242 ) )
    {
        level [[ params.var_a2358848c4408242 ]]( "specialty_ping_enemy_after_kill", &function_6647c8caa112f698, &function_91f42b3572fb4519, specialties, &function_839a7eaf0014e8a2 );
    }
}

// Namespace specialty_ping_enemy_after_kill
// Params 0
// Checksum 0xd576dae2, Offset: 0x1df
// Size: 0x17
function function_839a7eaf0014e8a2()
{
    callback::add( #"player_death", &onplayerdeath );
}

// Namespace specialty_ping_enemy_after_kill
// Params 0, eflags: 0x4
// Checksum 0x183e0d8b, Offset: 0x1fe
// Size: 0x24a
function private function_6647c8caa112f698()
{
    bundle = level.perkbundles[ "specialty_ping_enemy_after_kill" ];
    
    if ( !bundle )
    {
        return;
    }
    
    self.var_d13419b9ae5da11c = { #var_3edc5a2c72bbedf0:[], #var_3c92085f25831b7f:bundle.var_8449cc721d9fdc05 ?? 0, #var_3125feadbc9f7c06:bundle.var_a2d14341bad68f14 ?? 1, #var_f0e1591cd29c04c5:bundle.var_cf9c9fe1a2a0909b ?? 0, #var_fe58e6b9af6beddf:bundle.var_76f9b4ad4ea92e1d ?? 3, #var_e5d697c1330f0cc9:bundle.var_c9a43bca63482f47 ?? 5, #var_9bd13f5b0635a5a4:bundle.var_9ada17e5ab83f65a ?? 5000, #var_bfa44977e94ae199:bundle.var_7a893c4b9c2b14c3 ?? 15 };
    
    foreach ( value in bundle.var_809ea4906b1b42ad )
    {
        if ( !isdefined( value.streakref ) )
        {
            continue;
        }
        
        self.var_d13419b9ae5da11c.var_3edc5a2c72bbedf0[ value.streakref ] = 1;
    }
    
    if ( self.var_d13419b9ae5da11c.var_f0e1591cd29c04c5 >= self.var_d13419b9ae5da11c.var_fe58e6b9af6beddf )
    {
        assertmsg( "<dev string:x24>" );
    }
    
    foreach ( specialty in bundle.specialties )
    {
        perk::giveperk( specialty );
    }
}

// Namespace specialty_ping_enemy_after_kill
// Params 0, eflags: 0x4
// Checksum 0x9a208536, Offset: 0x450
// Size: 0xa7
function private function_91f42b3572fb4519()
{
    bundle = level.perkbundles[ "specialty_ping_enemy_after_kill" ];
    
    if ( !bundle )
    {
        return;
    }
    
    self.var_d13419b9ae5da11c = undefined;
    
    foreach ( specialty in bundle.specialties )
    {
        perk::removeperk( specialty );
    }
}

// Namespace specialty_ping_enemy_after_kill
// Params 1
// Checksum 0xcb635202, Offset: 0x4ff
// Size: 0x94
function onplayerdeath( deathdata )
{
    if ( !isdefined( deathdata.attacker.var_d13419b9ae5da11c ) )
    {
        return;
    }
    
    shouldping = deathdata.victim function_ac09a058df12066d( deathdata.objweapon, deathdata.attacker, deathdata.inflictor, deathdata.meansofdeath );
    
    if ( !shouldping )
    {
        return;
    }
    
    deathdata.victim function_38317f3ce21c18d8( deathdata.attacker );
}

// Namespace specialty_ping_enemy_after_kill
// Params 1
// Checksum 0x16ce5029, Offset: 0x59b
// Size: 0x46
function function_38317f3ce21c18d8( attacker )
{
    victim = self;
    
    if ( !isdefined( victim ) )
    {
        return;
    }
    
    var_51c7610d3b8a2032 = victim function_f2ba1de3bcce7175( attacker );
    
    if ( !isdefined( var_51c7610d3b8a2032 ) )
    {
        return;
    }
    
    pingtarget( attacker, var_51c7610d3b8a2032 );
}

// Namespace specialty_ping_enemy_after_kill
// Params 4
// Checksum 0x7c5db47, Offset: 0x5e9
// Size: 0x139, Type: bool
function function_ac09a058df12066d( weaponobj, attacker, inflictor, meansofdeath )
{
    victim = self;
    
    if ( !player_utility::playersareenemies( victim, attacker ) )
    {
        return false;
    }
    
    bundlehash = killstreak_utility::function_9ce4d95fd9ec1228( weaponobj );
    
    if ( attacker.var_d13419b9ae5da11c.var_3edc5a2c72bbedf0[ bundlehash ] )
    {
        return false;
    }
    
    var_9d5faa188ecb8357 = utility::isbulletdamage( meansofdeath );
    var_42d28022726a799f = attacker.var_d13419b9ae5da11c.var_3125feadbc9f7c06 && var_9d5faa188ecb8357 || attacker.var_d13419b9ae5da11c.var_3c92085f25831b7f && !var_9d5faa188ecb8357;
    
    if ( !var_42d28022726a799f )
    {
        return false;
    }
    
    lastpingtimeseconds = attacker.var_d13419b9ae5da11c.lastpingtimeseconds ?? -1;
    
    if ( lastpingtimeseconds > 0 )
    {
        var_80af201340498a0f = gettime() / 1000 - lastpingtimeseconds;
        
        if ( var_80af201340498a0f < attacker.var_d13419b9ae5da11c.var_e5d697c1330f0cc9 )
        {
            return false;
        }
    }
    
    return true;
}

// Namespace specialty_ping_enemy_after_kill
// Params 1, eflags: 0x4
// Checksum 0xccf13b52, Offset: 0x72b
// Size: 0xce
function private function_f2ba1de3bcce7175( attacker )
{
    victim = self;
    
    if ( !isdefined( victim.team ) )
    {
        return;
    }
    
    if ( level.teambased )
    {
        var_be97f42abdee91d5 = victim.team;
    }
    else
    {
        var_be97f42abdee91d5 = undefined;
    }
    
    inrangecandidates = player_utility::script_getplayersinradius( attacker.origin, attacker.var_d13419b9ae5da11c.var_9bd13f5b0635a5a4, var_be97f42abdee91d5 );
    validcandidates = attacker utility::function_5fdf0884f9b2d470( inrangecandidates, &function_7a4b1a6e8244b540 );
    var_6c45ce456f32b3fd = sortbydistance( validcandidates, attacker.origin );
    
    if ( var_6c45ce456f32b3fd.size <= 0 )
    {
        return;
    }
    
    var_deafd51c13ce1bf1 = var_6c45ce456f32b3fd[ 0 ];
    return var_deafd51c13ce1bf1;
}

// Namespace specialty_ping_enemy_after_kill
// Params 1, eflags: 0x4
// Checksum 0xaeeaba75, Offset: 0x802
// Size: 0x7b, Type: bool
function private function_7a4b1a6e8244b540( var_51c7610d3b8a2032 )
{
    if ( !player::isreallyalive( var_51c7610d3b8a2032 ) )
    {
        return false;
    }
    
    if ( var_51c7610d3b8a2032 isplayerghost() )
    {
        return false;
    }
    
    if ( var_51c7610d3b8a2032 == self )
    {
        return false;
    }
    
    var_32dbca3143d9c4a5 = level.sharedfuncs[ #"jamming_system" ][ #"hash_f3a152be2dbc14b9" ];
    
    if ( isdefined( var_32dbca3143d9c4a5 ) )
    {
        istargetjammed = var_51c7610d3b8a2032 [[ var_32dbca3143d9c4a5 ]]();
    }
    else
    {
        istargetjammed = 0;
    }
    
    if ( istargetjammed )
    {
        return false;
    }
    
    return true;
}

// Namespace specialty_ping_enemy_after_kill
// Params 2, eflags: 0x4
// Checksum 0x29e34405, Offset: 0x886
// Size: 0x12c
function private function_91ccda3cee679184( attacker, var_51c7610d3b8a2032 )
{
    var_51c7610d3b8a2032 endon( #"death" );
    var_51c7610d3b8a2032 endon( #"disconnect" );
    timepassed = 0;
    
    while ( timepassed < attacker.var_d13419b9ae5da11c.var_fe58e6b9af6beddf )
    {
        var_82a26e2fb1be0578 = 45;
        var_2c6ef5693d530d6 = utility::flatten_vector( var_51c7610d3b8a2032.origin - attacker.origin );
        playerforward = utility::flatten_vector( anglestoforward( attacker.angles ) );
        angle = angleclamp( math::anglebetweenvectorssigned( playerforward, var_2c6ef5693d530d6, ( 0, 0, 1 ) ) );
        angle = angleclamp( angle + var_82a26e2fb1be0578 / 2 );
        slicenum = int( floor( angle / var_82a26e2fb1be0578 ) ) + 1;
        
        if ( attacker )
        {
            attacker setclientomnvar( "ui_hunter_instinct_minimap_section", slicenum );
        }
        
        timepassed += level.framedurationseconds;
        waitframe();
        
        if ( !attacker || !var_51c7610d3b8a2032 )
        {
            return;
        }
    }
}

// Namespace specialty_ping_enemy_after_kill
// Params 2, eflags: 0x4
// Checksum 0xe749b42b, Offset: 0x9ba
// Size: 0x1bc
function private pingtarget( attacker, var_51c7610d3b8a2032 )
{
    if ( !isdefined( attacker.var_d13419b9ae5da11c ) )
    {
        return;
    }
    
    var_51c7610d3b8a2032 endon( #"disconnect" );
    attacker thread function_91ccda3cee679184( attacker, var_51c7610d3b8a2032 );
    attacker function_1fca3a43aa63c0bc( var_51c7610d3b8a2032 );
    attacker.var_d13419b9ae5da11c.lastpingtimeseconds = gettime() / 1000;
    var_51c7610d3b8a2032.var_645cb1131f4115[ attacker getentitynumber() ] = gettime();
    attackerentnum = attacker.entnum ?? utility::get_entity_number( attacker );
    var_32dbca3143d9c4a5 = level.sharedfuncs[ #"perceptive" ][ #"incrementcount" ];
    
    if ( isdefined( var_32dbca3143d9c4a5 ) )
    {
        var_51c7610d3b8a2032 [[ var_32dbca3143d9c4a5 ]]( attackerentnum );
    }
    
    var_51c7610d3b8a2032 utility::waittill_any_timeout( attacker.var_d13419b9ae5da11c.var_fe58e6b9af6beddf, "death" );
    
    if ( attacker )
    {
        attacker setclientomnvar( "ui_hunter_instinct_minimap_section", 0 );
    }
    
    var_32dbca3143d9c4a5 = level.sharedfuncs[ #"perceptive" ][ #"decrementcount" ];
    
    if ( isdefined( var_32dbca3143d9c4a5 ) )
    {
        var_51c7610d3b8a2032 [[ var_32dbca3143d9c4a5 ]]( attackerentnum );
    }
    
    if ( attacker && attacker.var_d13419b9ae5da11c.lastpingtimeseconds )
    {
        var_cfb93ffa28bc0b7f = gettime() / 1000 - attacker.var_d13419b9ae5da11c.lastpingtimeseconds;
        
        if ( var_cfb93ffa28bc0b7f < attacker.var_d13419b9ae5da11c.var_f0e1591cd29c04c5 )
        {
            attacker.var_d13419b9ae5da11c.lastpingtimeseconds = -1;
            var_51c7610d3b8a2032 function_38317f3ce21c18d8( attacker );
        }
    }
}

