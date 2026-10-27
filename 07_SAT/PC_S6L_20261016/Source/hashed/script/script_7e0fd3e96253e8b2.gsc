// script_7e0fd3e96253e8b2  (hash_7e0fd3e96253e8b2.gscc) (size: 2444 Bytes / 0x98c / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x3505a70b (889562891)
// size ...... 2444 (0x98c)
// includes .. 5   (offset: 0x8e8)
// strings ... 9   (offset: 0x910)
// dev strs .. 0   (offset: 0x98c)
// exports ... 10  (offset: 0x474)
// cseg ...... 0x153 + 0x321 (0x474)
// imports ... 26  (offset: 0x604)
// animtree1 . 0   (offset: 0x98c)
// animtree2 . 0   (offset: 0x98c)
#using scripts\common\activity_nexus\activity_common;
#using scripts\common\activity_nexus\activity_instance_common;
#using scripts\common\system;
#using scripts\mp\hud_util;
#using scripts\mp\interaction;

#namespace namespace_8011570415f5a340;

// Namespace namespace_8011570415f5a340
// Params 0, eflags: 0x5
// Checksum 0xe7240b97, Offset: 0x171
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"hash_4bdf0074c59183de", #"activity_common", &function_538033a540e63c70, undefined );
}

// Namespace namespace_8011570415f5a340
// Params 0, eflags: 0x4
// Checksum 0x6a0604a5, Offset: 0x19a
// Size: 0x13
function private function_538033a540e63c70()
{
    activity_common::registeractivitytype( "WZ_CONTRACT_IRONCLAD_TEST_PHASE", &activity_type_init );
}

// Namespace namespace_8011570415f5a340
// Params 0
// Checksum 0x8f9676c9, Offset: 0x1b5
// Size: 0x4d
function activity_type_init()
{
    activity_common::function_944074f3079c1d4e( "WZ_CONTRACT_IRONCLAD_TEST_PHASE", 0, &activity_setup );
    activity_common::function_944074f3079c1d4e( "WZ_CONTRACT_IRONCLAD_TEST_PHASE", 1, &function_477932e3884ea1fd );
    activity_common::function_944074f3079c1d4e( "WZ_CONTRACT_IRONCLAD_TEST_PHASE", 2, &activity_ended );
    activity_common::function_944074f3079c1d4e( "WZ_CONTRACT_IRONCLAD_TEST_PHASE", 3, &function_d4acef179eb9f9b2 );
}

// Namespace namespace_8011570415f5a340
// Params 0
// Checksum 0x42aa7c38, Offset: 0x20a
// Size: 0x32
function activity_setup()
{
    activity_instance = self;
    activity_instance endon( #"activity_ended" );
    activity_instance endon( #"instance_destroyed" );
    activity_instance_common::function_46135a69bddfec2c( activity_instance );
}

// Namespace namespace_8011570415f5a340
// Params 0
// Checksum 0x2ee87c45, Offset: 0x244
// Size: 0x13f
function function_477932e3884ea1fd()
{
    activity_instance = self;
    activity_instance endon( #"activity_ended" );
    activity_instance endon( #"instance_destroyed" );
    hud_util::showsplashtoteam( activity_instance.team, "elite_ironclad_console_start", undefined, undefined, undefined, undefined, "splash_list_br_contract_elite_ironclad" );
    [ initiatingplayer ] = activity_instance.playerparticipants;
    spawnorigin = initiatingplayer.origin + anglestoforward( initiatingplayer.angles ) * 500 + ( 0, 0, 10 );
    spawnangles = initiatingplayer.angles + ( 0, 90, 0 );
    computer = spawn( "script_model", spawnorigin );
    computer.angles = spawnangles;
    computer setmodel( "t10_electronics_keycard_console_01" );
    interaction::register_interact( computer, 60, &function_ae767d7ac0111355, &"hash_7c8f90193bc8c576" );
    computer setcursorhint( "HINT_BUTTON" );
    computer sethinticon( "ui_map_icon_elite_crown" );
    computer sethinttag( "tag_light_blue" );
    computer.activity = activity_instance;
}

// Namespace namespace_8011570415f5a340
// Params 1
// Checksum 0x67cfbb2d, Offset: 0x38b
// Size: 0x40
function function_ae767d7ac0111355( player )
{
    computer = self;
    player thread function_3ad7bf3150980aa8();
    computer makeunusable();
    wait 2;
    activity_instance_common::endactivity( computer.activity, 1 );
}

// Namespace namespace_8011570415f5a340
// Params 0
// Checksum 0x6bb8681, Offset: 0x3d3
// Size: 0x4f
function function_3ad7bf3150980aa8()
{
    level endon( #"game_ended" );
    self endon( #"death_or_disconnect" );
    weapobj = makeweapon( "iw8_ges_plyr_loot_pickup" );
    self giveandfireoffhand( weapobj );
    wait 1.17;
    
    if ( self hasweapon( weapobj ) )
    {
        self takeweapon( weapobj );
    }
}

// Namespace namespace_8011570415f5a340
// Params 1
// Checksum 0x2773f9dd, Offset: 0x42a
// Size: 0x26
function activity_ended( activity_succeeded )
{
    activity_instance = self;
    activity_instance endon( #"instance_destroyed" );
}

// Namespace namespace_8011570415f5a340
// Params 0
// Checksum 0x4cfb37e1, Offset: 0x458
// Size: 0x1c
function function_d4acef179eb9f9b2()
{
    activity_instance = self;
    activity_instance endon( #"instance_destroyed" );
}

