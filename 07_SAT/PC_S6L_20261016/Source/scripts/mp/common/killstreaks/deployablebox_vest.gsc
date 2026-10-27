// scripts\mp\common\killstreaks\deployablebox_vest.gsc  (hash_22a1fc9d7d4672e1.gscc) (size: 1919 Bytes / 0x77f / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x9ec7f0c5 (2663903429)
// size ...... 1919 (0x77f)
// includes .. 4   (offset: 0x6a3)
// strings ... 13  (offset: 0x6c3)
// dev strs .. 1   (offset: 0x773)
// exports ... 6   (offset: 0x4b7)
// cseg ...... 0x1b1 + 0x306 (0x4b7)
// imports ... 9   (offset: 0x5a7)
// animtree1 . 0   (offset: 0x77f)
// animtree2 . 0   (offset: 0x77f)
#using scripts\common\utility;
#using scripts\mp\common\killstreaks\deployablebox;
#using scripts\mp\common\perks\perkfunctions;
#using scripts\mp\lightarmor;

#namespace deployablebox_vest;

// Namespace deployablebox_vest
// Params 0
// Checksum 0x55c43f00, Offset: 0x1cf
// Size: 0x200
function init()
{
    boxconfig = spawnstruct();
    boxconfig.id = "deployable_vest";
    boxconfig.weaponinfo = "deployable_vest_marker_mp";
    boxconfig.modelbase = "prop_ballistic_vest_iw6";
    boxconfig.modelbombsquad = "prop_ballistic_vest_iw6_bombsquad";
    boxconfig.hintstring = &"killstreaks_hints_light_armor_pickup";
    boxconfig.capturingstring = &"killstreaks_box_getting_vest";
    boxconfig.event = "deployable_vest_taken";
    boxconfig.streakname = "deployable_vest";
    boxconfig.splashname = "used_deployable_vest";
    boxconfig.shadername = "compass_objpoint_deploy_friendly";
    boxconfig.headiconoffset = 20;
    boxconfig.lifespan = 90;
    boxconfig.usexp = 50;
    boxconfig.scorepopup = "destroyed_vest";
    boxconfig.vodestroyed = "ballistic_vest_destroyed";
    boxconfig.deployedsfx = "mp_vest_deployed_ui";
    boxconfig.onusesfx = "ammo_crate_use";
    boxconfig.onusecallback = &onusedeployable;
    boxconfig.canusecallback = &canusedeployable;
    boxconfig.usetime = 1000;
    boxconfig.maxhealth = 220;
    boxconfig.damagefeedback = "deployable_bag";
    boxconfig.deathvfx = loadfxasset( "vfx_iw7_requests_mp_generic_equip_explo" );
    boxconfig.allowmeleedamage = 1;
    boxconfig.allowgrenadedamage = 0;
    boxconfig.maxuses = 4;
    boxconfig.canuseotherboxes = 0;
    level.boxsettings[ "deployable_vest" ] = boxconfig;
    assertmsg( "<dev string:x24>" );
    level.deployable_box[ "deployable_vest" ] = [];
}

// Namespace deployablebox_vest
// Params 2
// Checksum 0xa413d3d6, Offset: 0x3d7
// Size: 0x56, Type: bool
function tryusedeployablevest( lifeid, streakname )
{
    result = deployablebox::begindeployableviamarker( lifeid, "deployable_vest" );
    
    if ( !result )
    {
        return false;
    }
    
    utility::trycall( level.matchdata_logkillstreakevent, "deployable_vest", self.origin );
    return true;
}

// Namespace deployablebox_vest
// Params 1
// Checksum 0x16b89352, Offset: 0x436
// Size: 0x14, Type: bool
function canusedeployable( boxent )
{
    return !lightarmor::haslightarmor( self );
}

// Namespace deployablebox_vest
// Params 1
// Checksum 0xd514970a, Offset: 0x453
// Size: 0x13
function onusedeployable( boxent )
{
    perkfunctions::setlightarmor();
}

// Namespace deployablebox_vest
// Params 2
// Checksum 0x8292ba2f, Offset: 0x46e
// Size: 0x48
function get_adjusted_armor( existing_armor, rank )
{
    if ( existing_armor + level.deployablebox_vest_rank[ rank ] > level.deployablebox_vest_max )
    {
        return level.deployablebox_vest_max;
    }
    
    return existing_armor + level.deployablebox_vest_rank[ rank ];
}

