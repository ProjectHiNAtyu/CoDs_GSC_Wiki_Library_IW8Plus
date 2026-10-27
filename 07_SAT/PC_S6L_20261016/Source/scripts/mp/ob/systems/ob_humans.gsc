// scripts\mp\ob\systems\ob_humans.gsc  (hash_0a27124fa08ab811.gscc) (size: 18701 Bytes / 0x490d / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xc649cbcf (3326725071)
// size ...... 18701 (0x490d)
// includes .. 16  (offset: 0x42f9)
// strings ... 35  (offset: 0x4379)
// dev strs .. 73  (offset: 0x457d)
// exports ... 43  (offset: 0x2c6d)
// cseg ...... 0x44f + 0x281e (0x2c6d)
// imports ... 124 (offset: 0x3325)
// animtree1 . 0   (offset: 0x490d)
// animtree2 . 0   (offset: 0x490d)
#using scripts\anim\battlechatter;
#using scripts\anim\squadmanager;
#using scripts\common\ai\ai_spawn_director;
#using scripts\common\callbacks;
#using scripts\common\conditional_container;
#using scripts\common\devgui;
#using scripts\common\metabone;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\mp\agents\agent_juggernaut;
#using scripts\mp\agents\common_agent_damage;
#using scripts\mp\emp_debuff;
#using scripts\mp\mp_agent_damage;
#using scripts\mp\mp_dialogue;
#using scripts\mp\ob\systems\region_difficulty_manager;
#using scripts\mp\weapons;

#namespace ob_humans;

// Namespace ob_humans
// Params 0
// Checksum 0xad62230f, Offset: 0x46d
// Size: 0x5a
function ob_humans_init()
{
    utility::flag_wait( "ai_spawn_director_initialized" );
    function_f1f913f3f9de8e2a();
    _ob_humans_setup_callbacks();
    function_67b5bf41b5022de7( 5.6, 1, 1 );
    function_303d9de75f8fd9da( 1 );
    function_f03b4790912a8e21( 1 );
    level.var_5e4d3c587acb273d = getdvarint( @"hash_6f668dc8f1000dd5", 1 );
    
    /#
        function_c350f092e17b0a09();
    #/
}

