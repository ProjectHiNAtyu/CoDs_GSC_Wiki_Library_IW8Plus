// scripts\mp\zm\maps\zm_sat_firefly\zm_sat_firefly_script_intel.gsc  (hash_636245b7a249bfe2.gscc) (size: 4861 Bytes / 0x12fd / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xc8d549ba (3369421242)
// size ...... 4861 (0x12fd)
// includes .. 6   (offset: 0x1139)
// strings ... 30  (offset: 0x1169)
// dev strs .. 1   (offset: 0x12f1)
// exports ... 9   (offset: 0xb41)
// cseg ...... 0x332 + 0x80f (0xb41)
// imports ... 40  (offset: 0xca9)
// animtree1 . 0   (offset: 0x12fd)
// animtree2 . 0   (offset: 0x12fd)
#using scripts\common\scriptable;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\mp\interaction;
#using scripts\mp\zm\maps\zm_sat_firefly\zm_sat_firefly_script_intel_cs;
#using scripts\mp\zombie_intel;

#namespace zm_sat_firefly_script_intel;

// Namespace zm_sat_firefly_script_intel
// Params 0, eflags: 0x5
// Checksum 0xa06b4819, Offset: 0x350
// Size: 0x19
function private autoexec __init__system__()
{
    system::register( #"hash_979e6abed3bb57db", undefined, &__init__, undefined );
}

// Namespace zm_sat_firefly_script_intel
// Params 0
// Checksum 0x225cbd37, Offset: 0x371
// Size: 0x129
function __init__()
{
    if ( !getdvarint( @"enable_firefly_ee", 0 ) )
    {
        return;
    }
    
    level._effect[ "tank_blast" ] = loadfxasset( "vfx_t10_gameplay_sp_ai_frag_explode_weak" );
    zm_sat_firefly_script_intel_cs::main();
    level utility::flag_wait( "zm_sat_firefly_script_intel_cs_completed" );
    level.firefly_intel = spawnstruct();
    level.firefly_intel.tank_trigger = getent( "janus_tank_damage_trigger", #targetname );
    level.firefly_intel.bullseye_trigger = getent( "firefly_document1_target", #targetname );
    level.firefly_intel.tank_trigger thread function_c6568c429079f746();
    level.firefly_intel.bullseye_trigger thread function_ced6ee0ed023b3c9();
    level.firefly_intel.grom_papers = spawnscriptable( "zmintel_t10_paper_stack", utility::getstruct( "firefly_document2_stack" ).origin, utility::getstruct( "firefly_document2_stack" ).angles );
    scriptable::scriptable_adddamagedcallback( &function_c82012a8e3d8c63c );
    setup_bale_interacts();
}

// Namespace zm_sat_firefly_script_intel
// Params 11, eflags: 0x4
// Checksum 0xad33c3e1, Offset: 0x4a2
// Size: 0xba
function private function_c82012a8e3d8c63c( einflictor, eattacker, instance, idamage, idflags, smeansofdeath, objweapon, vdir, vpoint, modelindex, partname )
{
    if ( instance getscriptablehaspart( "intel_paper_stack_base" ) )
    {
        if ( instance getscriptablepartstate( "intel_paper_stack_base" ) == "intact" )
        {
            instance setscriptablepartstate( "intel_paper_stack_base", "destroyed" );
            scriptable::function_dc174fecebb79952( &function_c82012a8e3d8c63c );
            waitframe();
            intel::spawn_intel_at_location( undefined, "firefly_document2_stack", undefined, undefined, "zmintel_sat_firefly_document_2" );
        }
    }
}

// Namespace zm_sat_firefly_script_intel
// Params 0, eflags: 0x4
// Checksum 0x578a649f, Offset: 0x564
// Size: 0x1a3
function private function_c6568c429079f746()
{
    level endon( #"game_ended" );
    self endon( #"death" );
    tank_hits = 0;
    var_5609b701181d6e4f = utility::getstruct( "tank_doc_landing", "targetname" );
    s_tank_barrel = utility::getstruct( "tank_barrel", "targetname" );
    
    while ( isdefined( self ) )
    {
        self waittill( #"damage", damage, eattacker, direction_vec, point, smeansofdeath, modelname, tagname, partname, idflags, objweapon, origin, angles, normal, inflictor );
        
        if ( smeansofdeath == "MOD_MELEE" && eattacker utility::ent_flag( "perk_m_mod_active" ) )
        {
            tank_hits++;
            
            if ( tank_hits >= 3 )
            {
                playsoundatpos( s_tank_barrel.origin, "eqp_frag_grenade_expl_trans" );
                playfx( utility::getfx( "tank_blast" ), s_tank_barrel.origin );
                intel::spawn_intel_at_location( undefined, undefined, s_tank_barrel.origin, var_5609b701181d6e4f.angles, "zmintel_sat_firefly_document_6", var_5609b701181d6e4f.origin );
                self delete();
                continue;
            }
            
            playsoundatpos( s_tank_barrel.origin, "evt_intel_tank_startup_fail_" + tank_hits );
        }
    }
}

// Namespace zm_sat_firefly_script_intel
// Params 0, eflags: 0x4
// Checksum 0x34bff137, Offset: 0x70f
// Size: 0x154
function private function_ced6ee0ed023b3c9()
{
    level endon( #"game_ended" );
    self endon( #"death" );
    bullseye_land = utility::getstruct( "bullseye_doc_landing", "targetname" ).origin;
    
    while ( isdefined( self ) )
    {
        self waittill( #"damage", damage, eattacker, direction_vec, point, smeansofdeath, modelname, tagname, partname, idflags, objweapon, origin, angles, normal, inflictor );
        
        if ( smeansofdeath == "MOD_RIFLE_BULLET" || smeansofdeath == "MOD_PISTOL_BULLET" )
        {
            dist = distance2d( eattacker.origin, self.origin );
            
            if ( isplayer( eattacker ) && dist > 190 )
            {
                intel::spawn_intel_at_location( undefined, undefined, self.origin, self.angles, "zmintel_sat_firefly_document_1", bullseye_land );
                self delete();
            }
        }
    }
}

// Namespace zm_sat_firefly_script_intel
// Params 0, eflags: 0x4
// Checksum 0x28662e74, Offset: 0x86b
// Size: 0x103
function private setup_bale_interacts()
{
    var_2ec4bec67a94bbc6 = utility::getstructarray( "firefly_document4_interact", "targetname" );
    level.firefly_intel.unchecked_interacts = var_2ec4bec67a94bbc6.size;
    
    foreach ( bale_interact_struct in var_2ec4bec67a94bbc6 )
    {
        bale_interact = spawnscriptable( "firefly_hay_bale_intel_interact", bale_interact_struct.origin );
        
        if ( isdefined( bale_interact_struct.script_noteworthy ) )
        {
            bale_interact.s_landing = utility::getstruct( bale_interact_struct.script_noteworthy );
        }
        
        bale_interact = interaction::register_scriptable_interact( bale_interact, &function_58a53610aaaafcbd );
        bale_interact interaction::set_interact_hint_callback( &bale_interact_hint );
    }
}

// Namespace zm_sat_firefly_script_intel
// Params 2, eflags: 0x4
// Checksum 0xd825a9b9, Offset: 0x976
// Size: 0x40
function private bale_interact_hint( usable, player )
{
    return { #var_26bbd300351fde34:0, #string:&"", #type:"HINT_NOBUTTON" };
}

// Namespace zm_sat_firefly_script_intel
// Params 1, eflags: 0x4
// Checksum 0x19fd1897, Offset: 0x9bf
// Size: 0x182
function private function_58a53610aaaafcbd( player )
{
    self setscriptablepartstate( "base", "off" );
    playsoundatpos( self.origin, "evt_intel_hay_rustle" );
    
    if ( level.firefly_intel.unchecked_interacts < 1 )
    {
        return;
    }
    
    if ( randomint( level.firefly_intel.unchecked_interacts ) == 0 )
    {
        /#
            iprintlnbold( "<dev string:x24>" );
        #/
        
        v_landing = isdefined( self.s_landing ) ? self.s_landing.origin : player.origin;
        s_intel = intel::spawn_intel_at_location( undefined, undefined, self.origin, self.angles, "zmintel_sat_firefly_document_4", v_landing );
        level.firefly_intel.unchecked_interacts = 0;
        wait 0.6;
        
        if ( isdefined( s_intel.mdl_intel ) && !isdefined( self.s_landing.origin ) )
        {
            v_ground = getgroundposition( s_intel.mdl_intel.origin, 8 );
            s_intel.mdl_intel.origin = v_ground + ( 0, 0, 2 );
        }
    }
    else
    {
        level.firefly_intel.unchecked_interacts--;
    }
    
    self freescriptable();
}

