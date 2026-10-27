// scripts\mp\common\equipment\ai\agent_claymore.gsc  (hash_5e1efc5dcb6b2a6e.gscc) (size: 1826 Bytes / 0x722 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x55a7b07a (1437053050)
// size ...... 1826 (0x722)
// includes .. 8   (offset: 0x686)
// strings ... 7   (offset: 0x6c6)
// dev strs .. 0   (offset: 0x722)
// exports ... 4   (offset: 0x2b2)
// cseg ...... 0xb8 + 0x1fa (0x2b2)
// imports ... 29  (offset: 0x352)
// animtree1 . 0   (offset: 0x722)
// animtree2 . 0   (offset: 0x722)
#using scripts\common\elevators;
#using scripts\mp\common\equipment\claymore;
#using scripts\mp\common\equipment\haywire;
#using scripts\mp\emp_debuff;
#using scripts\mp\ent_manager;
#using scripts\mp\equipment_interact;
#using scripts\mp\sentientpoolmanager;
#using scripts\mp\weapons;

#namespace agent_claymore;

// Namespace agent_claymore
// Params 0
// Checksum 0x9e6ebdef, Offset: 0xd6
// Size: 0x13
function agentclaymore_init()
{
    weapons::registeragentusedcallback( "claymore", &function_769f095bb74bb9ad );
}

// Namespace agent_claymore
// Params 1
// Checksum 0xbb91d4bf, Offset: 0xf1
// Size: 0x15
function function_769f095bb74bb9ad( grenade )
{
    grenade agentclaymore_plant();
}

// Namespace agent_claymore
// Params 0
// Checksum 0xd1b7d819, Offset: 0x10e
// Size: 0x1a4
function agentclaymore_plant()
{
    self endon( #"mine_triggered" );
    self endon( #"mine_destroyed" );
    self endon( #"death" );
    owner = self.owner;
    ent_manager::registerspawn( 1, &claymore::sweepclaymore );
    sentientpoolmanager::registersentient( "Lethal_Static", owner, 1 );
    owner weapons::onequipmentplanted( self, "equip_claymore", &claymore::claymore_delete );
    self missilethermal();
    self missileoutline();
    self setentityowner( owner );
    self setotherent( owner );
    self setnodeploy( 1 );
    thread weapons::minedamagemonitor();
    thread claymore::claymore_explodeonnotify();
    emp_debuff::set_apply_emp_callback( &claymore::claymore_empapplied );
    haywire::function_7f69a1eb3d590f76( &claymore::claymore_haywireapplied );
    claymore::function_a4ebfb83ec0621b9( &claymore::claymore_destroy );
    
    if ( isdefined( level.elevators ) )
    {
        foreach ( elevators in level.elevators )
        {
            elevators thread elevators::isentitytouchingdoortrigger( self );
        }
    }
    
    claymore::claymore_updatedangerzone();
    self setscriptablepartstate( "plant", "active", 0 );
    owner setscriptablepartstate( "equipClaymoreFXView", "plant", 0 );
    thread claymore::claymore_forceclampangles();
    wait 1;
    self setscriptablepartstate( "arm", "active", 0 );
    thread claymore::claymore_watchfortrigger();
    thread equipment_interact::remoteinteractsetup( &claymore::claymore_trigger, 1, 1 );
}

