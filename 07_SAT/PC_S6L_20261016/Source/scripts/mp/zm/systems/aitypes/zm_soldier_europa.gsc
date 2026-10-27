// scripts\mp\zm\systems\aitypes\zm_soldier_europa.gsc  (hash_6c1f47e03a968952.gscc) (size: 6309 Bytes / 0x18a5 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xe471ad7e (3832655230)
// size ...... 6309 (0x18a5)
// includes .. 13  (offset: 0x176d)
// strings ... 16  (offset: 0x17d5)
// dev strs .. 0   (offset: 0x18a5)
// exports ... 19  (offset: 0xdc1)
// cseg ...... 0x16c + 0xc55 (0xdc1)
// imports ... 58  (offset: 0x10b9)
// animtree1 . 0   (offset: 0x18a5)
// animtree2 . 0   (offset: 0x18a5)
#using script_16ea1b94f0f381b3;
#using script_2734ab7e314a0bd3;
#using script_ac28d65e8605696;
#using scripts\anim\shared;
#using scripts\common\ai\aitypes\shared\zombie\zombie_knockdown;
#using scripts\common\ai\aitypes\shared\zombie\zombie_utils;
#using scripts\common\callbacks;
#using scripts\common\trace;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\mp\pack_a_punch;
#using scripts\mp\zm\points;
#using scripts\mp\zm\systems\zone_manager;

#namespace zm_soldier_europa;

// Namespace zm_soldier_europa
// Params 2
// Checksum 0x4727022, Offset: 0x18a
// Size: 0x1c
function precache( classname, aitypescriptbundle )
{
    init();
}

