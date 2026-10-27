// scripts\mp\bots\bots_gametype_super_shared.gsc  (hash_59ff79d681bb860c.gscc) (size: 13241 Bytes / 0x33b9 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xf334491d (4080290077)
// size ...... 13241 (0x33b9)
// includes .. 14  (offset: 0x306d)
// strings ... 27  (offset: 0x30dd)
// dev strs .. 31  (offset: 0x3229)
// exports ... 30  (offset: 0x1f95)
// cseg ...... 0x1e0 + 0x1db5 (0x1f95)
// imports ... 101 (offset: 0x2445)
// animtree1 . 0   (offset: 0x33b9)
// animtree2 . 0   (offset: 0x33b9)
#using script_2444b97a3516cbb0;
#using script_4c9bd9a3bf3f8cf7;
#using script_d74ae0b4aa21186;
#using scripts\common\math;
#using scripts\common\trace;
#using scripts\common\utility;
#using scripts\mp\armor;
#using scripts\mp\bots\bots;
#using scripts\mp\bots\bots_gametype_br_super;
#using scripts\mp\bots\bots_util;
#using scripts\mp\br\gametypes\br_spectate;
#using scripts\mp\common\utility\teams;
#using scripts\mp\equipment;
#using scripts\mp\hostmigration;

#namespace bots_gametype_super_shared;

// Namespace bots_gametype_super_shared
// Params 0
// Checksum 0x22035b9c, Offset: 0x1fe
// Size: 0x83
function onbotspawnedcommon()
{
    self.onlyscriptenemy = 1;
    namespace_ddca46d216b096e2::function_30b9db7247f23009();
    bots::bot_set_xuid();
    bots_util_mp::bot_set_personality( "run_and_gun" );
    
    if ( !isdefined( self.mind_personality ) )
    {
        self.mind_personality = function_feab679ff95dfa4a();
        assert( isdefined( self.mind_personality ) );
    }
    
    function_4c57819a44d79e03( "Spawned" );
    self botsetflag( "disable_random_goal", 1 );
    self botsetflag( "allow_slide_for_any_script_goal", 1 );
    mind::initialize();
}

// Namespace bots_gametype_super_shared
// Params 0
// Checksum 0x81d12b8a, Offset: 0x289
// Size: 0x1d2
function function_b32072b9681ff553()
{
    difficulties = level.bot_difficulties;
    
    if ( !isdefined( difficulties ) )
    {
        var_d468eda55a8ab0ca = getdvarfloat( @"hash_60ae0d4490076046", 20 );
        regularproportion = getdvarfloat( @"hash_55ccab727e144f34", 35 );
        hardenedproportion = getdvarfloat( @"hash_b3f66372fb38fccb", 35 );
        veteranproportion = getdvarfloat( @"hash_ff9490c8b80cf74f", 10 );
        totalproportion = var_d468eda55a8ab0ca + regularproportion + hardenedproportion + veteranproportion;
        assert( var_d468eda55a8ab0ca >= 0 );
        assert( regularproportion >= 0 );
        assert( hardenedproportion >= 0 );
        assert( veteranproportion >= 0 );
        assert( totalproportion > 0 );
        difficulties = spawnstruct();
        difficulties.recruitsection = var_d468eda55a8ab0ca / totalproportion;
        difficulties.regularsection = regularproportion / totalproportion + difficulties.recruitsection;
        difficulties.hardenedsection = hardenedproportion / totalproportion + difficulties.regularsection;
        difficulties.veteransection = veteranproportion / totalproportion + difficulties.hardenedsection;
        level.bot_difficulties = difficulties;
    }
    
    randompick = randomfloat( 1 );
    
    if ( randompick < difficulties.recruitsection )
    {
        return "recruit";
    }
    
    if ( randompick < difficulties.regularsection )
    {
        return "regular";
    }
    
    if ( randompick < difficulties.hardenedsection )
    {
        return "hardened";
    }
    
    if ( randompick < difficulties.veteransection )
    {
        return "veteran";
    }
    
    assertmsg( "<dev string:x24>" );
    return "regular";
}