// Namespace ob_humans
// Params 0, eflags: 0x4
// Checksum 0x2068fa46, Offset: 0x4cf
// Size: 0x11e
function private test_spawn_ai()
{
    level endon( #"game_ended" );
    
    while ( true )
    {
        if ( getdvarint( @"hash_4513fc3284eaab01", 0 ) )
        {
            setdvar( @"hash_4513fc3284eaab01", 0 );
            anchor = dospawnaitype( "actor_sat_ob_enemy_guild_bot", level.player.origin, ( 0, 0, 0 ), 1, 0, 1, 0, "team_hundred_ninety_nine" );
            var_e11792a13d1a5d15 = dospawnaitype( "actor_sat_ob_enemy_basic_soldier_long", level.player.origin, ( 0, 0, 0 ), 1, 0, 1, 0, "team_hundred_ninety_nine" );
            var_e1178fa13d1a567c = dospawnaitype( "actor_sat_ob_enemy_basic_soldier_long", level.player.origin, ( 0, 0, 0 ), 1, 0, 1, 0, "team_hundred_ninety_nine" );
            
            if ( getdvarint( @"hash_66175c5ff0964741", 1 ) == 1 )
            {
                function_6198eaa0deba2b53( anchor, [ var_e11792a13d1a5d15, var_e1178fa13d1a567c ] );
            }
        }
        
        waitframe();
    }
}

// Namespace ob_humans
// Params 0, eflags: 0x4
// Checksum 0x4918397c, Offset: 0x5f5
// Size: 0x10
function private function_f1f913f3f9de8e2a()
{
    battlechatter::init_battlechatter();
    mp_dialogue::main();
}

// Namespace ob_humans
// Params 0, eflags: 0x4
// Checksum 0xe0bf6fee, Offset: 0x60d
// Size: 0xaa
function private _ob_humans_setup_callbacks()
{
    level callback::add( "on_agent_spawned", &_ob_humans_spawned_callback );
    utility::registersharedfunc( #"vehicle_damage", #"hash_b1c3c93f0fe003bc", &_ob_humans_modify_vehicle_damage );
    ai_spawn_director::function_c83497dcedebe189( &function_3af58f077014ffab );
    level.agent_funcs[ "soldier" ][ "on_damaged" ] = &namespace_3d78262d89dbe647::callbacksoldieragentdamaged;
    level.agent_funcs[ "soldier" ][ "gametype_on_killed" ] = &mp_agent_damage::callbacksoldieragentgametypekilled;
    level.agent_funcs[ "juggernaut" ][ "on_damaged" ] = &agent_juggernaut::function_627f8022f4c1c67b;
    level.agent_funcs[ "juggernaut" ][ "gametype_on_killed" ] = &mp_agent_damage::callbacksoldieragentgametypekilled;
}

// Namespace ob_humans
// Params 3, eflags: 0x4
// Checksum 0x816b2148, Offset: 0x6bf
// Size: 0xcd
function private function_3af58f077014ffab( agent, requestid, spawndata )
{
    if ( agent.subclass == "ob_rusher" && spawndata.ambient )
    {
        agent.var_d3a2a716bfeea071 = 0;
        agent.var_bba3d9ff816f2d64 = 500;
    }
    
    if ( getdvarint( @"hash_2de596b7436af9e7", 0 ) == 1 )
    {
        if ( agent.agent_type == "actor_sat_ob_enemy_guild_bot" || agent.agent_type == "actor_sat_ob_enemy_guild_bot_cradle" || agent.agent_type == "actor_sat_ob_enemy_guild_bot_advanced" || agent.agent_type == "actor_sat_ob_enemy_guild_bot_advanced_short" )
        {
            agent thread function_f5025122ada2ea33();
        }
    }
}

// Namespace ob_humans
// Params 1, eflags: 0x4
// Checksum 0x6903fc78, Offset: 0x794
// Size: 0x4cb
function private _ob_humans_spawned_callback( params )
{
    agent = params.agent;
    agent.var_1c6903eff348c65f = 1;
    
    if ( agent.unittype == "zombie" )
    {
        return;
    }
    
    if ( agent.unittype == "juggernaut" )
    {
        agent.stealth_idledemeanor = "combat";
        agent.var_b52fca22f7f1e144 = "combat";
        agent.var_98976fabf7d4b227 = 1;
    }
    
    if ( agent.unittype == "dog" || agent.unittype == "juggernaut" )
    {
        agent.basemaxhealth = agent.maxhealth;
        agent.basearmorhealth = agent.armorhealth;
        agent.baseaccuracy = agent.baseaccuracy;
        function_c4d7909ef9fb38dc( agent );
        
        if ( isdefined( agent.subclass ) )
        {
            switch ( agent.subclass )
            {
                case #"hash_91cd18ea8bf6d95":
                    function_a28d1b2065d59f0b( agent );
                    break;
                case #"hash_2e6334b07cfe8d2f":
                    function_a28d1c2065d5a13e( agent );
                    break;
                case #"hash_92a7d793db56a6a8":
                case #"hash_b0491209df7b4b5c":
                    function_a28d1d2065d5a371( agent );
                    break;
                case #"hash_d792b257b9ee46a":
                case #"hash_380bf38c682aabc7":
                case #"hash_584d4aced1c589dd":
                case #"hash_e230bbf8bfc20d2c":
                    function_d5d459bb9cd396e6( agent );
                    break;
                default:
                    break;
            }
        }
    }
    else if ( agent.unittype == "soldier" )
    {
        agent.basemaxhealth = agent.maxhealth;
        agent.basearmorhealth = agent.armorhealth;
        agent.baseaccuracy = agent.baseaccuracy;
        function_c4d7909ef9fb38dc( agent );
        
        if ( isdefined( agent.subclass ) )
        {
            switch ( agent.subclass )
            {
                case #"hash_91cd18ea8bf6d95":
                case #"hash_b8776a7c6d24d388":
                    function_a6f123307217c8ca( agent );
                    break;
                case #"hash_5a24fffee0d81302":
                case #"hash_6bd0663d453b9ee4":
                case #"hash_b8776d7c6d24d841":
                case #"hash_e907579ab7e94379":
                case #"hash_ef4c998bcc00f823":
                case #"hash_f4609eba318d1829":
                    function_a6f122307217c697( agent );
                    break;
                case #"hash_3c0ffb3dab1a9835":
                case #"hash_806a6487959205af":
                case #"hash_92a7d793db56a6a8":
                case #"hash_b8776c7c6d24d6ae":
                case #"hash_c9beeb2ff7f370db":
                    function_a6f121307217c464( agent );
                    break;
                case #"hash_3794ac3fadfffd9c":
                    function_a0e4caecbc938459( agent );
                    break;
                case #"hash_b32707f6c3892f15":
                    function_23cbd6eaf78834ac( agent );
                    break;
                case #"hash_8c9a60f5aaf1352e":
                case #"hash_c2ef1b0372c25ca4":
                    function_d5d459bb9cd396e6( agent );
                    break;
                default:
                    break;
            }
        }
        
        function_e637a3e16eb0e265( agent );
        agent thread squadmanager::addtosquad();
        agent thread weapons::watchgrenadeusage();
        agent.var_f38802177d63ee0f = undefined;
        agent.var_a85521434d6ba8bd = 0;
        
        if ( agent function_7a4b6c8d8f5f0853() )
        {
            emp_debuff::add_emp_ent( agent );
            agent emp_debuff::set_apply_emp_callback( &function_d0fe6863190ffeb7 );
        }
        
        if ( agent.subclass != "ob_rusher" && agent.subclass != "ob_shielded" )
        {
            agent.pathenemylookahead = 120;
            agent.pathenemyfightdist = 320;
            agent.var_84426dee9fe37d6 = 180;
            agent.meleechargedistvsplayer = 150;
            agent.meleemaxzdiff = 50;
            agent.var_3b069f6418c8a803 = 50;
        }
    }
    
    if ( agent.unittype == "dog" || agent.unittype == "juggernaut" || agent.unittype == "soldier" )
    {
        agent.collide_with_ai = 1;
        val::set( "ob_humans_spawned", "collide_with_ai_allies", 0 );
        agent.var_87db68283cfc14fb = 1;
        agent.dontdamageriotshield = 1;
        agent thread function_7d06171c334e2bd();
        agent thread function_33ab822843871887();
    }
}

// Namespace ob_humans
// Params 0, eflags: 0x4
// Checksum 0x3ae3889d, Offset: 0xc67
// Size: 0xe, Type: bool
function private function_7a4b6c8d8f5f0853()
{
    return self.powertier == 1;
}

// Namespace ob_humans
// Params 1, eflags: 0x4
// Checksum 0x4c636162, Offset: 0xc7e
// Size: 0x49
function private function_d0fe6863190ffeb7( params )
{
    self notify( #"flashbang", self.origin, 1, undefined, params.attacker, params.attacker.team, 1.5 );
}

// Namespace ob_humans
// Params 1, eflags: 0x4
// Checksum 0x3810d54, Offset: 0xccf
// Size: 0x55
function private function_a6f123307217c8ca( agent )
{
    agent.powertier = 1;
    agent.var_2ffc71aa3aa17005 = 10;
    agent.var_cf5b234b05d52123 = 10;
    agent function_5c50b48c0c81d566( "all", 1 );
    agent function_5dd647bf875159d9( 1 );
    agent function_1dd77549fda16bb3( 0 );
}

// Namespace ob_humans
// Params 1, eflags: 0x4
// Checksum 0xc62fb0f, Offset: 0xd2c
// Size: 0xe5
function private function_a6f122307217c697( agent )
{
    agent.powertier = 2;
    agent.var_2ffc71aa3aa17005 = 150;
    agent.var_cf5b234b05d52123 = 30;
    
    if ( agent.subclass == "ob_sniper" )
    {
        agent.suppressionthreshold = 0.4;
        agent.suppressiondecrement = 0.2;
        agent.var_fa45176aba581c9a = 0.05;
        agent function_2ef9eb3349906d00( 4646 );
        agent setsightconfigtemplateoverride( "jup_sandbox_sniper" );
        setdvarifuninitialized( @"hash_de2405a9f72799dd", agent.baseaccuracy );
        agent.baseaccuracy = getdvarfloat( @"hash_de2405a9f72799dd" );
    }
    
    agent function_5c50b48c0c81d566( "all", 1 );
    agent function_5dd647bf875159d9( 1 );
    agent function_1dd77549fda16bb3( 1 );
}

// Namespace ob_humans
// Params 1, eflags: 0x4
// Checksum 0xa062d4d1, Offset: 0xe19
// Size: 0x128
function private function_23cbd6eaf78834ac( agent )
{
    agent.powertier = 2;
    agent.var_de04c2fb38eec74a = 1;
    agent.var_1cabc40f1f97e378 = getdvarfloat( @"hash_10cacdc3eb0966e", 3.3 );
    var_d5ae8d9ff7d863e2 = agent metabone::get_metabone_health( "shield" );
    var_d5ae8d9ff7d863e2 *= function_dab547bbe5a5731e( agent.difficulty );
    agent metabone::set_metabone_health( "shield", var_d5ae8d9ff7d863e2 );
    
    if ( agent.armorhealth > 0 )
    {
        agent.minpaindamage = int( agent.armorhealth * 0.083 );
        agent.var_2ffc71aa3aa17005 = int( agent.armorhealth * 0.5 );
        agent.var_cf5b234b05d52123 = int( agent.var_2ffc71aa3aa17005 * 0.1 );
    }
    
    agent.stealth_idledemeanor = "combat";
    agent.var_b52fca22f7f1e144 = "combat";
    agent.var_98976fabf7d4b227 = 1;
}

// Namespace ob_humans
// Params 1, eflags: 0x4
// Checksum 0x9827f644, Offset: 0xf49
// Size: 0x45
function private function_a0e4caecbc938459( agent )
{
    agent.powertier = 1;
    agent.var_2ffc71aa3aa17005 = 100;
    agent.var_cf5b234b05d52123 = 60;
    agent.paincooldown = 3000;
}

// Namespace ob_humans
// Params 1, eflags: 0x4
// Checksum 0x897b1c14, Offset: 0xf96
// Size: 0x80
function private function_a6f121307217c464( agent )
{
    agent.powertier = 3;
    agent.var_2ffc71aa3aa17005 = 450;
    agent.var_cf5b234b05d52123 = 100;
    agent.aggressivemode = 1;
    agent.var_1bf926518b0cb33 = 1;
    agent.allowlongdeath = 0;
    agent function_5c50b48c0c81d566( "all", 1 );
    agent function_5dd647bf875159d9( 1 );
    agent function_1dd77549fda16bb3( 1 );
}

// Namespace ob_humans
// Params 1, eflags: 0x4
// Checksum 0x16b202f, Offset: 0x101e
// Size: 0x1a
function private function_d5d459bb9cd396e6( agent )
{
    agent.powertier = 4;
}

// Namespace ob_humans
// Params 1, eflags: 0x4
// Checksum 0x570912af, Offset: 0x1040
// Size: 0x1a
function private function_a28d1b2065d59f0b( agent )
{
    agent.powertier = 1;
}

// Namespace ob_humans
// Params 1, eflags: 0x4
// Checksum 0xce004316, Offset: 0x1062
// Size: 0x1a
function private function_a28d1c2065d5a13e( agent )
{
    agent.powertier = 2;
}

// Namespace ob_humans
// Params 1, eflags: 0x4
// Checksum 0xb9077381, Offset: 0x1084
// Size: 0x1a
function private function_a28d1d2065d5a371( agent )
{
    agent.powertier = 3;
}

// Namespace ob_humans
// Params 0, eflags: 0x4
// Checksum 0xafc3413a, Offset: 0x10a6
// Size: 0x8b
function private function_33ab822843871887()
{
    self endon( #"death" );
    utility::flag_wait( "scriptables_ready" );
    utility::waittill_any_timeout( level.framedurationseconds, "post_spawn" );
    
    if ( utility::callsharedfunc( #"ai", #"hash_e2521119339c3814" ) )
    {
        return;
    }
    
    if ( self isscriptable() && self.aisettings.var_b6294232e54aa4d7 && !self.suppress_minimap_icon )
    {
        self setscriptablepartstate( "icon", "active", 0 );
    }
}

// Namespace ob_humans
// Params 3, eflags: 0x4
// Checksum 0x5a47686c, Offset: 0x1139
// Size: 0xc1
function private _ob_humans_modify_vehicle_damage( inflictor, objweapon, damage )
{
    if ( !isagent( inflictor ) )
    {
        return damage;
    }
    
    isplayervehicle = isdefined( self ) && isplayer( self.owner );
    
    if ( !isplayervehicle )
    {
        return damage;
    }
    
    maxdamage = undefined;
    
    if ( isdefined( objweapon ) )
    {
        class = weaponclass( objweapon );
        
        if ( isdefined( class ) )
        {
            switch ( class )
            {
                case #"hash_690c0d6a821b42e":
                    maxdamage = level.agentmaxdamage_shotgun;
                    break;
                default:
                    break;
            }
        }
    }
    
    if ( isdefined( maxdamage ) )
    {
        return min( damage, maxdamage );
    }
    
    return damage;
}

// Namespace ob_humans
// Params 1, eflags: 0x4
// Checksum 0x240ae383, Offset: 0x1202
// Size: 0x16
function private function_e637a3e16eb0e265( agent )
{
    agent function_2ef9eb3349906d00( 4000 );
}

// Namespace ob_humans
// Params 1
// Checksum 0x50028a89, Offset: 0x1220
// Size: 0x86
function function_5bc0e59d126a6295( difficulty )
{
    if ( isdefined( self.basemaxhealth ) )
    {
        self.maxhealth = self.basemaxhealth;
    }
    
    if ( isdefined( self.basearmorhealth ) )
    {
        self.armorhealth = self.basearmorhealth;
    }
    
    if ( isdefined( self.baseaccuracy ) )
    {
        self.baseaccuracy = self.baseaccuracy;
    }
    
    self.difficulty = difficulty;
    function_28afce4f7e8b77a8( difficulty );
    function_a5a95a7d592d023e( difficulty );
}

// Namespace ob_humans
// Params 1, eflags: 0x4
// Checksum 0xb3a79b7d, Offset: 0x12ae
// Size: 0x51
function private function_c4d7909ef9fb38dc( agent )
{
    agent.difficulty = region_difficulty_manager::get_region_difficulty( agent.origin );
    agent function_28afce4f7e8b77a8( agent.difficulty );
    agent function_a5a95a7d592d023e( agent.difficulty );
}

// Namespace ob_humans
// Params 1, eflags: 0x4
// Checksum 0xf63a09c4, Offset: 0x1307
// Size: 0x183
function private function_a5a95a7d592d023e( agent )
{
    agent = self;
    
    switch ( agent.difficulty )
    {
        case #"hash_af83e47edfa8900a":
            agent.baseaccuracy += 0.1;
            agent.var_3761ee502c4a6baa = getdvarfloat( @"hash_1adf88fd35fbac70", 5.8 );
            break;
        case #"hash_5343b465e56ec9a4":
            agent.baseaccuracy += 0.2;
            agent.var_3761ee502c4a6baa = getdvarfloat( @"hash_9fb6065532820021", 8.6 );
            break;
        case #"hash_651f76c0ad6741ec":
        case #"hash_c0250ffc2e87f2ff":
            agent.baseaccuracy += 0.4;
            agent.var_3761ee502c4a6baa = getdvarfloat( @"hash_1cd948eac84468fe", 10 );
            break;
        case #"hash_c02510fc2e87f492":
            agent.baseaccuracy += 1.5;
            agent.var_3761ee502c4a6baa = getdvarfloat( @"hash_1cd948eac84468fe", 10 );
            break;
        default:
            agent.var_3761ee502c4a6baa = getdvarfloat( @"hash_d402fcc65515a733", 3 );
            break;
    }
}

// Namespace ob_humans
// Params 1, eflags: 0x4
// Checksum 0x212da2c8, Offset: 0x1492
// Size: 0x93
function private function_28afce4f7e8b77a8( difficulty )
{
    agent = self;
    
    if ( agent.subclass == "ob_rusher" && ( difficulty == "difficulty5" || difficulty == "difficulty6" ) )
    {
        scalar = 37;
    }
    else
    {
        scalar = function_dab547bbe5a5731e( difficulty );
    }
    
    agent.maxhealth = int( agent.maxhealth * scalar );
    agent.health = agent.maxhealth;
}

// Namespace ob_humans
// Params 1
// Checksum 0xcea3d0cb, Offset: 0x152d
// Size: 0xdf
function function_dab547bbe5a5731e( difficulty )
{
    scalar = 1;
    
    switch ( difficulty )
    {
        case #"hash_af83e47edfa8900a":
            scalar = getdvarint( @"hash_e32fd1dee257f814", 4 );
            break;
        case #"hash_5343b465e56ec9a4":
            scalar = getdvarint( @"hash_5f226025cddb0281", 8 );
            break;
        case #"hash_651f76c0ad6741ec":
            scalar = getdvarint( @"hash_518759652912f3fa", 24 );
            break;
        case #"hash_c0250ffc2e87f2ff":
        case #"hash_c02510fc2e87f492":
            scalar = getdvarint( @"hash_fd51ecc28cb1d89f", 50 );
            break;
    }
    
    scalar *= getdvarfloat( @"hash_a296d84ecc8ab62a", level.gametypebundle.var_6cfc57a4b0d987d ?? 1 );
    return scalar;
}

// Namespace ob_humans
// Params 0, eflags: 0x4
// Checksum 0x4c1fff8e, Offset: 0x1615
// Size: 0x1a0
function private function_7fbc272397d7b648()
{
    self.bodyguardtarget = undefined;
    requestdata = function_9b649316adcccbaa( self.directorrequestid );
    besttarget = undefined;
    var_e8b8aaf927465809 = 0;
    var_f94c15f566eafbdd = squared( 400 );
    var_96ebfd9e13c40c32 = 100;
    
    foreach ( otheragent in requestdata.ai )
    {
        if ( otheragent == self )
        {
            continue;
        }
        
        if ( otheragent.unittype == "soldier" && otheragent.subclass != "ob_rusher" && !isalive( otheragent.bodyguard ) )
        {
            distsq = distancesquared( self.origin, otheragent.origin );
            
            if ( distsq > var_f94c15f566eafbdd )
            {
                continue;
            }
            
            if ( abs( otheragent.origin[ 2 ] - self.origin[ 2 ] ) > var_96ebfd9e13c40c32 )
            {
                continue;
            }
            
            if ( !isdefined( besttarget ) || distsq < var_e8b8aaf927465809 )
            {
                besttarget = otheragent;
                var_e8b8aaf927465809 = distsq;
            }
        }
    }
    
    if ( isdefined( besttarget ) )
    {
        self.bodyguardtarget = besttarget;
        self.bodyguardtarget.bodyguard = self;
    }
}

// Namespace ob_humans
// Params 0, eflags: 0x4
// Checksum 0xde8bf9d6, Offset: 0x17bd
// Size: 0x554
function private function_f5025122ada2ea33()
{
    self endon( #"death" );
    wait 1;
    
    if ( !isalive( self.enemy ) )
    {
        utility::waittill_any( "stealth_combat", "enemy" );
    }
    
    var_13fa5d298e1d8048 = self.var_aaf12cbad4692c1b;
    var_a492f1271bdfc6ec = self.var_4fb7740c7ac5d31d;
    basegoalheight = self.goalheight;
    basegoalradius = self.var_d4b1e70a1931ada9;
    
    while ( true )
    {
        function_7fbc272397d7b648();
        
        if ( isalive( self.bodyguardtarget ) )
        {
            while ( isalive( self.bodyguardtarget ) )
            {
                if ( abs( self.origin[ 2 ] - self.bodyguardtarget.origin[ 2 ] ) > 200 || distancesquared( self.origin, self.bodyguardtarget.origin ) > squared( 600 ) )
                {
                    self.bodyguardtarget.bodyguard = undefined;
                    self.bodyguardtarget = undefined;
                    continue;
                }
                
                if ( isalive( self.enemy ) )
                {
                    guarddistance = getdvarfloat( @"hash_555d8f2742f5821e", 100 );
                    var_fb0fb0e2d9878346 = self.enemy.origin - self.bodyguardtarget.origin;
                    var_f8aef51c3decdbdd = vectornormalize( var_fb0fb0e2d9878346 );
                    var_a5c7a43d6d9b5f96 = length( var_fb0fb0e2d9878346 );
                    offsetdistance = min( var_a5c7a43d6d9b5f96, guarddistance );
                    guardpos = self.bodyguardtarget.origin + var_f8aef51c3decdbdd * offsetdistance;
                    var_df1447c2ad536879 = self.origin - self.bodyguardtarget.origin;
                    projectionlength = vectordot( var_df1447c2ad536879, var_f8aef51c3decdbdd );
                    projectionlength = clamp( projectionlength, 0, var_a5c7a43d6d9b5f96 );
                    var_e049f3a93dfbf696 = self.bodyguardtarget.origin + var_f8aef51c3decdbdd * projectionlength;
                    var_3daaee394bdc0edf = self.origin - var_e049f3a93dfbf696;
                    var_3daaee394bdc0edf = vectornormalize( ( var_3daaee394bdc0edf[ 0 ], var_3daaee394bdc0edf[ 1 ], 0 ) );
                    horizontaloffset = getdvarfloat( @"hash_2df8076228a1cebf", 0 );
                    offsetpos = guardpos + var_3daaee394bdc0edf * horizontaloffset;
                    newgoalpos = self getclosestreachablepointonnavmesh( offsetpos, 0 );
                    
                    if ( isdefined( newgoalpos ) )
                    {
                        goalradius = getdvarfloat( @"hash_31d2b6615c3992a5", 30 );
                        self setgoalpos( newgoalpos, goalradius );
                        self.goalheight = 64;
                        self.var_d4b1e70a1931ada9 = min( goalradius, basegoalradius );
                        self.var_4fb7740c7ac5d31d = 0;
                        self.var_aaf12cbad4692c1b = 50;
                        self.var_de04c2fb38eec74a = 1;
                        
                        /#
                            if ( getdvarint( @"hash_9fc02dc1999e7076", 0 ) == 1 )
                            {
                                line( self.origin + ( 0, 0, 30 ), newgoalpos + ( 0, 0, 30 ), ( 0, 1, 0 ), 1, 1, 20 );
                                line( self.bodyguardtarget.origin + ( 0, 0, 30 ), guardpos + ( 0, 0, 30 ), ( 0.88, 0, 0.88 ), 1, 1, 20 );
                                line( guardpos + ( 0, 0, 30 ), self.enemy.origin + ( 0, 0, 30 ), ( 0, 0, 1 ), 1, 1, 20 );
                                line( guardpos + ( 0, 0, 30 ), newgoalpos + ( 0, 0, 30 ), ( 1, 1, 0 ), 1, 1, 20 );
                                circle( newgoalpos + ( 0, 0, 30 ), goalradius, ( 0, 0, 1 ), ( 0, 1, 0 ), 1, 20 );
                            }
                        #/
                    }
                    else
                    {
                        self setgoalpos( self.bodyguardtarget.origin, 256 );
                        self.var_aaf12cbad4692c1b = var_13fa5d298e1d8048;
                        self.var_4fb7740c7ac5d31d = var_a492f1271bdfc6ec;
                        self.var_d4b1e70a1931ada9 = basegoalradius;
                        self.goalheight = 64;
                        self.var_de04c2fb38eec74a = 1;
                    }
                }
                else
                {
                    self setgoalpos( self.bodyguardtarget.origin, 450 );
                    self.var_aaf12cbad4692c1b = var_13fa5d298e1d8048;
                    self.var_4fb7740c7ac5d31d = var_a492f1271bdfc6ec;
                    self.var_d4b1e70a1931ada9 = basegoalradius;
                    self.var_de04c2fb38eec74a = 1;
                    self.goalheight = 64;
                }
                
                wait 1;
            }
            
            continue;
        }
        
        self setgoalpos( self.origin, 450 );
        self.var_de04c2fb38eec74a = 0;
        self.var_aaf12cbad4692c1b = var_13fa5d298e1d8048;
        self.var_4fb7740c7ac5d31d = var_a492f1271bdfc6ec;
        self.var_d4b1e70a1931ada9 = basegoalradius;
        self.goalheight = basegoalheight;
        wait 5;
    }
}

// Namespace ob_humans
// Params 0, eflags: 0x4
// Checksum 0x67aa67c2, Offset: 0x1d19
// Size: 0xc6
function private function_7d06171c334e2bd()
{
    waitframe();
    
    if ( isdefined( self.script_parameters ) )
    {
        params = strtok( self.script_parameters, "," );
        
        foreach ( param in params )
        {
            if ( issubstr( param, "squadanchor" ) )
            {
                function_8434da9cc278751c();
                continue;
            }
            
            if ( issubstr( param, "squad_" ) )
            {
                self.squadtag = param;
            }
        }
    }
}

// Namespace ob_humans
// Params 0
// Checksum 0x11e48244, Offset: 0x1de7
// Size: 0x32
function function_8434da9cc278751c()
{
    self.isanchor = 1;
    self.tethers = [];
    self.numtethers = 0;
    self.var_c9d5df7287247508 = 0;
    thread function_463947d43f326ee5();
}

// Namespace ob_humans
// Params 1
// Checksum 0xdb96730d, Offset: 0x1e21
// Size: 0x80
function function_f6f7ea23c30f1381( anchor )
{
    assert( isdefined( anchor ), "<dev string:x24>" );
    self.istether = 1;
    self.var_51f9bf29507916c2 = anchor;
    anchor.tethers[ anchor.numtethers ] = self;
    self.tetherid = anchor.numtethers;
    anchor.numtethers += 1;
    thread function_67e32170c0738dc9();
}

// Namespace ob_humans
// Params 2
// Checksum 0xe0fd043f, Offset: 0x1ea9
// Size: 0xa4
function function_6198eaa0deba2b53( anchor, tethers )
{
    if ( !isarray( tethers ) )
    {
        tethers = [ tethers ];
    }
    
    anchor function_8434da9cc278751c();
    
    foreach ( var_6397278d3edbaba6 in tethers )
    {
        var_6397278d3edbaba6 function_f6f7ea23c30f1381( anchor );
    }
}

// Namespace ob_humans
// Params 0, eflags: 0x4
// Checksum 0xaeb6829, Offset: 0x1f55
// Size: 0xf5
function private function_463947d43f326ee5()
{
    self endon( #"death" );
    
    while ( true )
    {
        if ( self.bisincombat )
        {
            break;
        }
        
        waitframe();
    }
    
    wait 1;
    
    if ( isdefined( self.squadtag ) )
    {
        requestdata = function_9b649316adcccbaa( self.directorrequestid );
        
        foreach ( ai in requestdata.ai )
        {
            if ( ai != self && ai.squadtag == self.squadtag )
            {
                ai function_f6f7ea23c30f1381( self );
            }
        }
    }
    
    self notify( #"squad_up" );
}

// Namespace ob_humans
// Params 0, eflags: 0x4
// Checksum 0xccafcc44, Offset: 0x2052
// Size: 0x3d1
function private function_67e32170c0738dc9()
{
    self endon( #"death" );
    tetherradius = getdvarint( @"hash_5f33634b43d7a3ba", 75 );
    backoffset = getdvarint( @"hash_b68066744ef4cdd8", 75 );
    sideoffset = getdvarint( @"hash_442a51c9348fe088", 80 );
    
    if ( self.var_51f9bf29507916c2.var_d89300bd1ff5b42c )
    {
        tetherradius = self.var_51f9bf29507916c2.var_d89300bd1ff5b42c;
    }
    
    if ( self.var_51f9bf29507916c2.var_6b9bdc1b2c784c16 )
    {
        backoffset = self.var_51f9bf29507916c2.var_6b9bdc1b2c784c16;
    }
    
    if ( self.var_51f9bf29507916c2.var_1f427c09ffe756a )
    {
        sideoffset = self.var_51f9bf29507916c2.var_1f427c09ffe756a;
    }
    
    goright = self.tetherid % 2 == 1;
    
    while ( isalive( self.var_51f9bf29507916c2 ) )
    {
        if ( getdvarint( @"hash_66175c5ff0964741", 1 ) == 1 && self.var_51f9bf29507916c2.bisincombat )
        {
            if ( !self.var_51f9bf29507916c2.enemy )
            {
                waitframe();
                continue;
            }
            
            if ( getdvarint( @"hash_8210a35df64fdfa", 0 ) )
            {
                if ( self.var_51f9bf29507916c2.var_c9d5df7287247508 )
                {
                    waitframe();
                    continue;
                }
                
                self.var_51f9bf29507916c2.var_c9d5df7287247508 = 1;
            }
            
            anchororigin = self.var_51f9bf29507916c2.origin;
            enemyorigin = self.var_51f9bf29507916c2.enemy.origin;
            anchorforward = anglestoforward( self.var_51f9bf29507916c2.angles );
            
            if ( getdvarint( @"hash_ebaddf175a9fa64a", 0 ) )
            {
                var_2e6cf2b37a59c49c = tetherradius * vectornormalize( self.origin - anchororigin );
                goal = anchororigin + var_2e6cf2b37a59c49c;
            }
            else if ( getdvarint( @"hash_18840ddc8dbd70b5", 0 ) )
            {
                goal = function_13a712c0887aa2a3( self.var_51f9bf29507916c2.goalpos, enemyorigin, backoffset, sideoffset, goright );
            }
            else
            {
                goal = function_13a712c0887aa2a3( anchororigin, enemyorigin, backoffset, sideoffset, goright );
            }
            
            goal = getclosestpointonnavmesh( goal, self );
            
            if ( !utility::ispointinsidecircle( self.origin, goal, tetherradius ) )
            {
                self setgoalpos( goal, tetherradius );
            }
            
            if ( self.var_51f9bf29507916c2.waittimeoverride )
            {
                avgwaittime = self.var_51f9bf29507916c2.waittimeoverride;
                waittime = round( randomfloatrange( 0.5 * avgwaittime, 1.5 * avgwaittime ), 0.1 );
            }
            else
            {
                avgwaittime = 2;
                waittime = round( randomfloatrange( 0.5, 3 ), 0.1 );
            }
            
            /#
                if ( getdvarint( @"hash_ee68a761580a64c6", 0 ) )
                {
                    circle( goal, tetherradius, ( 0, 0, 1 ), ( 0, 0.5, 1 ), 0, 50 );
                    line( self.origin, goal, ( 0, 0.5, 1 ), 1, 0, 50 );
                }
            #/
            
            if ( getdvarint( @"hash_8210a35df64fdfa", 0 ) )
            {
                utility::waittill_notify_or_timeout( "goal", avgwaittime );
                wait randomfloatrange( 0, 1 );
                self.var_51f9bf29507916c2.var_c9d5df7287247508 = 0;
            }
            
            wait waittime;
            continue;
        }
        
        waitframe();
    }
    
    self.tetherid = undefined;
    self notify( #"squad_disbanded" );
}

// Namespace ob_humans
// Params 5, eflags: 0x4
// Checksum 0x7111234b, Offset: 0x242b
// Size: 0x84
function private function_13a712c0887aa2a3( originalpos, enemypos, backoffset, sideoffset, goright )
{
    var_e4734983996943d = vectornormalize( enemypos - originalpos );
    originalright = anglestoright( vectortoangles( var_e4734983996943d ) );
    
    if ( goright )
    {
        goal = originalpos - backoffset * var_e4734983996943d + sideoffset * originalright;
    }
    else
    {
        goal = originalpos - backoffset * var_e4734983996943d - sideoffset * originalright;
    }
    
    return goal;
}

/#

    // Namespace ob_humans
    // Params 0, eflags: 0x4
    // Checksum 0x1d8561cd, Offset: 0x24b8
    // Size: 0x2a4, Type: dev
    function private function_c350f092e17b0a09()
    {
        thread test_spawn_ai();
        thread function_ddad9b0ea1edcf1f();
        devgui::function_9082edeb5db93280( "<dev string:x3c>" );
        devgui::function_cd4e263c1f3018ae( "<dev string:x51>", "<dev string:x5d>", &function_8676dbefdd47a302 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x94>", "<dev string:xa1>", &function_8676dbefdd47a302 );
        devgui::function_cd4e263c1f3018ae( "<dev string:xd9>", "<dev string:xe9>", &function_8676dbefdd47a302 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x11f>", "<dev string:x12d>", &function_8676dbefdd47a302 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x166>", "<dev string:x175>", &function_8676dbefdd47a302 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x1af>", "<dev string:x1bf>", &function_8676dbefdd47a302 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x1f0>", "<dev string:x209>", &function_8676dbefdd47a302 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x243>", "<dev string:x262>", &function_8676dbefdd47a302 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x1af>", "<dev string:x1bf>", &function_8676dbefdd47a302 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x2a2>", "<dev string:x2b0>", &function_8676dbefdd47a302 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x2e9>", "<dev string:x2f8>", &function_8676dbefdd47a302 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x332>", "<dev string:x344>", &function_8676dbefdd47a302 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x37c>", "<dev string:x38c>", &function_8676dbefdd47a302 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x3c7>", "<dev string:x3d8>", &function_8676dbefdd47a302 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x414>", "<dev string:x425>", &function_8676dbefdd47a302 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x463>", "<dev string:x475>", &function_8676dbefdd47a302 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x4b4>", "<dev string:x4c9>", &function_8676dbefdd47a302 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x506>", "<dev string:x519>", &function_8676dbefdd47a302 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x559>", "<dev string:x56d>", &function_8676dbefdd47a302 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x5ae>", "<dev string:x5cb>", &function_8676dbefdd47a302 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x60c>", "<dev string:x623>", &function_8676dbefdd47a302 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x65f>", "<dev string:x673>", &function_8676dbefdd47a302 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x6ac>", "<dev string:x6c2>", &function_8676dbefdd47a302 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x6fd>", "<dev string:x711>", &function_8676dbefdd47a302 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x74a>", "<dev string:x75a>", &function_8676dbefdd47a302 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x793>", "<dev string:x7a3>", &function_8676dbefdd47a302 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x7d5>", "<dev string:x7eb>", &function_8676dbefdd47a302 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x825>", "<dev string:x836>", &function_8676dbefdd47a302 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x86e>", "<dev string:x87d>", &function_8676dbefdd47a302 );
        devgui::function_77df7fe7dd273e10();
    }

    // Namespace ob_humans
    // Params 1
    // Checksum 0xac98f7ec, Offset: 0x2764
    // Size: 0xab, Type: dev
    function function_8676dbefdd47a302( params )
    {
        aitypename = params[ 0 ];
        firstplayer = level.players[ 0 ];
        playerforward = anglestoforward( firstplayer.angles );
        offsetposition = firstplayer.origin + playerforward * 100 + ( 0, 0, 10 );
        groupid = ai_spawn_director::function_e19f6a00c4bb7490( aitypename, 0, 1, 1, 0, 3 );
        ai_spawn_director::function_9893a28f1d682a28( groupid, aitypename, offsetposition, vectortoangles( playerforward * -1 ), undefined, undefined, undefined, "<dev string:x8a0>" );
    }

    // Namespace ob_humans
    // Params 0
    // Checksum 0xc3b3a21f, Offset: 0x2817
    // Size: 0xfd, Type: dev
    function function_ddad9b0ea1edcf1f()
    {
        level endon( #"game_ended" );
        setdevdvarifuninitialized( @"debug_ai_magic", 0 );
        var_9af8f7d39b96adac = 1;
        
        while ( true )
        {
            if ( int( getunarchiveddebugdvar( @"debug_ai_magic", "<dev string:x8b4>" ) ) > 0 && var_9af8f7d39b96adac )
            {
                var_9af8f7d39b96adac = 0;
                setdvar( @"ai_debugevents", 1 );
                setdvar( @"debug_stealth", 1 );
                setdvar( @"ai_showpaths", 1 );
                setdvar( @"bg_entinfo", 1 );
            }
            
            if ( int( getunarchiveddebugdvar( @"debug_ai_magic", "<dev string:x8b4>" ) ) == 0 && !var_9af8f7d39b96adac )
            {
                var_9af8f7d39b96adac = 1;
                setdvar( @"ai_debugevents", 0 );
                setdvar( @"debug_stealth", 0 );
                setdvar( @"ai_showpaths", 0 );
                setdvar( @"bg_entinfo", 0 );
            }
            
            waitframe();
        }
    }

    // Namespace ob_humans
    // Params 1
    // Checksum 0xdef100a0, Offset: 0x291c
    // Size: 0x1d3, Type: dev
    function function_b43e56660c5cfc1f( player )
    {
        totalactivities = 0;
        
        if ( isdefined( player.activities ) && isdefined( player.activities.participatingactivities ) )
        {
            totalactivities = player.activities.participatingactivities.size;
        }
        
        function_94686f69062d617( player, "<dev string:x8b6>" + totalactivities + "<dev string:x8d9>" );
        
        if ( totalactivities > 0 )
        {
            foreach ( var_a0de285215f8455d, var_89e86063b91ce05c in player.activities.participatingactivities )
            {
                var_2a5103ede405afca = player.activities.focusedactivityid == var_a0de285215f8455d;
                activityinstance = level.activities.instances[ var_a0de285215f8455d ];
                
                if ( isdefined( activityinstance ) )
                {
                    var_ee27bd41d8f03d2d = activityinstance.varianttag;
                    activitytype = activityinstance.type;
                    var_1c23cc2a9b239917 = 0;
                    
                    if ( isdefined( activityinstance.var_d8052ec8b8687b04 ) )
                    {
                        var_1c23cc2a9b239917 = conditional_container::function_33051347e9187361( activityinstance.var_d8052ec8b8687b04, player );
                    }
                    
                    function_94686f69062d617( player, "<dev string:x8e2>" + var_ee27bd41d8f03d2d + "<dev string:x905>" + activitytype + "<dev string:x90f>" + "<dev string:x911>" + var_2a5103ede405afca + "<dev string:x90f>" + "<dev string:x91c>" + var_1c23cc2a9b239917 + "<dev string:x90f>" );
                }
            }
        }
    }

    // Namespace ob_humans
    // Params 1
    // Checksum 0xad8caf48, Offset: 0x2af7
    // Size: 0x5b, Type: dev
    function function_611b71549ac85cc5( text )
    {
        shouldlog = getdvarint( @"hash_6e561210fe14f90c", 0 );
        
        if ( shouldlog > 0 )
        {
            if ( isstartstr( text, "<dev string:x933>" ) )
            {
                println( "<dev string:x935>" + text );
                return;
            }
            
            println( "<dev string:x943>" + text );
        }
    }

    // Namespace ob_humans
    // Params 2
    // Checksum 0x6cd29d, Offset: 0x2b5a
    // Size: 0x4e, Type: dev
    function function_718254d8560b5513( activityinstance, text )
    {
        if ( isdefined( activityinstance ) && isdefined( activityinstance.varianttag ) )
        {
            function_611b71549ac85cc5( "<dev string:x933>" + activityinstance.varianttag + "<dev string:x952>" + text );
        }
    }

    // Namespace ob_humans
    // Params 2
    // Checksum 0x20e8acc7, Offset: 0x2bb0
    // Size: 0x42, Type: dev
    function function_94686f69062d617( player, text )
    {
        if ( isplayer( player ) )
        {
            function_611b71549ac85cc5( "<dev string:x955>" + player.clientid + "<dev string:x952>" + text );
        }
    }

    // Namespace ob_humans
    // Params 3
    // Checksum 0xf5c937bb, Offset: 0x2bfa
    // Size: 0x73, Type: dev
    function function_5224f34d2833fe25( player, activityinstance, text )
    {
        if ( isplayer( player ) && isdefined( activityinstance ) && isdefined( activityinstance.varianttag ) )
        {
            function_611b71549ac85cc5( "<dev string:x955>" + player.clientid + "<dev string:x95e>" + activityinstance.varianttag + "<dev string:x952>" + text );
        }
    }

#/
