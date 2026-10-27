// scripts\mp\ftue\utility\ftue_objectives.gsc  (hash_5dfa1fb6b030bdcb.gscc) (size: 2990 Bytes / 0xbae / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xb7ffcabd (3086994109)
// size ...... 2990 (0xbae)
// includes .. 2   (offset: 0xb2a)
// strings ... 8   (offset: 0xb3a)
// dev strs .. 1   (offset: 0xba2)
// exports ... 11  (offset: 0x5aa)
// cseg ...... 0x11d + 0x48d (0x5aa)
// imports ... 34  (offset: 0x762)
// animtree1 . 0   (offset: 0xbae)
// animtree2 . 0   (offset: 0xbae)
#using scripts\common\utility;
#using scripts\mp\objidpoolmanager;

#namespace ftue_objectives;

// Namespace ftue_objectives
// Params 0
// Checksum 0x2a0d2196, Offset: 0x13b
// Size: 0x2b
function function_50101ec1259fbc62()
{
    level.ftueobjectives = spawnstruct();
    level.ftueobjectives.waypoints = [];
    function_1ab164ff42ef39b5();
}

// Namespace ftue_objectives
// Params 0, eflags: 0x4
// Checksum 0x98d5a5e8, Offset: 0x16e
// Size: 0x13
function private function_1ab164ff42ef39b5()
{
    utility::add_fx( "ftue_objectives_waypoint_fx", "vfx_misc_ftue_ring_01" );
}

// Namespace ftue_objectives
// Params 6
// Checksum 0x4ff4f4dd, Offset: 0x189
// Size: 0xaa
function function_518a2916085fd4f8( objectiveposition = ( 0, 0, 0 ), labeltext, icon, zoffset, owner, showwaypoint )
{
    waypointdata = spawnstruct();
    waypointdata.showwaypoint = istrue( showwaypoint );
    waypointdata.position = objectiveposition;
    waypointdata.owner = owner;
    objectiveid = function_59a71a8bcb39f0bf( labeltext, icon, zoffset, undefined, owner, waypointdata );
    objective_position( objectiveid, objectiveposition );
    return objectiveid;
}

// Namespace ftue_objectives
// Params 6
// Checksum 0x9fd66658, Offset: 0x23c
// Size: 0xce
function function_86cc57c1dfabee84( objectivetarget, labeltext, icon, zoffset, owner, showwaypoint )
{
    waypointdata = spawnstruct();
    waypointdata.showwaypoint = istrue( showwaypoint );
    waypointdata.position = objectivetarget.origin;
    waypointdata.owner = owner;
    team = undefined;
    
    if ( isplayer( objectivetarget ) )
    {
        team = objectivetarget.team;
    }
    
    objectiveid = function_59a71a8bcb39f0bf( labeltext, icon, zoffset, team, owner, waypointdata );
    objective_onentity( objectiveid, objectivetarget );
    objectivetarget.objectiveid = objectiveid;
    return objectiveid;
}

// Namespace ftue_objectives
// Params 6, eflags: 0x4
// Checksum 0x75c9d4f6, Offset: 0x313
// Size: 0x101
function private function_59a71a8bcb39f0bf( labeltext, icon, zoffset, team, owner, waypointdata )
{
    objectiveid = objidpoolmanager::requestobjectiveid( 1 );
    objective_state( objectiveid, "current" );
    objective_icon( objectiveid, icon );
    objective_setminimapiconsize( objectiveid, "icon_regular" );
    objective_setbackground( objectiveid, 1 );
    objective_setshowdistance( objectiveid, !isdefined( team ) );
    objective_setfadedisabled( objectiveid, 1 );
    
    if ( isdefined( labeltext ) )
    {
        objective_setlabel( objectiveid, labeltext );
    }
    
    objective_setzoffset( objectiveid, zoffset );
    objective_setwidget( objectiveid, "mobileftueobjective" );
    
    if ( isdefined( team ) )
    {
        objective_setownerteam( objectiveid, team );
        objective_addalltomask( objectiveid );
    }
    
    if ( isdefined( owner ) )
    {
        objective_removeallfrommask( objectiveid );
        objective_addclienttomask( objectiveid, owner );
        objective_showtoplayersinmask( objectiveid );
        owner thread function_47906576fa902f3a( objectiveid );
    }
    
    if ( waypointdata.showwaypoint )
    {
        function_5ec61a7725483c58( objectiveid, waypointdata );
    }
    
    return objectiveid;
}

// Namespace ftue_objectives
// Params 2, eflags: 0x4
// Checksum 0xa1d2b256, Offset: 0x41d
// Size: 0x7e
function private function_5ec61a7725483c58( objectiveid, waypointdata )
{
    assert( isdefined( waypointdata.owner ), "<dev string:x24>" );
    waypoint = spawnfxforclient( utility::getfx( "ftue_objectives_waypoint_fx" ), waypointdata.position, waypointdata.owner );
    triggerfx( waypoint );
    level.ftueobjectives.waypoints[ objectiveid ] = waypoint;
}

// Namespace ftue_objectives
// Params 1
// Checksum 0x2581f7f9, Offset: 0x4a3
// Size: 0x1e
function function_ed97408344737f10( objectivetarget )
{
    function_ecadaaabe4a83e9b( objectivetarget.objectiveid );
}

// Namespace ftue_objectives
// Params 1
// Checksum 0xa5d7b1c, Offset: 0x4c9
// Size: 0x35
function function_ecadaaabe4a83e9b( objectiveid )
{
    if ( !objidpoolmanager::function_1eca7bd1a3a49a4d( objectiveid ) )
    {
        level notify( "ftue_objective_removed_" + objectiveid );
        objidpoolmanager::returnobjectiveid( objectiveid );
        function_9be5d16ac42058e( objectiveid );
    }
}

// Namespace ftue_objectives
// Params 1, eflags: 0x4
// Checksum 0x665879, Offset: 0x506
// Size: 0x43
function private function_9be5d16ac42058e( objectiveid )
{
    if ( !isdefined( level.ftueobjectives.waypoints[ objectiveid ] ) )
    {
        return;
    }
    
    level.ftueobjectives.waypoints[ objectiveid ] delete();
}

// Namespace ftue_objectives
// Params 1, eflags: 0x4
// Checksum 0x95627f6e, Offset: 0x551
// Size: 0x59
function private function_47906576fa902f3a( objectiveid )
{
    player = self;
    player endon( #"disconnect" );
    level endon( #"game_ended" );
    level endon( "ftue_objective_removed_" + objectiveid );
    player utility::waittill_any_return( "currentContextualTipCompleted", "currentContextualTipAborted" );
    function_9be5d16ac42058e( objectiveid );
}

