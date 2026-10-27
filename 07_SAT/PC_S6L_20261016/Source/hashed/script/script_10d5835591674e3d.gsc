// script_10d5835591674e3d  (hash_10d5835591674e3d.gscc) (size: 1255 Bytes / 0x4e7 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x7c38ca94 (2084096660)
// size ...... 1255 (0x4e7)
// includes .. 8   (offset: 0x483)
// strings ... 3   (offset: 0x4c3)
// dev strs .. 0   (offset: 0x4e7)
// exports ... 4   (offset: 0x277)
// cseg ...... 0x84 + 0x1f3 (0x277)
// imports ... 13  (offset: 0x317)
// animtree1 . 0   (offset: 0x4e7)
// animtree2 . 0   (offset: 0x4e7)
#using script_3f14905e6bfa4fbb;
#using script_4eb10b8076cd40c;
#using scripts\anim\combat_utility;
#using scripts\anim\shared;
#using scripts\asm\asm_bb;
#using scripts\asm\shared\utility;
#using scripts\asm\soldier\patrol;
#using scripts\common\ai\ai_utility;

#namespace setup;

// Namespace setup
// Params 1
// Checksum 0x12f3342c, Offset: 0xa2
// Size: 0x176
function setupagent( taskid )
{
    if ( self.bagentinitialized )
    {
        return anim.success;
    }
    
    combat::soldier_init_common();
    self.goalradius = 480;
    self.goalheight = 1024;
    self.moveplaybackrate = 1;
    self.animplaybackrate = 1;
    self.movetransitionrate = 1;
    self.lookfordoorsalongpath = 1;
    self.dont_cleanup = 1;
    self.bsoldier = 1;
    self.space = 0;
    self.export = "agent";
    self.var_f38802177d63ee0f = "melee_ai_mp";
    
    if ( !isdefined( level.var_61435a225a04e6fc ) )
    {
        level.var_61435a225a04e6fc = makeweapon( "flash_grenade_mp" );
    }
    
    self.var_61435a225a04e6fc = level.var_61435a225a04e6fc;
    self.fnplaceweaponon = &shared::placeweaponon;
    self.fndropweapon = &shared::dropaiweapon;
    self.fnstealthgotonode = &ai_utility::go_to_node;
    stealth::initstealthfunctions();
    patrol::function_dc67338f3644087e();
    utility::setupsoldierdefaults();
    self.dropweapon = 0;
    thread shared::default_weaponsetup();
    thread handledeathcleanup();
    thread combat_utility::monitorflash();
    self enablemissedbulletclientonly( 1 );
    
    if ( isdefined( level.fnoffhandfire ) )
    {
        self thread [[ level.fnoffhandfire ]]();
    }
    
    self.bagentinitialized = 1;
    return anim.success;
}

// Namespace setup
// Params 1
// Checksum 0xcfb2a5fd, Offset: 0x221
// Size: 0x2c
function function_adc93b81b3ae7ff1( taskid )
{
    self.disablepistol = 1;
    self.disablelmgmount = 1;
    self.allowlongdeath = 0;
}

// Namespace setup
// Params 0
// Checksum 0x9a765fe9, Offset: 0x255
// Size: 0x22
function handledeathcleanup()
{
    level endon( #"game_ended" );
    self waittill( #"death" );
    asm_bb::bb_clearmeleetarget();
}

