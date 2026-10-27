// scripts\mp\agents\agent_utils.gsc  (hash_398091378a840fd8.gscc) (size: 34501 Bytes / 0x86c5 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x5ed0a008 (1590730760)
// size ...... 34501 (0x86c5)
// includes .. 13  (offset: 0x7f49)
// strings ... 84  (offset: 0x7fb1)
// dev strs .. 32  (offset: 0x84f9)
// exports ... 94  (offset: 0x5a75)
// cseg ...... 0x609 + 0x546c (0x5a75)
// imports ... 169 (offset: 0x6925)
// animtree1 . 0   (offset: 0x86c5)
// animtree2 . 0   (offset: 0x86c5)
#using scripts\asm\asm_bb;
#using scripts\common\ai;
#using scripts\common\callbacks;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\common\vehicle_ai;
#using scripts\mp\agents\common_agent_damage;
#using scripts\mp\armor;
#using scripts\mp\common\utility\debug;
#using scripts\mp\common\utility\debug_utility;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\equipment;
#using scripts\mp\flags;

#namespace agent_utils;

// Namespace agent_utils
// Params 0
// Checksum 0x80aa5780, Offset: 0x627
// Size: 0x69
function function_baae17b379cbf627()
{
    level.var_dd60cff6560fb12b = [];
    level.var_dd60cff6560fb12b[ "tier2" ] = getdvarint( @"hash_7e5512406a54dd39", 1 );
    level.var_dd60cff6560fb12b[ "tier3" ] = getdvarint( @"hash_7e5511406a54db06", 2 );
    level.var_dd60cff6560fb12b[ "jugg" ] = getdvarint( @"hash_bc69c0296b829cc6", 10 );
}

// Namespace agent_utils
// Params 1
// Checksum 0x633982e5, Offset: 0x698
// Size: 0x17a
function overridetier1( agent )
{
    if ( !isdefined( agent ) )
    {
        return;
    }
    
    if ( isint( agent ) )
    {
        return;
    }
    
    agent.var_2517193969180a2e = 1;
    body = undefined;
    head = undefined;
    weapon = undefined;
    grenade_type = undefined;
    grenadeammo = 0;
    var_d79d01e045a05ed2 = getdvarint( @"hash_261e9ce11934ffae", 50 );
    
    if ( randomintrange( 0, 100 ) < var_d79d01e045a05ed2 )
    {
        if ( isdefined( level.var_cec0acea1f6401cf ) )
        {
            grenade_type = agent [[ level.var_cec0acea1f6401cf ]]( 1 );
        }
        else
        {
            var_429063809711e232 = [ "equip_semtex", "equip_frag", "equip_gas_grenade" ];
            grenade_type = utility::array_random( var_429063809711e232 );
        }
        
        grenadeammo = getdvarint( @"hash_31607c7b3be624df", 1 );
    }
    
    if ( grenade_type )
    {
        if ( isdefined( equipment_mp::getweaponfromequipmentref( grenade_type ) ) )
        {
            grenade_type = equipment_mp::getweaponfromequipmentref( grenade_type );
        }
    }
    
    armor = getdvarint( @"hash_82ad0eab483e9f5a", 0 );
    
    if ( agent.armorplate_count < 0 )
    {
        agent.armorplate_count = 0;
    }
    
    agent overrideagentsettings( body, head, weapon, grenade_type, grenadeammo, armor );
    agent.tier = 1;
    agent.baseaccuracy = getdvarfloat( @"hash_8aa5333ca3f377e5", 0.95 );
}

// Namespace agent_utils
// Params 1
// Checksum 0x3558bd0c, Offset: 0x81a
// Size: 0x170
function overridetier2( agent )
{
    if ( !isdefined( agent ) )
    {
        return;
    }
    
    if ( isint( agent ) )
    {
        return;
    }
    
    agent.var_2517193969180a2e = 1;
    body = undefined;
    head = undefined;
    weapon = undefined;
    
    if ( isdefined( level.var_cec0acea1f6401cf ) )
    {
        grenade_type = agent [[ level.var_cec0acea1f6401cf ]]( 2 );
    }
    else
    {
        var_429063809711e232 = [ "semtex_mp", "frag_grenade_mp", "smoke_grenade_mp", "concussion_grenade_mp", "flash_grenade_mp", "gas_mp", "decoy_grenade_mp" ];
        grenade_type = utility::array_random( var_429063809711e232 );
    }
    
    grenadeammo = getdvarint( @"hash_31607d7b3be62712", 2 );
    armor = getdvarint( @"hash_82ad0dab483e9d27", 100 );
    
    if ( agent.armorplate_count < 0 )
    {
        agent.armorplate_count = 1;
    }
    
    helmet = level.var_dd60cff6560fb12b[ "tier2" ];
    agent overrideagentsettings( body, head, weapon, grenade_type, grenadeammo, armor, helmet );
    agent.tier = 2;
    agent.baseaccuracy = getdvarfloat( @"hash_8aa5303ca3f3714c", 1 );
}

// Namespace agent_utils
// Params 2
// Checksum 0x730170d4, Offset: 0x992
// Size: 0x18e
function overridetier3( agent, noweaponchange )
{
    if ( !isdefined( agent ) )
    {
        return;
    }
    
    if ( isint( agent ) )
    {
        return;
    }
    
    agent.var_7a6a03beaa00d46c = 1;
    body = undefined;
    head = undefined;
    weapon = undefined;
    
    if ( isdefined( level.var_cec0acea1f6401cf ) )
    {
        grenade_type = agent [[ level.var_cec0acea1f6401cf ]]( 3 );
    }
    else
    {
        var_429063809711e232 = [ "thermite_mp", "semtex_mp", "frag_grenade_mp", "smoke_grenade_mp", "concussion_grenade_mp", "flash_grenade_mp", "snapshot_grenade_mp", "gas_mp", "decoy_grenade_mp" ];
        grenade_type = utility::array_random( var_429063809711e232 );
    }
    
    grenadeammo = getdvarint( @"hash_31607e7b3be62945", 4 );
    armor = getdvarint( @"hash_82ad0cab483e9af4", 250 );
    
    if ( agent.armorplate_count < 0 )
    {
        agent.armorplate_count = 2;
    }
    
    helmet = level.var_dd60cff6560fb12b[ "tier3" ];
    agent overrideagentsettings( body, head, weapon, grenade_type, grenadeammo, armor, helmet );
    agent.tier = 3;
    agent.baseaccuracy = getdvarfloat( @"hash_8aa5313ca3f3737f", 1.05 );
}

// Namespace agent_utils
// Params 3
// Checksum 0x6fb5ddb, Offset: 0xb28
// Size: 0x1bf
function overridejugg( agent, weapon, var_b035dea752eb6c74 )
{
    if ( !isdefined( agent ) )
    {
        return;
    }
    
    agent.var_1db1f2ef9c7f9036 = 1200;
    agent.var_aaf12cbad4692c1b = 512;
    agent.goalheight = 1000;
    agent.var_2517193969180a2e = 0;
    
    if ( game_utility::getgametype() == "dmz" )
    {
        agent.shoulddropweapon = 0;
    }
    
    if ( getdvarint( @"hash_60645ea7f5bb11f6", 1 ) == 1 )
    {
        agent.var_de04c2fb38eec74a = 1;
    }
    else
    {
        agent.var_de04c2fb38eec74a = 0;
    }
    
    body = undefined;
    head = undefined;
    
    if ( !var_b035dea752eb6c74 )
    {
        grenade_type = function_c7ac99e13a55d70e();
        grenadeammo = getdvarint( @"hash_537fa443ce212a8a", 4 );
    }
    
    if ( isdefined( level.var_6697c2de42c7367 ) )
    {
        armor = level.var_6697c2de42c7367;
    }
    
    armor = 2500;
    helmethealth = getdvarint( @"scr_jugg_helmethealth", 2500 );
    agent.var_3286ca1ac5a94fb = 1;
    agent overrideagentsettings( body, head, weapon, grenade_type, grenadeammo, armor, helmethealth, 0 );
    agent.allowlongdeath = 0;
    agent.allowpain = 1;
    
    if ( isdefined( level.var_f8f66bdfc121c09 ) )
    {
        agent.var_9e34089b647899c5 = level.var_f8f66bdfc121c09;
    }
    
    agent.var_469e4ea30ce637a8 = 1;
    agent.baseaccuracy = getdvarfloat( @"hash_bf81930e3ff6d7eb", 1 );
}

// Namespace agent_utils
// Params 1
// Checksum 0x55ec1124, Offset: 0xcef
// Size: 0xa6
function overrideriotshield( agent )
{
    if ( !isdefined( agent ) )
    {
        return;
    }
    
    agent.var_de04c2fb38eec74a = 1;
    
    if ( agent.armorhealth > 0 )
    {
        agent.minpaindamage = int( agent.armorhealth / 2 );
    }
    
    agent enabletraversals( 0 );
    agent.var_6357802f7e466fae = 1;
    
    if ( isdefined( level.var_b1be51e9e95fa444 ) )
    {
        agent.var_9e34089b647899c5 = level.var_b1be51e9e95fa444;
    }
    
    agent.baseaccuracy = getdvarfloat( @"hash_48f1ebb27eaa1abb", 0.8 );
}

// Namespace agent_utils
// Params 1
// Checksum 0x3ba83fa3, Offset: 0xd9d
// Size: 0xc
function overridepow( agent )
{
    
}

// Namespace agent_utils
// Params 8
// Checksum 0xe9aea878, Offset: 0xdb1
// Size: 0x19c
function overrideagentsettings( body, head, weapon, grenade_type, grenadeammo, armor, helmet, blockexecution )
{
    if ( isdefined( body ) )
    {
        self setmodel( body );
    }
    
    if ( isdefined( head ) )
    {
        if ( isdefined( self.headmodel ) )
        {
            self detach( self.headmodel );
        }
        
        self attach( head, "", 1 );
        self.headmodel = head;
    }
    
    if ( isdefined( weapon ) )
    {
        self.weapon = weapon;
        utility::initweapon( self.weapon );
        self giveweapon( self.weapon );
        self setspawnweapon( self.weapon );
        self.bulletsinclip = weaponclipsize( self.weapon );
        self.primaryweapon = self.weapon;
    }
    
    if ( isdefined( grenade_type ) )
    {
        self.grenadeweapon = grenade_type;
    }
    
    if ( !isdefined( grenadeammo ) )
    {
        grenadeammo = 3;
    }
    
    self.grenadeammo = grenadeammo;
    
    if ( isdefined( armor ) )
    {
        self.armorhealth = int( armor );
        self.maxarmorhealth = int( armor );
        self.armorbreakfunc = &common_agent_damage::function_d1aff350047f9613;
    }
    
    if ( isdefined( helmet ) )
    {
        self.helmethealth = helmet;
        self.maxhelmethealth = helmet;
        self.var_6252beaf62201a30 = &common_agent_damage::function_3384dd53b83c8bf;
    }
    
    if ( blockexecution )
    {
        ai_blockexecution( 1 );
    }
    
    if ( armor > 0 )
    {
        function_b2aa0272588a7cdb( self, armor );
    }
}

