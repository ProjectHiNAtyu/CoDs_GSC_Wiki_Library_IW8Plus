// scripts\common\gas_common.gsc  (hash_0a5bc690f45a1cd1.gscc) (size: 10063 Bytes / 0x274f / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x34dd8b2 (55433394)
// size ...... 10063 (0x274f)
// includes .. 8   (offset: 0x2553)
// strings ... 29  (offset: 0x2593)
// dev strs .. 3   (offset: 0x272b)
// exports ... 20  (offset: 0x17c7)
// cseg ...... 0x270 + 0x1557 (0x17c7)
// imports ... 89  (offset: 0x1ae7)
// animtree1 . 0   (offset: 0x274f)
// animtree2 . 0   (offset: 0x274f)
#using script_16ea1b94f0f381b3;
#using scripts\common\callbacks;
#using scripts\common\throttle;
#using scripts\common\trace;
#using scripts\common\utility;
#using scripts\common\weapon;
#using scripts\mp\common\utility\points;
#using scripts\mp\damage;

#namespace gas_common;

// Namespace gas_common
// Params 0, eflags: 0x5
// Checksum 0x61160407, Offset: 0x28e
// Size: 0x18
function private autoexec main()
{
    level callback::add( #"register_super", &function_afed2c92726ae0d6 );
}

// Namespace gas_common
// Params 1
// Checksum 0x90fd24ac, Offset: 0x2ae
// Size: 0x86
function function_afed2c92726ae0d6( params )
{
    level callback::add( #"player_death", &function_381e3c9018e4e39a );
    level callback::add( #"player_disconnect", &function_91f07de9d1f88ab2 );
    utility::registersharedfunc( "gas_hallucination", #"hash_fafb93cf2eff0b4b", &function_190e9b395a23e44a );
    utility::registersharedfunc( "gas_hallucination", #"hash_f00f78b8f103a397", &function_81ce0d0c1e1afdea );
    utility::registersharedfunc( "gas_hallucination", #"hash_8d11dd86e8c44217", &function_eb5841e85910091c );
}

// Namespace gas_common
// Params 1
// Checksum 0x6166b251, Offset: 0x33c
// Size: 0x13
function function_381e3c9018e4e39a( params )
{
    function_81ce0d0c1e1afdea();
}

// Namespace gas_common
// Params 1
// Checksum 0xf8c26559, Offset: 0x357
// Size: 0x13
function function_91f07de9d1f88ab2( params )
{
    function_81ce0d0c1e1afdea();
}

// Namespace gas_common
// Params 2
// Checksum 0x2ec34988, Offset: 0x372
// Size: 0x64
function function_190e9b395a23e44a( bundle, tryspawndecoysthrottle )
{
    if ( !isdefined( self ) )
    {
        return;
    }
    
    if ( !self isconnected() )
    {
        return;
    }
    
    if ( self function_5c766d1d0140b86( "ui_is_gas_effected" ) )
    {
        self setclientomnvar( "ui_is_gas_effected", 1 );
        function_bab6a447e5dc21f4();
    }
    
    self lerpfovbypreset( "gas_common_default" );
    self function_cea29dd946077443( 1 );
    thread function_559888eec09fcd58( bundle, tryspawndecoysthrottle );
}

// Namespace gas_common
// Params 1
// Checksum 0x492f31eb, Offset: 0x3de
// Size: 0x5d
function function_81ce0d0c1e1afdea( bundle )
{
    if ( !isdefined( self ) )
    {
        return;
    }
    
    if ( !self isconnected() )
    {
        return;
    }
    
    if ( self function_5c766d1d0140b86( "ui_is_gas_effected" ) )
    {
        self setclientomnvar( "ui_is_gas_effected", 0 );
    }
    
    self function_cea29dd946077443( 0 );
    function_1b87ec8f122d8f62( bundle );
    self lerpfovbypreset( "default_2seconds" );
    self notify( #"hash_dce4a8c62aa288f1" );
}

// Namespace gas_common
// Params 0
// Checksum 0x49521cae, Offset: 0x443
// Size: 0xb5
function function_bab6a447e5dc21f4()
{
    utility::flag_wait( "scriptables_ready" );
    
    foreach ( player in level.players )
    {
        if ( player isscriptable() && player getscriptablehaspart( #"gas_vfx" ) )
        {
            player setscriptablepartstate( #"gas_vfx", #"vfx_on", 1 );
        }
    }
}

// Namespace gas_common
// Params 1
// Checksum 0x8422dc3b, Offset: 0x500
// Size: 0x177
function function_eb5841e85910091c( brainrotdata )
{
    if ( !utility::callsharedfunc( #"zombie_utils", #"hash_ed46e37d3efd53d3" ) )
    {
        brainrotdata.var_f0f21071d94cee1 = self.team;
        brainrotdata.oldhealth = self.health;
        self [[ utility::getsharedfunc( #"zombie_utils", #"turn_ai" ) ]]( brainrotdata.trigger.owner );
        utility::function_32b24db3127bff40( "brainrot", "brainrot_on" );
        enemiesarray = [ self ];
        level notify( #"highvis_reload_outline", self.team, enemiesarray, 1 );
        
        if ( brainrotdata.ignored )
        {
            self.ignoreme = 1;
        }
        
        if ( brainrotdata.var_2570f353fae877d0 )
        {
            end_damage_percent = brainrotdata.brainrot_end_damage_percent ?? 1;
            round_difficulty = namespace_9d8e359c3b1041e5::function_57de0ca2e80536a1( self.origin );
            zombie_base_health = namespace_9d8e359c3b1041e5::function_870440d8340968c0( "zombie_base", round_difficulty );
            
            if ( !isdefined( zombie_base_health ) )
            {
                zombie_base_health = 125;
            }
            
            brainrot_damage_percent = brainrotdata.brainrot_base_damage_percent ?? 1;
            self.var_cab75db7e9e5b64c = zombie_base_health * brainrot_damage_percent;
        }
        
        if ( brainrotdata.brainrotduration )
        {
            thread function_c87e21ae73d96d3c( brainrotdata );
        }
    }
}

// Namespace gas_common
// Params 1
// Checksum 0xdf152970, Offset: 0x67f
// Size: 0x1bb
function function_c87e21ae73d96d3c( brainrotdata )
{
    self endon( #"death" );
    wait brainrotdata.brainrotduration;
    self [[ utility::getsharedfunc( #"zombie_utils", #"turn_ai_back" ) ]]( brainrotdata.var_f0f21071d94cee1, "brainrot", "brainrot_off" );
    
    if ( brainrotdata.oldhealth && brainrotdata.oldhealth > 0 )
    {
        self.health = brainrotdata.oldhealth;
    }
    
    enemiesarray = [ self ];
    level notify( #"highvis_reload_outline", self.team, enemiesarray, 1 );
    
    if ( brainrotdata.kill_enemy )
    {
        self kill( self.origin );
        return;
    }
    
    if ( brainrotdata.var_5076313ebb1f3fbf )
    {
        self.forceannihilate = 1;
        
        if ( isdefined( level._effect[ "vfx_t10_gameplay_zm_ai_zai_explo_aoe_brain_rot" ] ) )
        {
            playfx( utility::getfx( "vfx_t10_gameplay_zm_ai_zai_explo_aoe_brain_rot" ), self.origin );
        }
        
        end_damage_percent = brainrotdata.brainrot_end_damage_percent ?? 1;
        round_difficulty = namespace_9d8e359c3b1041e5::function_57de0ca2e80536a1( self.origin );
        zombie_base_health = namespace_9d8e359c3b1041e5::function_870440d8340968c0( "zombie_base", round_difficulty );
        
        if ( !isdefined( zombie_base_health ) )
        {
            zombie_base_health = 125;
        }
        
        end_damage = zombie_base_health * end_damage_percent;
        self dodamage( end_damage, self.origin, brainrotdata.owner, brainrotdata.owner, "MOD_ELEMENTAL_TOXIC", brainrotdata.weapon, "torso_upper", undefined, 1610678272 );
    }
}

// Namespace gas_common
// Params 1, eflags: 0x4
// Checksum 0x6c5fec, Offset: 0x842
// Size: 0x380
function private function_bf88cd0ee604db85( spawndata )
{
    if ( spawndata.tryspawndecoysthrottle )
    {
        throttle::throttle_wait_in_queue( spawndata.tryspawndecoysthrottle, self );
    }
    
    startpos = self.origin;
    startang = self.angles;
    forward = anglestoforward( startang );
    backward = -1 * forward;
    var_6dc48eb5eac7204 = spawndata.var_de3b77a5b88d82b3;
    var_5ddcd32346b788dd = 180 - spawndata.var_de3b77a5b88d82b3;
    spacinggap = ( spawndata.var_5248a6ad29e9da2b - spawndata.var_26ee141b1654d2c9 ) / max( spawndata.var_4518426ffa8411a1 - spawndata.var_721b8f4c560de5de, 1 );
    var_56ac8df6a49038a = ( spawndata.var_4dd221792ec088d6 - spawndata.var_b90808171ee88d04 ) / max( spawndata.var_721b8f4c560de5de, 1 );
    var_28f5b5e30cb24b38 = spawndata.var_4518426ffa8411a1;
    
    if ( isdefined( level.gametypebundle.var_8da97050894e91d6 ) && var_28f5b5e30cb24b38 > 0 )
    {
        var_28f5b5e30cb24b38 = clampint( var_28f5b5e30cb24b38, 1, int( ( level.gametypebundle.var_8da97050894e91d6 - level.gas_common_decoys.size ) / 2 ) );
    }
    
    var_148ae3205212f36 = var_28f5b5e30cb24b38 - self.decoys.size;
    var_8b262899184622f9 = 0;
    
    foreach ( decoy in self.decoys )
    {
        var_4a1e4cdbe9485a48 = vectornormalize( decoy.origin - self geteye() );
        dotproduct = vectordot( vectornormalize( anglestoforward( self.angles ) ), var_4a1e4cdbe9485a48 );
        
        if ( dotproduct >= 0.5 )
        {
            var_8b262899184622f9++;
        }
    }
    
    var_a1144a5f891db1a8 = int( clamp( spawndata.var_721b8f4c560de5de - var_8b262899184622f9, 0, spawndata.var_721b8f4c560de5de ) );
    
    for ( i = 0; i < var_148ae3205212f36 && i < spawndata.var_93fc6c18523c0e29 ; i++ )
    {
        curpos = undefined;
        result = undefined;
        
        if ( var_a1144a5f891db1a8 > 0 )
        {
            spawndist = spawndata.var_26ee141b1654d2c9 + var_56ac8df6a49038a * i + randomfloatrange( 0, var_56ac8df6a49038a );
            curpos = startpos + spawndist * rotatevector( forward, ( 0, randomfloatrange( var_6dc48eb5eac7204 * -1, var_6dc48eb5eac7204 ), 0 ) );
            result = function_dad62d4322c6217e( curpos, 1 );
            
            if ( isdefined( result ) )
            {
                function_cba7c4b22fce5d45( spawndata, result, 1 );
                var_a1144a5f891db1a8--;
            }
            
            continue;
        }
        
        if ( var_148ae3205212f36 - var_a1144a5f891db1a8 > 0 )
        {
            spawndist = spawndata.var_26ee141b1654d2c9 + spacinggap * i + randomfloatrange( 0, spacinggap );
            curpos = startpos + spawndist * rotatevector( backward, ( 0, randomfloatrange( var_5ddcd32346b788dd * -1, var_5ddcd32346b788dd ), 0 ) );
            result = function_dad62d4322c6217e( curpos, 0 );
            
            if ( isdefined( result ) )
            {
                function_cba7c4b22fce5d45( spawndata, result, 0 );
            }
        }
    }
}

// Namespace gas_common
// Params 2
// Checksum 0x57980d38, Offset: 0xbca
// Size: 0x18e
function function_dad62d4322c6217e( spawnpoint, var_f045abe5bbc15dd9 )
{
    result = undefined;
    zoffset = ( 0, 0, 72 );
    collisioncontents = trace::create_contents( 1, 1, 1, 1, 1, 1, 1, 0, 1 );
    tracestart = spawnpoint + zoffset;
    spheretestradius = 50;
    var_a4a104a99365ead5 = trace::ray_trace_passed( self geteye(), tracestart, self, collisioncontents );
    
    if ( var_f045abe5bbc15dd9 && var_a4a104a99365ead5 )
    {
        return result;
    }
    
    if ( !var_f045abe5bbc15dd9 && !var_a4a104a99365ead5 )
    {
        return result;
    }
    
    groundtrace = trace::ray_trace( tracestart, tracestart - ( 0, 0, 1000 ), undefined, collisioncontents, 1 );
    
    if ( isdefined( groundtrace[ "position" ] ) && groundtrace[ "hittype" ] == "hittype_world" && isdefined( groundtrace[ "surfacetype" ] ) && groundtrace[ "surfacetype" ] != "surftype_water" && groundtrace[ "fraction" ] < 0.99 )
    {
        testspawnpos = groundtrace[ "position" ] + zoffset;
        var_d6e39170a55e23d0 = trace::sphere_trace_passed( testspawnpos, testspawnpos, spheretestradius, undefined, collisioncontents );
        teamtocheck = undefined;
        
        if ( level.teambased )
        {
            teamtocheck = self.team;
        }
        
        if ( var_d6e39170a55e23d0 && !namespace_9d8e359c3b1041e5::ispointinoutofboundssharedfunc( groundtrace[ "position" ], teamtocheck ) )
        {
            result = groundtrace[ "position" ];
        }
    }
    
    return result;
}

// Namespace gas_common
// Params 2, eflags: 0x4
// Checksum 0x47c1ce37, Offset: 0xd61
// Size: 0x2a3
function private function_559888eec09fcd58( bundle, tryspawndecoysthrottle )
{
    self endon( #"hash_dce4a8c62aa288f1" );
    gasvictim = self;
    spawndata = { #tryspawndecoysthrottle:tryspawndecoysthrottle, #var_93fc6c18523c0e29:bundle.gas_hallucination_settings.var_a394f66610998c5a ?? 2147483647, #var_dfa139d7066f373f:bundle.gas_hallucination_settings.var_a88d403785adabdb ?? 0.5, #var_26b549a741e90fe8:bundle.gas_hallucination_settings.var_d53deb8ecd070b33 ?? 1, #var_de3b77a5b88d82b3:( bundle.gas_hallucination_settings.var_df30815db7d20709 ?? 100 ) / 2, #var_5248a6ad29e9da2b:bundle.gas_hallucination_settings.var_e93e08546675eea6 ?? 650, #var_26ee141b1654d2c9:max( 200, bundle.gas_hallucination_settings.var_31f7ae8e34a37a1c ?? 150 ), #var_4dd221792ec088d6:bundle.gas_hallucination_settings.var_6696856db0869970 ?? 1000, #var_b90808171ee88d04:max( 200, bundle.gas_hallucination_settings.var_66144d530177eec2 ?? 650 ), #var_721b8f4c560de5de:bundle.gas_hallucination_settings.var_4c0322330dfba5e8 ?? 0, #var_4518426ffa8411a1:bundle.gas_hallucination_settings.var_508b3e4b368472d9 ?? 0 };
    assert( spawndata.var_26ee141b1654d2c9 < spawndata.var_5248a6ad29e9da2b, "<dev string:x24>" );
    assert( spawndata.var_b90808171ee88d04 < spawndata.var_4dd221792ec088d6, "<dev string:x83>" );
    
    if ( !isdefined( gasvictim.decoys ) )
    {
        gasvictim.decoys = [];
    }
    
    if ( !isdefined( level.gas_common_decoys ) )
    {
        level.gas_common_decoys = [];
    }
    
    while ( true )
    {
        gasvictim.decoys = function_46f9072493651dc9( gasvictim.decoys );
        level.gas_common_decoys = function_46f9072493651dc9( level.gas_common_decoys );
        
        if ( gasvictim.decoys.size < spawndata.var_4518426ffa8411a1 )
        {
            spawnpositions = function_bf88cd0ee604db85( spawndata );
        }
        
        wait spawndata.var_26b549a741e90fe8;
    }
}

// Namespace gas_common
// Params 3, eflags: 0x4
// Checksum 0x1a17e1b1, Offset: 0x100c
// Size: 0x345
function private function_cba7c4b22fce5d45( spawndata, position, var_30b5eaf7f63a08 )
{
    curdecoy = spawn( "script_model", position );
    curdecoy function_ce21f4102d5d17f6( self.operatorcustomization.skinref, "super_gas_decoy" );
    curdecoy.team = self.team;
    curdecoy.owner = self;
    curdecoy setentityowner( self );
    curdecoy setotherent( self );
    curdecoy.deletiondelay = spawndata.var_dfa139d7066f373f;
    var_35c83af455d3733b = vectortoangles( self.origin - position );
    curdecoy.angles = ( 0, var_35c83af455d3733b[ 1 ], 0 );
    weaponobj = level.var_45e605ee1bcfe0f5;
    
    if ( !weaponobj )
    {
        gamemodebundle = getgamemodescriptbundle();
        
        if ( gamemodebundle.weaponlist )
        {
            weaponlistbundle = getscriptbundle( gamemodebundle.weaponlist );
            var_907cbe52a4f7eced = weaponlistbundle.defaultprimaryweapon;
            
            if ( var_907cbe52a4f7eced )
            {
                weaponrootname = getscriptbundlefieldvalue( getxhashasset( "weapondata:" + var_907cbe52a4f7eced ), #"ref" ) ?? var_907cbe52a4f7eced ?? "none";
            }
            else
            {
                weaponrootname = "none";
            }
            
            weaponobj = weapon::buildweapon( weaponrootname );
            
            if ( isweapon( weaponobj ) && !isnullweapon( weaponobj ) )
            {
                level.var_45e605ee1bcfe0f5 = weaponobj;
            }
        }
    }
    
    if ( isweapon( weaponobj ) && !isnullweapon( weaponobj ) )
    {
        weaponent = spawn( "script_weapon", curdecoy.origin, 0, 0, weaponobj );
        weaponent makeunusable();
        weaponent linkto( curdecoy, "j_gun", ( 0, 0, 0 ), ( 0, 0, 0 ) );
        curdecoy.weaponent = weaponent;
    }
    else
    {
        assertmsg( "<dev string:xf2>" );
    }
    
    randomstance = randomintrange( 0, 2 );
    
    if ( randomstance == 0 )
    {
        curdecoy scriptmodelplayanim( "sdr_mp_crouch_idle", "gasVictim_notify" );
        curdecoy.spawnedtype = 1;
    }
    else
    {
        curdecoy scriptmodelplayanim( "sdr_mp_stand_idle01", "gasVictim_notify" );
        curdecoy.spawnedtype = 0;
    }
    
    curdecoy hide();
    weaponent hide();
    curdecoy showtoplayer( self );
    weaponent showtoplayer( self );
    curdecoy thread function_cd8cba22623f716c( self );
    var_7c170ceae0649b57 = [ #"teamselect", self getentitynumber() ];
    curdecoy.hitreactscriptable = spawnscriptable( "super_gas_decoy_hitreact_noentity", position, undefined, undefined, var_7c170ceae0649b57 );
    curdecoy.health = 1;
    curdecoy setcandamage( 1 );
    thread function_df28742310ea736( spawndata, curdecoy );
    curdecoy thread damage::monitordamage( curdecoy.health, "none", &function_d6219e8357881a71, &function_5c7502c21850b006 );
    self.decoys[ self.decoys.size ] = curdecoy;
    level.gas_common_decoys[ level.gas_common_decoys.size ] = curdecoy;
}

// Namespace gas_common
// Params 1, eflags: 0x4
// Checksum 0x3b955fe6, Offset: 0x1359
// Size: 0x4e
function private function_cd8cba22623f716c( owner )
{
    self endon( #"death" );
    owner endon( #"disconnect" );
    
    while ( true )
    {
        level waittill( #"connected", player );
        self hidefromplayer( player );
    }
}

// Namespace gas_common
// Params 1
// Checksum 0x854c04d6, Offset: 0x13af
// Size: 0x95
function function_1b87ec8f122d8f62( bundle )
{
    if ( self )
    {
        foreach ( decoy in self.decoys )
        {
            decoy function_d6219e8357881a71( undefined, 0 );
        }
        
        self.decoys = undefined;
    }
}

// Namespace gas_common
// Params 2, eflags: 0x4
// Checksum 0x3015066f, Offset: 0x144c
// Size: 0xe2
function private function_df28742310ea736( spawndata, decoy )
{
    self endon( #"death" );
    decoy endon( #"death" );
    var_987a77e9508ae30b = max( spawndata.var_4dd221792ec088d6, spawndata.var_5248a6ad29e9da2b ) + 50;
    var_318fd78d4cd6d310 = var_987a77e9508ae30b * var_987a77e9508ae30b;
    
    while ( true )
    {
        waitframe();
        var_fb3b07a76164dac9 = distance2dsquared( self.origin, decoy.origin );
        
        if ( var_fb3b07a76164dac9 <= 10000 || var_fb3b07a76164dac9 > var_318fd78d4cd6d310 )
        {
            decoy function_d6219e8357881a71( undefined, 0 );
        }
        
        var_35c83af455d3733b = vectortoangles( self.origin - decoy.origin );
        decoy.angles = ( 0, var_35c83af455d3733b[ 1 ], 0 );
    }
}

// Namespace gas_common
// Params 2
// Checksum 0xc1b42a50, Offset: 0x1536
// Size: 0x57
function function_d6219e8357881a71( damagedata, immediate )
{
    if ( !isdefined( self ) || self.var_918f5731d316cbc )
    {
        return;
    }
    
    self setcandamage( 0 );
    deletiondelay = immediate ? 0 : self.deletiondelay;
    thread function_7f0f35536b352248( deletiondelay );
}

// Namespace gas_common
// Params 1, eflags: 0xc
// Checksum 0xac3c197, Offset: 0x1595
// Size: 0xdd
function private function_7f0f35536b352248( deletiondelay )
{
    self notify( #"hash_60d461b84765d8ab" );
    self endon( #"hash_60d461b84765d8ab" );
    self notify( #"death" );
    self.var_918f5731d316cbc = 1;
    
    if ( self.hitreactscriptable )
    {
        if ( self.hitreactscriptable getscriptablepartstate( #"hitreact_fx", 1 ) != "triggered" )
        {
            self.hitreactscriptable setscriptablepartstate( #"hitreact_fx", #"triggered", 0 );
        }
    }
    
    if ( !isdefined( deletiondelay ) )
    {
        deletiondelay = 0;
    }
    
    if ( deletiondelay <= 0 )
    {
        waitframe();
    }
    else
    {
        wait deletiondelay;
    }
    
    if ( self.weaponent )
    {
        self.weaponent delete();
    }
    
    if ( self.hitreactscriptable )
    {
        self.hitreactscriptable freescriptable();
    }
    
    if ( self )
    {
        self delete();
    }
}

// Namespace gas_common
// Params 1
// Checksum 0x78fc3ddd, Offset: 0x167a
// Size: 0x14c
function function_5c7502c21850b006( data )
{
    attacker = data.attacker;
    
    foreach ( gasowner in attacker.var_dc025d4b9929cb1f.attackers )
    {
        if ( gasowner != attacker )
        {
            gasowner thread points::doscoreevent( #"hash_ade4f36c3759f240" );
        }
    }
    
    foreach ( gasowner in attacker.var_221bcd7e6f8830f8.attackers )
    {
        if ( gasowner != attacker )
        {
            gasowner thread points::doscoreevent( #"hash_ade4f36c3759f240" );
        }
    }
    
    return data.damage;
}

