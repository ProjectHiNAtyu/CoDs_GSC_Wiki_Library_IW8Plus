// scripts\mp\zm\gametypes\zm_rb.gsc  (hash_0910c7776b0f07f6.gscc) (size: 4151 Bytes / 0x1037 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xdc3d230a (3694994186)
// size ...... 4151 (0x1037)
// includes .. 17  (offset: 0xf37)
// strings ... 10  (offset: 0xfbf)
// dev strs .. 0   (offset: 0x1037)
// exports ... 10  (offset: 0x8db)
// cseg ...... 0x121 + 0x7ba (0x8db)
// imports ... 42  (offset: 0xa6b)
// animtree1 . 0   (offset: 0x1037)
// animtree2 . 0   (offset: 0x1037)
#using scripts\common\callbacks;
#using scripts\common\utility;
#using scripts\common\vehicle;
#using scripts\mp\agents\agent_utils;
#using scripts\mp\common\utility\game;
#using scripts\mp\gametypes\common;
#using scripts\mp\spawnlogic;
#using scripts\mp\zm\globallogic;
#using scripts\mp\zm\spawners\agent_spawner;
#using scripts\mp\zm\spawners\zone_spawner;
#using scripts\mp\zm\systems\zm_music;
#using scripts\mp\zm\systems\zm_round_logic;
#using scripts\mp\zm\systems\zm_save;
#using scripts\mp\zm\systems\zone_manager;
#using scripts\mp\zm\zm;
#using scripts\mp\zm\zm_player;
#using scripts\mp\zm\zm_player_damage;

#namespace zm_rb;

