// script_dfbffa20f9a73d  (hash_00dfbffa20f9a73d.gscc) (size: 8386 Bytes / 0x20c2 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x15210765 (354486117)
// size ...... 8386 (0x20c2)
// includes .. 5   (offset: 0x1e46)
// strings ... 44  (offset: 0x1e6e)
// dev strs .. 2   (offset: 0x20aa)
// exports ... 14  (offset: 0x1666)
// cseg ...... 0x386 + 0x12e0 (0x1666)
// imports ... 48  (offset: 0x1896)
// animtree1 . 0   (offset: 0x20c2)
// animtree2 . 0   (offset: 0x20c2)
#using script_3d2770dc09c1243;
#using scripts\common\utility;
#using scripts\mp\bots\bots_gametype_super_shared;
#using scripts\mp\bots\bots_util;
#using scripts\mp\matchdata;

#namespace mit_doors;

// Namespace mit_doors
// Params 0
// Checksum 0xc46e7956, Offset: 0x3a4
// Size: 0x1e3
function init()
{
    var_3b665dc4b674fde7 = { #success:0, #total:0, #var_a752a51f6436637c:[], #doors:[] };
    level.mit.door = var_3b665dc4b674fde7;
    doors = getentitylessscriptablearray( undefined, undefined, undefined, undefined, "door" );
    
    foreach ( door in doors )
    {
        state = door getscriptablepartstate( "door", 1 );
        islocked = door function_4f79c45e0fd47b7f();
        assert( !islocked );
        
        if ( state != "closed" )
        {
            continue;
        }
        
        doormidpoint = door function_50ddcb729a6c2820();
        
        if ( !ispointonnavmesh( doormidpoint ) )
        {
            continue;
        }
        
        door.failedtimes = 0;
        level.mit.door.doors[ level.mit.door.doors.size ] = door;
    }
    
    level.mit.door.total = level.mit.door.doors.size;
    
    if ( level.mit.door.total == 0 )
    {
        mit::outputlog( "Door", "No doors to test." );
    }
}

// Namespace mit_doors
// Params 0
// Checksum 0x46c159e9, Offset: 0x58f
// Size: 0x281
function testprocess()
{
    assert( !isdefined( self.mit.var_17f4f434fd59efb3 ) );
    self botsetdifficultysetting( "slideChance", 0 );
    self.mit.onplayerkilled = &onplayerkilled;
    
    if ( level.mit.door.doors.size <= 0 )
    {
        return;
    }
    
    door = function_e25e36e4aea620bb();
    self.mit.var_17f4f434fd59efb3 = door;
    
    if ( !function_2d7f01a561c759d4( door ) )
    {
        function_b95a0db54ca18cd3( "door is not closed", self, undefined, door, undefined, undefined, 0 );
        self.mit.var_17f4f434fd59efb3.testingresult = 0;
        return;
    }
    
    doorinfo = function_b5e62c5c6f60111d( door );
    self.mit.var_17f4f434fd59efb3.doorinfo = doorinfo;
    
    if ( !isdefined( doorinfo ) )
    {
        function_b95a0db54ca18cd3( "can't find test pos", self, undefined, door, undefined, undefined, 0 );
        self.mit.var_17f4f434fd59efb3.testingresult = 0;
        return;
    }
    
    var_4adbd46a987c2f21 = 20;
    failedresult = mit::botteleport( doorinfo.beforedoorpos, var_4adbd46a987c2f21 );
    
    if ( isdefined( failedresult ) )
    {
        function_b95a0db54ca18cd3( "teleport failed/" + failedresult, self, self.origin, door, doorinfo.beforedoorpos, doorinfo.afterdoorpos, 0 );
        self.mit.var_17f4f434fd59efb3.testingresult = 0;
        return;
    }
    
    self.mit.var_17f4f434fd59efb3.testingresult = 0;
    
    for ( targetpositions = [ doorinfo.afterdoorpos, doorinfo.beforedoorpos ]; targetpositions.size > 0 ; targetpositions = arrayremove( targetpositions, nextpos ) )
    {
        nextpos = targetpositions[ 0 ];
        
        if ( !gototargetposition( self, doorinfo, nextpos ) )
        {
            break;
        }
    }
    
    door scriptabledoorclose();
    
    if ( isdefined( self.mit.var_17f4f434fd59efb3.testingresult ) )
    {
        self.mit.var_17f4f434fd59efb3.testingresult = targetpositions.size <= 0;
    }
}

// Namespace mit_doors
// Params 0
// Checksum 0x89f75589, Offset: 0x818
// Size: 0x2f6
function endhandler()
{
    if ( isdefined( self ) )
    {
        if ( isdefined( self.mit.var_17f4f434fd59efb3.testingresult ) )
        {
            if ( self.mit.var_17f4f434fd59efb3.testingresult )
            {
                level.mit.door.success++;
                door = self.mit.var_17f4f434fd59efb3;
                report( "passed", self, self.origin, door, door.doorinfo.beforedoorpos, door.doorinfo.afterdoorpos, 1 );
            }
            else
            {
                var_61563f95f51d5159 = 3;
                door = self.mit.var_17f4f434fd59efb3;
                door.failedtimes++;
                
                if ( door.failedtimes < var_61563f95f51d5159 )
                {
                    function_5e29bc6ac4c15830( self.mit.var_17f4f434fd59efb3 );
                }
                else if ( door.failedtimes == var_61563f95f51d5159 )
                {
                    level.mit.door.var_a752a51f6436637c[ level.mit.door.var_a752a51f6436637c.size ] = door.doorinfo;
                    failinfo = door.var_38f671059d6311ca;
                    report( failinfo.situation, failinfo.bot, failinfo.lastposition, door, failinfo.beforedoorpos, failinfo.afterdoorpos, failinfo.ispassed );
                }
                else
                {
                    assertmsg( "<dev string:x24>" );
                }
            }
            
            if ( level.mit.door.success + level.mit.door.var_a752a51f6436637c.size >= level.mit.door.total )
            {
                reportstring = "Test result: " + level.mit.door.total + " doors, " + level.mit.door.success + " successes, " + level.mit.door.var_a752a51f6436637c.size + " failures.";
                mit::outputlog( "Door", reportstring );
            }
        }
        
        self botsetflag( "disable_movement", 0 );
        self.mit.var_17f4f434fd59efb3 = undefined;
    }
}

// Namespace mit_doors
// Params 0, eflags: 0x4
// Checksum 0xc4220ba8, Offset: 0xb16
// Size: 0xce
function private function_e25e36e4aea620bb()
{
    assert( level.mit.door.doors.size > 0 );
    lastindex = level.mit.door.doors.size - 1;
    door = level.mit.door.doors[ lastindex ];
    level.mit.door.doors[ lastindex ] = undefined;
    
    if ( isint( lastindex ) )
    {
        function_cdc669dbc8ea2101( level.mit.door.doors );
    }
    
    return door;
}

// Namespace mit_doors
// Params 1, eflags: 0x4
// Checksum 0x3f31f2be, Offset: 0xbed
// Size: 0x31
function private function_5e29bc6ac4c15830( door )
{
    arrayinsert( level.mit.door.doors, door, 0 );
}

// Namespace mit_doors
// Params 7, eflags: 0x4
// Checksum 0xcc058e38, Offset: 0xc26
// Size: 0x9f
function private function_b95a0db54ca18cd3( situation, bot, lastposition, door, beforedoorpos, afterdoorpos, ispassed )
{
    failinfo = { #ispassed:ispassed, #afterdoorpos:afterdoorpos, #beforedoorpos:beforedoorpos, #lastposition:lastposition, #bot:bot, #situation:situation };
    door.var_38f671059d6311ca = failinfo;
}

// Namespace mit_doors
// Params 0
// Checksum 0x92fdb7f9, Offset: 0xccd
// Size: 0x22, Type: bool
function function_119b9a096f5511d2()
{
    return level.mit.door.doors.size > 0;
}

// Namespace mit_doors
// Params 1, eflags: 0x4
// Checksum 0xd25b2c61, Offset: 0xcf8
// Size: 0x28
function private function_2d7f01a561c759d4( door )
{
    if ( door scriptabledoorisclosed() )
    {
        return 1;
    }
    
    door scriptabledoorclose();
    wait 1;
    return door scriptabledoorisclosed();
}

// Namespace mit_doors
// Params 1, eflags: 0x4
// Checksum 0x56e2b681, Offset: 0xd29
// Size: 0x19a
function private function_b5e62c5c6f60111d( door )
{
    var_9dceb595de66b33f = [ 100, 70, 50 ];
    var_a0a612eb0924efc1 = 50;
    var_45d3b5139914173a = 1.25;
    doormidpoint = door function_50ddcb729a6c2820();
    
    foreach ( dis in var_9dceb595de66b33f )
    {
        beforedoorpos = bots_util_mp::function_1882f18076610076( doormidpoint + anglestoforward( door.angles + ( 0, -90, 0 ) ) * dis );
        beforedoorpos = utility::drop_to_ground( beforedoorpos, var_a0a612eb0924efc1 );
        afterdoorpos = bots_util_mp::function_1882f18076610076( doormidpoint + anglestoforward( door.angles + ( 0, 90, 0 ) ) * dis );
        afterdoorpos = utility::drop_to_ground( afterdoorpos, var_a0a612eb0924efc1 );
        
        if ( distance( beforedoorpos, afterdoorpos ) <= 2 * dis * var_45d3b5139914173a )
        {
            doorinfo = { #midpoint:doormidpoint, #afterdoorpos:afterdoorpos, #beforedoorpos:beforedoorpos, #originangle:door.angles, #door:door };
            return doorinfo;
        }
    }
}

// Namespace mit_doors
// Params 3, eflags: 0x4
// Checksum 0x999f78ec, Offset: 0xecc
// Size: 0x1f3, Type: bool
function private gototargetposition( bot, doorinfo, targetpos )
{
    const_time_limit = 4.5;
    const_time_interval = 0.25;
    ispassed = 0;
    tickstart = mit::function_9f2a98ba9eb78c4d();
    lastposition = bot.origin;
    
    while ( true )
    {
        bot namespace_ef4547f85724edd1::setscriptgoal( targetpos, 32 );
        result = mit::function_adbdc8fee4453bd7( bot, const_time_interval );
        
        if ( !ispassed )
        {
            ispassed = function_f076ce901235a582( doorinfo, lastposition, bot.origin );
            lastposition = bot.origin;
        }
        
        if ( result == "goal" )
        {
            if ( !ispassed )
            {
                function_b95a0db54ca18cd3( "bypass the door", bot, lastposition, doorinfo.door, doorinfo.beforedoorpos, doorinfo.afterdoorpos, ispassed );
                return false;
            }
            
            break;
        }
        
        if ( gettimescale() == 4 )
        {
            limitduration = const_time_limit * 2.125 / const_time_limit / 4;
        }
        else
        {
            limitduration = const_time_limit;
        }
        
        if ( ( result == "timeout" || result == "bad_path_stuck" ) && mit::function_9f2a98ba9eb78c4d() - tickstart < limitduration * 1000 )
        {
            continue;
        }
        else if ( result == "bad_path_door_blocker_door_owner" || result == "bad_path_door_blocker_invalid_client" )
        {
            doorinfo.door scriptabledoorclose();
            function_5e29bc6ac4c15830( doorinfo.door );
            self.mit.var_17f4f434fd59efb3.testingresult = undefined;
            return false;
        }
        
        function_b95a0db54ca18cd3( result, bot, lastposition, doorinfo.door, doorinfo.beforedoorpos, doorinfo.afterdoorpos, ispassed );
        return false;
    }
    
    return true;
}

// Namespace mit_doors
// Params 3, eflags: 0x4
// Checksum 0x96cddda7, Offset: 0x10c8
// Size: 0x76
function private function_f076ce901235a582( doorinfo, startpos, endpos )
{
    var_b5783c36c6e1d6c9 = 64;
    var_d49178107e605b6e = doorinfo.door.origin;
    var_fde5ed9eb3095cdb = var_d49178107e605b6e + anglestoforward( doorinfo.originangle ) * var_b5783c36c6e1d6c9;
    return mit::function_57b388b15cd6d2a5( startpos, endpos, var_d49178107e605b6e, var_fde5ed9eb3095cdb );
}

// Namespace mit_doors
// Params 1, eflags: 0x4
// Checksum 0x7e13e533, Offset: 0x1147
// Size: 0x42
function private onplayerkilled( deathdata )
{
    if ( !isbot( self ) )
    {
        return;
    }
    
    report( "death", self, self.lastdeathpos, self.mit.var_17f4f434fd59efb3, undefined, undefined, 0 );
}

// Namespace mit_doors
// Params 7, eflags: 0x4
// Checksum 0x3a2ec068, Offset: 0x1191
// Size: 0x4d5
function private report( situation, bot, lastposition, door, beforedoorpos, afterdoorpos, ispassed )
{
    if ( !level.mit.door.var_3fa4867e71b23351 )
    {
        header = "#time; #situation; #bot; #lastPosition; #doorIndex; #doorOrigin; #beforeDoorPos; #afterDoorPos; #isPassed";
        mit::outputlog( "Door", header );
        level.mit.door.var_3fa4867e71b23351 = 1;
    }
    
    unknownpos = "unknownPos";
    
    if ( !isdefined( lastposition ) )
    {
        lastposition = unknownpos;
    }
    
    if ( !isdefined( beforedoorpos ) )
    {
        beforedoorpos = unknownpos;
    }
    
    if ( !isdefined( afterdoorpos ) )
    {
        afterdoorpos = unknownpos;
    }
    
    doorindex = -1;
    doororigin = ( 0, 0, 0 );
    situation = situation ? situation : "NO_SITUATION";
    
    if ( isdefined( door ) )
    {
        doorindex = door.index;
        doororigin = door.origin;
    }
    
    reportstring = gettime() + ";" + situation + ";" + bot getentitynumber() + ";" + lastposition + ";" + doorindex + ";" + doororigin + ";" + beforedoorpos + ";" + afterdoorpos + ";" + ispassed;
    mit::outputlog( "Door", reportstring );
    var_d51e46999aca9ddb = mit::function_655ffb35317b1edb( lastposition, 3, [ -1, -1, -1 ] );
    var_1c778da92c363542 = mit::function_655ffb35317b1edb( doororigin, 3, [ -1, -1, -1 ] );
    var_ecf39975fec0e20b = mit::function_655ffb35317b1edb( beforedoorpos, 3, [ -1, -1, -1 ] );
    var_8fc629f6c66d86c0 = mit::function_655ffb35317b1edb( afterdoorpos, 3, [ -1, -1, -1 ] );
    dlog_recordevent( "dlog_event_mit_door", [ "time", matchdata::gettimefrommatchstart( gettime() ) ?? -1, "situation", situation ?? "", "bot", bot getentitynumber() ?? -1, "last_position_x", var_d51e46999aca9ddb[ 0 ] * 1, "last_position_y", var_d51e46999aca9ddb[ 1 ] * 1, "last_position_z", var_d51e46999aca9ddb[ 2 ] * 1, "door_index", isnumber( doorindex ) ? doorindex : -1, "door_origin_x", var_1c778da92c363542[ 0 ] * 1, "door_origin_y", var_1c778da92c363542[ 1 ] * 1, "door_origin_z", var_1c778da92c363542[ 2 ] * 1, "before_door_pos_x", var_ecf39975fec0e20b[ 0 ] * 1, "before_door_pos_y", var_ecf39975fec0e20b[ 1 ] * 1, "before_door_pos_z", var_ecf39975fec0e20b[ 2 ] * 1, "after_door_pos_x", var_8fc629f6c66d86c0[ 0 ] * 1, "after_door_pos_y", var_8fc629f6c66d86c0[ 1 ] * 1, "after_door_pos_z", var_8fc629f6c66d86c0[ 2 ] * 1, "is_passed", isnumber( ispassed ) ? ispassed : 0 ] );
    
    /#
        if ( isdefined( level.mit.door.var_5d233476ee119367 ) )
        {
            level.mit.door.var_5d233476ee119367 += 1;
        }
        else
        {
            level.mit.door.var_5d233476ee119367 = 1;
        }
        
        doormidpoint = door function_50ddcb729a6c2820();
        camerapos = bots_util_mp::function_1882f18076610076( doormidpoint + anglestoforward( door.angles + ( 0, 90, 0 ) ) * 170 );
        camerapos = utility::drop_to_ground( camerapos, 50 );
        camerapos = ( camerapos[ 0 ], camerapos[ 1 ], camerapos[ 2 ] - 40 );
        mit::requestscreenshot( "<dev string:x41>", doormidpoint, camerapos, door, level.mit.door.var_5d233476ee119367 );
    #/
}

