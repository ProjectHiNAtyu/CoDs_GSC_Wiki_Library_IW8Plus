// scripts\mp\zm\maps\zm_sat_scarab\zm_sat_scarab_intel.gsc  (hash_07923aa4919f7e36.gscc) (size: 2933 Bytes / 0xb75 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x4fd5e77e (1339418494)
// size ...... 2933 (0xb75)
// includes .. 7   (offset: 0xa79)
// strings ... 16  (offset: 0xab1)
// dev strs .. 0   (offset: 0xb75)
// exports ... 10  (offset: 0x5a1)
// cseg ...... 0x1aa + 0x3f7 (0x5a1)
// imports ... 29  (offset: 0x731)
// animtree1 . 0   (offset: 0xb75)
// animtree2 . 0   (offset: 0xb75)
#using scripts\common\callbacks;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\mp\common\weapons\weap_scarabww;
#using scripts\mp\zm\systems\weapons\zm_damage;
#using scripts\mp\zm\systems\zm_save;
#using scripts\mp\zombie_intel;

#namespace zm_sat_scarab_intel;

// Namespace zm_sat_scarab_intel
// Params 0, eflags: 0x5
// Checksum 0x579e7328, Offset: 0x1c8
// Size: 0x19
function private autoexec __init__system__()
{
    system::register( #"hash_4b28f3ad54b77a2c", undefined, &__init__, undefined );
}

// Namespace zm_sat_scarab_intel
// Params 0
// Checksum 0xaa6d24f4, Offset: 0x1e9
// Size: 0x1d
function __init__()
{
    if ( !getdvarint( @"hash_1389eb7dad9f9d83", 0 ) )
    {
        return;
    }
    
    level thread intel_setup();
}

// Namespace zm_sat_scarab_intel
// Params 0
// Checksum 0x1074a3f2, Offset: 0x20e
// Size: 0x6b
function intel_setup()
{
    level.scarab_intel = spawnstruct();
    level utility::flag_wait( "scriptables_ready" );
    level utility::flag_wait( "zm_sat_scarab_intel_cs_completed" );
    zm_save::function_1f44a48caae2acbf();
    level callback::add( #"player_connect", &function_41da1cb9de6c0688 );
    level callback::add( #"hash_78694f61c22b5057", &function_85a0b5b797af9dd0 );
    setup_web_doc();
    level thread function_f829cfa7958e381();
}

// Namespace zm_sat_scarab_intel
// Params 1, eflags: 0x4
// Checksum 0x16c6c33d, Offset: 0x281
// Size: 0x44
function private function_85a0b5b797af9dd0( params )
{
    if ( isdefined( params.player ) )
    {
        params.player utility::callsharedfunc( #"intel", #"collect_intel", "zmintel_sat_scarab_artifact_2" );
    }
}

// Namespace zm_sat_scarab_intel
// Params 0, eflags: 0x4
// Checksum 0xb5e67826, Offset: 0x2cd
// Size: 0xa8
function private setup_web_doc()
{
    a_webs = getentitylessscriptablearray( "intel_web", #targetname );
    
    foreach ( web in a_webs )
    {
        web setscriptablepartstate( "base", "on" );
        web zm_damage::register_scriptable_damage_callback( &function_190deddae604eaac, 1 );
    }
}

// Namespace zm_sat_scarab_intel
// Params 1, eflags: 0x4
// Checksum 0x4a933823, Offset: 0x37d
// Size: 0x93
function private function_190deddae604eaac( params )
{
    if ( params.var_5e5a2456deacd236 != "fire" && !utility::isfiredamage( params.smeansofdeath ) && !utility::isexplosivedamage( params.smeansofdeath ) && !weap_scarabww::function_3a1514a781375202( params ) )
    {
        return 0;
    }
    
    self setscriptablepartstate( "base", "hit" );
    self setscriptablepartstate( "health", "ignore_damage" );
    zm_damage::function_c31f9d79d5ceb7ec( &function_190deddae604eaac, 0 );
    return params.idamage;
}

// Namespace zm_sat_scarab_intel
// Params 1, eflags: 0x4
// Checksum 0x730b0e80, Offset: 0x419
// Size: 0x2e
function private function_41da1cb9de6c0688( params )
{
    self waittill( #"spawned_player" );
    callback::add( #"hash_476fcd5501956e2c", &function_f62bf81709107036 );
}

// Namespace zm_sat_scarab_intel
// Params 1, eflags: 0x4
// Checksum 0xf2137654, Offset: 0x44f
// Size: 0x67
function private function_f62bf81709107036( params )
{
    if ( params.str_intel_name == "zmintel_sat_scarab_document_5" )
    {
        utility::callsharedfunc( #"intel", #"collect_intel", "zmintel_sat_scarab_audiolog_3", undefined, level.var_704fb5f66fb99126.s_piano_sbl );
        callback::remove( #"hash_476fcd5501956e2c", &function_f62bf81709107036 );
    }
}

// Namespace zm_sat_scarab_intel
// Params 0, eflags: 0x4
// Checksum 0x41cd0acf, Offset: 0x4be
// Size: 0xe3
function private function_f829cfa7958e381()
{
    level endon( #"game_ended" );
    var_bb69c3f5bd6dbaec = utility::getstruct( "bed_jump_trigger" );
    bed_trigger = spawn( "noent_volume_trigger_radius", var_bb69c3f5bd6dbaec.origin, 0, var_bb69c3f5bd6dbaec.radius, var_bb69c3f5bd6dbaec.radius );
    
    for ( i = 0; i < 5 ; i++ )
    {
        bed_trigger waittill( #"trigger", triggeredent );
        wait 0.5;
    }
    
    var_4f96dbe97996752a = utility::getstruct( "scarab_document_6_landing" );
    intel::spawn_intel_at_location( undefined, undefined, var_4f96dbe97996752a.origin + ( 0, 0, 30 ), var_4f96dbe97996752a.angles, "zmintel_sat_scarab_document_6", var_4f96dbe97996752a.origin );
}

