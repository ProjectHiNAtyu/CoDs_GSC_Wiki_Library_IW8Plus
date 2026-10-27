// scripts\mp\ob\activities\ob_activity_gunship_commander.gsc  (hash_2721f099dd766f41.gscc) (size: 3894 Bytes / 0xf36 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x27f9cc08 (670682120)
// size ...... 3894 (0xf36)
// includes .. 11  (offset: 0xe36)
// strings ... 11  (offset: 0xe8e)
// dev strs .. 1   (offset: 0xf2a)
// exports ... 16  (offset: 0x69e)
// cseg ...... 0x130 + 0x56e (0x69e)
// imports ... 46  (offset: 0x91e)
// animtree1 . 0   (offset: 0xf36)
// animtree2 . 0   (offset: 0xf36)
#using script_3455b106458253e7;
#using scripts\common\activity_nexus\activity_common;
#using scripts\common\activity_nexus\activity_definition_utils;
#using scripts\common\activity_nexus\activity_instance_common;
#using scripts\common\activity_nexus\activity_participation;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\mp\common\utility\player_utility;
#using scripts\mp\flags;
#using scripts\mp\loot\common_cache;
#using scripts\mp\ob\activities\ob_activity_gunship_heli;

#namespace ob_activity_gunship_commander;

/#

    // Namespace ob_activity_gunship_commander
    // Params 0
    // Checksum 0x746e5029, Offset: 0x14e
    // Size: 0x5, Type: dev
    function function_5c4ff2ec34953c72()
    {
        
    }

#/

// Namespace ob_activity_gunship_commander
// Params 0, eflags: 0x5
// Checksum 0x566449a4, Offset: 0x15b
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"hash_43e8f59569cbc76a", #"activity_common", &function_bbb74f260e58b192, undefined );
}

// Namespace ob_activity_gunship_commander
// Params 0, eflags: 0x4
// Checksum 0xeb63e6f6, Offset: 0x184
// Size: 0x13
function private function_bbb74f260e58b192()
{
    activity_common::registeractivitytype( "REV_OB_GUNSHIP_COMMANDER", &function_ce3a85de3a054b5 );
}