// Namespace zm_rb
// Params 0
// Checksum 0xf874b8ec, Offset: 0x13f
// Size: 0x1b6
function main()
{
    level.callbackstartgametype = &void;
    level.callbackplayeractive = &void;
    level.callbackplayerconnect = &void;
    level.callbackplayerdisconnect = &void;
    level.callbackplayerkilled = &void;
    level.callbackplayerlaststand = &void;
    level.callbackplayermigrated = &void;
    level.var_16eab40d8f2ae445 = &void;
    globallogic::init();
    globallogic::setupcallbacks();
    level.var_309f8f867be84cac = level.callbackplayerdamage;
    level.callbackplayerdamage = &callback_playerdamage;
    level.var_a77da733a6ccbb76 = "zm_base_magicbox_scaling";
    level.var_1de073b03eb3e525 = "zm_base_equipment_scaling";
    level.getspawnpoint = &get_player_spawn_point;
    level.forceteamassignmentoverride = &zm::function_824ea4febe3f5318;
    zm::init();
    level thread zone_spawner::init_zone_spawner();
    level.var_b7013d9ccd1b171a = 1;
    level.initializematchrules = &initializematchrules;
    [[ level.initializematchrules ]]();
    level thread game_utility_mp::reinitializematchrulesonmigration();
    common::updatecommongametypedvars();
    function_27459deefbb3631d();
    var_3e6257afaa75758 = "zone";
    
    /#
        var_3e6257afaa75758 = getdvar( @"hash_a5647468cd17c478", var_3e6257afaa75758 );
    #/
    
    agent_spawner::function_da6c989ec2c8c5fa( var_3e6257afaa75758 );
    level zm_round_logic::init_zm_round_logic();
    level zm_music::init_zm_music();
    level callback::add( "on_zombie_ai_spawned", &rb_on_zombie_ai_spawned );
    level callback::add( #"player_connect", &callback_playerconnect );
    
    if ( !isdefined( level.var_6efaf96150acaafa ) )
    {
        level.var_6efaf96150acaafa = 1;
    }
    
    if ( !isdefined( level.var_5ab0498cf1ac995e ) )
    {
        level.var_5ab0498cf1ac995e = 1;
    }
}

// Namespace zm_rb
// Params 0
// Checksum 0x6e0dce12, Offset: 0x2fd
// Size: 0x9
function initializematchrules()
{
    game_utility_mp::setcommonrulesfrommatchrulesdata();
}

// Namespace zm_rb
// Params 0
// Checksum 0x75fe0628, Offset: 0x30e
// Size: 0xe
function function_27459deefbb3631d()
{
    setnojipscore( 0 );
    setnojiptime( 0 );
}

// Namespace zm_rb
// Params 0
// Checksum 0xfef10e6a, Offset: 0x324
// Size: 0x2
function void()
{
    
}

// Namespace zm_rb
// Params 1
// Checksum 0x763a9900, Offset: 0x32e
// Size: 0x81
function callback_playerconnect( params )
{
    self waittill( #"begin" );
    
    if ( !isdefined( level.player ) )
    {
        spawnpoints = getentarray( "mp_global_intermission", #classname );
        self spawn( spawnpoints[ 0 ].origin, spawnpoints[ 0 ].angles );
        self.maxhealth = 10000000;
        self.health = 10000000;
    }
}

// Namespace zm_rb
// Params 18
// Checksum 0xacf51547, Offset: 0x3b7
// Size: 0x27f
function callback_playerdamage( einflictor, eattacker, idamage, idflags, smeansofdeath, fdistance, objweapon, vpoint, vdir, shitloc, timeoffset, modelindex, partname, var_2300d396e46c0fe7, var_cdd29ad5d1362c2, poisedamage, willknockdown, additionalparams )
{
    if ( function_155aa95b980a1663( einflictor, eattacker, smeansofdeath ) )
    {
        return;
    }
    
    dmg_struct = spawnstruct();
    dmg_struct.einflictor = einflictor;
    dmg_struct.eattacker = eattacker;
    dmg_struct.idflags = idflags;
    dmg_struct.smeansofdeath = smeansofdeath;
    dmg_struct.fdistance = fdistance;
    dmg_struct.objweapon = objweapon;
    dmg_struct.vpoint = vpoint;
    dmg_struct.vdir = vdir;
    dmg_struct.shitloc = shitloc;
    dmg_struct.timeoffset = timeoffset;
    dmg_struct.modelindex = modelindex;
    dmg_struct.partname = partname;
    dmg_struct.var_2300d396e46c0fe7 = var_2300d396e46c0fe7;
    dmg_struct.var_cdd29ad5d1362c2 = var_cdd29ad5d1362c2;
    dmg_struct.idamage = idamage;
    dmg_struct.additionalparams = additionalparams;
    dmg_struct = namespace_1b9d7114ac9b32e3::function_8509d988e53f1c55( dmg_struct );
    [[ level.var_309f8f867be84cac ]]( dmg_struct.einflictor, dmg_struct.eattacker, dmg_struct.idamage, dmg_struct.idflags, dmg_struct.smeansofdeath, dmg_struct.fdistance, dmg_struct.objweapon, dmg_struct.vpoint, dmg_struct.vdir, dmg_struct.shitloc, dmg_struct.timeoffset, dmg_struct.modelindex, dmg_struct.partname, dmg_struct.var_2300d396e46c0fe7, dmg_struct.var_cdd29ad5d1362c2, dmg_struct.poisedamage, dmg_struct.willknockdown, dmg_struct.additionalparams );
}

// Namespace zm_rb
// Params 1, eflags: 0x4
// Checksum 0x36f76616, Offset: 0x63e
// Size: 0x13
function private rb_on_zombie_ai_spawned( params )
{
    agent_utils::function_e6724888010b2003();
}

// Namespace zm_rb
// Params 3, eflags: 0x4
// Checksum 0x72545613, Offset: 0x659
// Size: 0xaa, Type: bool
function private function_155aa95b980a1663( einflictor, eattacker, smeansofdeath )
{
    attackent = eattacker ?? einflictor;
    
    if ( isdefined( attackent ) && attackent vehicle::is_vehicle() )
    {
        if ( attackent.occupants.size == 0 && !isdefined( attackent.driver ) && !attackent.var_19a36b17776e8e85 )
        {
            return true;
        }
        else if ( attackent vehicle_isphysveh() && !attackent vehphys_isgroundvehicle() )
        {
            if ( smeansofdeath == "MOD_CRUSH" || smeansofdeath == "MOD_IMPACT" )
            {
                return true;
            }
        }
    }
    
    return false;
}

// Namespace zm_rb
// Params 0, eflags: 0x4
// Checksum 0xe0392790, Offset: 0x70c
// Size: 0x1ce
function private get_player_spawn_point()
{
    if ( !self.hasspawned )
    {
        if ( zm_save::function_fcccc3d2a616b1c7() )
        {
            zone_name = zm_save::get_saved_spawn_zone();
            
            if ( isdefined( zone_name ) )
            {
                spawn_point = namespace_af5a2e4a7277c1d::function_c107082b3aabba7d( zone_name );
                
                if ( isdefined( spawn_point ) )
                {
                    return spawn_point;
                }
            }
        }
        
        if ( !utility::flag( "begin_round_logic" ) )
        {
            spawnpoints = utility::getstructarray( "initial_spawn_points", "targetname" );
            
            if ( spawnpoints.size < 4 )
            {
                if ( level.var_8fb8bca729cc4b96 )
                {
                    spawn_point = namespace_af5a2e4a7277c1d::function_c107082b3aabba7d( level.var_8fb8bca729cc4b96 );
                    
                    if ( spawn_point )
                    {
                        return spawn_point;
                    }
                }
                
                return spawnlogic::function_3f9d5fcfb93d4190( self );
            }
            
            foreach ( spawn_point in spawnpoints )
            {
                if ( isdefined( spawn_point.script_int ) )
                {
                    var_6787895101874fb4 = self getentitynumber();
                    
                    if ( var_6787895101874fb4 == spawn_point.script_int )
                    {
                        spawn_point.index = var_6787895101874fb4;
                        return spawn_point;
                    }
                }
            }
            
            return spawnpoints[ self getentitynumber() ];
        }
        
        return spawnlogic::function_3f9d5fcfb93d4190( self );
    }
    
    spawn_point = namespace_af5a2e4a7277c1d::function_4edc86bda6052f6e();
    
    if ( !isdefined( spawn_point ) )
    {
        var_8c4fe62d01999d1e = zone_manager::function_90e5c3e2272b0130( self.origin );
        spawn_point = namespace_af5a2e4a7277c1d::function_c107082b3aabba7d( var_8c4fe62d01999d1e.zone_name );
    }
    
    if ( !isdefined( spawn_point ) )
    {
        spawn_point = namespace_af5a2e4a7277c1d::function_c107082b3aabba7d( self.cached_zone_info.zone_struct.zone_name );
    }
    
    if ( !isdefined( spawn_point ) )
    {
        spawn_point = spawnlogic::function_3f9d5fcfb93d4190( self );
    }
    
    return spawn_point;
}