// Namespace bots_gametype_super_shared
// Params 0, eflags: 0x4
// Checksum 0x394abf2a, Offset: 0x463
// Size: 0xbd
function private function_feab679ff95dfa4a()
{
    personalities = level.mind.personalities;
    targetvalue = randomfloat( 1 );
    sumvalue = 0;
    
    foreach ( name, personality in personalities )
    {
        sumvalue += personality.proportion;
        
        if ( targetvalue < sumvalue )
        {
            return name;
        }
    }
}

// Namespace bots_gametype_super_shared
// Params 6
// Checksum 0x8e9b34cf, Offset: 0x529
// Size: 0x150
function function_d59d37c2c0cb2cc9( meansofdeath = "", victim, attacker, damage, var_40c023f525b678b9, var_549921f89e97e6ec )
{
    if ( meansofdeath == "MOD_TRIGGER_HURT" && isdefined( victim ) && victim.plotarmortriggerhurt )
    {
        return 0;
    }
    
    if ( meansofdeath == "MOD_TRIGGER_HURT" || meansofdeath == "MOD_FALLING" || meansofdeath == "MOD_SUICIDE" || meansofdeath == "MOD_EXECUTION" || meansofdeath == "MOD_BUMP" || meansofdeath == "MOD_UNKNOWN" )
    {
        return damage;
    }
    
    attackerisbot = isbot( attacker );
    
    if ( !attackerisbot )
    {
        return damage;
    }
    
    var_c2f7dc18e3222b67 = isplayer( victim ) && !isbot( victim );
    
    if ( var_c2f7dc18e3222b67 )
    {
        ratio = function_ae1d39e3c9b0c835( attacker, victim, var_40c023f525b678b9 );
    }
    else if ( var_549921f89e97e6ec )
    {
        var_3f48f39671159fb9 = 0.8;
        ratio = getdvarfloat( @"hash_72dce163d860183a", var_3f48f39671159fb9 );
    }
    else
    {
        var_49abf78b68068df9 = 1.25;
        ratio = getdvarfloat( @"hash_19b1deee03b39dce", var_49abf78b68068df9 );
    }
    
    return damage * ratio;
}

// Namespace bots_gametype_super_shared
// Params 3, eflags: 0x4
// Checksum 0x9d7129b5, Offset: 0x682
// Size: 0x154
function private function_ae1d39e3c9b0c835( attackerbot, victimhuman, var_40c023f525b678b9 )
{
    assert( isbot( attackerbot ) && isplayer( victimhuman ) && !isbot( victimhuman ) );
    data = function_85d2c6d67ddb21d5( attackerbot );
    factor = data.factor;
    addend = data.addend;
    
    if ( var_40c023f525b678b9 )
    {
        data = bots_gametype_br_super::function_ec3e20ae39d43be9();
        
        if ( data )
        {
            factor += data.factor;
            addend += data.addend;
        }
    }
    
    factor = max( factor, 0 );
    addend = max( addend, 0 );
    health = victimhuman.health;
    maxhealth = victimhuman.maxhealth;
    
    if ( var_40c023f525b678b9 )
    {
        if ( isdefined( victimhuman.maxarmorhealth ) )
        {
            if ( victimhuman armor::hasarmor() )
            {
                health += victimhuman armor::getarmorhealth();
            }
            
            maxhealth += victimhuman.maxarmorhealth;
        }
    }
    
    healthpercentage = health / maxhealth;
    damageratio = healthpercentage * factor + addend;
    return clamp( damageratio, 0, 1 );
}

