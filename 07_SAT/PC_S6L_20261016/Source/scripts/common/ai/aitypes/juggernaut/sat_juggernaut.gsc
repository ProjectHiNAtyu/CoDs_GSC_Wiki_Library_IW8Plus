// scripts\common\ai\aitypes\juggernaut\sat_juggernaut.gsc  (hash_2661d953f8183f8f.gscc) (size: 1045 Bytes / 0x415 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x1eb6a6aa (515286698)
// size ...... 1045 (0x415)
// includes .. 1   (offset: 0x3c1)
// strings ... 6   (offset: 0x3c9)
// dev strs .. 0   (offset: 0x415)
// exports ... 4   (offset: 0x281)
// cseg ...... 0x139 + 0x148 (0x281)
// imports ... 5   (offset: 0x321)
// animtree1 . 0   (offset: 0x415)
// animtree2 . 0   (offset: 0x415)
#using scripts\common\callbacks;

#namespace sat_juggernaut;

// Namespace sat_juggernaut
// Params 2
// Checksum 0x395a50be, Offset: 0x157
// Size: 0x3c
function precache( classname, aitypescriptbundle )
{
    if ( !level callback::exists( "on_agent_spawned", &agent_on_spawned ) )
    {
        level callback::add( "on_agent_spawned", &agent_on_spawned );
    }
}

// Namespace sat_juggernaut
// Params 1
// Checksum 0x321b0660, Offset: 0x19b
// Size: 0x80, Type: bool
function is_agent_juggernaut( agent )
{
    return issubstr( agent.agent_type, "sat_ob_enemy_specialist_jugg_minigun" ) || issubstr( agent.agent_type, "sat_ob_enemy_cradle_specialist_jugg_minigun" ) || issubstr( agent.agent_type, "sat_ob_enemy_specialist_jugg_minigun_hunt" ) || issubstr( agent.agent_type, "sat_ob_enemy_hvt_jugg_minigun" ) || issubstr( agent.agent_type, "sat_ob_enemy_cradle_hvt_jugg_minigun" );
}

// Namespace sat_juggernaut
// Params 1, eflags: 0x4
// Checksum 0x1bddb5d5, Offset: 0x224
// Size: 0x5d
function private agent_on_spawned( params )
{
    agent = params.agent;
    
    if ( !is_agent_juggernaut( agent ) )
    {
        return;
    }
    
    self.allowpain = 1;
    self.minpaindamage = 15;
    self.var_2ffc71aa3aa17005 = 750;
    self.var_cf5b234b05d52123 = 30;
}