// Namespace agent_utils
// Params 0
// Checksum 0x606b6404, Offset: 0xf55
// Size: 0x88
function function_4e993a7242cafcc2()
{
    if ( isdefined( self.armorhealth ) )
    {
        var_8851979933cb334a = self.var_4cabaa19388f29f7;
        
        if ( !isdefined( var_8851979933cb334a ) )
        {
            var_8851979933cb334a = getdvarint( @"hash_a69c6853620fc61f", 200 );
        }
        
        newhealth = min( self.armorhealth + var_8851979933cb334a, self.maxarmorhealth );
        armor::setarmorhealth( newhealth );
        self.armorplate_count -= 1;
        self.armorplate_lastusetime = gettime();
    }
}

// Namespace agent_utils
// Params 1
// Checksum 0xf7fec3c4, Offset: 0xfe5
// Size: 0x47
function ai_blockexecution( bool )
{
    if ( bool )
    {
        self.blockexecution = 1;
        val::set( "agent_blockExecution", "execution_victim", 0 );
        return;
    }
    
    self.blockexecution = 0;
    val::reset_all( "agent_blockExecution" );
}

// Namespace agent_utils
// Params 2
// Checksum 0x76b37857, Offset: 0x1034
// Size: 0x2f
function function_b2aa0272588a7cdb( agent, armor )
{
    if ( !level.var_a959ed5cd2b0fb0a )
    {
        agent.var_5609d8c260be3f0e = 0;
    }
}

// Namespace agent_utils
// Params 2
// Checksum 0xa50a9805, Offset: 0x106b
// Size: 0x64
function function_b102de469af94500( agent, var_7fdb4b2f6d5b70fc )
{
    if ( isagent( agent ) )
    {
        agent.var_7fdb4b2f6d5b70fc = var_7fdb4b2f6d5b70fc;
        return;
    }
    
    if ( isint( agent ) )
    {
        infopackage = function_d77442145c568a4e( agent );
        infopackage.var_7fdb4b2f6d5b70fc = var_7fdb4b2f6d5b70fc;
        function_86157c3fbf5fdea2( agent, infopackage );
    }
}

// Namespace agent_utils
// Params 0
// Checksum 0xf4a30a4d, Offset: 0x10d7
// Size: 0x36
function function_ae6f0da4f7ad0d7d()
{
    level.var_88b3cfa83abf5242 = [];
    level.var_88b3cfa83abf5242[ 1 ] = [];
    level.var_88b3cfa83abf5242[ 2 ] = [];
    level.var_88b3cfa83abf5242[ 3 ] = [];
}

// Namespace agent_utils
// Params 2
// Checksum 0xfafc60bb, Offset: 0x1115
// Size: 0x15
function function_c5a3c9817f49ef90( agent, aitype )
{
    
}

