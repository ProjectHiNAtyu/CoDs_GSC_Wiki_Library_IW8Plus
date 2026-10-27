// scripts\mp\ob\activities\ob_robot_charging.gsc  (hash_6899ae2fb6097674.gscc) (size: 2309 Bytes / 0x905 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xdd12319e (3708957086)
// size ...... 2309 (0x905)
// includes .. 4   (offset: 0x7d9)
// strings ... 15  (offset: 0x7f9)
// dev strs .. 2   (offset: 0x8ed)
// exports ... 6   (offset: 0x54d)
// cseg ...... 0x123 + 0x42a (0x54d)
// imports ... 13  (offset: 0x63d)
// animtree1 . 0   (offset: 0x905)
// animtree2 . 0   (offset: 0x905)
#using scripts\common\callbacks;
#using scripts\common\scene;
#using scripts\common\utility;
#using scripts\common\values;

#namespace ob_robot_charging;

// Namespace ob_robot_charging
// Params 0
// Checksum 0x5fd2e83f, Offset: 0x141
// Size: 0x1bf, Type: bool
function function_8e231efbddecc102()
{
    robot = self;
    robot endon( #"death" );
    is_guild_bot = robot is_robot_guild_bot();
    is_dawg = robot is_robot_dawg();
    
    if ( !is_guild_bot && !is_dawg )
    {
        return false;
    }
    
    robot.var_24954f14e27b448d = 0;
    robot val::set( "ob_robot_charging", "ignoreme", 1 );
    robot val::set( "ob_robot_charging", "ignoreall", 1 );
    robot val::set( "ob_robot_charging", "damage", 0 );
    robot.script_pushable_by_ai = 0;
    robot.script_pushable = 0;
    robot.kfe_ignore = 1;
    
    if ( is_guild_bot )
    {
        scene_root = spawnstruct();
        scene_root.origin = robot.origin;
        scene_root.angles = robot.angles;
        scene_root scene::init( [ robot ], "idle", "sat_ai_guildbot_folded" );
        scene_root thread scene::play( [ robot ], "idle" );
        robot.scene_root = scene_root;
        robot callback::add( #"asm_death_anim", &function_bd1d69cee5ad085d );
        robot val::set( "ob_robot_charging", "allow_battlechatter_vo", 0 );
    }
    else if ( is_dawg )
    {
        robot.mode = "inactive";
        robot.var_e88e025ae79c116e = 1;
        robot.turret val::set( "ob_robot_charging", "damage", 0 );
    }
    
    robot._is_on_charging_pad = 1;
    return true;
}

// Namespace ob_robot_charging
// Params 0
// Checksum 0x6be7a37f, Offset: 0x309
// Size: 0x192, Type: bool
function activate_robot()
{
    robot = self;
    
    if ( !robot._is_on_charging_pad )
    {
        assertmsg( "<dev string:x24>" );
        return false;
    }
    
    is_guild_bot = robot is_robot_guild_bot();
    is_dawg = robot is_robot_dawg();
    
    if ( !is_guild_bot && !is_dawg )
    {
        return false;
    }
    
    robot.var_24954f14e27b448d = 1;
    robot val::set( "ob_robot_charging", "ignoreme", 0 );
    robot val::set( "ob_robot_charging", "ignoreall", 0 );
    robot val::set( "ob_robot_charging", "damage", 1 );
    robot.script_pushable_by_ai = 1;
    robot.script_pushable = 1;
    robot.kfe_ignore = undefined;
    
    if ( is_guild_bot )
    {
        robot val::set( "ob_robot_charging", "allow_battlechatter_vo", 1 );
        
        if ( robot.scene_root )
        {
            robot.scene_root scene::play( [ robot ], utility::array_random( [ "exit_01", "exit_02", "exit_03", "exit_04" ] ) );
            robot.scene_root = undefined;
        }
        else
        {
            assertmsg( "<dev string:x4a>" );
        }
    }
    else if ( is_dawg )
    {
        robot.turret val::set( "ob_robot_charging", "damage", 1 );
        robot.mode = "attack";
    }
    
    return true;
}

// Namespace ob_robot_charging
// Params 1, eflags: 0x4
// Checksum 0x67e95638, Offset: 0x4a4
// Size: 0x32
function private function_bd1d69cee5ad085d( params )
{
    if ( self.scene_root )
    {
        self.scene_root scene::stop();
        self.scene_root = undefined;
    }
}

// Namespace ob_robot_charging
// Params 0, eflags: 0x4
// Checksum 0x651598b4, Offset: 0x4de
// Size: 0x34
function private is_robot_guild_bot()
{
    robot = self;
    
    if ( !robot.agent_type )
    {
        return 0;
    }
    
    return issubstr( robot.agent_type, "guild_bot" );
}

// Namespace ob_robot_charging
// Params 0, eflags: 0x4
// Checksum 0x9e42d844, Offset: 0x51b
// Size: 0x31, Type: bool
function private is_robot_dawg()
{
    robot = self;
    
    if ( !robot.subclass )
    {
        return false;
    }
    
    return robot.subclass == "dawg";
}

