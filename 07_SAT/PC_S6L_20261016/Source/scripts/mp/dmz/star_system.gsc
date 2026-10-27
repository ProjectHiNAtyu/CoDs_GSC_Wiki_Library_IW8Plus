// scripts\mp\dmz\star_system.gsc  (hash_530ac533f0eacf4c.gscc) (size: 23675 Bytes / 0x5c7b / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x33cda00 (54319616)
// size ...... 23675 (0x5c7b)
// includes .. 11  (offset: 0x5893)
// strings ... 37  (offset: 0x58eb)
// dev strs .. 5   (offset: 0x5c07)
// exports ... 75  (offset: 0x3eeb)
// cseg ...... 0x2fd + 0x3bee (0x3eeb)
// imports ... 108 (offset: 0x4aa3)
// animtree1 . 0   (offset: 0x5c7b)
// animtree2 . 0   (offset: 0x5c7b)
#using scripts\common\callbacks;
#using scripts\common\utility;
#using scripts\mp\agents\agent_utils;
#using scripts\mp\ai_mp_controller;
#using scripts\mp\ai_reinforcements;
#using scripts\mp\common\utility\debug;
#using scripts\mp\common\utility\teams;
#using scripts\mp\dmz\dmz_poi;
#using scripts\mp\dmz\gametypes\dmz_ai;
#using scripts\mp\dmz\threat_list;
#using scripts\mp\hud_message;

#namespace star_system;