// Namespace zm_soldier_europa
// Params 0
// Checksum 0x5d1affd9, Offset: 0x1ae
// Size: 0x105
function init()
{
    if ( !level callback::exists( #"on_ai_killed", &zm_event_on_ai_killed ) )
    {
        level callback::add( #"on_ai_killed", &zm_event_on_ai_killed );
    }
    
    if ( !level callback::exists( #"hash_f2c79b44bf002ece", &function_c45014711cfb806 ) )
    {
        level callback::add( #"hash_f2c79b44bf002ece", &function_c45014711cfb806 );
    }
    
    if ( !level callback::exists( #"hash_4ee55d1a7046ff82", &function_11554f48a9592faa ) )
    {
        level callback::add( #"hash_4ee55d1a7046ff82", &function_11554f48a9592faa );
    }
    
    level zombie_utils::function_dfae6a5bd222c586( &function_df427ff0f3f36028 );
    callback::add( #"europa_init", &function_17af73cff065ccc4 );
    callback::add( #"europa_activated", &on_activated );
    callback::add( #"europa_return_to_chair", &on_return_to_chair );
    callback::add( #"hash_bf2f3d5470c22e57", &function_22fc08d53be6ae );
    callback::add( #"hash_706274acea59a6d6", &is_location_reachable );
}

// Namespace zm_soldier_europa
// Params 1, eflags: 0x4
// Checksum 0x570f48f5, Offset: 0x2bb
// Size: 0x1c
function private on_activated( params )
{
    function_dc25cc97f7c6deae( 1 );
    thread function_db93ec3cb3a30df3();
}

// Namespace zm_soldier_europa
// Params 1, eflags: 0x4
// Checksum 0x20fbd24a, Offset: 0x2df
// Size: 0x3a
function private on_return_to_chair( params )
{
    level endon( #"game_ended" );
    self endon( #"death" );
    self waittill( #"europa_sit_on_chair" );
    function_dc25cc97f7c6deae( 2 );
}

// Namespace zm_soldier_europa
// Params 1, eflags: 0x4
// Checksum 0x42dcccfb, Offset: 0x321
// Size: 0x6f
function private function_17af73cff065ccc4( params )
{
    if ( !level callback::exists( "on_pluto_teleport", &on_pluto_teleport, self ) )
    {
        level callback::add( "on_pluto_teleport", &on_pluto_teleport, self );
    }
    
    if ( !isdefined( level.soldier_europas ) )
    {
        level.soldier_europas = [];
    }
    
    level.soldier_europas[ level.soldier_europas.size ] = self;
    thread function_8011bd2ea8f953e9();
    init_ping_objective();
}

// Namespace zm_soldier_europa
// Params 0, eflags: 0x4
// Checksum 0x356095b3, Offset: 0x398
// Size: 0x91
function private function_8011bd2ea8f953e9()
{
    settings = self.aisettings.specificaisettings;
    weapon = self getcurrentweapon();
    var_39044599845b54cf = weapon getnoaltweapon();
    ammo_mod = utility::callsharedfunc( #"ammo_mod", #"hash_cf1012c4d313de70", var_39044599845b54cf );
    var_101633ed971732ba = pack_a_punch::function_e190a315803e2870( var_39044599845b54cf, settings.paplevel, ammo_mod );
    shared::forceuseweapon( var_101633ed971732ba, "primary" );
}

// Namespace zm_soldier_europa
// Params 0, eflags: 0x4
// Checksum 0x930e841e, Offset: 0x431
// Size: 0x93
function private init_ping_objective()
{
    scriptable = spawnscriptable( "zm_sat_firefly_europa_objective", self.origin, self.angles );
    
    if ( scriptable )
    {
        self.europa.objectivemover = spawn( "script_model", self.origin );
        scriptable scriptablesetparententity( self.europa.objectivemover );
        self.europa.objectivesbl = scriptable;
        function_dc25cc97f7c6deae( 0 );
        thread update_objective_pos();
    }
}

// Namespace zm_soldier_europa
// Params 0, eflags: 0x4
// Checksum 0x8df3cf2b, Offset: 0x4cc
// Size: 0x4a
function private update_objective_pos()
{
    level endon( #"game_ended" );
    self endon( #"death" );
    
    while ( true )
    {
        self.europa.objectivemover.origin = self.origin;
        waitframe();
    }
}

// Namespace zm_soldier_europa
// Params 1, eflags: 0x4
// Checksum 0x2020f488, Offset: 0x51e
// Size: 0x26b
function private function_df427ff0f3f36028( params )
{
    if ( !europa::is_europa( params.eattacker ) )
    {
        return -1;
    }
    
    if ( self.klaus_target )
    {
        return -1;
    }
    
    damage = -1;
    
    if ( params.smeansofdeath == "MOD_RIFLE_BULLET" )
    {
        europa = params.eattacker;
        victim = self;
        category = victim.aicategory ?? "normal";
        
        switch ( category )
        {
            case #"hash_84fcf5e68d7230b2":
                multiplier = europa.aisettings.specificaisettings.damagemultipliernormal;
                damage = function_66abfdd54ffc9269( victim, multiplier );
                break;
            case #"hash_8c089e813083e510":
                multiplier = europa.aisettings.specificaisettings.damagemultiplierspecial;
                damage = function_66abfdd54ffc9269( victim, multiplier );
                break;
            case #"hash_7b0e2f2ed84f34":
                multiplier = europa.aisettings.specificaisettings.damagemultiplierelite;
                damage = function_66abfdd54ffc9269( victim, multiplier );
                break;
            case #"hash_4e47eb6c32f5b165":
                multiplier = europa.aisettings.specificaisettings.damagemultiplierhvt;
                damage = function_66abfdd54ffc9269( victim, multiplier );
                break;
            case #"hash_7e8a002ed096276c":
                if ( europa.aisettings.specificaisettings.var_5ab277c708881307 > 0 )
                {
                    damage = europa.aisettings.specificaisettings.var_5ab277c708881307;
                }
                
                if ( victim.health <= damage )
                {
                    return 0;
                }
                
                break;
            default:
                damage = params.idamage;
                break;
        }
        
        damage = max( params.idamage, damage );
    }
    else if ( params.smeansofdeath == "MOD_MELEE" )
    {
        round_difficulty = namespace_9d8e359c3b1041e5::function_57de0ca2e80536a1( self.origin );
        damage = namespace_9d8e359c3b1041e5::function_870440d8340968c0( "zombie_base", round_difficulty );
    }
    
    return int( damage );
}

// Namespace zm_soldier_europa
// Params 2, eflags: 0x4
// Checksum 0xfd0217b0, Offset: 0x792
// Size: 0x2d
function private function_66abfdd54ffc9269( target, multiplier )
{
    if ( multiplier > 0 )
    {
        return ( target.maxhealth * multiplier );
    }
    
    return -1;
}

// Namespace zm_soldier_europa
// Params 1
// Checksum 0x2d1ada3b, Offset: 0x7c8
// Size: 0xb1
function function_dc25cc97f7c6deae( state )
{
    scriptable = self.europa.objectivesbl;
    
    if ( !scriptable )
    {
        return;
    }
    
    switch ( state )
    {
        case 0:
            scriptable utility::function_32b24db3127bff40( "objective", "off" );
            break;
        case 1:
            scriptable utility::function_32b24db3127bff40( "objective", "activated" );
            break;
        case 2:
            scriptable utility::function_32b24db3127bff40( "objective", "deactivated" );
            break;
        default:
            break;
    }
}

// Namespace zm_soldier_europa
// Params 1, eflags: 0x4
// Checksum 0xc252b597, Offset: 0x881
// Size: 0x131, Type: bool
function private function_22fc08d53be6ae( params )
{
    if ( !self || self.sessionstate == "dead" || self.sessionstate == "spectating" )
    {
        return false;
    }
    
    foreach ( ai in level.soldier_europas )
    {
        if ( !ai europa::is_activated() || !ai europa::can_think() )
        {
            continue;
        }
        
        revivecount = ai.aisettings.specificaisettings.revivetimes;
        
        if ( revivecount > 0 && ai.europa.revive_teammate_count >= revivecount )
        {
            continue;
        }
        
        if ( level.europa.no_revive )
        {
            continue;
        }
        
        return true;
    }
    
    return false;
}

// Namespace zm_soldier_europa
// Params 1, eflags: 0x4
// Checksum 0x19d69fcf, Offset: 0x9bb
// Size: 0x103
function private zm_event_on_ai_killed( params )
{
    if ( level.soldier_europas && europa::is_europa( self ) )
    {
        level.soldier_europas = arrayremove( level.soldier_europas, self );
    }
    
    if ( !val::get( "allow_give_point" ) )
    {
        return;
    }
    
    if ( !europa::is_europa( params.eattacker ) )
    {
        return;
    }
    
    switch ( self.aicategory )
    {
        case #"hash_8c089e813083e510":
            event = #"zombie_kia_europa_special";
            break;
        case #"hash_7b0e2f2ed84f34":
        case #"hash_4e47eb6c32f5b165":
            event = #"zombie_kia_europa_elite";
            break;
        default:
            event = #"zombie_kia_europa";
            break;
    }
    
    player = params.eattacker europa::get_owner();
    
    if ( player )
    {
        player points::zm_do_score_event( event, undefined, undefined, undefined, self );
    }
}

// Namespace zm_soldier_europa
// Params 1, eflags: 0x4
// Checksum 0xe7db493f, Offset: 0xac6
// Size: 0x49
function private function_c45014711cfb806( params )
{
    if ( self.allyeuropa && self.savedtactical )
    {
        utility::callsharedfunc( #"europa", #"hash_461d60a67b99be95" );
        self.var_9b9d033de4d3ef5a = 1;
    }
}

// Namespace zm_soldier_europa
// Params 1, eflags: 0x4
// Checksum 0x6053d672, Offset: 0xb17
// Size: 0x3b
function private function_11554f48a9592faa( params )
{
    if ( self.var_9b9d033de4d3ef5a )
    {
        utility::callsharedfunc( #"europa", #"hash_c7ca27e86991f1a7" );
        self.var_9b9d033de4d3ef5a = 0;
    }
}

// Namespace zm_soldier_europa
// Params 2, eflags: 0x4
// Checksum 0x1408de95, Offset: 0xb5a
// Size: 0x7e
function private on_pluto_teleport( params, europa )
{
    if ( europa )
    {
        const_distance_sq = squared( 100 );
        
        if ( distancesquared( europa.origin, params.teleportpos ) < const_distance_sq )
        {
            dir = params.teleportpos - europa.origin;
            europa thread europa::knock_back( dir, 200, 0.2 );
        }
    }
}

// Namespace zm_soldier_europa
// Params 0, eflags: 0xc
// Checksum 0x3ffb13f9, Offset: 0xbe0
// Size: 0x19c
function private function_db93ec3cb3a30df3()
{
    self notify( #"hash_8f05a98eef3975c3" );
    self endon( #"hash_8f05a98eef3975c3" );
    level endon( #"game_ended" );
    self endon( #"death" );
    self endon( #"europa_deactivated" );
    var_4f173c7abd0f3385 = 64;
    overridecontent = trace::create_contents( 1 );
    
    while ( true )
    {
        if ( europa_hover::is_hovering() )
        {
            start = europa_hover::get_hover_origin();
            end = start + anglestoforward( self.angles ) * var_4f173c7abd0f3385;
            results = trace::sphere_trace_get_all_results( start, end, self.radius, self, overridecontent );
            
            foreach ( result in results )
            {
                ent = result[ "entity" ];
                
                if ( isai( ent ) && isalive( ent ) && ent.team != self.team && ent.aicategory == "normal" && !ent zombie_knockdown::function_19d6107cb6bdff5c() )
                {
                    ent zombie_knockdown::function_6fc167d4a3590991( ent.origin );
                    waitframe();
                }
            }
        }
        
        wait 0.1;
    }
}

// Namespace zm_soldier_europa
// Params 1
// Checksum 0xe7971a6e, Offset: 0xd84
// Size: 0x3c, Type: bool
function is_location_reachable( params )
{
    zone = zone_manager::function_90e5c3e2272b0130( params.origin );
    
    if ( !zone.is_enabled )
    {
        return false;
    }
    
    return true;
}