// Namespace agent_utils
// Params 4
// Checksum 0x8f8aabe5, Offset: 0x1132
// Size: 0x17a
function ai_forcethrowgrenade( targetorigin, grenadetype, offsetdist, var_26ee74c73ef0f823 )
{
    self endon( #"death" );
    self.throwingscriptgrenade = 1;
    
    if ( isdefined( offsetdist ) )
    {
        offsetdist = min( abs( offsetdist ), 256 );
        targetorigin += ( randomfloatrange( -1 * offsetdist, offsetdist ), randomfloatrange( -1 * offsetdist, offsetdist ), randomfloatrange( -1 * offsetdist, offsetdist ) );
    }
    
    stance = asm_bb::bb_getrequestedstance();
    
    if ( isdefined( self.currentpose ) )
    {
        stance = self.currentpose;
    }
    
    if ( !isdefined( stance ) )
    {
        stance = "stand";
    }
    
    if ( !isdefined( var_26ee74c73ef0f823 ) || var_26ee74c73ef0f823 == 1 )
    {
        [ animname, var_991cf64180f709de, offsetvect ] = function_bd11377c2de302e7( self.origin, targetorigin, stance, self.animsetname );
        [ launchpos, throwvect ] = function_f6ca7d21a42991fd( self, targetorigin, grenadetype, offsetvect );
    }
    
    self.var_c1c6c0454bc4a201 = targetorigin;
    self.var_f69be00bfc44b94 = throwvect;
    function_b92a39a92308fce6();
    self.var_c1c6c0454bc4a201 = undefined;
    self.var_f69be00bfc44b94 = undefined;
}

// Namespace agent_utils
// Params 0
// Checksum 0xc05d4c20, Offset: 0x12b4
// Size: 0x95
function function_b92a39a92308fce6()
{
    timeoutnotify = "ai_forceThrowGrenade_timeout";
    finishnotify = "ai_forceThrowGrenade_finish";
    ctimeout = 6;
    self endon( timeoutnotify );
    childthread function_b0ba6c03fcb9b540( ctimeout, timeoutnotify, finishnotify );
    
    while ( !self.isholdinggrenade && isdefined( self.var_c1c6c0454bc4a201 ) )
    {
        waitframe();
    }
    
    self.throwingscriptgrenade = 1;
    
    while ( self.isholdinggrenade && isdefined( self.var_c1c6c0454bc4a201 ) )
    {
        waitframe();
    }
    
    self.throwingscriptgrenade = 0;
    self notify( finishnotify );
}

// Namespace agent_utils
// Params 3
// Checksum 0x8ffe83d6, Offset: 0x1351
// Size: 0x2b
function function_b0ba6c03fcb9b540( t, notifyname, endonname )
{
    self endon( endonname );
    wait t;
    self notify( notifyname );
}

// Namespace agent_utils
// Params 1, eflags: 0x4
// Checksum 0xf9734c7a, Offset: 0x1384
// Size: 0x66
function private function_70e8d613c3c80369( agent )
{
    if ( isdefined( agent.node ) )
    {
        assert( isdefined( agent.node.angles ) );
        return anglestoforward( agent.node.angles );
    }
    
    return anglestoforward( agent.angles );
}

// Namespace agent_utils
// Params 4
// Checksum 0xd71172bd, Offset: 0x13f2
// Size: 0xbf
function function_f6ca7d21a42991fd( thrower, targetorigin, grenadetype, var_668d6ff72589857c )
{
    offset = ( 0, 0, 100 );
    
    if ( isdefined( var_668d6ff72589857c ) )
    {
        offset = var_668d6ff72589857c;
    }
    
    launchpos = thrower.origin + offset;
    throwvect = targetorigin - launchpos;
    throwvect = vectornormalize( throwvect );
    throwvect = ( throwvect[ 0 ], throwvect[ 1 ], 0 ) + ( 0, 0, 1 );
    dist = distance2d( launchpos, targetorigin );
    throwvect = throwvect * dist * function_e5d9f29f0de7cdff( grenadetype, dist );
    return [ launchpos, throwvect ];
}

// Namespace agent_utils
// Params 2, eflags: 0x4
// Checksum 0xd28ebd7a, Offset: 0x14ba
// Size: 0xc9
function private function_e5d9f29f0de7cdff( grenade_type, distancetotarget )
{
    switch ( grenade_type )
    {
        case #"hash_5e4ccaa178cac19c":
        case #"hash_8c7819f0a3fbd1e0":
            return 0.75;
        case #"hash_4cd748aa3895508a":
        case #"hash_70200b060d09d860":
            return 600;
        case #"hash_142a787e36d7d7ce":
        case #"hash_ab3485fa6834de47":
            if ( isdefined( distancetotarget ) && distancetotarget < 512 )
            {
                return 0.8;
            }
            
            return 0.6;
        case #"hash_34e7a4cd11aed6bc":
        case #"hash_5fca4943a78ace9c":
            return 180;
        case #"hash_7eed3e576b799b16":
            return 1;
        default:
            return 0.6;
    }
}

// Namespace agent_utils
// Params 2
// Checksum 0xa6e59d5e, Offset: 0x158b
// Size: 0x80
function function_b4b39ecdb3de8e6b( sourceorigin, targetorigin )
{
    distancetotarget = distance2dsquared( sourceorigin, targetorigin );
    
    if ( distancetotarget < 262144 )
    {
        return [ "grenade_throw_short", 0.6, ( 0, 10, 50 ) ];
    }
    
    return [ "grenade_throw", 0.5, ( 0, 0, 100 ) ];
}

// Namespace agent_utils
// Params 4
// Checksum 0x692ee644, Offset: 0x1613
// Size: 0x153
function function_bd11377c2de302e7( sourceorigin, targetorigin, stance, animsetname )
{
    distancetotarget = distance2dsquared( sourceorigin, targetorigin );
    throwoffset = function_bb5f3c43f2ada303( sourceorigin, targetorigin, stance, animsetname );
    
    switch ( stance )
    {
        case #"hash_d91940431ed7c605":
            if ( isdefined( distancetotarget ) && distancetotarget < 16384 )
            {
                return [ "grenade_prone_throw", 0.6, throwoffset ];
            }
            else
            {
                return [ "grenade_prone_throw", 0.5, throwoffset ];
            }
        case #"hash_3fed0cbd303639eb":
            if ( isdefined( distancetotarget ) && distancetotarget < 16384 )
            {
                return [ "grenade_crouch_throw", 0.6, throwoffset ];
            }
            else
            {
                return [ "grenade_crouch_throw", 0.5, throwoffset ];
            }
        default:
            if ( isdefined( distancetotarget ) && distancetotarget < 16384 )
            {
                return [ "grenade_throw_short", 0.6, throwoffset ];
            }
            else
            {
                return [ "grenade_throw", 0.5, throwoffset ];
            }
            
            break;
    }
}

// Namespace agent_utils
// Params 4
// Checksum 0xf1ddf0f2, Offset: 0x176e
// Size: 0x7c
function function_bb5f3c43f2ada303( sourceorigin, targetorigin, stance, animsetname )
{
    switch ( stance )
    {
        case #"hash_d91940431ed7c605":
            return getgrenadethrowoffset( "exposed_prone_throw_grenade", 0, animsetname );
        case #"hash_3fed0cbd303639eb":
            return getgrenadethrowoffset( "exposed_crouch_throw_grenade", 0, animsetname );
        default:
            return getgrenadethrowoffset( "exposed_throw_grenade", 0, animsetname );
    }
}

// Namespace agent_utils
// Params 1
// Checksum 0x2c9b7303, Offset: 0x17f2
// Size: 0x91
function function_c7ac99e13a55d70e( var_429063809711e232 )
{
    if ( isdefined( var_429063809711e232 ) )
    {
        return utility::array_random( var_429063809711e232 );
    }
    
    if ( !isdefined( level.var_6788ac4109778b4b ) )
    {
        level.var_6788ac4109778b4b = [ "thermite_mp", "semtex_mp", "frag_grenade_mp", "smoke_grenade_mp", "concussion_grenade_mp", "flash_grenade_mp", "snapshot_grenade_mp", "gas_mp", "decoy_grenade_mp" ];
    }
    
    return utility::array_random( level.var_6788ac4109778b4b );
}

// Namespace agent_utils
// Params 6
// Checksum 0xb7edfd54, Offset: 0x188c
// Size: 0x6b4
function function_5dd4fff15bd73459( agenttype, origin, angles, dormancyid, var_8735f083fb8a8924, isdemotion )
{
    if ( isdemotion )
    {
        var_b63827a9f258cef2 = function_1af167929351b62a( dormancyid );
        
        if ( isdefined( var_b63827a9f258cef2 ) )
        {
            function_43b479867a04e6fd( var_b63827a9f258cef2, dormancyid, 0 );
        }
    }
    
    infopackage = function_d77442145c568a4e( dormancyid );
    
    if ( var_8735f083fb8a8924 )
    {
        return function_a477b6ca6bf09168( agenttype, origin, angles, dormancyid, infopackage, isdemotion );
    }
    
    function_8e0d6f25ff035ee6( dormancyid, undefined, infopackage );
    
    if ( !isdefined( infopackage ) )
    {
        println( "<dev string:x24>" );
        return;
    }
    
    aitype = infopackage.aitype;
    priority = function_ae9005e87c0d5b0b( infopackage.priority );
    category = infopackage.category;
    subcategory = infopackage.subcategory;
    groupname = infopackage.groupname;
    team = infopackage.team;
    destination = undefined;
    subarea = infopackage.subarea;
    skipstealth = infopackage.skipstealth;
    behaviorpackage = infopackage.behaviorpackage;
    var_7fdb4b2f6d5b70fc = infopackage.var_7fdb4b2f6d5b70fc;
    spawnfunctions = infopackage.functionsonspawn;
    agentstruct = infopackage.agentstruct;
    var_ef5c1d36f4119efa = infopackage.var_ef5c1d36f4119efa;
    radiationattachment = infopackage.radiationattachment;
    insidegoalvolume = infopackage.insidegoalvolume;
    combatrole = infopackage.combatrole;
    var_9798188c1cb9a97b = infopackage.var_9798188c1cb9a97b;
    var_95ac5561735900db = infopackage.var_95ac5561735900db;
    var_cae8263562118c46 = infopackage.var_cae8263562118c46;
    awarenessoverride = infopackage.awarenessoverride;
    missionref = infopackage.missionref;
    vehicle = infopackage.vehicle;
    seatnumber = infopackage.seatnumber;
    var_fd204967f81acf49 = -1;
    ispromotion = 0;
    
    if ( level.var_15fb757c9b81d8c4 )
    {
        var_7daa92f0b31d997c = function_3ed5240bf923c004( dormancyid );
        
        if ( isdefined( var_7daa92f0b31d997c ) )
        {
            ispromotion = 1;
            var_eeba5f32e65c9a9c = function_9da605e21296da98( var_7daa92f0b31d997c );
            
            if ( isdefined( var_eeba5f32e65c9a9c ) )
            {
                if ( var_eeba5f32e65c9a9c.var_78625d3abacddec9 == "patrol" )
                {
                    var_fd204967f81acf49 = var_eeba5f32e65c9a9c.var_cc3f1daec9a07303;
                }
                
                origin = var_eeba5f32e65c9a9c.origin;
                angles = var_eeba5f32e65c9a9c.angles;
            }
        }
        
        groupid = function_d66b019d88a8c27( dormancyid );
    }
    
    var_1c91b4f4bf3bca9f = isdefined( groupid ) && function_4fad6763470ee31a( groupid );
    
    if ( var_1c91b4f4bf3bca9f )
    {
        var_fd204967f81acf49 = -1;
    }
    
    requestspawnagentfunc = utility::getsharedfunc( #"ai_mp_controller", #"hash_92dcfffa4c19a93" );
    agent = [[ requestspawnagentfunc ]]( aitype, origin, angles, priority, category, subcategory, groupname, team, destination, subarea, skipstealth, 1, undefined, var_7fdb4b2f6d5b70fc, undefined, radiationattachment, insidegoalvolume, combatrole, var_9798188c1cb9a97b, groupid, undefined, var_cae8263562118c46, awarenessoverride );
    
    if ( isdefined( agent ) )
    {
        agent.insidegoalvolume = insidegoalvolume;
        
        if ( ispromotion )
        {
            if ( behaviorpackage.behavior == "patrol" )
            {
                behaviorpackage.var_fd204967f81acf49 = var_fd204967f81acf49;
            }
        }
        
        agent.behaviorpackage = behaviorpackage;
        agent.var_95ac5561735900db = var_95ac5561735900db;
        agent.missionref = missionref;
        function_e1d61d098684f944( agent, agentstruct );
        var_d98277d53e3f3b38 = agent function_1bf00baa490a3962( agent.var_ef5c1d36f4119efa, var_ef5c1d36f4119efa );
        function_fa8c97ce7495ecaf( agent, var_d98277d53e3f3b38 );
        behavior_executebehaviorpackage = utility::getsharedfunc( #"ai_mp_controller", #"hash_eef1e1b9713bdbdf" );
        [[ behavior_executebehaviorpackage ]]( agent );
        agent.functionsonspawn = spawnfunctions;
        function_b96009140e540809( agent );
        
        if ( isdefined( level.areas[ subarea.areaname ][ "subAreas" ][ subarea.subareaname ].tuning.damagetypeoverride ) )
        {
            agent function_a6b3b1684b28b346( level.areas[ subarea.areaname ][ "subAreas" ][ subarea.subareaname ].tuning.damagetypeoverride );
        }
        
        var_a2da2dfb2d911da3 = isdefined( vehicle ) && isdefined( seatnumber ) && seatnumber != 15;
        
        if ( getdvarint( @"hash_4deba55716c47c46", 0 ) && var_a2da2dfb2d911da3 )
        {
            /#
                if ( getdvarint( @"hash_836e1ee4b3242cd2", 0 ) )
                {
                    groupid = function_d66b019d88a8c27( dormancyid );
                    println( "<dev string:x77>" + vehicle getentitynumber() + "<dev string:x8d>" + dormancyid + "<dev string:xa5>" + groupid + "<dev string:xb0>" + agent getentitynumber() + "<dev string:xd1>" + seatnumber );
                }
            #/
            
            agent.var_f60cb46dafea871e = infopackage.var_f60cb46dafea871e;
            agent.var_cef5d8d02e0c6afd = infopackage.var_cef5d8d02e0c6afd;
            vehicle_ai::function_f25ee752204f9f8b( vehicle, seatnumber, agent, dormancyid );
            
            /#
                if ( getdvarint( @"hash_836e1ee4b3242cd2", 0 ) )
                {
                    foreach ( lw in vehicle.lwriders )
                    {
                        println( "<dev string:x77>" + vehicle getentitynumber() + "<dev string:x8d>" + lw.dormancyid + "<dev string:xa5>" + lw.groupid + "<dev string:xe0>" + lw.seatnumber );
                    }
                }
            #/
        }
    }
    
    if ( agent.var_323430499142a512 )
    {
        agent thread [[ agent.var_323430499142a512 ]]( agent, dormancyid );
    }
    
    return agent;
}

// Namespace agent_utils
// Params 2, eflags: 0x4
// Checksum 0x9e3e18ab, Offset: 0x1f49
// Size: 0x199
function private function_1bf00baa490a3962( array1, array2 )
{
    var_d98277d53e3f3b38 = [];
    
    if ( array1.size )
    {
        foreach ( item in array1 )
        {
            if ( !item.bundlename )
            {
                logstring( "Found a forced drop item without a bundle name: " + item + " on this agent: " + self.agent_type + " here: " + self.origin );
                continue;
            }
            
            var_d98277d53e3f3b38[ item.bundlename ] = item;
        }
    }
    
    if ( array2.size )
    {
        foreach ( item in array2 )
        {
            if ( !item.bundlename )
            {
                logstring( "Found a forced drop item without a bundle name: " + item + " on this agent: " + self.agent_type + " here: " + self.origin );
                continue;
            }
            
            var_d98277d53e3f3b38[ item.bundlename ] = item;
        }
    }
    
    return arraycombine( var_d98277d53e3f3b38, [] );
}

// Namespace agent_utils
// Params 6
// Checksum 0x614397f8, Offset: 0x20eb
// Size: 0x1eb
function function_a477b6ca6bf09168( agenttype, origin, angles, dormancyid, infopackage, isdemotion )
{
    assert( isdefined( infopackage ) );
    assert( isdefined( infopackage.aitype ) );
    aitypename = removesubstr( infopackage.aitype, "actor_" );
    lwagentid = function_8234856093b76105( aitypename, infopackage.team, infopackage.var_cae8263562118c46 );
    
    if ( isdefined( lwagentid ) )
    {
        groupid = function_d66b019d88a8c27( dormancyid );
        var_1c91b4f4bf3bca9f = !isdemotion && isdefined( groupid ) && function_4fad6763470ee31a( groupid );
        
        if ( var_1c91b4f4bf3bca9f && isdefined( infopackage.behaviorpackage.var_aaf6f0ce2cb6508 ) )
        {
            function_4c9eaa14722abbe8( lwagentid, infopackage.behaviorpackage.var_aaf6f0ce2cb6508, origin );
        }
        else if ( !isdemotion && isdefined( infopackage.behaviorpackage.var_aaf6f0ce2cb6508 ) )
        {
            function_4c9eaa14722abbe8( lwagentid, infopackage.behaviorpackage.var_aaf6f0ce2cb6508, origin );
        }
        else if ( getdvarint( @"hash_4deba55716c47c46", 0 ) && isdefined( infopackage.vehicle ) && isdefined( infopackage.seatnumber ) && getdvarint( @"hash_4deba55716c47c46", 0 ) && infopackage.seatnumber != 15 )
        {
            function_eec9fe6e894070f3( lwagentid, infopackage.vehicle getentitynumber(), infopackage.seatnumber );
            function_28fe15d9e2bfab0d( groupid );
        }
        else
        {
            function_87f5ba010fc2e55b( lwagentid, origin );
        }
    }
    else
    {
        function_8e0d6f25ff035ee6( dormancyid, undefined, infopackage );
    }
    
    return lwagentid;
}

// Namespace agent_utils
// Params 1
// Checksum 0x83fc19e6, Offset: 0x22df
// Size: 0x2ae
function function_54c25c86c31896eb( agent )
{
    aitype = agent.agent_type;
    priority = agent.priority;
    category = agent.category;
    subcategory = agent.subcategory;
    groupname = agent.script_stealthgroup;
    destination = undefined;
    subarea = agent.subarea;
    team = agent.team;
    skipstealth = !agent.stealth_enabled;
    behaviorpackage = agent.behaviorpackage;
    var_7fdb4b2f6d5b70fc = agent.var_7fdb4b2f6d5b70fc;
    spawnfunctions = agent.functionsonspawn;
    agentstruct = function_86f7e46a7753eee0( agent );
    threatbiasgroup = agent.threatbiasgroup;
    var_ef5c1d36f4119efa = function_813fb93fad3172ab( agent );
    radiationattachment = agent.radiationattachment;
    insidegoalvolume = agent.insidegoalvolume;
    combatrole = agent.combatrole;
    var_9798188c1cb9a97b = agent.var_9798188c1cb9a97b;
    var_95ac5561735900db = agent.var_95ac5561735900db;
    var_cae8263562118c46 = agent.var_cae8263562118c46;
    awarenessoverride = agent.awarenessoverride;
    missionref = agent.missionref;
    vehicle = undefined;
    seatnumber = undefined;
    var_f60cb46dafea871e = undefined;
    var_cef5d8d02e0c6afd = undefined;
    
    if ( getdvarint( @"hash_4deba55716c47c46", 0 ) == 1 && isdefined( agent._blackboard.currentvehicle ) )
    {
        vehicle = agent._blackboard.currentvehicle;
        seatnumber = agent._blackboard.var_25799974c1f2939b;
        var_f60cb46dafea871e = agent.var_f60cb46dafea871e;
        var_cef5d8d02e0c6afd = agent.var_cef5d8d02e0c6afd;
    }
    
    return function_f0be63728857705c( aitype, priority, category, subcategory, groupname, team, destination, subarea, skipstealth, behaviorpackage, var_7fdb4b2f6d5b70fc, spawnfunctions, agentstruct, threatbiasgroup, var_ef5c1d36f4119efa, radiationattachment, insidegoalvolume, combatrole, var_9798188c1cb9a97b, var_95ac5561735900db, var_cae8263562118c46, awarenessoverride, missionref, vehicle, seatnumber, var_f60cb46dafea871e, var_cef5d8d02e0c6afd );
}

// Namespace agent_utils
// Params 3
// Checksum 0x2575710b, Offset: 0x2596
// Size: 0x3d0
function function_43b479867a04e6fd( agent, dormancyid, var_c2d1b1f57897b6ae )
{
    groupid = level.var_15fb757c9b81d8c4 ? function_d66b019d88a8c27( dormancyid ) : undefined;
    
    if ( var_c2d1b1f57897b6ae )
    {
        function_29b93f9d3dc9757c( groupid, agent, dormancyid );
        return;
    }
    
    agent.goingdormant = 1;
    
    if ( agent.var_870f90c5773f57d6 )
    {
        [[ agent.var_870f90c5773f57d6 ]]( agent, dormancyid );
    }
    
    if ( isdefined( agent.behaviorpackage ) && isdefined( agent.behaviorpackage.cqbnodes ) && agent.behaviorpackage.behavior == "cqb" )
    {
        foreach ( node in agent.behaviorpackage.cqbnodes )
        {
            if ( isdefined( node ) )
            {
                node.claimed = 0;
            }
        }
    }
    
    infopackage = function_54c25c86c31896eb( agent );
    
    if ( isdefined( infopackage.vehicle ) )
    {
        if ( getdvarint( @"hash_836e1ee4b3242cd2", 0 ) )
        {
            println( "<dev string:xec>" + agent getentitynumber() + "<dev string:xfb>" + dormancyid + "<dev string:xa5>" + groupid + "<dev string:x10f>" + infopackage.vehicle getentitynumber() + "<dev string:x124>" + infopackage.seatnumber );
        }
        
        assert( isdefined( groupid ) );
        vehicle_ai::function_68ffea92fc8dafc5( groupid, dormancyid, infopackage.vehicle, infopackage.seatnumber );
    }
    
    function_86157c3fbf5fdea2( dormancyid, infopackage );
    utility::callsharedfunc( #"poi", #"subarea_findandassignfordormancyid", agent.origin, infopackage.subarea, infopackage.destination, dormancyid );
    utility::callsharedfunc( #"ai_mp_controller", #"priority_setbydormancyid", dormancyid, function_ae9005e87c0d5b0b( infopackage.priority ) );
    utility::callsharedfunc( #"ai_mp_controller", #"hash_35dcbf8d092b58a2", dormancyid, infopackage.category, infopackage.subcategory, infopackage.subarea );
    utility::callsharedfunc( #"ai_mp_controller", #"hash_87d113f09dbe31bb", agent );
    utility::callsharedfunc( #"ai_mp_controller", #"hash_4fb7ab9f852006e6", agent );
    utility::callsharedfunc( #"poi", #"subarea_removeagentfrom", agent, infopackage.subarea );
    utility::callsharedfunc( #"behavior", #"hash_55bb0997b208356b", agent.cqbnode );
    
    if ( infopackage.agentstruct )
    {
        if ( infopackage.agentstruct.group && infopackage.agentstruct.var_66ed919d586cec20 )
        {
            [[ infopackage.agentstruct.var_66ed919d586cec20 ]]( agent, dormancyid );
            return;
        }
        
        if ( infopackage.agentstruct.fortress && level.fortressagentcallbacks.var_66ed919d586cec20 )
        {
            [[ level.fortressagentcallbacks.var_66ed919d586cec20 ]]( agent, dormancyid );
        }
    }
}

// Namespace agent_utils
// Params 3
// Checksum 0x2a251199, Offset: 0x296e
// Size: 0x1f9
function function_29b93f9d3dc9757c( groupid, lwagentid, dormancyid )
{
    assert( function_3ed5240bf923c004( dormancyid ) == lwagentid );
    infopackage = function_d77442145c568a4e( dormancyid );
    var_eeba5f32e65c9a9c = function_9da605e21296da98( lwagentid );
    
    if ( isdefined( var_eeba5f32e65c9a9c ) )
    {
        if ( var_eeba5f32e65c9a9c.var_78625d3abacddec9 == "patrol" && isdefined( var_eeba5f32e65c9a9c.var_cc3f1daec9a07303 ) )
        {
            infopackage.behaviorpackage.var_fd204967f81acf49 = var_eeba5f32e65c9a9c.var_cc3f1daec9a07303;
        }
    }
    
    /#
        if ( isdefined( infopackage.vehicle ) && isdefined( infopackage.seatnumber ) )
        {
            if ( getdvarint( @"hash_836e1ee4b3242cd2", 0 ) )
            {
                println( "<dev string:x133>" + lwagentid + "<dev string:x147>" + groupid + "<dev string:x166>" + dormancyid + "<dev string:x174>" + infopackage.vehicle getentitynumber() + "<dev string:x18b>" + infopackage.seatnumber );
            }
            
            riderfound = 0;
            
            foreach ( lwrider in infopackage.vehicle.lwriders )
            {
                if ( lwrider.dormancyid == dormancyid && lwrider.seatnumber == infopackage.seatnumber )
                {
                    riderfound = 1;
                    break;
                }
            }
            
            assert( riderfound );
            assert( isdefined( groupid ) );
        }
    #/
    
    assert( isdefined( infopackage ) );
    function_86157c3fbf5fdea2( dormancyid, infopackage );
}

// Namespace agent_utils
// Params 2
// Checksum 0x3932777d, Offset: 0x2b6f
// Size: 0x10b
function function_cdc6a152cfac853d( lwagentid, killed )
{
    if ( killed )
    {
        dormancyid = function_eab6a1ef4c367e4b( lwagentid );
        
        if ( isdefined( dormancyid ) )
        {
            infopackage = function_d77442145c568a4e( dormancyid );
            
            if ( isdefined( infopackage ) && isdefined( infopackage.agentstruct ) )
            {
                if ( isdefined( infopackage.agentstruct.group ) )
                {
                    [[ infopackage.agentstruct.ondeath ]]( dormancyid );
                }
                else if ( isdefined( level.fortressagentcallbacks ) && isdefined( level.fortressagentcallbacks.ondeath ) )
                {
                    [[ level.fortressagentcallbacks.ondeath ]]( dormancyid );
                }
            }
            
            if ( infopackage.vehicle )
            {
                infopackage.vehicle vehicle_ai::function_69ae68e26a68c8c7( dormancyid );
            }
            
            function_8e0d6f25ff035ee6( dormancyid, undefined, infopackage );
            infopackage callback::callback( #"hash_75dff854da9c4d73" );
        }
    }
}

// Namespace agent_utils
// Params 1
// Checksum 0x84784e71, Offset: 0x2c82
// Size: 0x98
function function_d6d4e4f85ad3876c( priority )
{
    if ( isint( priority ) )
    {
        return ( priority < 0 ? 0 : priority > 5 ? 5 : priority );
    }
    
    switch ( tolower( priority ) )
    {
        case #"hash_c49f372eec1c61c":
            return 1;
        case #"hash_7e89154a96f625d":
            return 2;
        case #"hash_c71b112fe04823d6":
            return 3;
        case #"hash_2f27546c22430661":
            return 4;
        case #"hash_1de65f6f9597841f":
            return 5;
        default:
            return 5;
    }
}

// Namespace agent_utils
// Params 1
// Checksum 0x67b45353, Offset: 0x2d22
// Size: 0x82
function function_ae9005e87c0d5b0b( importance )
{
    switch ( importance )
    {
        case 1:
            return "absolute";
        case 2:
            return "high";
        case 3:
            return "medium";
        case 4:
            return "low";
        case 5:
            return "filler";
        default:
            return "filler";
    }
}

// Namespace agent_utils
// Params 22
// Checksum 0xc8df42b, Offset: 0x2dac
// Size: 0x14a
function function_83ec6d81ae3010dd( aitype, origin, angles = ( 0, 0, 0 ), priority, category, subcategory, groupname, team, destination, subarea, skipstealth, behaviorpackage, threatbiasgroup, var_ef5c1d36f4119efa, radiationattachment, insidegoalvolume, combatrole, var_9798188c1cb9a97b, groupid, var_95ac5561735900db, awarenessoverride, mission )
{
    priority = function_d6d4e4f85ad3876c( priority );
    infopackage = function_f0be63728857705c( aitype, priority, category, subcategory, groupname, team, destination, subarea, skipstealth, behaviorpackage, undefined, undefined, undefined, threatbiasgroup, var_ef5c1d36f4119efa, radiationattachment, insidegoalvolume, combatrole, var_9798188c1cb9a97b, var_95ac5561735900db, undefined, awarenessoverride, mission );
    dormancyid = function_8d50218fd60d6346( origin, angles, aitype, priority, groupid );
    assert( dormancyid >= 0, "<dev string:x19c>" );
    function_86157c3fbf5fdea2( dormancyid, infopackage );
    return dormancyid;
}

// Namespace agent_utils
// Params 0
// Checksum 0xdea725f0, Offset: 0x2eff
// Size: 0x88
function dormancy_init()
{
    level.var_5aededa530361e29 = &function_5dd4fff15bd73459;
    level.var_da105458e50be04c = &function_43b479867a04e6fd;
    level.var_757a3c22b0e39a5a = &function_cdc6a152cfac853d;
    level.var_15fb757c9b81d8c4 = getdvarint( @"hash_c69456bc853363e0" ) == 1;
    level.allowdormancy = getdvarint( @"ai_allowdormancy", 0 );
    level.dormancystats = spawnstruct();
    level.dormancystats.var_b86f9258513f2261 = 0;
    level.var_87bd0b3632631717 = [];
}

// Namespace agent_utils
// Params 27
// Checksum 0xd0fac493, Offset: 0x2f8f
// Size: 0x234
function function_f0be63728857705c( aitype, priority, category, subcategory, groupname, team, destination, subarea, skipstealth, behaviorpackage, var_7fdb4b2f6d5b70fc, functionsonspawn, agentstruct, threatbiasgroup, var_ef5c1d36f4119efa, radiationattachment, insidegoalvolume, combatrole, var_9798188c1cb9a97b, var_95ac5561735900db, var_cae8263562118c46, awarenessoverride, missionref, vehicle, seatnumber, var_f60cb46dafea871e, var_cef5d8d02e0c6afd )
{
    infopackage = { #var_cef5d8d02e0c6afd:var_cef5d8d02e0c6afd, #var_f60cb46dafea871e:var_f60cb46dafea871e, #seatnumber:seatnumber, #vehicle:vehicle, #missionref:missionref, #awarenessoverride:awarenessoverride, #var_cae8263562118c46:var_cae8263562118c46, #var_95ac5561735900db:var_95ac5561735900db, #var_9798188c1cb9a97b:var_9798188c1cb9a97b, #combatrole:combatrole, #insidegoalvolume:insidegoalvolume, #radiationattachment:radiationattachment, #var_ef5c1d36f4119efa:var_ef5c1d36f4119efa, #threatbiasgroup:threatbiasgroup, #agentstruct:agentstruct, #functionsonspawn:functionsonspawn, #var_7fdb4b2f6d5b70fc:var_7fdb4b2f6d5b70fc, #behaviorpackage:behaviorpackage, #skipstealth:skipstealth, #subarea:subarea, #destination:destination, #team:team, #groupname:groupname, #subcategory:subcategory, #category:category, #priority:function_d6d4e4f85ad3876c( priority ), #aitype:aitype };
    return infopackage;
}

// Namespace agent_utils
// Params 2
// Checksum 0x73ed83fc, Offset: 0x31cc
// Size: 0x472
function function_86157c3fbf5fdea2( dormancyid, infopackage )
{
    assert( !isdefined( infopackage.combatrole ) || infopackage.combatrole < 4, "<dev string:x1bb>" + ( infopackage.combatrole ?? "<dev string:x1f5>" ) );
    assert( !isdefined( infopackage.priority ) || infopackage.priority < 8, "<dev string:x1ff>" + ( infopackage.priorityint ?? "<dev string:x1f5>" ) );
    assert( !isdefined( infopackage.missionref ) || infopackage.missionref < 2048, "<dev string:x23a>" + ( infopackage.missionref ?? "<dev string:x1f5>" ) );
    assert( !isdefined( infopackage.functionsonspawn ) || infopackage.functionsonspawn < 1024, "<dev string:x274>" + ( infopackage.functionsonspawn ?? "<dev string:x1f5>" ) );
    assert( !isdefined( infopackage.seatnumber ) || infopackage.seatnumber < 16, "<dev string:x2b4>" + ( infopackage.seatnumber ?? "<dev string:x1f5>" ) );
    var_d87d43f6c0196f26 = infopackage.combatrole ?? 0;
    var_d87d43f6c0196f26 += ( infopackage.priority ?? 1 ) << 2;
    var_d87d43f6c0196f26 += ( infopackage.skipstealth ?? 0 ) << 5;
    var_d87d43f6c0196f26 += int( infopackage.var_9798188c1cb9a97b ?? 0 ) << 6;
    var_d87d43f6c0196f26 += ( infopackage.missionref ?? 0 ) << 7;
    var_d87d43f6c0196f26 += ( infopackage.functionsonspawn ?? 0 ) << 18;
    var_d87d43f6c0196f26 += ( infopackage.seatnumber ?? 15 ) << 28;
    var_d87d43f6c0196f26 += ( infopackage.var_f60cb46dafea871e ?? 0 ) << 32;
    var_d87d43f6c0196f26 += ( infopackage.var_cef5d8d02e0c6afd ?? 0 ) << 33;
    allstrings = "";
    var_41bf1741d980ae51 = [ infopackage.aitype ?? "", infopackage.category ?? "", infopackage.subcategory ?? "", infopackage.team ?? "", infopackage.groupname ?? "", infopackage.var_7fdb4b2f6d5b70fc ?? "", infopackage.radiationattachment ?? "", infopackage.threatbiasgroup ?? "", infopackage.var_95ac5561735900db ?? "", infopackage.awarenessoverride ?? "" ];
    
    foreach ( str in var_41bf1741d980ae51 )
    {
        allstrings += str + ",";
    }
    
    var_79468be086ba4d51 = { #vehicle:infopackage.vehicle, #insidegoalvolume:infopackage.insidegoalvolume, #var_cae8263562118c46:infopackage.var_cae8263562118c46, #var_ef5c1d36f4119efa:infopackage.var_ef5c1d36f4119efa, #agentstruct:infopackage.agentstruct, #behaviorpackage:infopackage.behaviorpackage, #subarea:infopackage.subarea, #destination:infopackage.destination, #allstrings:allstrings, #var_d87d43f6c0196f26:var_d87d43f6c0196f26 };
    level.var_87bd0b3632631717[ dormancyid ] = var_79468be086ba4d51;
}

// Namespace agent_utils
// Params 1
// Checksum 0xa905f975, Offset: 0x3646
// Size: 0x265
function function_d77442145c568a4e( dormancyid )
{
    dormancyinfo = level.var_87bd0b3632631717[ dormancyid ];
    
    if ( !isdefined( dormancyinfo ) )
    {
        return;
    }
    
    struct = structcopy( dormancyinfo );
    assert( isstring( struct.allstrings ) );
    allstrings = struct.allstrings ?? "";
    struct.allstrings = undefined;
    strings = strtok( allstrings, ",", 1 );
    struct.aitype = strings[ 0 ];
    struct.category = strings[ 1 ];
    struct.subcategory = strings[ 2 ];
    struct.team = strings[ 3 ];
    struct.groupname = strings[ 4 ];
    struct.var_7fdb4b2f6d5b70fc = strings[ 5 ];
    struct.radiationattachment = strings[ 6 ];
    struct.threatbiasgroup = strings[ 7 ];
    struct.var_95ac5561735900db = strings[ 8 ];
    struct.awarenessoverride = strings[ 9 ];
    assert( isint( struct.var_d87d43f6c0196f26 ) );
    var_d87d43f6c0196f26 = struct.var_d87d43f6c0196f26 ?? 0;
    struct.var_d87d43f6c0196f26 = undefined;
    struct.combatrole = var_d87d43f6c0196f26 & 3;
    struct.priority = var_d87d43f6c0196f26 >> 2 & 7;
    struct.skipstealth = ( var_d87d43f6c0196f26 & 32 ) == 32;
    struct.var_9798188c1cb9a97b = ( var_d87d43f6c0196f26 & 64 ) == 64;
    struct.missionref = var_d87d43f6c0196f26 >> 7 & 2047;
    struct.functionsonspawn = var_d87d43f6c0196f26 >> 18 & 1023;
    struct.seatnumber = var_d87d43f6c0196f26 >> 28 & 15;
    struct.var_f60cb46dafea871e = ( var_d87d43f6c0196f26 & 4294967296 ) == 4294967296;
    struct.var_cef5d8d02e0c6afd = ( var_d87d43f6c0196f26 & 8589934592 ) == 8589934592;
    
    if ( namespace_287664c3b016b734::exists( struct.category ) )
    {
        struct callback::function_99edd620ee45cd95( struct.category );
    }
    
    return struct;
}

// Namespace agent_utils
// Params 0
// Checksum 0x92b7c8b3, Offset: 0x38b4
// Size: 0x1e
function function_2ea3462d6f1960e7()
{
    assert( isdefined( level.var_87bd0b3632631717 ) );
    return level.var_87bd0b3632631717.size;
}

// Namespace agent_utils
// Params 0
// Checksum 0x6edade2a, Offset: 0x38db
// Size: 0x32
function function_771f3b959117f4e5()
{
    if ( !isdefined( level.var_258c09c8df9c8da9 ) )
    {
        level.var_258c09c8df9c8da9 = getdvarint( @"hash_ee8cf30f1e199e42", 200 ) - 1;
    }
    
    return level.var_258c09c8df9c8da9;
}

// Namespace agent_utils
// Params 2
// Checksum 0xb68f5fb0, Offset: 0x3916
// Size: 0x142
function function_585134f4744c6f80( dormancyid, category )
{
    cleardormantaientry( dormancyid );
    infopackage = function_d77442145c568a4e( dormancyid );
    
    if ( level.var_15fb757c9b81d8c4 && !isdefined( infopackage ) )
    {
        return;
    }
    
    if ( level.var_8532cd02459840d2 )
    {
        level thread debug_utility::drawsphere( function_c62e58693ace9312( dormancyid ).origin, 64, 500, ( 1, 0, 0 ) );
    }
    
    if ( isdefined( infopackage ) && isdefined( infopackage.agentstruct ) )
    {
        if ( isdefined( infopackage.agentstruct.group ) )
        {
            [[ infopackage.agentstruct.ondeath ]]( dormancyid );
        }
        else if ( isdefined( level.fortressagentcallbacks ) && isdefined( level.fortressagentcallbacks.ondeath ) )
        {
            [[ level.fortressagentcallbacks.ondeath ]]( dormancyid );
        }
    }
    
    if ( infopackage.vehicle )
    {
        infopackage.vehicle vehicle_ai::function_69ae68e26a68c8c7( dormancyid );
    }
    
    function_8e0d6f25ff035ee6( dormancyid, undefined, infopackage );
    infopackage callback::callback( #"hash_75dff854da9c4d73" );
}

// Namespace agent_utils
// Params 3
// Checksum 0x521e9869, Offset: 0x3a60
// Size: 0xc6
function function_8e0d6f25ff035ee6( dormancyid, category, infopackage = function_d77442145c568a4e( dormancyid ) )
{
    subarea = infopackage.subarea;
    
    if ( !isdefined( category ) )
    {
        category = infopackage.category;
    }
    
    utility::callsharedfunc( #"ai_mp_controller", #"priority_removebydormancyid", dormancyid, infopackage.priority );
    utility::callsharedfunc( #"ai_mp_controller", #"hash_87d113f09dbe31bb", dormancyid, infopackage );
    
    if ( isdefined( subarea ) )
    {
        utility::callsharedfunc( #"poi", #"subarea_removeagentfrom", dormancyid, subarea );
    }
    
    level.var_87bd0b3632631717[ dormancyid ] = undefined;
}

// Namespace agent_utils
// Params 1
// Checksum 0xd28bf40f, Offset: 0x3b2e
// Size: 0x89
function function_b96009140e540809( agent )
{
    if ( !isagent( agent ) )
    {
        return;
    }
    
    if ( isdefined( agent.functionsonspawn ) )
    {
        for ( i = 0; i < 10 ; i++ )
        {
            shiftedbit = 1 << i;
            
            if ( shiftedbit > agent.functionsonspawn )
            {
                break;
            }
            
            if ( ( agent.functionsonspawn & shiftedbit ) == shiftedbit )
            {
                agent thread [[ level.var_ad68f2bf45f37e22[ i ] ]]( agent );
            }
        }
    }
}

// Namespace agent_utils
// Params 3
// Checksum 0xaf817976, Offset: 0x3bbf
// Size: 0x10e
function function_3d1ccb7ed2f7c332( agent, key, function )
{
    if ( !isfunction( function ) || !isdefined( agent ) || !isdefined( key ) )
    {
        return;
    }
    
    function_f6faa0a56e084859( key, function );
    
    if ( isagent( agent ) )
    {
        if ( !isdefined( agent.functionsonspawn ) )
        {
            agent.functionsonspawn = 0;
        }
        
        agent.functionsonspawn |= 1 << level.var_55a01b25dfe1d7f1[ key ].index;
        return;
    }
    
    if ( isint( agent ) )
    {
        infopackage = function_d77442145c568a4e( agent );
        
        if ( !isdefined( infopackage.functionsonspawn ) )
        {
            infopackage.functionsonspawn = 0;
        }
        
        infopackage.functionsonspawn |= 1 << level.var_55a01b25dfe1d7f1[ key ].index;
        function_86157c3fbf5fdea2( agent, infopackage );
    }
}

// Namespace agent_utils
// Params 3
// Checksum 0xec8a3a5b, Offset: 0x3cd5
// Size: 0x121
function function_50bb14a8f7b54037( agent, key, function )
{
    if ( !isfunction( function ) || !isdefined( agent ) || !isdefined( key ) )
    {
        return;
    }
    
    function_f6faa0a56e084859( key, function );
    
    if ( isagent( agent ) )
    {
        if ( !isdefined( agent.functionsonspawn ) )
        {
            agent.functionsonspawn = 0;
        }
        
        agent.functionsonspawn &= ~( 1 << level.var_55a01b25dfe1d7f1[ key ].index );
        return;
    }
    
    if ( isint( agent ) && isdefined( level.var_87bd0b3632631717[ agent ] ) )
    {
        infopackage = function_d77442145c568a4e( agent );
        
        if ( !isdefined( infopackage.functionsonspawn ) )
        {
            infopackage.functionsonspawn = 0;
        }
        
        infopackage.functionsonspawn &= ~( 1 << level.var_55a01b25dfe1d7f1[ key ].index );
        function_86157c3fbf5fdea2( agent, infopackage );
    }
}

// Namespace agent_utils
// Params 2, eflags: 0x4
// Checksum 0x2a3fa6b0, Offset: 0x3dfe
// Size: 0xec
function private function_f6faa0a56e084859( functionstring, function )
{
    if ( !isdefined( level.var_55a01b25dfe1d7f1 ) )
    {
        level.var_55a01b25dfe1d7f1 = [];
    }
    
    if ( !isdefined( level.var_ad68f2bf45f37e22 ) )
    {
        level.var_ad68f2bf45f37e22 = [];
    }
    
    if ( !isdefined( level.var_55a01b25dfe1d7f1[ functionstring ] ) )
    {
        funcstruct = spawnstruct();
        funcstruct.func = function;
        funcstruct.index = level.var_55a01b25dfe1d7f1.size;
        assert( funcstruct.index < 10, "<dev string:x2ee>" );
        level.var_55a01b25dfe1d7f1[ functionstring ] = funcstruct;
    }
    
    index = level.var_55a01b25dfe1d7f1[ functionstring ].index;
    
    if ( !isdefined( level.var_ad68f2bf45f37e22[ index ] ) )
    {
        level.var_ad68f2bf45f37e22[ index ] = function;
    }
}

// Namespace agent_utils
// Params 2
// Checksum 0x3553b2c6, Offset: 0x3ef2
// Size: 0x23
function function_459c06de589c578f( agent, func )
{
    agent.var_870f90c5773f57d6 = func;
}

// Namespace agent_utils
// Params 2
// Checksum 0xc030c305, Offset: 0x3f1d
// Size: 0x23
function function_4fb45ea5ae33c5ad( agent, func )
{
    agent.var_323430499142a512 = func;
}

// Namespace agent_utils
// Params 1
// Checksum 0xbb5a59eb, Offset: 0x3f48
// Size: 0x22
function agent_sethealth( health )
{
    self.health = health;
    self.maxhealth = health;
}

// Namespace agent_utils
// Params 2
// Checksum 0x668515b0, Offset: 0x3f72
// Size: 0x63
function function_e1d61d098684f944( agent, struct )
{
    if ( isagent( agent ) )
    {
        agent.agentstruct = struct;
        return;
    }
    
    if ( isint( agent ) )
    {
        info = level.var_87bd0b3632631717[ agent ];
        
        if ( info )
        {
            info.agentstruct = struct;
        }
    }
}

// Namespace agent_utils
// Params 1
// Checksum 0x688040c5, Offset: 0x3fdd
// Size: 0x51
function function_86f7e46a7753eee0( agent )
{
    if ( isagent( agent ) )
    {
        return agent.agentstruct;
    }
    
    if ( isint( agent ) )
    {
        info = level.var_87bd0b3632631717[ agent ];
        return info.agentstruct;
    }
}

// Namespace agent_utils
// Params 2
// Checksum 0x90051ea1, Offset: 0x4036
// Size: 0x95
function function_fa8c97ce7495ecaf( agent, var_ef5c1d36f4119efa )
{
    if ( !var_ef5c1d36f4119efa || isarray( var_ef5c1d36f4119efa ) && var_ef5c1d36f4119efa.size == 0 )
    {
        var_ef5c1d36f4119efa = undefined;
    }
    else if ( !isarray( var_ef5c1d36f4119efa ) )
    {
        var_ef5c1d36f4119efa = [ var_ef5c1d36f4119efa ];
    }
    
    if ( isagent( agent ) )
    {
        agent.var_ef5c1d36f4119efa = var_ef5c1d36f4119efa;
        return;
    }
    
    if ( isint( agent ) )
    {
        info = level.var_87bd0b3632631717[ agent ];
        
        if ( info )
        {
            info.var_ef5c1d36f4119efa = var_ef5c1d36f4119efa;
        }
    }
}

// Namespace agent_utils
// Params 1
// Checksum 0x5aa20826, Offset: 0x40d3
// Size: 0x51
function function_813fb93fad3172ab( agent )
{
    if ( isagent( agent ) )
    {
        return agent.var_ef5c1d36f4119efa;
    }
    
    if ( isint( agent ) )
    {
        info = level.var_87bd0b3632631717[ agent ];
        return info.var_ef5c1d36f4119efa;
    }
}

// Namespace agent_utils
// Params 0
// Checksum 0x5efee8d8, Offset: 0x412c
// Size: 0x37
function function_e6724888010b2003()
{
    for ( i = 0; i < level.players.size ; i++ )
    {
        self getenemyinfo( level.players[ i ] );
    }
}

// Namespace agent_utils
// Params 1
// Checksum 0xe16e32bd, Offset: 0x416b
// Size: 0x6a
function gethealthmax( aitype )
{
    if ( !isdefined( aitype ) )
    {
        return;
    }
    
    if ( issubstr( aitype, "tier1" ) )
    {
        return level.var_b1650a317c7fca6e[ 0 ];
    }
    
    if ( issubstr( aitype, "tier2" ) )
    {
        return level.var_b1650a317c7fca6e[ 1 ];
    }
    
    if ( issubstr( aitype, "tier3" ) )
    {
        return level.var_b1650a317c7fca6e[ 2 ];
    }
}

// Namespace agent_utils
// Params 3
// Checksum 0x99dbdab4, Offset: 0x41de
// Size: 0x4bc
function function_a26c336f4af182bd( aigroup, aileaders, squadleaderfunc )
{
    squadleader = utility::array_random( aigroup );
    
    if ( isdefined( aileaders ) )
    {
        if ( isarray( aileaders ) )
        {
            squadleader = utility::array_random( aileaders );
        }
        else
        {
            squadleader = aileaders;
        }
    }
    
    if ( isdefined( squadleaderfunc ) )
    {
        level thread [[ squadleaderfunc ]]( squadleader );
    }
    
    /#
        if ( getdvarint( @"squad_debug", 0 ) > 0 )
        {
            squadleader hudoutlineenable( "<dev string:x330>" );
        }
    #/
    
    while ( true )
    {
        groupalive = 0;
        
        foreach ( ai in aigroup )
        {
            if ( !isalive( ai ) || ai.health < 1 )
            {
                continue;
            }
            
            groupalive = 1;
        }
        
        if ( !groupalive )
        {
            return;
        }
        
        if ( isalive( squadleader ) )
        {
            foreach ( ai in aigroup )
            {
                if ( !isdefined( ai ) )
                {
                    continue;
                }
                
                if ( ai == squadleader )
                {
                    continue;
                }
                
                if ( !isalive( ai ) || ai.health < 1 )
                {
                    continue;
                }
                
                if ( ai.goalent != squadleader )
                {
                    /#
                        if ( getdvar( @"squad_debug", "<dev string:x346>" ) != "<dev string:x346>" )
                        {
                            ai hudoutlineenable( "<dev string:x347>" );
                        }
                    #/
                    
                    ai setgoalentity( squadleader );
                    ai.goalent = squadleader;
                }
                
                var_8a4cc66f833d1abd = 0;
                players = level.players;
                
                if ( level.var_f8f564d5b2b09e05 ?? utility::function_645a77750f1850b5() )
                {
                    team = ai.team;
                    players = getentitiesinradiusfrompartitiongrid( squadleader.origin, squadleader.goalradius, createentitytypemask( [ "etype_player" ] ), [], team );
                    
                    if ( players.size )
                    {
                        var_8a4cc66f833d1abd = 1;
                    }
                }
                else
                {
                    foreach ( player in players )
                    {
                        if ( distance2dsquared( squadleader.origin, player.origin ) < squared( squadleader.goalradius ) )
                        {
                            var_8a4cc66f833d1abd = 1;
                        }
                    }
                }
                
                ai.goalradius = 256;
                
                if ( var_8a4cc66f833d1abd || distance2dsquared( squadleader.origin, ai.origin ) < squared( ai.goalradius ) )
                {
                    if ( distance2dsquared( squadleader.origin, ai.origin ) < squared( ai.goalradius ) )
                    {
                        ai.goalradius = 1200;
                    }
                }
            }
        }
        else
        {
            aigroup = function_5713d46873b29625( aigroup );
            
            if ( !aigroup.size )
            {
                return;
            }
            
            squadleader = utility::array_random( aigroup );
            
            if ( isdefined( aileaders ) )
            {
                alive = 0;
                
                foreach ( guy in aileaders )
                {
                    if ( !isalive( guy ) || guy.health < 1 )
                    {
                        continue;
                    }
                    
                    alive = 1;
                }
                
                if ( alive )
                {
                    if ( isarray( aileaders ) )
                    {
                        squadleader = utility::array_random( aileaders );
                    }
                    else
                    {
                        squadleader = aileaders;
                    }
                }
            }
            
            /#
                if ( getdvar( @"squad_debug", "<dev string:x346>" ) != "<dev string:x346>" )
                {
                    squadleader hudoutlineenable( "<dev string:x330>" );
                }
            #/
            
            if ( isdefined( squadleaderfunc ) )
            {
                level thread [[ squadleaderfunc ]]( squadleader );
            }
        }
        
        wait 1;
    }
}

// Namespace agent_utils
// Params 1
// Checksum 0x711f0afb, Offset: 0x46a2
// Size: 0x70
function function_f2c27b974ba879f9( trigger )
{
    enabled = getdvarint( @"hash_3d2d2d527cf543f9", 1 );
    
    if ( !enabled )
    {
        return;
    }
    
    if ( utility::issharedfuncdefined( #"game", #"makeenterexittrigger" ) )
    {
        [[ utility::getsharedfunc( #"game", #"makeenterexittrigger" ) ]]( trigger, &function_a04e399244fd59ab, &function_8fada1eae5abe47f );
    }
}

// Namespace agent_utils
// Params 2
// Checksum 0x9c5d57bd, Offset: 0x471a
// Size: 0xfe
function function_a04e399244fd59ab( soldier, trigger )
{
    if ( !isagent( soldier ) )
    {
        return;
    }
    
    if ( !isalive( soldier ) )
    {
        return;
    }
    
    if ( soldier.var_9c25269441156054 )
    {
        soldier.var_3af123405737ef7c = 1;
        soldier allowedstances( "stand" );
    }
    
    if ( function_443432814f1bd726( soldier ) )
    {
        return;
    }
    
    soldier.var_560915d16b8fb131 = spawnstruct();
    soldier.var_560915d16b8fb131.default_arch = soldier getbasearchetype();
    soldier.var_560915d16b8fb131.allowlongdeath = soldier.allowlongdeath;
    waterarc = "soldier_water";
    
    if ( soldier.var_560915d16b8fb131.default_arch == "juggernaut" )
    {
        waterarc = "juggernaut_water";
    }
    
    soldier setoverridearchetype( "default", waterarc, 0 );
    soldier.allowlongdeath = 0;
}

// Namespace agent_utils
// Params 2
// Checksum 0xe859a74, Offset: 0x4820
// Size: 0xfe
function function_8fada1eae5abe47f( soldier, trigger )
{
    if ( !isagent( soldier ) )
    {
        return;
    }
    
    if ( !isalive( soldier ) )
    {
        return;
    }
    
    if ( soldier.var_3af123405737ef7c )
    {
        soldier allowedstances( "crouch", "stand" );
    }
    
    if ( function_443432814f1bd726( soldier ) )
    {
        return;
    }
    
    archtoset = "soldier";
    
    if ( isdefined( soldier.var_560915d16b8fb131 ) && isdefined( soldier.var_560915d16b8fb131.default_arch ) )
    {
        archtoset = soldier.var_560915d16b8fb131.default_arch;
    }
    
    soldier setoverridearchetype( "default", archtoset, 0 );
    
    if ( isdefined( soldier.var_560915d16b8fb131 ) && isdefined( soldier.var_560915d16b8fb131.allowlongdeath ) )
    {
        soldier.allowlongdeath = soldier.var_560915d16b8fb131.allowlongdeath;
    }
}

// Namespace agent_utils
// Params 1
// Checksum 0x749932aa, Offset: 0x4926
// Size: 0x4d, Type: bool
function function_443432814f1bd726( soldier )
{
    enabled = getdvarint( @"hash_cb527a1b28e21dfd", 0 );
    
    if ( !enabled )
    {
        return false;
    }
    
    arch = soldier getbasearchetype();
    
    if ( arch == "juggernaut" )
    {
        return false;
    }
    
    return true;
}

// Namespace agent_utils
// Params 2
// Checksum 0x632a4130, Offset: 0x497c
// Size: 0x176
function function_25b40f5accbca0dd( nationality, agent_type )
{
    if ( isdefined( nationality ) )
    {
        switch ( nationality )
        {
            case #"hash_fa50b3f6bd82ee2b":
                return "team_hundred_ninety_five";
            case #"hash_3931080a2ee4d716":
            case #"hash_fa24c0f6bd607060":
            case #"hash_fa2ed3f6bd68dd0e":
            case #"hash_fa53bdf6bd853c80":
                return "team_hundred_ninety_four";
            case #"hash_4bc0839e1ade7b30":
                return "team_hundred_ninety_seven";
            case #"hash_8915246c51a3d9ff":
                return "team_hundred_ninety_eight";
            case #"hash_19b89634f50eeda4":
                return "team_hundred_ninety_nine";
        }
    }
    
    if ( !isdefined( nationality ) )
    {
        if ( issubstr( agent_type, "_sk" ) || issubstr( agent_type, "_pow_sk" ) )
        {
            return "team_hundred_ninety_five";
        }
        
        if ( issubstr( agent_type, "_ru" ) || issubstr( agent_type, "_nk" ) || issubstr( agent_type, "_mx" ) || issubstr( agent_type, "_cartel" ) )
        {
            return "team_hundred_ninety_four";
        }
        
        if ( issubstr( agent_type, "_biolab" ) )
        {
            return "team_hundred_ninety_seven";
        }
        
        if ( issubstr( agent_type, "_pmc" ) )
        {
            return "team_hundred_ninety_eight";
        }
        
        if ( issubstr( agent_type, "_merc" ) )
        {
            return "team_hundred_ninety_nine";
        }
        
        if ( issubstr( agent_type, "_wolf" ) )
        {
            return "team_hundred_ninety_two";
        }
        
        return "team_hundred_ninety_four";
    }
}

// Namespace agent_utils
// Params 2
// Checksum 0xd3173299, Offset: 0x4afa
// Size: 0x101, Type: bool
function detachifattached( model, basetag )
{
    attachsize = self getattachsize();
    
    for ( i = 0; i < attachsize ; i++ )
    {
        attach = self getattachmodelname( i );
        
        if ( attach != model )
        {
            continue;
        }
        
        tag = self getattachtagname( i );
        self detach( model, tag );
        
        if ( tag != basetag )
        {
            attachsize = self getattachsize();
            
            for ( i = 0; i < attachsize ; i++ )
            {
                tag = self getattachtagname( i );
                
                if ( tag != basetag )
                {
                    continue;
                }
                
                model = self getattachmodelname( i );
                self detach( model, tag );
                break;
            }
        }
        
        level thread debug::drawsphere( self.origin, 64, 30, ( 0, 1, 0 ) );
        return true;
    }
    
    level thread debug::drawsphere( self.origin, 64, 30, ( 1, 0, 0 ) );
    return false;
}

// Namespace agent_utils
// Params 1
// Checksum 0xae7e58, Offset: 0x4c04
// Size: 0x39
function register_soldier_damage_callback( func )
{
    if ( !isdefined( level.var_e8f6b03121a2f56d ) )
    {
        level.var_e8f6b03121a2f56d = [];
    }
    
    level.var_e8f6b03121a2f56d[ level.var_e8f6b03121a2f56d.size ] = func;
}

// Namespace agent_utils
// Params 1
// Checksum 0xef90503e, Offset: 0x4c45
// Size: 0x46
function function_1874e18b42e6d814( func )
{
    assert( isai( self ) );
    
    if ( !isdefined( self.var_e8f6b03121a2f56d ) )
    {
        self.var_e8f6b03121a2f56d = [];
    }
    
    self.var_e8f6b03121a2f56d[ self.var_e8f6b03121a2f56d.size ] = func;
}

// Namespace agent_utils
// Params 1
// Checksum 0x9190616f, Offset: 0x4c93
// Size: 0x39
function function_83de736d67f930bf( func )
{
    if ( !isdefined( self.var_2951937606aa477a ) )
    {
        self.var_2951937606aa477a = [];
    }
    
    self.var_2951937606aa477a[ self.var_2951937606aa477a.size ] = func;
}

// Namespace agent_utils
// Params 1
// Checksum 0x1cb41d2c, Offset: 0x4cd4
// Size: 0x4f
function function_bc89b9076dd93902( func )
{
    assert( isai( self ) || isplayer( self ) );
    
    if ( !isdefined( self.var_a6b60fbbf92080ed ) )
    {
        self.var_a6b60fbbf92080ed = [];
    }
    
    self.var_a6b60fbbf92080ed[ self.var_a6b60fbbf92080ed.size ] = func;
}

// Namespace agent_utils
// Params 1
// Checksum 0xe67d7dd1, Offset: 0x4d2b
// Size: 0x36
function function_e677ab9f3cd1927e( func )
{
    if ( !isarray( self.var_2951937606aa477a ) )
    {
        return;
    }
    
    self.var_2951937606aa477a = arrayremove( self.var_2951937606aa477a, func );
}

// Namespace agent_utils
// Params 1
// Checksum 0x6c54dc67, Offset: 0x4d69
// Size: 0x36
function function_b01fd53506fb21c3( func )
{
    if ( !isarray( self.var_e8f6b03121a2f56d ) )
    {
        return;
    }
    
    self.var_e8f6b03121a2f56d = arrayremove( self.var_e8f6b03121a2f56d, func );
}

// Namespace agent_utils
// Params 1
// Checksum 0xe71e4faf, Offset: 0x4da7
// Size: 0x36
function function_def5273cfe3c9109( func )
{
    if ( !isarray( self.var_a6b60fbbf92080ed ) )
    {
        return;
    }
    
    self.var_a6b60fbbf92080ed = arrayremove( self.var_a6b60fbbf92080ed, func );
}

// Namespace agent_utils
// Params 0
// Checksum 0x97ed78a5, Offset: 0x4de5
// Size: 0xf4
function build_subclass_to_aitype_map()
{
    map = [];
    
    foreach ( aitype in getaitypenames() )
    {
        aitypescriptbundle = getaitypescriptbundle( aitype );
        subclass_struct = getscriptbundle( hashcat( %"hash_138dab78b1b28a0f", aitypescriptbundle.subclass ) );
        
        if ( isdefined( subclass_struct ) )
        {
            if ( !isdefined( map[ subclass_struct.name ] ) )
            {
                map[ subclass_struct.name ] = [];
            }
            
            map[ subclass_struct.name ][ map[ subclass_struct.name ].size ] = aitype;
        }
    }
    
    return map;
}

// Namespace agent_utils
// Params 1
// Checksum 0x8e94f77a, Offset: 0x4ee2
// Size: 0x176
function get_aitype_by_subclass( subclass )
{
    if ( !isdefined( level.var_933df5d8c4e87f87 ) )
    {
        level.var_933df5d8c4e87f87 = 0;
    }
    
    aitypecount = getaitypecount();
    
    if ( !isdefined( level.var_57382c7d3b462f0d ) || level.var_933df5d8c4e87f87 != aitypecount )
    {
        level.var_933df5d8c4e87f87 = aitypecount;
        level.var_57382c7d3b462f0d = [];
        
        foreach ( aitype in getaitypenames() )
        {
            aitypescriptbundle = getaitypescriptbundle( aitype );
            subclass_struct = getscriptbundle( hashcat( %"hash_138dab78b1b28a0f", aitypescriptbundle.subclass ) );
            
            if ( isdefined( subclass_struct ) )
            {
                subname = subclass_struct.name;
                
                if ( !isdefined( level.var_57382c7d3b462f0d[ subname ] ) )
                {
                    level.var_57382c7d3b462f0d[ subname ] = [];
                }
                
                level.var_57382c7d3b462f0d[ subname ][ level.var_57382c7d3b462f0d[ subname ].size ] = aitype;
            }
        }
    }
    
    if ( isdefined( level.var_57382c7d3b462f0d[ subclass ] ) )
    {
        return level.var_57382c7d3b462f0d[ subclass ];
    }
    
    return [];
}

// Namespace agent_utils
// Params 0
// Checksum 0x655e92, Offset: 0x5061
// Size: 0x21
function despawnagent()
{
    self.skipdeathanim = 1;
    self.noragdoll = 1;
    ai::function_dd7b3233e5b07718( 1 );
}

// Namespace agent_utils
// Params 1
// Checksum 0x4542148, Offset: 0x508a
// Size: 0xee
function getaverageorigin( ent_array )
{
    avg_origin = ( 0, 0, 0 );
    
    if ( !ent_array.size )
    {
        return;
    }
    
    foreach ( ent in ent_array )
    {
        avg_origin += ent.origin;
    }
    
    avg_x = int( avg_origin[ 0 ] / ent_array.size );
    avg_y = int( avg_origin[ 1 ] / ent_array.size );
    avg_z = int( avg_origin[ 2 ] / ent_array.size );
    avg_origin = ( avg_x, avg_y, avg_z );
    return avg_origin;
}

// Namespace agent_utils
// Params 0
// Checksum 0x60fcf6d0, Offset: 0x5181
// Size: 0x44
function function_227c84ac1f64db33()
{
    if ( utility::issharedfuncdefined( #"hash_bcbc7bd4873098e7", #"init" ) )
    {
        level thread [[ utility::getsharedfunc( #"hash_bcbc7bd4873098e7", #"init" ) ]]();
        return;
    }
    
    level thread function_3b5b04459dffd95a();
}

// Namespace agent_utils
// Params 0
// Checksum 0x676d3a91, Offset: 0x51cd
// Size: 0x154
function function_3b5b04459dffd95a()
{
    level.var_4dc4d9854d55ae6e = [];
    level.var_4dc4d9854d55ae6e[ level.var_4dc4d9854d55ae6e.size ] = "sk";
    level.var_4dc4d9854d55ae6e[ level.var_4dc4d9854d55ae6e.size ] = "skp";
    ai_createthreatbiasgroup( "north_korea" );
    ai_createthreatbiasgroup( "south_korea" );
    ai_createthreatbiasgroup( "south_korea_pow" );
    ai_createthreatbiasgroup( "player" );
    ai_setignoremegroup( "north_korea", "south_korea_pow" );
    ai_setignoremegroup( "south_korea_pow", "north_korea" );
    ai_setignoremegroup( "south_korea_pow", "north_korea" );
    ai_setignoremegroup( "south_korea", "player" );
    ai_setignoremegroup( "south_korea_pow", "player" );
    ai_setignoremegroup( "player", "south_korea" );
    ai_setignoremegroup( "player", "south_korea_pow" );
    utility::flag_wait( "sentientpoolmanager_initialized" );
    ai_setignoremegroup( "Lethal_Static", "north_korea" );
    ai_setignoremegroup( "Tactical_Static", "north_korea" );
    
    if ( utility::issharedfuncdefined( #"hash_bcbc7bd4873098e7", #"customnationality" ) )
    {
        level thread [[ utility::getsharedfunc( #"hash_bcbc7bd4873098e7", #"customnationality" ) ]]();
    }
    
    level thread function_6a89e0bbbf8439f2();
}

// Namespace agent_utils
// Params 0
// Checksum 0x24740d42, Offset: 0x5329
// Size: 0x8c
function function_6a89e0bbbf8439f2()
{
    flags::function_2f3408423ccc9b2e( "prematch_done" );
    
    foreach ( player in level.players )
    {
        function_33f83956b1b9af77( player, "player" );
    }
}

// Namespace agent_utils
// Params 1
// Checksum 0x523264cd, Offset: 0x53bd
// Size: 0x13
function ai_createthreatbiasgroup( group )
{
    createthreatbiasgroup( group );
}

// Namespace agent_utils
// Params 3
// Checksum 0x28b21974, Offset: 0x53d8
// Size: 0x91
function function_4ba92f680237cedb( agent, group, var_c54b2a7f2e03e684 )
{
    if ( !isdefined( agent ) )
    {
        return;
    }
    
    if ( agent.var_ebd6d64805ad706d )
    {
        return;
    }
    
    if ( isagent( agent ) )
    {
        agent setthreatbiasgroup( group );
    }
    else if ( isint( agent ) )
    {
        package = function_d77442145c568a4e( agent );
        package.threatbiasgroup = group;
        function_86157c3fbf5fdea2( agent, package );
    }
    
    if ( var_c54b2a7f2e03e684 )
    {
        agent.var_ebd6d64805ad706d = 1;
    }
}

// Namespace agent_utils
// Params 2
// Checksum 0xf3616a7e, Offset: 0x5471
// Size: 0x2d
function function_33f83956b1b9af77( player, group )
{
    if ( !isdefined( player ) || !isdefined( group ) )
    {
        return;
    }
    
    player setthreatbiasgroup( group );
}

// Namespace agent_utils
// Params 3
// Checksum 0x43fff26, Offset: 0x54a6
// Size: 0x3d
function ai_setthreatbias( groupa, groupb, bias )
{
    if ( !( isdefined( groupa ) && isdefined( groupb ) ) )
    {
        return;
    }
    
    if ( !isdefined( bias ) )
    {
        return;
    }
    
    setthreatbias( groupa, groupb, bias );
}

// Namespace agent_utils
// Params 2
// Checksum 0x4dda32d8, Offset: 0x54eb
// Size: 0x2b
function ai_setignoremegroup( var_3063e837225c7b28, var_311a2b0d81ed7ee2 )
{
    if ( !( isdefined( var_3063e837225c7b28 ) && isdefined( var_311a2b0d81ed7ee2 ) ) )
    {
        return;
    }
    
    setignoremegroup( var_3063e837225c7b28, var_311a2b0d81ed7ee2 );
}

// Namespace agent_utils
// Params 2
// Checksum 0x37f24487, Offset: 0x551e
// Size: 0x23
function function_98d13aae520a6fbf( player, group )
{
    return player.var_90556b50e56beff8[ group ];
}

// Namespace agent_utils
// Params 3
// Checksum 0xb7348934, Offset: 0x554a
// Size: 0x2e
function function_3d40319b594473cb( player, group, status )
{
    player.var_90556b50e56beff8[ group ] = status;
}

// Namespace agent_utils
// Params 1
// Checksum 0xa44a8d59, Offset: 0x5580
// Size: 0xa4
function function_35d561fbfa55ea02( player )
{
    groupname = "player";
    
    foreach ( group in level.var_4dc4d9854d55ae6e )
    {
        groupname = groupname + "_" + group + function_98d13aae520a6fbf( player, group );
    }
    
    return groupname;
}

// Namespace agent_utils
// Params 1
// Checksum 0x8fc6fbea, Offset: 0x562d
// Size: 0xb6
function function_4731f4afdd4b04fd( player )
{
    player.var_90556b50e56beff8 = [];
    
    foreach ( group in level.var_4dc4d9854d55ae6e )
    {
        player.var_90556b50e56beff8[ group ] = 1;
    }
    
    startinggroup = function_35d561fbfa55ea02( player );
    function_33f83956b1b9af77( player, startinggroup );
}

// Namespace agent_utils
// Params 1
// Checksum 0xb94f30c, Offset: 0x56eb
// Size: 0x28
function function_d0d18e52b43c1bf0( nationality )
{
    switch ( nationality )
    {
        case #"hash_19b89634f50eeda4":
            return "sc";
    }
}

// Namespace agent_utils
// Params 2
// Checksum 0xb5e66b3a, Offset: 0x571b
// Size: 0x128
function function_90c51856f55da0a( agent, var_7fdb4b2f6d5b70fc )
{
    prefix = "agent_";
    postfix = "";
    
    if ( issubstr( agent.agent_type, "jugg" ) )
    {
        postfix = "jugg";
    }
    else if ( agent.subclass == "tier1" )
    {
        postfix = "tier1";
    }
    else if ( agent.subclass == "tier2" )
    {
        postfix = "tier2";
    }
    else if ( agent.subclass == "tier3" )
    {
        postfix = "tier3";
    }
    else if ( issubstr( agent.agent_type, "wolf" ) )
    {
        postfix = "wildlife";
    }
    
    if ( issubstr( agent.agent_type, "riotshield" ) )
    {
        postfix = "riotshield";
    }
    
    tbgroup = prefix + postfix;
    
    if ( postfix == "" )
    {
        return;
    }
    
    if ( !threatbiasgroupexists( tbgroup ) )
    {
        createthreatbiasgroup( tbgroup );
        function_a0e3d072aec6ee76( tbgroup );
    }
    
    agent setthreatbiasgroup( tbgroup );
}

// Namespace agent_utils
// Params 1
// Checksum 0x3a2711fb, Offset: 0x584b
// Size: 0x36
function function_a0e3d072aec6ee76( tbgroup )
{
    setthreatbias( tbgroup, "Drone", getdvarint( @"hash_4620216a9470ae72", -5000 ) );
    
    if ( issubstr( tbgroup, "tier1" ) )
    {
    }
}

// Namespace agent_utils
// Params 1
// Checksum 0xd3cf3c4d, Offset: 0x5889
// Size: 0x77
function function_a6b3b1684b28b346( category = "unset" )
{
    if ( category == "default" )
    {
        return;
    }
    
    if ( !isdefined( level.var_27992b614e2aed12 ) )
    {
        assertmsg( "<dev string:x35d>" );
        return;
    }
    
    if ( !isdefined( level.var_27992b614e2aed12[ category ] ) )
    {
        assertmsg( "<dev string:x3af>" + category );
        return;
    }
    
    self.damagecategory = level.var_27992b614e2aed12[ category ];
}

#namespace namespace_287664c3b016b734;

// Namespace namespace_287664c3b016b734
// Params 1
// Checksum 0x5b69210e, Offset: 0x5908
// Size: 0x73
function register( categoryname )
{
    assert( isstring( categoryname ), "<dev string:x3de>" + categoryname + "<dev string:x3ed>" );
    assert( !exists( categoryname ), "<dev string:x3de>" + categoryname + "<dev string:x3ff>" );
    function_56d1f269587ffc64( categoryname );
    
    if ( !isdefined( level.var_f66fe12c8c29cb75 ) )
    {
        level.var_f66fe12c8c29cb75 = [];
    }
    
    level.var_f66fe12c8c29cb75[ categoryname ] = 1;
}

// Namespace namespace_287664c3b016b734
// Params 1
// Checksum 0xb29fd102, Offset: 0x5983
// Size: 0x35, Type: bool
function exists( categoryname )
{
    assert( isstring( categoryname ), "<dev string:x3de>" + categoryname + "<dev string:x3ed>" );
    return isdefined( level.var_f66fe12c8c29cb75[ categoryname ] );
}

// Namespace namespace_287664c3b016b734
// Params 4
// Checksum 0xff145782, Offset: 0x59c1
// Size: 0x56
function add( categoryname, event, function, params )
{
    assert( isstring( categoryname ), "<dev string:x3de>" + categoryname + "<dev string:x3ed>" );
    callback::get_template( categoryname ) callback::add( event, function, params );
}

// Namespace namespace_287664c3b016b734
// Params 4
// Checksum 0xff145782, Offset: 0x5a1f
// Size: 0x56
function remove( categoryname, event, function, params )
{
    assert( isstring( categoryname ), "<dev string:x3de>" + categoryname + "<dev string:x3ed>" );
    callback::get_template( categoryname ) callback::remove( event, function, params );
}

