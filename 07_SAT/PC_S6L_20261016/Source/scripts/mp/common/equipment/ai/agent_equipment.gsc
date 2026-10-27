// scripts\mp\common\equipment\ai\agent_equipment.gsc  (hash_5c7620f2c295e590.gscc) (size: 2539 Bytes / 0x9eb / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x18114eb (25236715)
// size ...... 2539 (0x9eb)
// includes .. 7   (offset: 0x8ef)
// strings ... 13  (offset: 0x927)
// dev strs .. 1   (offset: 0x9d7)
// exports ... 4   (offset: 0x5db)
// cseg ...... 0x11e + 0x4bd (0x5db)
// imports ... 22  (offset: 0x67b)
// animtree1 . 0   (offset: 0x9eb)
// animtree2 . 0   (offset: 0x9eb)
#using scripts\common\math;
#using scripts\common\trace;
#using scripts\common\utility;
#using scripts\mp\agents\agent_utils;
#using scripts\mp\ai_mp_controller;
#using scripts\mp\common\utility\weapon;
#using scripts\mp\equipment;

#namespace agent_equipment;

// Namespace agent_equipment
// Params 0
// Checksum 0xa23cc50d, Offset: 0x13c
// Size: 0x1a2
function function_bcc76eaafcb0353f()
{
    if ( getdvarint( @"scr_agent_equipment_killswitch", 1 ) == 0 )
    {
        return;
    }
    
    claymorenodes = level.struct_class_names[ "script_noteworthy" ][ "boss_trapper_claymore" ];
    atminenodes = level.struct_class_names[ "script_noteworthy" ][ "boss_trapper_at_mine" ];
    soundveilnodes = level.struct_class_names[ "script_noteworthy" ][ "boss_trapper_cluster" ];
    var_5ffa78b7621e61ca = [ claymorenodes, atminenodes, soundveilnodes ];
    equipstrings = [ "claymore", "at_mine", "sound_veil" ];
    
    for ( i = 0; i < var_5ffa78b7621e61ca.size ; i++ )
    {
        if ( !isdefined( var_5ffa78b7621e61ca[ i ] ) )
        {
            continue;
        }
        
        foreach ( node in var_5ffa78b7621e61ca[ i ] )
        {
            deploystruct = spawnstruct();
            deploystruct.origin = node.origin;
            deploystruct.angles = node.angles;
            deploystruct.ref = "equip_" + equipstrings[ i ];
            thread function_75c0ba09c6e9ef85( deploystruct );
        }
    }
}

// Namespace agent_equipment
// Params 1
// Checksum 0x9c3c5c7d, Offset: 0x2e6
// Size: 0x154
function function_f3b908ca82b18202( equipmentref )
{
    eyeposition = self getvieworigin();
    cameraorientation = self getplayerangles();
    cameraforward = anglestoforward( cameraorientation );
    cameratraceend = eyeposition + cameraforward * 256;
    ignorearray = self;
    contentarray = trace::create_contents( 1, 0, 0, 1, 0, 1, 0, 1, 1 );
    deploytrace = trace::ray_trace( eyeposition, cameratraceend, ignorearray, contentarray, 0, 0, 1 );
    
    if ( deploytrace[ "hittype" ] == "hittype_none" )
    {
        return;
    }
    
    deploypos = deploytrace[ "position" ];
    deployfwd = math::vector_project_onto_plane( vectornormalize( self.origin - deploytrace[ "position" ] ), deploytrace[ "normal" ] );
    deployup = deploytrace[ "normal" ];
    deployright = vectorcross( deployfwd, deployup );
    deployorientation = axistoangles( deployfwd, deployright, deployup );
    deploystruct = spawnstruct();
    deploystruct.origin = deploypos;
    deploystruct.angles = deployorientation;
    deploystruct.ref = equipmentref;
    function_75c0ba09c6e9ef85( deploystruct );
}

// Namespace agent_equipment
// Params 2
// Checksum 0xd0a05bf3, Offset: 0x442
// Size: 0x199
function function_75c0ba09c6e9ef85( deploystruct, agentteam )
{
    assert( isdefined( deploystruct.origin ), "<dev string:x24>" );
    assert( isdefined( deploystruct.angles ), "<dev string:x24>" );
    assert( isdefined( deploystruct.origin ), "<dev string:x24>" );
    weaponref = deploystruct.ref;
    isequip = issubstr( deploystruct.ref, "equip_" );
    weaponobj = undefined;
    
    if ( isequip )
    {
        tableinfo = equipment_mp::getequipmenttableinfo( deploystruct.ref );
        
        if ( isdefined( tableinfo.objweapon ) )
        {
            weaponref = tableinfo.objweapon.basename;
            weaponobj = tableinfo.objweapon;
        }
    }
    else
    {
        weaponobj = makeweapon( weaponref );
    }
    
    fakeowner = ai_mp_controller::function_3d6581dd2c928fbc( agent_utils::function_25b40f5accbca0dd( "merc" ) );
    grenade = fakeowner weapon::_launchgrenade( weaponref, deploystruct.origin, ( 0, 0, 0 ), undefined, 0, undefined, 0 );
    grenade.angles = deploystruct.angles;
    
    /#
        level thread utility::draw_angles( grenade.angles, grenade.origin, ( 1, 0, 0 ), 5000, 100 );
    #/
}