// Namespace bots_gametype_super_shared
// Params 1, eflags: 0x4
// Checksum 0x7889e94a, Offset: 0x7df
// Size: 0x13c
function private function_85d2c6d67ddb21d5( bot )
{
    difficulty = bot botgetdifficulty();
    
    if ( !isdefined( level.var_790bb6f809a8eea1.var_f88f2b7a63dff286[ difficulty ] ) )
    {
        if ( !isdefined( level.var_790bb6f809a8eea1 ) )
        {
            level.var_790bb6f809a8eea1 = {};
        }
        
        if ( !isdefined( level.var_790bb6f809a8eea1.var_f88f2b7a63dff286 ) )
        {
            level.var_790bb6f809a8eea1.var_f88f2b7a63dff286 = [];
        }
        
        factordvar = hashcat( @"hash_387cde307b36e7ad", difficulty );
        var_acd7945ee3db78bf = bot botgetdifficultysetting( "damageRatioToHumanFactor" );
        factorvalue = getdvarfloat( factordvar, var_acd7945ee3db78bf );
        var_7758d8d423601623 = hashcat( @"hash_4be22cd855af9cf8", difficulty );
        var_d345de82af5ee328 = bot botgetdifficultysetting( "damageRatioToHumanAddend" );
        var_4c72aea462fcc7a7 = getdvarfloat( var_7758d8d423601623, var_d345de82af5ee328 );
        level.var_790bb6f809a8eea1.var_f88f2b7a63dff286[ difficulty ] = { #addend:var_4c72aea462fcc7a7, #factor:factorvalue };
    }
    
    return level.var_790bb6f809a8eea1.var_f88f2b7a63dff286[ difficulty ];
}

// Namespace bots_gametype_super_shared
// Params 6
// Checksum 0xe850ec69, Offset: 0x924
// Size: 0x47b
function spawnbots( botinfoarray, team, botcallback, var_96b053bb0e850a74, var_84f55f032a811f8f, fixedspawndata = undefined )
{
    if ( getdvarint( @"hash_bf83ab2fda368593", 0 ) != 0 )
    {
        return;
    }
    
    level.bot_spawn_in_progress = 1;
    function_wait_time = gettime() + 15000;
    num_bots = botinfoarray.size;
    connectingarray = [];
    
    for ( botindex = connectingarray.size; level.players.size < bots_util_mp::bot_get_client_limit() && connectingarray.size < num_bots && gettime() < function_wait_time ; botindex++ )
    {
        hostmigration::waitlongdurationwithhostmigrationpause( 0.05 );
        botprofile = botinfoarray[ botindex ];
        
        if ( isdefined( botprofile.xuid ) )
        {
            bot = addbot( botprofile.name, botprofile.xuid, istrue( botprofile.uibot ) );
        }
        else
        {
            bot = addbot( botprofile.name );
        }
        
        if ( !isdefined( bot ) )
        {
            /#
                if ( gettime() >= function_wait_time )
                {
                    println( "<dev string:x72>" );
                }
                else
                {
                    println( "<dev string:xb8>" );
                }
            #/
            
            if ( var_96b053bb0e850a74 )
            {
                if ( isdefined( var_84f55f032a811f8f ) )
                {
                    self notify( var_84f55f032a811f8f );
                }
                
                return [];
            }
            
            hostmigration::waitlongdurationwithhostmigrationpause( 1 );
            continue;
        }
        
        assert( !isdefined( botprofile.bot ) );
        
        if ( botprofile.uibot )
        {
            ui_bot::spawnuibotlogic( bot, botprofile );
        }
        
        bot namespace_ddca46d216b096e2::function_30b9db7247f23009();
        bot bots::bot_set_xuid();
        connecting = spawnstruct();
        connecting.bot = bot;
        connecting.ready = 0;
        connecting.abort = 0;
        connecting.index = botindex;
        connecting.difficulty = botprofile.difficulty;
        connecting.mind_personality = botprofile.mind_personality;
        connecting.bot_squad = botprofile.squad;
        connectingarray[ connectingarray.size ] = connecting;
        
        /#
            if ( isdefined( fixedspawndata ) )
            {
                bot.pers[ #"fixedbotspawn" ] = 1;
                bot.pers[ #"fixedspawnorigin" ] = fixedspawndata.origin;
                bot.pers[ #"fixedspawnangles" ] = fixedspawndata.angles;
                
                if ( !isdefined( level.fixedspawnbots ) )
                {
                    level.fixedspawnbots = [];
                }
                
                level.fixedspawnbots[ level.fixedspawnbots.size ] = bot;
            }
        #/
        
        botteam = team ?? botprofile.team;
        connecting.bot thread bots::spawn_bot_latent( botteam, botcallback, connecting );
    }
    
    /#
        if ( gettime() >= function_wait_time )
        {
            println( "<dev string:xfc>" );
        }
    #/
    
    connectedcomplete = 0;
    function_wait_time = gettime() + 60000;
    
    while ( connectedcomplete < connectingarray.size && gettime() < function_wait_time )
    {
        connectedcomplete = 0;
        
        foreach ( connecting in connectingarray )
        {
            if ( connecting.ready || connecting.abort )
            {
                connectedcomplete++;
            }
        }
        
        wait 0.2;
    }
    
    botconnected = [];
    
    foreach ( connecting in connectingarray )
    {
        if ( isdefined( connecting.bot ) )
        {
            botconnected[ botconnected.size ] = connecting.bot;
        }
    }
    
    if ( isdefined( var_84f55f032a811f8f ) )
    {
        self notify( var_84f55f032a811f8f );
    }
    
    level.bot_spawn_in_progress = undefined;
    return botconnected;
}

// Namespace bots_gametype_super_shared
// Params 1
// Checksum 0xb1bac66e, Offset: 0xda8
// Size: 0x17
function function_4c57819a44d79e03( status )
{
    self.status = status;
}

// Namespace bots_gametype_super_shared
// Params 2
// Checksum 0x4719b3ca, Offset: 0xdc7
// Size: 0x46
function setscriptgoal( origin, radius )
{
    assert( radius == 0 || radius >= 4 );
    self botclearscriptgoal();
    self botsetscriptgoal( origin, radius, "tactical" );
    self botsetshorttermgoal( 1 );
}

// Namespace bots_gametype_super_shared
// Params 2
// Checksum 0x29e555a, Offset: 0xe15
// Size: 0x83
function function_95089351b7addf9f( randompoint, maxdistance )
{
    dist2d = distance2d( self.origin, randompoint );
    
    if ( !isdefined( maxdistance ) )
    {
        maxdistance = 2000;
    }
    
    if ( dist2d > maxdistance )
    {
        temppos = vectorlerp( self.origin, randompoint, maxdistance / dist2d );
        randompoint = bots_util_mp::function_1882f18076610076( ( temppos[ 0 ], temppos[ 1 ], self.origin[ 2 ] ) );
    }
    
    return self getclosestreachablepointonnavmesh( randompoint );
}

// Namespace bots_gametype_super_shared
// Params 1
// Checksum 0xaddeee4, Offset: 0xea1
// Size: 0x43
function setenemy( enemy )
{
    if ( self.scriptenemy == enemy && self.enemy == enemy )
    {
        return;
    }
    
    if ( isdefined( enemy ) )
    {
        self botsetscriptenemy( enemy );
        return;
    }
    
    self botclearscriptenemy();
}

// Namespace bots_gametype_super_shared
// Params 1
// Checksum 0xd8c96d47, Offset: 0xeec
// Size: 0x12
function isaliveplayer( player )
{
    return function_fe2ab4b94e839b08( player );
}

// Namespace bots_gametype_super_shared
// Params 1
// Checksum 0xd8c96d47, Offset: 0xf07
// Size: 0x12
function isvalidplayer( player )
{
    return bot_isvalidplayer( player );
}

// Namespace bots_gametype_super_shared
// Params 1, eflags: 0x4
// Checksum 0x22b51e96, Offset: 0xf22
// Size: 0x26, Type: bool
function private isvalidagent( agent )
{
    if ( !isagent( agent ) )
    {
        return false;
    }
    
    if ( !isalive( agent ) )
    {
        return false;
    }
    
    return true;
}

// Namespace bots_gametype_super_shared
// Params 1
// Checksum 0x25f86b95, Offset: 0xf51
// Size: 0x83, Type: bool
function isvalidtarget( player )
{
    if ( !isvalidplayer( player ) && !isvalidagent( player ) )
    {
        return false;
    }
    
    if ( isdefined( player.vehicle ) && player.vehicle.isheli )
    {
        var_3b3478d3ecf35221 = 658;
        
        if ( player.origin[ 2 ] - self.origin[ 2 ] > var_3b3478d3ecf35221 )
        {
            return false;
        }
    }
    
    return true;
}

// Namespace bots_gametype_super_shared
// Params 2
// Checksum 0xedaba913, Offset: 0xfdd
// Size: 0x137, Type: bool
function function_e4b76504b035bac7( var_88cc6b449181498c, ignoredcharacter = undefined )
{
    var_3aadc7bb5d9749ad = anglestoforward( self.angles );
    var_dc2795f4a888d67a = var_88cc6b449181498c - self.origin;
    
    if ( vectordot( var_dc2795f4a888d67a, var_3aadc7bb5d9749ad ) <= 0 )
    {
        return false;
    }
    
    var_3b155d6b0417e07f = var_88cc6b449181498c + ( 0, 0, 58 );
    var_fad8f532a78fcc6a = var_88cc6b449181498c + ( 0, 0, 29 );
    targetpositions = [ var_3b155d6b0417e07f, var_fad8f532a78fcc6a ];
    eyepos = self geteye();
    
    foreach ( targetpos in targetpositions )
    {
        if ( trace::ray_trace_passed( eyepos, targetpos, [ self, ignoredcharacter ] ) )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace bots_gametype_super_shared
// Params 1
// Checksum 0x1af5377c, Offset: 0x111d
// Size: 0x34
function function_8e48d7e569f73fa2( endedaction )
{
    if ( endedaction.exclusivegroup == "main" && isdefined( self ) )
    {
        setenemy( undefined );
        self botclearscriptgoal();
    }
}

// Namespace bots_gametype_super_shared
// Params 1
// Checksum 0xe6e9d209, Offset: 0x1159
// Size: 0x212
function function_d38100c0f2e7a5de( target )
{
    primaryequipment = equipment_mp::getequipmentslotammo( "primary" );
    secondaryequipment = equipment_mp::getequipmentslotammo( "secondary" );
    hasgrenade = primaryequipment > 0 || secondaryequipment > 0;
    
    if ( hasgrenade )
    {
        var_843f0518148a0d0e = distancesquared( self.origin, target.origin );
        var_eaf9b01ff180c014 = 211600;
        
        if ( var_843f0518148a0d0e < var_eaf9b01ff180c014 )
        {
            return;
        }
        
        var_b6c21a2a70d92530 = self botcanseeentity( target );
        
        if ( !var_b6c21a2a70d92530 )
        {
            var_e31876f851ddf11f = target gettagorigin( "j_spinelower" );
            var_b6c21a2a70d92530 = trace::can_see_origin( var_e31876f851ddf11f, undefined, undefined, undefined, 0 );
        }
        
        if ( !var_b6c21a2a70d92530 )
        {
            directiontotarget = vectornormalize( target.origin - self.origin );
            var_d2a606164b6b2d43 = ( directiontotarget[ 1 ], directiontotarget[ 0 ] * -1, 0 );
            var_b4a686695c93d34e = ( directiontotarget[ 1 ] * -1, directiontotarget[ 0 ], 0 );
            var_3db3a2bbb57461c = [];
            mainroot = target gettagorigin( "j_mainroot" );
            var_3db3a2bbb57461c[ var_3db3a2bbb57461c.size ] = target gettagorigin( "j_head" ) + ( 0, 0, 50 );
            var_3db3a2bbb57461c[ var_3db3a2bbb57461c.size ] = mainroot + var_d2a606164b6b2d43 * 50;
            var_3db3a2bbb57461c[ var_3db3a2bbb57461c.size ] = mainroot + var_b4a686695c93d34e * 50;
            var_3db3a2bbb57461c[ var_3db3a2bbb57461c.size ] = mainroot + var_d2a606164b6b2d43 * 100;
            var_3db3a2bbb57461c[ var_3db3a2bbb57461c.size ] = mainroot + var_b4a686695c93d34e * 100;
            
            foreach ( point in var_3db3a2bbb57461c )
            {
                if ( trace::can_see_origin( point, undefined, undefined, undefined, 0 ) )
                {
                    self botpressbutton( "lethal" );
                    break;
                }
            }
        }
    }
}

// Namespace bots_gametype_super_shared
// Params 1
// Checksum 0x34fa4377, Offset: 0x1373
// Size: 0x83
function getentityname( entity )
{
    assert( isent( entity ) );
    
    if ( isplayer( entity ) && !isbot( entity ) )
    {
        return ( "#" + entity getplayerunoid() );
    }
    else if ( isdefined( entity.name ) )
    {
        return entity.name;
    }
    else if ( isdefined( entity.persistent_unique_id ) )
    {
        return entity.persistent_unique_id;
    }
    
    return "entity" + entity getentitynumber();
}

// Namespace bots_gametype_super_shared
// Params 1, eflags: 0x4
// Checksum 0x3065b9e0, Offset: 0x13ff
// Size: 0x54, Type: bool
function private function_8a3c6d4ac7746b03( var_e93996f8c0e3c598 )
{
    for ( index = 0; index < var_e93996f8c0e3c598.size - 1 ; index++ )
    {
        current = var_e93996f8c0e3c598[ index ];
        next = var_e93996f8c0e3c598[ index + 1 ];
        
        if ( current > next )
        {
            return false;
        }
    }
    
    return true;
}

// Namespace bots_gametype_super_shared
// Params 3
// Checksum 0xdb4363cc, Offset: 0x145c
// Size: 0xdb
function function_3649fa69baa2da26( x, xvalues, yvalues )
{
    assert( function_8a3c6d4ac7746b03( xvalues ) );
    assert( xvalues.size > 0 && xvalues.size == yvalues.size );
    
    if ( x <= xvalues[ 0 ] )
    {
        return yvalues[ 0 ];
    }
    
    if ( x >= xvalues[ xvalues.size - 1 ] )
    {
        return yvalues[ yvalues.size - 1 ];
    }
    
    for ( i = 0; i < xvalues.size ; i++ )
    {
        xvalue = xvalues[ i ];
        
        if ( x < xvalue )
        {
            if ( i == 0 )
            {
                return yvalues[ 0 ];
            }
            
            rate = math::lerp_fraction( xvalues[ i - 1 ], xvalue, x );
            return math::lerp( yvalues[ i - 1 ], yvalues[ i ], rate );
        }
    }
    
    return yvalues[ yvalues.size - 1 ];
}

// Namespace bots_gametype_super_shared
// Params 1
// Checksum 0xcd949cdf, Offset: 0x1540
// Size: 0xb3, Type: bool
function function_4c51ebd039307c1a( player )
{
    foreach ( attacker in self.attackerdata )
    {
        if ( attacker.attackerent === player )
        {
            return ( !player.inlaststand && gettime() - attacker.lasttimedamaged < 5000 );
        }
    }
    
    return false;
}

/#

    // Namespace bots_gametype_super_shared
    // Params 0
    // Checksum 0xd74108d3, Offset: 0x15fc
    // Size: 0x58, Type: dev
    function setupdevgui()
    {
        humanplayer = bots::get_human_player();
        
        if ( !isdefined( humanplayer ) )
        {
            return;
        }
        
        cmd = "<dev string:x11e>";
        adddevguicmd( cmd );
        cmd = "<dev string:x17b>";
        adddevguicmd( cmd );
        level thread function_52595cd6bd52595e();
        humanplayer thread function_c7dcb61fe7965912();
    }

    // Namespace bots_gametype_super_shared
    // Params 1
    // Checksum 0xe8d05d82, Offset: 0x165c
    // Size: 0x177, Type: dev
    function adddevguicmd( command )
    {
        finalcommand = "<dev string:x1e8>";
        alltokens = strtok( command, "<dev string:x1e9>" );
        tokensnumber = 0;
        
        foreach ( tok in alltokens )
        {
            token = strtok( tok, "<dev string:x1eb>" );
            count = 1;
            size = token.size;
            
            foreach ( new_tok in token )
            {
                if ( count < size )
                {
                    finalcommand = finalcommand + new_tok + "<dev string:x1eb>";
                }
                else
                {
                    finalcommand += new_tok;
                }
                
                count++;
            }
            
            tokensnumber++;
            
            if ( tokensnumber < alltokens.size )
            {
                finalcommand += "<dev string:x1e9>";
            }
        }
        
        adddebugcommand( finalcommand );
    }

    // Namespace bots_gametype_super_shared
    // Params 0, eflags: 0x4
    // Checksum 0x4dc8bfd, Offset: 0x17db
    // Size: 0xdf, Type: dev
    function private function_52595cd6bd52595e()
    {
        level endon( #"game_ended" );
        
        while ( !isdefined( level.players ) )
        {
            wait 1;
        }
        
        setdvarifuninitialized( @"hash_283524741d876bcd", 0 );
        showoutline = 0;
        var_f8a425430b5b42df = 0;
        
        for ( var_f5514d8edb879cee = 0; true ; var_f5514d8edb879cee = 1 )
        {
            if ( var_f5514d8edb879cee || showoutline != getdvarint( @"hash_283524741d876bcd", 0 ) )
            {
                showoutline = getdvarint( @"hash_283524741d876bcd", 0 );
                var_f5514d8edb879cee = 0;
                
                if ( showoutline > 0 )
                {
                    function_bfb09f4cad46a842( 1 );
                    var_f8a425430b5b42df = 1;
                }
                else if ( var_f8a425430b5b42df )
                {
                    function_bfb09f4cad46a842( 0 );
                    var_f8a425430b5b42df = 0;
                }
            }
            
            msg = level utility::waittill_any_in_array_or_timeout( [ "<dev string:x1ed>" ], 1 );
            
            if ( msg == "<dev string:x1ed>" )
            {
            }
        }
    }

    // Namespace bots_gametype_super_shared
    // Params 1, eflags: 0x4
    // Checksum 0xd5c479d6, Offset: 0x18c2
    // Size: 0xc5, Type: dev
    function private function_bfb09f4cad46a842( isvisible )
    {
        foreach ( player in level.players )
        {
            if ( !isbot( player ) )
            {
                continue;
            }
            
            if ( isvisible )
            {
                if ( isdefined( player.enemy ) )
                {
                    player hudoutlineenable( "<dev string:x1fc>" );
                }
                else
                {
                    player hudoutlineenable( "<dev string:x210>" );
                }
                
                continue;
            }
            
            player hudoutlinedisable();
        }
    }

    // Namespace bots_gametype_super_shared
    // Params 0, eflags: 0x4
    // Checksum 0x8e50c463, Offset: 0x198f
    // Size: 0x500, Type: dev
    function private function_c7dcb61fe7965912()
    {
        level endon( #"game_ended" );
        setdvarifuninitialized( @"bot_drawdebugstatus", 0 );
        setdvarifuninitialized( @"bot_drawdebugteam", 0 );
        const_text_color = ( 1, 0.94902, 0 );
        var_2bc8edc28cb19da0 = ( 1, 0.8, 0.5 );
        var_9153ff13fedc172c = 30;
        
        while ( true )
        {
            drawoption = getdvarint( @"bot_drawdebugstatus", 0 );
            
            if ( drawoption <= 0 )
            {
                wait 1;
                continue;
            }
            
            drawteam = getdvarint( @"bot_drawdebugteam", 0 );
            
            foreach ( bot in level.players )
            {
                eliminated = isbrgamemode() && bot bots_gametype_br_super::iseliminated();
                
                if ( !( isbot( bot ) || isautopilot( bot ) ) || eliminated )
                {
                    continue;
                }
                
                if ( drawteam )
                {
                    bots = teams::getteamdata( bot.team, "<dev string:x226>" );
                    
                    foreach ( teammate in bots )
                    {
                        if ( teammate == bot || !isvalidplayer( teammate ) )
                        {
                            continue;
                        }
                        
                        line( bot.origin, teammate.origin, ( 0, 0, 1 ), 1, 0, 1 );
                    }
                }
                
                scale = 0.75;
                
                if ( drawoption == 2 )
                {
                    distance = distance( self.origin, bot.origin );
                    scale = distance * 0.65 / 600;
                    
                    if ( scale < 0.4 )
                    {
                        scale = 0.4;
                    }
                }
                
                linespacing = -1 * scale * 10;
                printlocation = bot.origin;
                spectatingplayer = br_spectate::playergetspectatingplayer();
                printspectated = spectatingplayer == bot || self == bot;
                screenx = 600;
                screeny = 700;
                printstring = "<dev string:x233>" + bot.team + "<dev string:x23a>" + bot.name;
                print3d( printlocation, printstring, const_text_color, 1, scale, 1 );
                printlocation += ( 0, 0, linespacing );
                
                if ( printspectated )
                {
                    printtoscreen2d( screenx, screeny, printstring, var_2bc8edc28cb19da0, 1.5 );
                    screeny += var_9153ff13fedc172c;
                }
                
                if ( bot.status.size > 0 )
                {
                    printstring = "<dev string:x242>" + bot.status;
                    
                    if ( isdefined( bot.mind_personality ) )
                    {
                        printstring += "<dev string:x24b>" + bot function_20cee9cd0491ff06();
                    }
                    
                    printstring += "<dev string:x24b>" + bot function_f844ad24ed2e1ecf();
                    print3d( printlocation, printstring, const_text_color, 1, scale, 1 );
                    printlocation += ( 0, 0, linespacing );
                    
                    if ( printspectated )
                    {
                        printtoscreen2d( screenx, screeny, printstring, var_2bc8edc28cb19da0, 1.5 );
                        screeny += var_9153ff13fedc172c;
                    }
                }
                
                if ( isdefined( bot.mind ) )
                {
                    var_d162119b0c415d5c = 3;
                    decisions = bot mind::function_36d91754a4470861( var_d162119b0c415d5c );
                    
                    if ( decisions.size > 0 )
                    {
                        print3d( printlocation, "<dev string:x24f>" + decisions, const_text_color, 1, scale, 1 );
                        
                        if ( printspectated )
                        {
                            printtoscreen2d( screenx, screeny, "<dev string:x24f>" + decisions, var_2bc8edc28cb19da0, 1.5 );
                        }
                    }
                    
                    printlocation += ( 0, 0, linespacing );
                    
                    if ( printspectated )
                    {
                        screeny += var_9153ff13fedc172c;
                    }
                    
                    actions = bot mind::function_c5aeddd244a1f2b9();
                    
                    if ( actions.size > 0 )
                    {
                        print3d( printlocation, "<dev string:x25b>" + actions, const_text_color, 1, scale, 1 );
                        printlocation += ( 0, 0, linespacing );
                        
                        if ( printspectated )
                        {
                            printtoscreen2d( screenx, screeny, "<dev string:x25b>" + actions, var_2bc8edc28cb19da0, 1.5 );
                            screeny += var_9153ff13fedc172c;
                        }
                    }
                    
                    lasterror = bot mind::function_359be5e5e82f9bae();
                    
                    if ( isdefined( lasterror ) )
                    {
                        printstring = "<dev string:x265>" + lasterror;
                        print3d( printlocation, printstring, const_text_color, 1, scale, 1 );
                        printlocation += ( 0, 0, linespacing );
                        
                        if ( printspectated )
                        {
                            printtoscreen2d( screenx, screeny, printstring, var_2bc8edc28cb19da0, 1.5 );
                            screeny += var_9153ff13fedc172c;
                        }
                    }
                }
            }
            
            waitframe();
        }
    }

    // Namespace bots_gametype_super_shared
    // Params 0, eflags: 0x4
    // Checksum 0x96cc5461, Offset: 0x1e97
    // Size: 0x59, Type: dev
    function private function_20cee9cd0491ff06()
    {
        switch ( self.mind_personality )
        {
            case #"hash_7038dec66d8275be":
                return "<dev string:x27a>";
            case #"hash_6191aaef9f922f96":
                return "<dev string:x283>";
            default:
                assertmsg( "<dev string:x285>" );
                return "<dev string:x2a3>";
        }
    }

    // Namespace bots_gametype_super_shared
    // Params 0, eflags: 0x4
    // Checksum 0xdd7c7495, Offset: 0x1ef8
    // Size: 0x9d, Type: dev
    function private function_f844ad24ed2e1ecf()
    {
        switch ( self botgetdifficulty() )
        {
            case #"hash_29f66d99d48ef101":
                return "<dev string:x2ad>";
            case #"hash_284b2545dbaa82f7":
                return "<dev string:x2b7>";
            case #"hash_bd9217f8be6084ee":
                return "<dev string:x2c2>";
            case #"hash_b66ed8ef2f4f67f4":
                return "<dev string:x2cc>";
            case #"hash_7b0e2f2ed84f34":
                return "<dev string:x2d4>";
            case #"hash_75157a9ee3260b93":
                return "<dev string:x2dd>";
            default:
                assertmsg( "<dev string:x2df>" );
                return "<dev string:x2a3>";
        }
    }

#/
