// scripts\mp\gametypes\sprintgametype.gsc  (hash_7c1a15229fd51c78.gscc) (size: 5645 Bytes / 0x160d / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x598a6c5a (1502243930)
// size ...... 5645 (0x160d)
// includes .. 10  (offset: 0x1365)
// strings ... 41  (offset: 0x13b5)
// dev strs .. 2   (offset: 0x15f5)
// exports ... 13  (offset: 0xc09)
// cseg ...... 0x37a + 0x88f (0xc09)
// imports ... 48  (offset: 0xe11)
// animtree1 . 0   (offset: 0x160d)
// animtree2 . 0   (offset: 0x160d)
#using script_5003199e6be85294;
#using script_64355ec2069d2e95;
#using scripts\common\callbacks;
#using scripts\mp\class;
#using scripts\mp\common\utility\game;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\gameobjects;
#using scripts\mp\gametypes\common;
#using scripts\mp\globallogic;
#using scripts\mp\spawnlogic;

#namespace sprintgametype;

// Namespace sprintgametype
// Params 0
// Checksum 0xd555ae28, Offset: 0x398
// Size: 0x15b
function main()
{
    if ( getdvar( @"g_mapname" ) == "mp_background" )
    {
        return;
    }
    
    globallogic::init();
    globallogic::setupcallbacks();
    allowed[ 0 ] = game_utility::getgametype();
    gameobjects::main( allowed );
    level.initializematchrules = &initializematchrules;
    [[ level.initializematchrules ]]();
    level thread game_utility_mp::reinitializematchrulesonmigration();
    updategametypedvars();
    callback::add( #"player_spawned", &onspawnplayer );
    level.teambased = 1;
    level.onstartgametype = &onstartgametype;
    level.getspawnpoint = &getspawnpoint;
    level.onnormaldeath = &onnormaldeath;
    level.modeonspawnplayer = &onspawnplayer;
    level.denyclasschoice = 1;
    level.bypassclasschoicefunc = &class::alwaysgamemodeclass;
    level.onplayerconnect = &onplayerconnect;
    function_d96e2971c87e276a();
    var_d18b3e69cd198fc6 = 1;
    level.var_67361f68db6dcf34 = [];
    
    for ( i = 0; i < var_d18b3e69cd198fc6 ; i++ )
    {
        level.var_67361f68db6dcf34[ i ] = 0;
    }
    
    level.onplayerdisconnect = &onplayerdisconnect;
    namespace_21d86dfc5d377d8a::init();
    
    if ( game_utility_mp::matchmakinggame() )
    {
        level.shouldgamelobbyremainintact = &shouldgamelobbyremainintact;
    }
}

// Namespace sprintgametype
// Params 0
// Checksum 0xc42bf56a, Offset: 0x4fb
// Size: 0x9
function initializematchrules()
{
    game_utility_mp::setcommonrulesfrommatchrulesdata();
}

// Namespace sprintgametype
// Params 0
// Checksum 0xd909152b, Offset: 0x50c
// Size: 0x149
function onstartgametype()
{
    setclientnamemode( "auto_change" );
    
    if ( !isdefined( game[ "switchedsides" ] ) )
    {
        game[ "switchedsides" ] = 0;
    }
    
    if ( game[ "switchedsides" ] )
    {
        oldattackers = game[ "attackers" ];
        olddefenders = game[ "defenders" ];
        game[ "attackers" ] = olddefenders;
        game[ "defenders" ] = oldattackers;
    }
    
    foreach ( entry in level.teamnamelist )
    {
        game_utility_mp::setobjectivetext( entry, &"objectives/template" );
        
        if ( level.splitscreen )
        {
            game_utility_mp::setobjectivescoretext( entry, &"objectives/template" );
        }
        else
        {
            game_utility_mp::setobjectivescoretext( entry, &"hash_1ffc5eb0426f6ae4" );
        }
        
        game_utility_mp::setobjectivehinttext( entry, &"hash_36076ec9adea0ac3" );
    }
    
    if ( isdefined( level.initspawnsoverridefunc ) )
    {
        [[ level.initspawnsoverridefunc ]]();
        return;
    }
    
    initspawns();
}

// Namespace sprintgametype
// Params 0
// Checksum 0xa133ce6d, Offset: 0x65d
// Size: 0x9
function updategametypedvars()
{
    common::updatecommongametypedvars();
}

// Namespace sprintgametype
// Params 0
// Checksum 0xf9475c7b, Offset: 0x66e
// Size: 0xe2
function initspawns()
{
    if ( getdvarint( @"hash_742caa13b3c2e685" ) )
    {
        return;
    }
    
    spawnlogic::function_6dbabb72223a4bca();
    spawnlogic::setactivespawnlogic( #"default" );
    spawnkey = spawnlogic::function_d5c160a4110b573e();
    
    if ( spawnlogic::function_5cf82e30c52a895d( spawnkey ) )
    {
        spawnlogic::function_3cdbb94b81729d5f( spawnkey );
    }
    else
    {
        spawnlogic::function_9bd2654564d3372d( #"start", #"start_attackers", "mp_tdm_spawn_allies_start", game[ "attackers" ] );
        spawnlogic::function_9bd2654564d3372d( #"start", #"start_defenders", "mp_tdm_spawn_axis_start", game[ "defenders" ] );
        spawnlogic::function_17e08e497a9b4136( #"primary", #"primary", "mp_tdm_spawn" );
        spawnlogic::function_17e08e497a9b4136( #"fallback", #"fallback", "mp_tdm_spawn_secondary", 1 );
    }
    
    spawnlogic::finalizemap();
}

// Namespace sprintgametype
// Params 0
// Checksum 0xa87b184, Offset: 0x758
// Size: 0xb2
function getspawnpoint()
{
    if ( self.var_f29dc93306875523 )
    {
        var_7d179594e9b9d748 = "tutorial_" + self.var_f29dc93306875523;
        
        if ( var_7d179594e9b9d748 == "tutorial_move" )
        {
            sourceent = level.startline;
        }
        else
        {
            sourceent = self.var_b5e25f53db98a707;
        }
        
        if ( sourceent )
        {
            return { #index:1, #angles:sourceent.angles ?? self.angles ?? ( 0, 0, 0 ), #origin:sourceent.origin };
        }
    }
    
    return spawnlogic::function_3f9d5fcfb93d4190( self );
}

// Namespace sprintgametype
// Params 1
// Checksum 0xdc488a8a, Offset: 0x813
// Size: 0xc
function onspawnplayer( spawndata )
{
    
}

// Namespace sprintgametype
// Params 6
// Checksum 0x35574b11, Offset: 0x827
// Size: 0x48
function onnormaldeath( victim, attacker, lifeid, meansofdeath, objweapon, iskillstreakweapon )
{
    common::oncommonnormaldeath( victim, attacker, lifeid, meansofdeath, objweapon, iskillstreakweapon );
}

// Namespace sprintgametype
// Params 1
// Checksum 0xac6d9885, Offset: 0x877
// Size: 0x132
function onplayerconnect( player )
{
    player endon( #"disconnect" );
    player waittill( #"spawned" );
    
    for ( i = 0; i < level.var_67361f68db6dcf34.size ; i++ )
    {
        if ( !level.var_67361f68db6dcf34[ i ] )
        {
            player.map_instance_index = i;
            level.var_67361f68db6dcf34[ i ] = 1;
            break;
        }
    }
    
    assert( isdefined( player.map_instance_index ), "<dev string:x24>" );
    
    if ( !isdefined( player.map_instance_index ) )
    {
        return;
    }
    
    player class::function_e84a99f0f4904c66();
    player.pers[ "gamemodeLoadout" ] = level.sprintloadout;
    primaryweapon = player.pers[ "gamemodeLoadout" ][ "loadoutPrimary" ];
    secondaryweapon = player.pers[ "gamemodeLoadout" ][ "loadoutSecondary" ];
    player loadweaponsforplayer( [ primaryweapon, secondaryweapon ], 1 );
    namespace_21d86dfc5d377d8a::onplayerconnect( player );
    player namespace_5a75cabd00ec95ef::onplayerconnect();
}

// Namespace sprintgametype
// Params 1, eflags: 0x4
// Checksum 0x43ff2f65, Offset: 0x9b1
// Size: 0x44
function private onplayerdisconnect( player )
{
    if ( isdefined( player.map_instance_index ) )
    {
        level.var_67361f68db6dcf34[ player.map_instance_index ] = 0;
    }
    
    namespace_21d86dfc5d377d8a::onplayerdisconnect( player );
    player namespace_5a75cabd00ec95ef::onplayerdisconnect();
}

// Namespace sprintgametype
// Params 0
// Checksum 0xff0bda50, Offset: 0x9fd
// Size: 0x4d, Type: bool
function shouldgamelobbyremainintact()
{
    axisscore = int( game[ "teamScores" ][ "axis" ] );
    alliesscore = int( game[ "teamScores" ][ "allies" ] );
    differential = axisscore - alliesscore;
    return differential < 10;
}

// Namespace sprintgametype
// Params 0, eflags: 0x4
// Checksum 0x826d2233, Offset: 0xa53
// Size: 0x1b6
function private function_d96e2971c87e276a()
{
    assert( !isdefined( level.sprintloadout ), "<dev string:x4f>" );
    level.sprintloadout = [];
    level.sprintloadout[ "loadoutPrimary" ] = "rex_me_fists_mp";
    level.sprintloadout[ "loadoutPrimaryAttachment" ] = "none";
    level.sprintloadout[ "loadoutPrimaryAttachment2" ] = "none";
    level.sprintloadout[ "loadoutPrimaryCamo" ] = "none";
    level.sprintloadout[ "loadoutPrimaryReticle" ] = "none";
    level.sprintloadout[ "loadoutPrimaryVariantID" ] = 0;
    level.sprintloadout[ "loadoutEquipmentPrimary" ] = "none";
    level.sprintloadout[ "loadoutEquipmentSecondary" ] = "none";
    level.sprintloadout[ "loadoutSuper" ] = "none";
    level.sprintloadout[ "loadoutStreakType" ] = "assault";
    level.sprintloadout[ "loadoutKillstreak1" ] = "none";
    level.sprintloadout[ "loadoutKillstreak2" ] = "none";
    level.sprintloadout[ "loadoutKillstreak3" ] = "none";
    level.sprintloadout[ "loadoutUsingSpecialist" ] = 1;
    level.sprintloadout[ "loadoutPerks" ] = [ "specialty_warhead" ];
    level.sprintloadout[ "loadoutExtraPerks" ] = [ "specialty_null" ];
    level.sprintloadout[ "loadoutGesture" ] = "playerData";
    level.sprintloadout[ "loadoutFieldUpgrade1" ] = "none";
    level.sprintloadout[ "loadoutFieldUpgrade2" ] = "none";
}