// Namespace ob_activity_gunship_commander
// Params 0
// Checksum 0x5edeefa3, Offset: 0x19f
// Size: 0x6e
function function_ce3a85de3a054b5()
{
    activity_common::function_944074f3079c1d4e( "REV_OB_GUNSHIP_COMMANDER", 0, &function_62430aaa7617c493 );
    activity_common::function_944074f3079c1d4e( "REV_OB_GUNSHIP_COMMANDER", 1, &function_4e7b5e70e60372bb );
    activity_common::function_944074f3079c1d4e( "REV_OB_GUNSHIP_COMMANDER", 2, &function_92a81d6c7f2cff03 );
    activity_common::function_2dd4f07fa5c3e911( "ActivitySuccess", &on_activity_success, "REV_OB_GUNSHIP_COMMANDER" );
    utility::registersharedfunc( #"hash_9476caf6b0377996", #"hash_57c3ad8e12c378d1", &function_3e31d9ffd4e6b2e7 );
}

// Namespace ob_activity_gunship_commander
// Params 0
// Checksum 0xa60409a0, Offset: 0x215
// Size: 0x18d
function function_62430aaa7617c493()
{
    activityvariantdefinition = activity_definition_utils::function_837a0c8626c9b419();
    self.var_91c91f4a631c481d = activity_definition_utils::function_9129cd8075c85c09( activityvariantdefinition );
    self.start = utility::getstruct( self.varianttag, "targetname" );
    self.heli_path_start = self.start namespace_be3150865da9d2f1::get_linked_struct();
    assert( isdefined( self.start ), "<dev string:x24>" + self.varianttag );
    
    if ( utility::issharedfuncdefined( #"hash_9476caf6b0377996", #"hash_a9b37ef5c1f86827" ) )
    {
        utility::callsharedfunc( #"hash_9476caf6b0377996", #"hash_a9b37ef5c1f86827", self.var_91c91f4a631c481d );
    }
    
    if ( flags::gameflagexists( "prematch_done" ) )
    {
        flags::gameflagwait( "prematch_done" );
    }
    
    ob_activity_gunship_heli::chopper_init();
    level.var_be17f6f2696e1d1a = 6000;
    level.var_89ef72f6589587f0 = 1;
    instance = spawnstruct();
    instance.var_b2596b0f06a9e7a1 = [];
    instance.bossname = "chopper";
    instance.spawned = 0;
    instance.spawnloc = self.heli_path_start.origin;
    instance.patrolpath = self.heli_path_start;
    instance.activity = self;
    instance ob_activity_gunship_heli::chopper_spawn();
    activity_instance_common::function_46135a69bddfec2c( self );
    activity_participation::function_d041ee0ec570299d( instance.chopper );
}

// Namespace ob_activity_gunship_commander
// Params 0
// Checksum 0xd009fc42, Offset: 0x3aa
// Size: 0xa
function function_4e7b5e70e60372bb()
{
    activity_participation::function_a45fd1c5cc774007( self );
}

// Namespace ob_activity_gunship_commander
// Params 1
// Checksum 0xe5a6d2a6, Offset: 0x3bc
// Size: 0x15
function function_3e31d9ffd4e6b2e7( activityinstance )
{
    function_babd34fe09dc1bdc( activityinstance );
}

// Namespace ob_activity_gunship_commander
// Params 1
// Checksum 0x5883b098, Offset: 0x3d9
// Size: 0xfb
function function_babd34fe09dc1bdc( activityinstance )
{
    crate_model = spawn( "script_model", self.origin );
    crate_model setmodel( "military_carepackage_03_ob" );
    crate_model unlink();
    crate_model physicslaunchserver( ( 0, 0, 0 ), ( 0, 0, 0 ) );
    bodyid = crate_model physics_getbodyid( 0 );
    physics_setbodycenterofmassnormal( bodyid, ( 0, 0, -1 ) );
    crate_model.physicsactivated = 1;
    var_7efd2ef630bd1000 = spawnscriptable( "ob_loot_cache_crate", self.origin );
    var_7efd2ef630bd1000 scriptablesetparententity( crate_model, ( 0, 0, 40 ) );
    var_7efd2ef630bd1000 setscriptablepartstate( "body", #"closed_usable" );
    common_cache::fillcontentsfromlist( var_7efd2ef630bd1000, "ob_jup_items_activity_gunship", 4 );
    var_7efd2ef630bd1000 thread function_67151111b7196d5a( crate_model );
    var_7efd2ef630bd1000 thread function_32e0783a9f8a1ce6( crate_model );
}

// Namespace ob_activity_gunship_commander
// Params 1
// Checksum 0xaaa41bf3, Offset: 0x4dc
// Size: 0x1c
function function_13d2be80b39dab83( activityinstance )
{
    self setscriptablepartstate( "body", "closed_usable" );
}

// Namespace ob_activity_gunship_commander
// Params 1
// Checksum 0xb82f8d58, Offset: 0x500
// Size: 0x26
function function_67151111b7196d5a( crate_model )
{
    crate_model endon( #"hash_23174a5ca590a5f4" );
    wait 180;
    crate_model childthread function_ef2c025616df34d5( self );
}

// Namespace ob_activity_gunship_commander
// Params 1
// Checksum 0x722dc869, Offset: 0x52e
// Size: 0xd5
function function_32e0783a9f8a1ce6( crate_model )
{
    crate_model endon( #"hash_23174a5ca590a5f4" );
    
    while ( true )
    {
        items_remaining = 0;
        
        foreach ( item in self.contents )
        {
            items_remaining += item.quantity;
        }
        
        if ( items_remaining == 0 )
        {
            self freescriptable();
            crate_model thread function_ef2c025616df34d5();
            crate_model notify( #"hash_23174a5ca590a5f4" );
        }
        
        wait 5;
    }
}

// Namespace ob_activity_gunship_commander
// Params 1
// Checksum 0xaaa9b10b, Offset: 0x60b
// Size: 0x5f
function function_ef2c025616df34d5( scriptable )
{
    while ( true )
    {
        player_in_radius = player_utility::script_getplayersinradius( self.origin, 2000 );
        
        if ( player_in_radius.size == 0 )
        {
            if ( isdefined( scriptable ) )
            {
                scriptable freescriptable();
            }
            
            self delete();
            self notify( #"hash_23174a5ca590a5f4" );
        }
        
        wait 10;
    }
}

// Namespace ob_activity_gunship_commander
// Params 1
// Checksum 0xf7ddb8e6, Offset: 0x672
// Size: 0xc
function on_activity_success( relevantinfostruct )
{
    
}

// Namespace ob_activity_gunship_commander
// Params 0
// Checksum 0x4465240d, Offset: 0x686
// Size: 0x2
function function_92a81d6c7f2cff03()
{
    
}

// Namespace ob_activity_gunship_commander
// Params 0
// Checksum 0x836da437, Offset: 0x690
// Size: 0xd
function wait_till_player_proximity()
{
    return level.players[ 0 ];
}