// Namespace star_system
// Params 0
// Checksum 0x44b90933, Offset: 0x31b
// Size: 0x579
function starsystem_init()
{
    if ( !starsystem_isenabled() )
    {
        return;
    }
    
    utility::registersharedfunc( #"starsystem", #"hash_e7536c049ffc3673", &function_8fb952c22d4cd3da );
    level.var_1d43e6e89a526030 = spawnstruct();
    level.var_1d43e6e89a526030.var_46dd4a4e46fce80b = getdvarfloat( @"hash_2c3eabf4a542ff3c", 0 );
    level.var_1d43e6e89a526030.var_ec6b866b9b132e1c = getdvarfloat( @"hash_bff507e30583af77", 0.5 );
    level.var_1d43e6e89a526030.var_5ccd74871b8d172c = getdvarfloat( @"hash_2230fc7a68495b75", 0.1 );
    level.var_1d43e6e89a526030.var_21bd8813f1e29859 = getdvarfloat( @"hash_5c438007433d1392", 1 );
    level.var_1d43e6e89a526030.reqreinforcements = [];
    level.var_1d43e6e89a526030.reqreinforcements[ 0 ] = getdvarint( @"hash_2e473219b28f0957", 0 );
    level.var_1d43e6e89a526030.reqreinforcements[ 1 ] = getdvarint( @"hash_2e473119b28f0724", 10 );
    level.var_1d43e6e89a526030.reqreinforcements[ 2 ] = getdvarint( @"hash_2e473419b28f0dbd", 10 );
    level.var_1d43e6e89a526030.reqreinforcements[ 3 ] = getdvarint( @"hash_2e473319b28f0b8a", 15 );
    level.var_1d43e6e89a526030.var_8535ffc242157aee = getdvarint( @"hash_3fd4229cd74ff0a9", 60 );
    level.var_1d43e6e89a526030.var_9ee2d0e553ab232b = [];
    level.var_1d43e6e89a526030.var_9ee2d0e553ab232b = [];
    level.var_1d43e6e89a526030.var_9ee2d0e553ab232b[ 0 ] = "rex_default_tier_1";
    level.var_1d43e6e89a526030.var_9ee2d0e553ab232b[ 1 ] = "rex_default_tier_2";
    level.var_1d43e6e89a526030.var_9ee2d0e553ab232b[ 2 ] = "rex_default_tier_2";
    level.var_1d43e6e89a526030.var_9ee2d0e553ab232b[ 3 ] = "rex_default_tier_3";
    level.var_1d43e6e89a526030.var_9ee2d0e553ab232b[ 4 ] = "rex_default_tier_3";
    level.var_1d43e6e89a526030.agentvalues = [ 1, 1, 2, 3 ];
    level.var_1d43e6e89a526030.var_dd0077234090ad0d = getdvarfloat( @"hash_42fc6f7f4782a387", 15 );
    level.var_1d43e6e89a526030.var_f7861862eccd2c65 = [];
    level.var_1d43e6e89a526030.var_f7861862eccd2c65[ 0 ] = "ai_token_dmz_shoot_poi_0star";
    level.var_1d43e6e89a526030.var_f7861862eccd2c65[ 1 ] = "ai_token_dmz_shoot_poi_1star";
    level.var_1d43e6e89a526030.var_f7861862eccd2c65[ 2 ] = "ai_token_dmz_shoot_poi_2star";
    level.var_1d43e6e89a526030.var_f7861862eccd2c65[ 3 ] = "ai_token_dmz_shoot_poi_3star";
    level.var_1d43e6e89a526030.var_f7861862eccd2c65[ 4 ] = "ai_token_dmz_shoot_poi_4star";
    level.starsystemcap = getdvarint( @"hash_17fafda47d01073e", 100 );
    level.var_dc20724b10526bdc = getdvarint( @"hash_63a1a7228cc09f39", 100 );
    callback::add( #"hash_6a3e445c5100cb67", &function_11b4d752306118dd );
    callback::add( #"on_player_enters_location", &function_ba78c6a0800dd3b );
    var_4f8ccece45ddd6b7 = getscriptbundle( level.gametypebundle.var_1a4bb06e997d0fb9[ 0 ].starSystem );
    
    if ( var_4f8ccece45ddd6b7 )
    {
        foreach ( index, starlevel in var_4f8ccece45ddd6b7.threatlevels )
        {
            if ( starlevel.splash )
            {
                hud_message::function_b4446495b4d8f194( hashcat( #"hash_4b18194f62601e1a", index ), starlevel.splash );
            }
            
            if ( starlevel.splashdown )
            {
                hud_message::function_b4446495b4d8f194( hashcat( #"hash_af0e769dfb464677", index ), starlevel.splashdown );
            }
        }
    }
    
    level.startracker = [];
    
    foreach ( poiname, poi in level.poi )
    {
        if ( poi[ "priority" ] != 0 )
        {
            continue;
        }
        
        function_f583101729804baf( poiname );
    }
    
    level thread starsystem_update();
    
    /#
        level thread starsystem_debug();
        level thread function_e97a9b2b4efee769();
    #/
    
    ai_mp_controller::function_2b1cc53b284373( &onagentdeath );
    utility::registersharedfunc( #"dmz_star_system", #"hash_87cef5439a4b9eda", &function_8fb952c22d4cd3da );
    utility::flag_set( "star_system_initialized" );
}

// Namespace star_system
// Params 1
// Checksum 0xe0453882, Offset: 0x89c
// Size: 0x465
function onagentdeath( params )
{
    if ( 0 && params.smeansofdeath == "MOD_UNKNOWN" )
    {
        /#
            level thread debug::drawsphere( params.victim.origin, 64, 300, ( 1, 0, 0 ) );
            print3d( params.victim.origin, "<dev string:x24>" + params.smeansofdeath, ( 0, 0, 1 ), 1, 1, 10000 );
        #/
        
        return;
    }
    
    agent = params.victim;
    
    /#
        if ( false )
        {
            level thread debug::drawsphere( agent.origin, 64, 300, ( 0, 1, 0 ) );
            print3d( params.victim.origin, params.smeansofdeath, ( 0, 0, 1 ), 1, 1, 10000 );
        }
    #/
    
    killer = params.einflictor.owner ?? params.einflictor;
    
    if ( self.subarea.poiname )
    {
        var_98a9094c33458685 = killer.compromised;
        var_68b7af9656ecff14 = agent.var_68b7af9656ecff14;
        poi = self.subarea.poiname;
        tier = agent.tier;
        waittillframeend();
        
        if ( level.var_477715688f562bf0 && ( agent.quickkill || !isdefined( agent.enemy ) ) && !var_68b7af9656ecff14 && !var_98a9094c33458685 )
        {
            stealthkill = 1;
        }
        
        level.startracker[ poi ].killedagents += 1;
        level.startracker[ poi ].var_3343c3768fa680ac[ tier ?? 1 ] = level.startracker[ poi ].var_3343c3768fa680ac[ tier ?? 1 ] + 1;
        level.startracker[ poi ].var_a1611c67c26aa022 += level.var_1d43e6e89a526030.agentvalues[ tier ?? 1 ];
        level.startracker[ poi ].dirty = 1;
        
        if ( agent.missionagent || killer.startracker.var_7140bfb4602aa91c == 0 )
        {
            return;
        }
        
        if ( !stealthkill )
        {
            level.startracker[ poi ] threat_list::addthreat( killer, 100 );
            
            foreach ( player in teams::getteamdata( killer.team, "players" ) )
            {
                if ( player.startracker )
                {
                    player.startracker.killedagents += 1;
                    player.startracker.var_3343c3768fa680ac[ tier ?? 1 ] = player.startracker.var_3343c3768fa680ac[ tier ?? 1 ] + 1;
                    player.startracker.var_a1611c67c26aa022 += level.var_1d43e6e89a526030.agentvalues[ tier ?? 1 ];
                    player.startracker.dirty = 1;
                }
            }
        }
    }
}

// Namespace star_system
// Params 1, eflags: 0x4
// Checksum 0x59994c11, Offset: 0xd09
// Size: 0x16
function private onspawnagent( params )
{
    function_c12b5a2f27551abc( self, 1 );
}

// Namespace star_system
// Params 1, eflags: 0x4
// Checksum 0x756cf07d, Offset: 0xd27
// Size: 0x41
function private function_11b4d752306118dd( params )
{
    starlevel = function_8fb952c22d4cd3da( params.poi );
    
    if ( starlevel > 3 )
    {
        return 3;
    }
    
    if ( starlevel >= 2 )
    {
        return 2;
    }
    
    return 1;
}

// Namespace star_system
// Params 1
// Checksum 0xd624636d, Offset: 0xd71
// Size: 0x22
function function_5fba7d5453698bbe( cap )
{
    self.startracker.var_7140bfb4602aa91c = cap;
}

// Namespace star_system
// Params 0
// Checksum 0xbf5306a3, Offset: 0xd9b
// Size: 0x18
function function_ec7e019c9b29ea26()
{
    self.startracker.var_7140bfb4602aa91c = 99;
}

// Namespace star_system
// Params 2
// Checksum 0xed5ea912, Offset: 0xdbb
// Size: 0x93
function function_1df9307068e80b1c( cap, team )
{
    foreach ( player in teams::getteamdata( team, "players" ) )
    {
        player function_5fba7d5453698bbe( cap );
    }
}

// Namespace star_system
// Params 1
// Checksum 0xcb688221, Offset: 0xe56
// Size: 0x89
function function_2d83ac3e6d998cf4( team )
{
    foreach ( player in teams::getteamdata( team, "players" ) )
    {
        player function_ec7e019c9b29ea26();
    }
}

// Namespace star_system
// Params 0
// Checksum 0x82a1e321, Offset: 0xee7
// Size: 0x28
function starsystem_disable()
{
    if ( function_494a657443f51330() )
    {
        return;
    }
    
    self.var_7140bfb4602aa91c = 0;
    self.var_c642e2c22164c2b7 = self.starlevel;
}

// Namespace star_system
// Params 0
// Checksum 0x8085348, Offset: 0xf17
// Size: 0xc, Type: bool
function function_494a657443f51330()
{
    return isdefined( self.var_c642e2c22164c2b7 );
}

// Namespace star_system
// Params 0
// Checksum 0x7882eca5, Offset: 0xf2c
// Size: 0x32
function starsystem_enable()
{
    if ( function_494a657443f51330() )
    {
        self.var_7140bfb4602aa91c = 99;
        self.starlevel = self.var_c642e2c22164c2b7;
        self.var_c642e2c22164c2b7 = undefined;
    }
}

// Namespace star_system
// Params 1
// Checksum 0xc04794dc, Offset: 0xf66
// Size: 0x23
function function_4b95f354e7c259de( poiname )
{
    self.var_a703ef912e66cae5[ self.var_a703ef912e66cae5.size ] = poiname;
}

// Namespace star_system
// Params 1
// Checksum 0x94fc0ade, Offset: 0xf91
// Size: 0x24
function function_f7a3a337ad266750( poiname )
{
    self.var_a703ef912e66cae5 = arrayremove( self.var_a703ef912e66cae5, poiname );
}

// Namespace star_system
// Params 2
// Checksum 0x27dd136e, Offset: 0xfbd
// Size: 0x9d
function function_1f81632a75b180bc( poiname, team )
{
    foreach ( player in teams::getteamdata( team, "players" ) )
    {
        player.startracker function_4b95f354e7c259de( poiname );
    }
}

// Namespace star_system
// Params 2
// Checksum 0xc295f730, Offset: 0x1062
// Size: 0x9d
function function_7941be83ce64049e( poiname, team )
{
    foreach ( player in teams::getteamdata( team, "players" ) )
    {
        player.startracker function_f7a3a337ad266750( poiname );
    }
}

// Namespace star_system
// Params 2
// Checksum 0xd7329ff1, Offset: 0x1107
// Size: 0x2e
function function_401d5b95f7e26b6f( poi, num )
{
    return level.startracker[ poi ] threat_list::function_9df30f252e7d31e9( &function_ee46f4267ae2597f, num );
}

// Namespace star_system
// Params 1
// Checksum 0x32d4e928, Offset: 0x113e
// Size: 0x3a, Type: bool
function function_ee46f4267ae2597f( player )
{
    return arraycontains( level.poi[ self.poi ][ "players" ], player ) && player.compromised;
}

// Namespace star_system
// Params 3
// Checksum 0x4c58b6ab, Offset: 0x1181
// Size: 0x32
function function_636ea7f52899f70a( poi, player, value )
{
    return level.startracker[ poi ] threat_list::addthreat( player, value );
}

// Namespace star_system
// Params 2
// Checksum 0xa9167c4e, Offset: 0x11bc
// Size: 0x1e
function function_e911f5dafda05ffb( player, value )
{
    return threat_list::addthreat( player, value );
}

// Namespace star_system
// Params 0
// Checksum 0x130288a7, Offset: 0x11e3
// Size: 0xc, Type: bool
function function_bbf594df09859fa2()
{
    return isdefined( level.var_1d43e6e89a526030 );
}

// Namespace star_system
// Params 1
// Checksum 0xad0b95a0, Offset: 0x11f8
// Size: 0x2c9
function function_f583101729804baf( poiname )
{
    struct = starsystem_register( poiname );
    struct.poi = poiname;
    struct.var_f69f2defddf844b6 = [ 0, function_1e4ae6407cf90f40( [ 0, 1, 0, 0 ] ), function_1e4ae6407cf90f40( [ 0, 10, 0, 0 ] ), function_1e4ae6407cf90f40( [ 0, 30, 0, 0 ] ), function_1e4ae6407cf90f40( [ 0, 65, 0, 0 ] ), function_1e4ae6407cf90f40( [ 0, 100, 0, 0 ] ) ];
    struct.var_d0a6586bb8ba42b1 = [ 5, 30, 60, 60, 60, 60 ];
    struct.reqs[ "increase" ][ 1 ][ struct.reqs[ "increase" ][ 1 ].size ] = &function_fd312626de3bb265;
    struct.reqs[ "increase" ][ 2 ][ struct.reqs[ "increase" ][ 2 ].size ] = &function_fd312626de3bb265;
    struct.reqs[ "increase" ][ 3 ][ struct.reqs[ "increase" ][ 3 ].size ] = &function_fd312626de3bb265;
    struct.reqs[ "increase" ][ 4 ][ struct.reqs[ "increase" ][ 4 ].size ] = &function_fd312626de3bb265;
    struct.reqs[ "increase" ][ 5 ][ struct.reqs[ "increase" ][ 5 ].size ] = &function_fd312626de3bb265;
    struct.var_4f08309a163f753f = 0;
    struct.var_d225a8ac8fd8da78 = 0;
    struct.var_f56cc0ec712ced9d = 0;
    struct.var_44109cae1d886ec0 = 0;
    struct.killedagents = 0;
    struct.var_3343c3768fa680ac = [];
    struct.var_3343c3768fa680ac[ 0 ] = 0;
    struct.var_3343c3768fa680ac[ 1 ] = 0;
    struct.var_3343c3768fa680ac[ 2 ] = 0;
    struct.var_3343c3768fa680ac[ 3 ] = 0;
    struct.var_a1611c67c26aa022 = 0;
    struct.delay = level.var_1d43e6e89a526030.var_dd0077234090ad0d;
    struct.var_98734d01db5935cd = 0;
    return struct;
}

// Namespace star_system
// Params 0
// Checksum 0xe3fbc193, Offset: 0x14ca
// Size: 0x431
function function_f5de525361c53674()
{
    if ( !starsystem_isenabled() )
    {
        return;
    }
    
    struct = starsystem_register( self getguid() );
    struct.player = self;
    struct.var_a703ef912e66cae5 = [];
    struct.var_f69f2defddf844b6 = [ 0, function_1e4ae6407cf90f40( [ 0, 1, 0, 0 ] ), function_1e4ae6407cf90f40( [ 0, 15, 0, 0 ] ), function_1e4ae6407cf90f40( [ 0, 30, 0, 0 ] ), function_1e4ae6407cf90f40( [ 0, 60, 0, 0 ] ), function_1e4ae6407cf90f40( [ 0, 100, 0, 0 ] ), 0 ];
    struct.funcs[ "onEnter" ][ 1 ] = &function_eedb9a249972575c;
    struct.funcs[ "onEnter" ][ 2 ] = &function_eedb9d2499725df5;
    struct.funcs[ "onEnter" ][ 3 ] = &function_eedb9c2499725bc2;
    struct.funcs[ "onEnter" ][ 4 ] = &function_eedb9724997250c3;
    struct.funcs[ "onEnter" ][ 5 ] = &function_eedb962499724e90;
    struct.reqs[ "increase" ][ 1 ][ struct.reqs[ "increase" ][ 1 ].size ] = &function_fd312626de3bb265;
    struct.reqs[ "increase" ][ 2 ][ struct.reqs[ "increase" ][ 2 ].size ] = &function_fd312626de3bb265;
    struct.reqs[ "increase" ][ 3 ][ struct.reqs[ "increase" ][ 3 ].size ] = &function_fd312626de3bb265;
    struct.reqs[ "increase" ][ 4 ][ struct.reqs[ "increase" ][ 4 ].size ] = &function_fd312626de3bb265;
    struct.reqs[ "increase" ][ 5 ][ struct.reqs[ "increase" ][ 5 ].size ] = &function_fd312626de3bb265;
    struct.reqs[ "increase" ][ 6 ] = [];
    struct.reqs[ "increase" ][ 6 ][ struct.reqs[ "increase" ][ 6 ].size ] = &function_71f8159196555c12;
    struct.reqs[ "decrease" ][ 5 ][ struct.reqs[ "decrease" ][ 5 ].size ] = &function_83df7e2eb196080b;
    struct.funcs[ "onLevelUpStart" ][ "all" ] = &function_5b63ef795cd0fe68;
    struct.funcs[ "onLevelDownStart" ][ "all" ] = &function_79737bb2e6ada63;
    struct.funcs[ "onLevelChangeEnd" ][ "all" ] = &function_7fc7e968c2aeafe6;
    struct.funcs[ "onNoUpdates" ][ "all" ] = &function_14b51ebc711c02b3;
    struct.funcs[ "calculatePercent" ][ 5 ] = &function_2b04f7103b8d95b1;
    struct.var_4f08309a163f753f = 0;
    struct.var_d225a8ac8fd8da78 = 0;
    struct.var_f56cc0ec712ced9d = 0;
    struct.var_44109cae1d886ec0 = 0;
    struct.killedagents = 0;
    struct.var_3343c3768fa680ac = [];
    struct.var_3343c3768fa680ac[ 0 ] = 0;
    struct.var_3343c3768fa680ac[ 1 ] = 0;
    struct.var_3343c3768fa680ac[ 2 ] = 0;
    struct.var_3343c3768fa680ac[ 3 ] = 0;
    struct.var_a1611c67c26aa022 = 0;
    struct.delay = level.var_1d43e6e89a526030.var_dd0077234090ad0d;
    self.startracker = struct;
    return struct;
}

// Namespace star_system
// Params 1
// Checksum 0xc7df934f, Offset: 0x1904
// Size: 0x2c5
function starsystem_register( index )
{
    if ( !starsystem_isenabled() )
    {
        return;
    }
    
    struct = spawnstruct();
    struct.starlevel = 0;
    struct.starprogress = 0;
    struct.var_e85083c41e9cffe9 = 100;
    struct.dirty = 0;
    struct.delay = 0;
    struct.noupdates = 0;
    struct.var_94802ca47a51bdf4 = 0;
    struct.reclaimedpoints = 0;
    struct.var_568e8cb84dce58f2 = 0;
    struct.var_905d042a5f4e6b3 = 15;
    struct.var_f69f2defddf844b6 = [ 0, 0, 0, 0, 0, 0 ];
    struct.var_d0a6586bb8ba42b1 = [ 0, 0, 0, 0, 0, 0 ];
    struct.funcs = [];
    struct.funcs[ "onEnter" ] = [];
    struct.funcs[ "onExit" ] = [];
    struct.funcs[ "onLevelUpStart" ] = [];
    struct.funcs[ "onLevelChangeEnd" ] = [];
    struct.funcs[ "onNoUpdates" ] = [];
    struct.funcs[ "calculatePercent" ] = [];
    struct.reqs = [];
    struct.reqs[ "increase" ] = [];
    struct.reqs[ "decrease" ] = [];
    struct.reqs[ "increase" ][ "all" ] = [];
    struct.reqs[ "decrease" ][ "all" ] = [];
    
    foreach ( i, b in struct.var_f69f2defddf844b6 )
    {
        struct.reqs[ "increase" ][ i ] = [];
        struct.reqs[ "decrease" ][ i ] = [];
    }
    
    struct.modifiers = [];
    struct.totalweight = 0;
    struct threat_list::function_f93f570e9f229858();
    
    if ( !isdefined( index ) )
    {
        index = level.startracker.size;
    }
    
    level.startracker[ index ] = struct;
    return struct;
}

// Namespace star_system
// Params 3
// Checksum 0x3449d277, Offset: 0x1bd2
// Size: 0x8c
function function_5f029bc16c55a24c( poiname, func, weight )
{
    poi = level.startracker[ poiname ];
    array = [];
    array[ 0 ] = weight ?? 1;
    array[ 1 ] = func;
    poi.totalweight += array[ 0 ];
    poi.modifiers[ poi.modifiers.size ] = array;
}

// Namespace star_system
// Params 3
// Checksum 0xf1588391, Offset: 0x1c66
// Size: 0x3a
function function_30617c05c7908c53( name, function, index = "all" )
{
    self.funcs[ name ][ index ] = function;
}

// Namespace star_system
// Params 2
// Checksum 0x19a6331d, Offset: 0x1ca8
// Size: 0x45
function function_19e9962cb26fbcb6( name, index = "all" )
{
    if ( isdefined( self.funcs[ name ][ index ] ) )
    {
        return self [[ self.funcs[ name ][ index ] ]]();
    }
}

// Namespace star_system
// Params 3
// Checksum 0x3b062e59, Offset: 0x1cf5
// Size: 0x4a
function function_b277808af677dc07( name, function, index = "all" )
{
    self.reqs[ name ][ index ][ self.reqs[ name ][ index ].size ] = function;
}

// Namespace star_system
// Params 0
// Checksum 0xecbd2d69, Offset: 0x1d47
// Size: 0x1de
function starsystem_update()
{
    while ( true )
    {
        foreach ( struct in level.startracker )
        {
            waitframe();
            
            if ( struct function_f7e083a484f8bc5() )
            {
                struct.var_94802ca47a51bdf4 = 0;
                struct thread function_6f856aaf4eeead7b();
            }
            
            if ( struct.dirty || struct.player && struct.player.compromised )
            {
                struct.dirty = 0;
                struct.noupdates = 0;
                struct.var_94802ca47a51bdf4 += 1;
                
                if ( struct.var_e5409d75e96c7db1 )
                {
                    struct function_c0c7055c676ceb24();
                }
                
                continue;
            }
            
            if ( struct.starlevel > 0 )
            {
                struct.noupdates += 1;
                
                if ( struct.player && !dmz_poi::function_555354f7d26705ef( struct.player.origin ) )
                {
                    struct.noupdates += 1;
                }
                
                if ( struct.noupdates >= struct.var_905d042a5f4e6b3 && struct function_8a178455de9ad94a() )
                {
                    struct.var_94802ca47a51bdf4 = 0;
                    struct thread function_b63a5f43a229face();
                    struct.noupdates = 0;
                }
            }
        }
        
        wait 1;
    }
}

// Namespace star_system
// Params 0
// Checksum 0x79b02112, Offset: 0x1f2d
// Size: 0xa7
function function_3b42703b85b23210()
{
    self.var_2f408280862172a1 = 0;
    self.starlevel = 0;
    self.starprogress = 0;
    self.var_4f08309a163f753f = 0;
    self.var_d225a8ac8fd8da78 = 0;
    self.var_f56cc0ec712ced9d = 0;
    self.var_44109cae1d886ec0 = 0;
    self.killedagents = 0;
    self.var_3343c3768fa680ac = [];
    self.var_3343c3768fa680ac[ 0 ] = 0;
    self.var_3343c3768fa680ac[ 1 ] = 0;
    self.var_3343c3768fa680ac[ 2 ] = 0;
    self.var_3343c3768fa680ac[ 3 ] = 0;
    self.var_a1611c67c26aa022 = 0;
    self.reclaimedpoints = 0;
}

// Namespace star_system
// Params 0
// Checksum 0x492257b4, Offset: 0x1fdc
// Size: 0x11
function starsystem_isenabled()
{
    return getdvarint( @"scr_starsystem", 1 );
}

// Namespace star_system
// Params 0
// Checksum 0x86f52c25, Offset: 0x1ff6
// Size: 0x152, Type: bool
function function_f7e083a484f8bc5()
{
    if ( self.starlevel + 1 > self.var_f69f2defddf844b6.size - 1 )
    {
        return false;
    }
    
    if ( self.var_2f408280862172a1 )
    {
        return false;
    }
    
    foreach ( req in self.reqs[ "increase" ][ "all" ] )
    {
        if ( !self [[ req ]]() )
        {
            return false;
        }
    }
    
    foreach ( req in self.reqs[ "increase" ][ int( clamp( self.starlevel + 1, 0, self.var_f69f2defddf844b6.size - 1 ) ) ] )
    {
        if ( !self [[ req ]]() )
        {
            return false;
        }
    }
    
    return true;
}

// Namespace star_system
// Params 0
// Checksum 0x8393ade7, Offset: 0x2151
// Size: 0xd2
function function_6f856aaf4eeead7b()
{
    self notify( #"star_level_up" );
    self.var_2f408280862172a1 = 1;
    thread function_19e9962cb26fbcb6( "onLevelUpStart" );
    thread function_19e9962cb26fbcb6( "onExit" );
    thread function_19e9962cb26fbcb6( "onExit", int( self.starlevel ) );
    self.starlevel = int( clamp( self.starlevel + 1, 0, self.var_f69f2defddf844b6.size - 1 ) );
    self.starprogress = 0;
    level thread function_d6d6789d400b138d( self.poi );
    thread function_19e9962cb26fbcb6( "onEnter" );
    thread function_19e9962cb26fbcb6( "onEnter", self.starlevel );
    self.var_2f408280862172a1 = 0;
    self.var_fb3cfde86448e688 = 1;
    thread function_19e9962cb26fbcb6( "onLevelChangeEnd" );
}

// Namespace star_system
// Params 1
// Checksum 0xfb70635b, Offset: 0x222b
// Size: 0x19c
function function_d6d6789d400b138d( poi )
{
    if ( !utility::issharedfuncdefined( #"aitokens", #"tokens_issystemactive" ) )
    {
        return;
    }
    
    starlevel = function_8fb952c22d4cd3da( poi );
    
    if ( isdefined( level.var_1d43e6e89a526030.var_f7861862eccd2c65[ starlevel ] ) )
    {
        tokencollection = level.var_1d43e6e89a526030.var_f7861862eccd2c65[ starlevel ];
    }
    else
    {
        tokencollection = "ai_token_dmz_shoot_poi_0star";
    }
    
    poiinfo = level.poi[ poi ];
    subareas = poiinfo[ "subAreas" ];
    
    foreach ( subarea in subareas )
    {
        foreach ( guy in subarea.livingagents )
        {
            utility::callsharedfunc( #"aitokens", #"hash_d7f2ef75bdc51062", guy, tokencollection );
            waitframe();
        }
    }
}

// Namespace star_system
// Params 0
// Checksum 0xc2d2a11c, Offset: 0x23cf
// Size: 0x24
function function_97fa65b6afe65acc()
{
    if ( self.startracker )
    {
        self.startracker.var_98734d01db5935cd = 1;
    }
}

// Namespace star_system
// Params 0
// Checksum 0xd6491fbe, Offset: 0x23fb
// Size: 0x21
function function_ee8824026bd71881()
{
    if ( self.startracker )
    {
        self.startracker.var_98734d01db5935cd = undefined;
    }
}

// Namespace star_system
// Params 0
// Checksum 0x87263e38, Offset: 0x2424
// Size: 0x153, Type: bool
function function_8a178455de9ad94a()
{
    if ( self.starlevel - 1 < 0 )
    {
        return false;
    }
    
    if ( self.var_2f408280862172a1 || self.var_98734d01db5935cd )
    {
        return false;
    }
    
    foreach ( req in self.reqs[ "decrease" ][ "all" ] )
    {
        if ( !self [[ req ]]() )
        {
            return false;
        }
    }
    
    foreach ( req in self.reqs[ "decrease" ][ int( clamp( self.starlevel - 1, 0, self.var_f69f2defddf844b6.size - 1 ) ) ] )
    {
        if ( !self [[ req ]]() )
        {
            return false;
        }
    }
    
    return true;
}

// Namespace star_system
// Params 0
// Checksum 0xc058b9ab, Offset: 0x2580
// Size: 0x47
function function_c0c7055c676ceb24()
{
    self notify( #"hash_fa201a68efc32f63" );
    self.var_2f408280862172a1 = 0;
    self.var_e5409d75e96c7db1 = undefined;
    
    if ( self.player )
    {
        self.player setclientomnvar( "ui_dmz_poi_stars", function_524807113b12738b() );
    }
}

// Namespace star_system
// Params 0
// Checksum 0xf87d6423, Offset: 0x25cf
// Size: 0x6a
function function_d64b90e8b112e639()
{
    self notify( #"hash_65ef4a2a6bfffa4f" );
    self endon( #"hash_65ef4a2a6bfffa4f" );
    self.player endon( #"death_or_disconnect" );
    self endon( #"star_level_down" );
    self endon( #"star_level_up" );
    
    while ( true )
    {
        self.player setclientomnvar( "ui_dmz_poi_stars", function_524807113b12738b() );
        wait 1;
    }
}

// Namespace star_system
// Params 0
// Checksum 0xa00165c4, Offset: 0x2641
// Size: 0x14f
function function_b63a5f43a229face()
{
    self endon( #"hash_fa201a68efc32f63" );
    self notify( #"star_level_down" );
    self.var_2f408280862172a1 = 1;
    self.var_e5409d75e96c7db1 = 1;
    thread function_19e9962cb26fbcb6( "onLevelDownStart" );
    wait self.delay;
    thread function_19e9962cb26fbcb6( "onExit" );
    thread function_19e9962cb26fbcb6( "onExit", self.starlevel );
    self.reclaimedpoints += self.var_f69f2defddf844b6[ self.starlevel ];
    self.starlevel = int( clamp( self.starlevel - 1, 0, self.var_f69f2defddf844b6.size - 1 ) );
    self.starprogress = 0;
    self.var_a1611c67c26aa022 = self.var_f69f2defddf844b6[ self.starlevel ];
    level thread function_d6d6789d400b138d( self.poi );
    thread function_19e9962cb26fbcb6( "onEnter" );
    thread function_19e9962cb26fbcb6( "onEnter", self.starlevel );
    self.var_2f408280862172a1 = 0;
    self.var_e5409d75e96c7db1 = undefined;
    self.var_fb3cfde86448e688 = 0;
    
    if ( self.starlevel == 0 )
    {
        function_3b42703b85b23210();
    }
    
    thread function_19e9962cb26fbcb6( "onLevelChangeEnd" );
}

// Namespace star_system
// Params 0
// Checksum 0x83758816, Offset: 0x2798
// Size: 0x16d
function function_8d7d6aeb2cd89f92()
{
    influencetotal = 0;
    
    foreach ( mod in self.modifiers )
    {
        value = [[ mod[ 1 ] ]]();
        influencetotal += mod[ 0 ] / self.totalweight * value;
    }
    
    if ( influencetotal == 0 )
    {
        influencetotal = -1;
    }
    
    self.dirty = 1;
    influencecap = self.var_f69f2defddf844b6[ int( self.starlevel ) ] / self.var_d0a6586bb8ba42b1[ int( self.starlevel ) ];
    self.var_e2ad9e20c5a7d3b5 = influencecap * influencetotal;
    minprogress = self.starlevel > 0 ? self.var_f69f2defddf844b6[ int( self.starlevel ) ] * -1 : 0;
    self.starprogress = clamp( self.starprogress + self.var_e2ad9e20c5a7d3b5, minprogress, self.var_f69f2defddf844b6[ int( self.starlevel ) ] );
}

// Namespace star_system
// Params 1
// Checksum 0x6b610299, Offset: 0x290d
// Size: 0x99
function function_ba78c6a0800dd3b( params )
{
    poi = params.player.var_764fa622c95214e4 ?? "none";
    
    if ( !arraycontains( params.player.startracker.var_a703ef912e66cae5, poi ) )
    {
        params.player.startracker starsystem_enable();
        return;
    }
    
    params.player.startracker starsystem_disable();
}

// Namespace star_system
// Params 0
// Checksum 0x31aa5c3, Offset: 0x29ae
// Size: 0x120
function function_85a0207e16d54f51()
{
    influencetotal = 0;
    [ idle, investigate, combat, hunt ] = ai_mp_controller::function_dbc2aed56a183c6b( self.poi );
    self.var_4f08309a163f753f = idle;
    self.var_d225a8ac8fd8da78 = investigate;
    self.var_f56cc0ec712ced9d = combat;
    self.var_44109cae1d886ec0 = hunt;
    influencetotal += investigate * level.var_1d43e6e89a526030.var_5ccd74871b8d172c;
    influencetotal += combat * level.var_1d43e6e89a526030.var_21bd8813f1e29859;
    influencetotal += hunt * level.var_1d43e6e89a526030.var_ec6b866b9b132e1c;
    totalagents = ( self.var_4f08309a163f753f + self.var_d225a8ac8fd8da78 + self.var_f56cc0ec712ced9d + self.var_44109cae1d886ec0 ) * 0.7;
    return totalagents != 0 ? influencetotal / totalagents : 0;
}

// Namespace star_system
// Params 0
// Checksum 0xd5ed320f, Offset: 0x2ad7
// Size: 0x9b
function function_8b0e4cd3cce2fcb8()
{
    influencetotal = clamp( self.killedagents / ( self.maxagentskilled ?? 20 ), 0, 1 );
    timer = !self.var_42e051e67878cb5f || self.var_42e051e67878cb5f < 0 ? 5 : self.var_42e051e67878cb5f;
    
    if ( timer <= 0 )
    {
        self.killedagents -= ceil( self.killedagents / 4 );
    }
    
    self.var_42e051e67878cb5f = timer - 1;
    return influencetotal;
}

// Namespace star_system
// Params 1
// Checksum 0x89724b9c, Offset: 0x2b7b
// Size: 0xbd
function function_501b6087ee493924( time )
{
    influencecap = self.var_f69f2defddf844b6[ int( self.starlevel ) ] / self.var_d0a6586bb8ba42b1[ int( self.starlevel ) ];
    adjustment = influencecap * time;
    minprogress = self.starlevel > 0 ? self.var_f69f2defddf844b6[ int( self.starlevel ) ] * -1 : 0;
    self.starprogress = clamp( self.starprogress + adjustment, minprogress, self.var_f69f2defddf844b6[ int( self.starlevel ) ] );
}

// Namespace star_system
// Params 1
// Checksum 0x79570dec, Offset: 0x2c40
// Size: 0x91
function function_524807113b12738b( modifier )
{
    mod = modifier ?? 0;
    percent = self.var_2f408280862172a1 ? 9 : 1;
    
    if ( self.funcs[ "calculatePercent" ][ self.starlevel ] )
    {
        percent = [[ self.funcs[ "calculatePercent" ][ self.starlevel ] ]]();
    }
    
    return int( clamp( self.starlevel * 10 + percent + mod, 0, 60 ) );
}

// Namespace star_system
// Params 1
// Checksum 0xb4fed16b, Offset: 0x2cda
// Size: 0x1f
function function_7ff0315a9e66ad4d( index )
{
    level.startracker[ index ] function_524807113b12738b();
}

// Namespace star_system
// Params 1
// Checksum 0x7b72e314, Offset: 0x2d01
// Size: 0x75
function function_8fb952c22d4cd3da( poiname )
{
    if ( !function_bbf594df09859fa2() || !starsystem_isenabled() )
    {
        return 0;
    }
    
    startracker = level.startracker;
    
    if ( !isdefined( poiname ) )
    {
        return 0;
    }
    
    startracker = level.startracker[ poiname ];
    
    if ( !isdefined( startracker ) )
    {
        return 0;
    }
    
    if ( !isdefined( startracker.starlevel ) )
    {
        return 0;
    }
    
    return startracker.starlevel;
}

// Namespace star_system
// Params 2
// Checksum 0x3a5b8abb, Offset: 0x2d7f
// Size: 0x129
function function_c12b5a2f27551abc( agent, starlevel )
{
    if ( !function_bbf594df09859fa2() || dmz_ai::function_fb0f68f6b97f7f6c() )
    {
        return;
    }
    
    if ( !isdefined( starlevel ) )
    {
        starlevel = 0;
    }
    
    if ( isdefined( level.var_9fb946fd0329db79[ starlevel ] ) )
    {
        templatestring = level.var_9fb946fd0329db79[ starlevel ];
    }
    else
    {
        templatestring = level.var_1d43e6e89a526030.var_9ee2d0e553ab232b[ starlevel ];
    }
    
    switch ( starlevel )
    {
        case 0:
            var_eee6b641213731cc = templatestring;
            var_a6bc754ddd59ac4b = 5;
            break;
        case 1:
            var_eee6b641213731cc = templatestring;
            var_a6bc754ddd59ac4b = 6;
            break;
        case 2:
            var_eee6b641213731cc = templatestring;
            var_a6bc754ddd59ac4b = 7;
            break;
        case 3:
            var_eee6b641213731cc = templatestring;
            var_a6bc754ddd59ac4b = 8;
            var_e76fe4ca8a260f6 = 1;
            break;
        case 4:
            var_eee6b641213731cc = templatestring;
            var_a6bc754ddd59ac4b = 10;
            var_e76fe4ca8a260f6 = 1;
            break;
        default:
            var_eee6b641213731cc = "star_0";
            var_a6bc754ddd59ac4b = 5;
            break;
    }
}

// Namespace star_system
// Params 1
// Checksum 0xa863537f, Offset: 0x2eb0
// Size: 0x3c
function function_f43039a16ffb2fb6( starlevel )
{
    tracker = self.startracker;
    
    while ( tracker.starlevel < starlevel )
    {
        function_54eb2c3ee6993efe();
    }
}

// Namespace star_system
// Params 0
// Checksum 0x7cc4753d, Offset: 0x2ef4
// Size: 0xae
function function_54eb2c3ee6993efe()
{
    tracker = self.startracker;
    
    if ( isplayer( self ) )
    {
        pointsreq = tracker.var_f69f2defddf844b6[ tracker.starlevel + 1 ];
        tracker.killedagents += pointsreq;
        tracker.var_3343c3768fa680ac[ 1 ] += pointsreq;
        tracker.var_a1611c67c26aa022 += pointsreq;
        tracker.dirty = 1;
    }
    
    tracker function_6f856aaf4eeead7b();
}

/#

    // Namespace star_system
    // Params 0
    // Checksum 0x938947dd, Offset: 0x2faa
    // Size: 0x285, Type: dev
    function starsystem_debug()
    {
        while ( true )
        {
            waitframe();
            
            if ( getdvarint( @"hash_8c467c597a2393b7", 0 ) == 1 )
            {
                foreach ( player in level.players )
                {
                    player function_54eb2c3ee6993efe();
                }
                
                setdvar( @"hash_8c467c597a2393b7", 0 );
            }
            
            if ( getdvarint( @"hash_6212fff3232e881f", 0 ) == 1 )
            {
                foreach ( player in level.players )
                {
                    player function_29eeb0f2e759305f();
                }
                
                setdvar( @"hash_6212fff3232e881f", 0 );
            }
            
            if ( getdvarint( @"hash_ad641196a9a22c26", 0 ) == 1 )
            {
                foreach ( player in level.players )
                {
                    player.startracker function_14b51ebc711c02b3();
                }
                
                setdvar( @"hash_ad641196a9a22c26", 0 );
            }
            
            if ( getdvarint( @"hash_a4257629c6124856", -1 ) != -1 )
            {
                foreach ( player in level.players )
                {
                    player.startracker.delay = getdvarfloat( @"hash_a4257629c6124856" );
                }
                
                setdvar( @"hash_a4257629c6124856", -1 );
            }
        }
    }

    // Namespace star_system
    // Params 0
    // Checksum 0xbca521ea, Offset: 0x3237
    // Size: 0x15, Type: dev
    function function_29eeb0f2e759305f()
    {
        self.startracker function_b63a5f43a229face();
    }

    // Namespace star_system
    // Params 0
    // Checksum 0xf6489606, Offset: 0x3254
    // Size: 0x367, Type: dev
    function function_e97a9b2b4efee769()
    {
        var_24761ab0868753ca = { #scale:2, #color:( 0.9, 0.3, 0.5 ), #lineheight:35, #y:100, #x:500 };
        var_df3182e910a2e9f7 = { #scale:2, #color:( 0.3, 0.9, 0.3 ), #lineheight:35, #y:100, #x:1300 };
        
        while ( true )
        {
            waitframe();
            isenabled = getdvarint( @"hash_cef40a1e777303e0", 0 );
            
            if ( isenabled == 0 )
            {
                continue;
            }
            
            if ( !level.startracker )
            {
                continue;
            }
            
            var_a58aeaede0d0b6b = var_24761ab0868753ca.y;
            var_902b372671099634 = var_df3182e910a2e9f7.y;
            printtoscreen2d( var_24761ab0868753ca.x, var_a58aeaede0d0b6b, "<dev string:x2b>", var_24761ab0868753ca.color, var_24761ab0868753ca.scale );
            var_a58aeaede0d0b6b += var_24761ab0868753ca.lineheight;
            printtoscreen2d( var_df3182e910a2e9f7.x, var_902b372671099634, "<dev string:x5d>", var_df3182e910a2e9f7.color, var_df3182e910a2e9f7.scale );
            var_902b372671099634 += var_df3182e910a2e9f7.lineheight;
            
            foreach ( index, tracker in level.startracker )
            {
                if ( tracker.player )
                {
                    linestring = index + "<dev string:x9c>" + ( tracker.player.name ?? "<dev string:xa0>" ) + "<dev string:x9c>" + ( tracker.player.team ?? "<dev string:xa0>" ) + "<dev string:x9c>" + ( tracker.starlevel ?? "<dev string:xa0>" ) + "<dev string:x9c>" + ( tracker.killedagents ?? "<dev string:xa0>" ) + "<dev string:x9c>" + ( tracker.var_a1611c67c26aa022 ?? "<dev string:xa0>" );
                    printtoscreen2d( var_df3182e910a2e9f7.x, var_902b372671099634, linestring, var_df3182e910a2e9f7.color, var_df3182e910a2e9f7.scale );
                    var_902b372671099634 += var_df3182e910a2e9f7.lineheight;
                    continue;
                }
                
                linestring = index + "<dev string:x9c>" + ( tracker.starlevel ?? "<dev string:xa0>" ) + "<dev string:x9c>" + ( tracker.killedagents ?? "<dev string:xa0>" ) + "<dev string:x9c>" + ( tracker.var_a1611c67c26aa022 ?? "<dev string:xa0>" );
                printtoscreen2d( var_24761ab0868753ca.x, var_a58aeaede0d0b6b, linestring, var_24761ab0868753ca.color, var_24761ab0868753ca.scale );
                var_a58aeaede0d0b6b += var_24761ab0868753ca.lineheight;
            }
        }
    }

#/

// Namespace star_system
// Params 0
// Checksum 0x3b632694, Offset: 0x35c3
// Size: 0x241
function function_41750bc5e3efe5b4()
{
    var_2ffe4e944595f393 = function_401d5b95f7e26b6f( self.poi, 1 );
    
    if ( !isdefined( var_2ffe4e944595f393 ) )
    {
        return;
    }
    
    team = level.var_7ba393bd5b21cc2d;
    agents = ai_reinforcements::function_1faa63a0b398c676( 4, var_2ffe4e944595f393.origin, "absolute", "bosses", "hunt_squad", undefined, team, undefined, level.areas[ "bossArea" ][ "subAreas" ][ 0 ], "heli" );
    var_e8e2ae18d79edb6d = [];
    
    foreach ( index, agent in agents )
    {
        if ( index < 2 )
        {
            continue;
        }
        
        agent agent_utils::overrideagentsettings( "body_mp_eastern_velikan_1_1", "head_mp_eastern_velikan_1_1", undefined, undefined, undefined, 500, 5 );
        team = "team_hundred_ninety_four";
        dog = ai_mp_controller::spawn( { #subarea:level.areas[ "bossArea" ][ "subAreas" ][ 0 ], #team:team, #subcategory:"hunt_squad", #category:"bosses", #priority:"absolute", #spawnangles:agent.angles, #groundspawnorigin:agent.origin, #agenttype:"rex_enemy_wolf" } );
        dog setgoalpos( var_2ffe4e944595f393.origin, 100 );
        dog.team = team;
        dog.leader = agent;
        dog.grouppatrolname = "hunt_dogs";
        dog.groupname = "hunt_dogs";
        dog linkto( agent );
        agent.dog = dog;
        var_e8e2ae18d79edb6d[ var_e8e2ae18d79edb6d.size ] = dog;
        dog setdoghandler( agent );
        agent thread function_9af03687d2515bc4();
    }
}

// Namespace star_system
// Params 0
// Checksum 0xb3db8ac7, Offset: 0x380c
// Size: 0x69
function function_9af03687d2515bc4()
{
    self endon( #"death" );
    
    while ( self._blackboard.invehicle )
    {
        wait 0.2;
    }
    
    if ( isdefined( self.dog ) )
    {
        self.dog unlink();
        self.dog.origin = getclosestpointonnavmesh( self.origin );
    }
}

// Namespace star_system
// Params 2
// Checksum 0x2fc93dbd, Offset: 0x387d
// Size: 0x51
function function_7ac7d1716defba99( poi, lv )
{
    thread utility::callsharedfunc( #"splash", #"hash_1cdff8916d495428", hashcat( #"hash_4b18194f62601e1a", lv ), level.poi[ poi ][ "players" ], poi );
}

// Namespace star_system
// Params 3
// Checksum 0x2b231bbd, Offset: 0x38d6
// Size: 0x64
function function_687c3d27b72293dd( player, lv, prefix )
{
    if ( player.var_9ec7a8c907e9cc6c )
    {
        return;
    }
    
    if ( !isdefined( prefix ) )
    {
        prefix = #"hash_4b18194f62601e1a";
    }
    
    thread utility::callsharedfunc( #"splash", #"hash_1cdff8916d495428", hashcat( prefix, lv ), [ player ] );
}

// Namespace star_system
// Params 0
// Checksum 0xc0215cf0, Offset: 0x3942
// Size: 0x14
function function_eedb9a249972575c()
{
    function_7ac7d1716defba99( self.poi, 1 );
}

// Namespace star_system
// Params 0
// Checksum 0x59280d49, Offset: 0x395e
// Size: 0x14
function function_eedb9d2499725df5()
{
    function_7ac7d1716defba99( self.poi, 2 );
}

// Namespace star_system
// Params 0
// Checksum 0x2e2f3dde, Offset: 0x397a
// Size: 0x14
function function_eedb9c2499725bc2()
{
    function_7ac7d1716defba99( self.poi, 3 );
}

// Namespace star_system
// Params 0
// Checksum 0xb04ba87a, Offset: 0x3996
// Size: 0x14
function function_eedb9724997250c3()
{
    function_7ac7d1716defba99( self.poi, 4 );
}

// Namespace star_system
// Params 0
// Checksum 0x91efb952, Offset: 0x39b2
// Size: 0x1b
function function_eedb962499724e90()
{
    function_7ac7d1716defba99( self.poi, 5 );
    thread function_d64b90e8b112e639();
}

// Namespace star_system
// Params 0
// Checksum 0x6037b34d, Offset: 0x39d5
// Size: 0x52
function function_d9ec43bccaae6fa3()
{
    totalval = 0;
    
    for ( i = 1; i < 3 ; i++ )
    {
        totalval += self.var_3343c3768fa680ac[ i ] * level.var_1d43e6e89a526030.agentvalues[ i ];
    }
    
    return totalval;
}

// Namespace star_system
// Params 1, eflags: 0x4
// Checksum 0x26af21be, Offset: 0x3a30
// Size: 0x54
function private function_1e4ae6407cf90f40( tiercounts )
{
    totalval = 0;
    
    for ( i = 1; i < 3 ; i++ )
    {
        totalval += tiercounts[ i ] * level.var_1d43e6e89a526030.agentvalues[ i ];
    }
    
    return totalval;
}

// Namespace star_system
// Params 2
// Checksum 0x96bdd522, Offset: 0x3a8d
// Size: 0xd9
function function_c7a5d1fd397934a0( poi, agents )
{
    foreach ( agent in agents )
    {
        agent.missionagent = 1;
        level.startracker[ poi ].var_568e8cb84dce58f2 += level.var_1d43e6e89a526030.agentvalues[ agent.tier ];
    }
}

// Namespace star_system
// Params 0
// Checksum 0x8b4a6c26, Offset: 0x3b6e
// Size: 0xc, Type: bool
function function_eef5045867b1fc3e()
{
    return istrue( self.reinforcementsactive );
}

// Namespace star_system
// Params 0
// Checksum 0xefecd983, Offset: 0x3b83
// Size: 0x99, Type: bool
function function_fd312626de3bb265()
{
    if ( self.starlevel >= level.starsystemcap )
    {
        return false;
    }
    
    if ( self.starlevel >= self.var_7140bfb4602aa91c )
    {
        return false;
    }
    
    if ( self.starlevel >= level.var_dc20724b10526bdc && utility::callsharedfunc( #"mission_manager", #"hash_93feea55d2745f32", self.player ) )
    {
        return false;
    }
    
    return self.var_a1611c67c26aa022 >= self.var_568e8cb84dce58f2 + self.var_f69f2defddf844b6[ self.starlevel + 1 ];
}

// Namespace star_system
// Params 0
// Checksum 0xeeaa3bbd, Offset: 0x3c25
// Size: 0xe, Type: bool
function function_71f8159196555c12()
{
    return self.var_94802ca47a51bdf4 > 120;
}

// Namespace star_system
// Params 0
// Checksum 0x43aa67f0, Offset: 0x3c3c
// Size: 0x15
function function_2b04f7103b8d95b1()
{
    return int( self.var_94802ca47a51bdf4 / 120 * 10 );
}

// Namespace star_system
// Params 0
// Checksum 0x6acf743, Offset: 0x3c5a
// Size: 0x3, Type: bool
function function_83df7e2eb196080b()
{
    return false;
}

// Namespace star_system
// Params 0
// Checksum 0xbd543b08, Offset: 0x3c66
// Size: 0x27
function function_5b63ef795cd0fe68()
{
    if ( self.player )
    {
        self.player setclientomnvar( "ui_dmz_poi_stars", function_524807113b12738b() );
    }
}

// Namespace star_system
// Params 0
// Checksum 0xd9cd3a99, Offset: 0x3c95
// Size: 0x45
function function_79737bb2e6ada63()
{
    if ( self.player )
    {
        self.player setclientomnvar( "ui_dmz_poi_stars", function_524807113b12738b( -19 ) );
        waitframe();
        self.player setclientomnvar( "ui_dmz_poi_stars", function_524807113b12738b( -10 ) );
    }
}

// Namespace star_system
// Params 0
// Checksum 0xb1a8dd95, Offset: 0x3ce2
// Size: 0x181
function function_7fc7e968c2aeafe6()
{
    if ( self.player )
    {
        self.player setclientomnvar( "ui_dmz_poi_stars", function_524807113b12738b() );
        function_687c3d27b72293dd( self.player, self.starlevel, self.var_fb3cfde86448e688 ? #"hash_4b18194f62601e1a" : #"hash_af0e769dfb464677" );
        voline = self.var_fb3cfde86448e688 ? hashcat( #"hash_dfcb11aaff954292", self.starlevel ) : #"stars_rank_down";
        utility::callsharedfunc( #"overlord", #"hash_82f680233629c231", voline, [ self.player ] );
        
        if ( self.starlevel == 0 )
        {
            self.player notify( #"gotaway" );
        }
        
        var_97d2c62ca3c02cea = int( clamp( self.starlevel, 1, 4 ) );
        self.player thread utility::callsharedfunc( #"music_intensity", #"boost_intensity", { #timeout:60, #amount:var_97d2c62ca3c02cea, #name:"starSystem" } );
        callback::callback( #"star_system_level", { #starlevel:self.starlevel, #player:self.player } );
    }
}

// Namespace star_system
// Params 0
// Checksum 0x39e91ed9, Offset: 0x3e6b
// Size: 0x80
function function_14b51ebc711c02b3()
{
    function_3b42703b85b23210();
    
    if ( self.player )
    {
        self.player setclientomnvar( "ui_dmz_poi_stars", function_524807113b12738b() );
        function_687c3d27b72293dd( self.player, self.starlevel, #"hash_4b18194f62601e1a" );
        utility::callsharedfunc( #"overlord", #"hash_82f680233629c231", #"hash_9f5a40155caedd73", [ self.player ] );
    }
}

