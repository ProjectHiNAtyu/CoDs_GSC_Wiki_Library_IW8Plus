// scripts\mp\zm\maps\zm_sat_ruby\zm_sat_ruby_script_intel.gsc  (hash_6ea735030c3ce500.gscc) (size: 2910 Bytes / 0xb5e / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x51e9cb13 (1374276371)
// size ...... 2910 (0xb5e)
// includes .. 5   (offset: 0xa56)
// strings ... 15  (offset: 0xa7e)
// dev strs .. 2   (offset: 0xb46)
// exports ... 5   (offset: 0x67a)
// cseg ...... 0x1d9 + 0x4a1 (0x67a)
// imports ... 27  (offset: 0x742)
// animtree1 . 0   (offset: 0xb5e)
// animtree2 . 0   (offset: 0xb5e)
#using scripts\common\scriptable;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\mp\zm\maps\zm_sat_ruby\zm_sat_ruby_script_intel_cs;
#using scripts\mp\zombie_intel;

#namespace zm_sat_ruby_script_intel;

// Namespace zm_sat_ruby_script_intel
// Params 0, eflags: 0x5
// Checksum 0xa02fc167, Offset: 0x1f7
// Size: 0x19
function private autoexec __init__system__()
{
    system::register( #"hash_c509e445058a5996", undefined, &__init__, undefined );
}

// Namespace zm_sat_ruby_script_intel
// Params 0
// Checksum 0xbdae14ca, Offset: 0x218
// Size: 0x131
function __init__()
{
    if ( !getdvarint( @"hash_3a9ff30b9c2ea1f1", 0 ) )
    {
        return;
    }
    
    level._effect[ "planet_puff" ] = loadfxasset( "vfx_t10_gameplay_sp_ai_frag_explode_weak" );
    zm_sat_ruby_script_intel_cs::main();
    level utility::flag_wait( "zm_sat_ruby_script_intel_cs_completed" );
    level.ruby_intel = spawnstruct();
    level.ruby_intel.library_papers = spawnscriptable( "zmintel_t10_paper_stack", utility::getstruct( "ruby_document2_stack" ).origin, utility::getstruct( "ruby_document2_stack" ).angles );
    scriptable::scriptable_adddamagedcallback( &function_27404b252322a386 );
    level.ruby_intel.pluto = utility::spawn_model( "sat_zm_decor_planet_pluto_01", utility::getstruct( "pluto_spawn" ).origin );
    level.ruby_intel.var_b3ae50d99f2ac00d = 1;
    level.ruby_intel.planet_triggers = getentarray( "ruby_intel_planets", #targetname );
    utility::array_thread( level.ruby_intel.planet_triggers, &function_fcd37783d3da35ec );
}

// Namespace zm_sat_ruby_script_intel
// Params 11, eflags: 0x4
// Checksum 0x6ea961b5, Offset: 0x351
// Size: 0xba
function private function_27404b252322a386( einflictor, eattacker, instance, idamage, idflags, smeansofdeath, objweapon, vdir, vpoint, modelindex, partname )
{
    if ( instance getscriptablehaspart( "intel_paper_stack_base" ) )
    {
        if ( instance getscriptablepartstate( "intel_paper_stack_base" ) == "intact" )
        {
            instance setscriptablepartstate( "intel_paper_stack_base", "destroyed" );
            scriptable::function_dc174fecebb79952( &function_27404b252322a386 );
            waitframe();
            intel::spawn_intel_at_location( undefined, "ruby_document2_stack", undefined, undefined, "zmintel_sat_ruby_document_2" );
        }
    }
}

// Namespace zm_sat_ruby_script_intel
// Params 0, eflags: 0x4
// Checksum 0xc03ceb5c, Offset: 0x413
// Size: 0x267
function private function_fcd37783d3da35ec()
{
    level endon( #"game_ended" );
    level endon( #"hash_2b1951f14a045a51" );
    
    while ( isdefined( self ) && level.ruby_intel.var_b3ae50d99f2ac00d < 9 )
    {
        self waittill( #"damage", damage, eattacker, direction_vec, point, smeansofdeath, modelname, tagname, partname, idflags, objweapon, origin, angles, normal, inflictor );
        
        if ( level.ruby_intel.var_b3ae50d99f2ac00d == int( self.script_noteworthy ) )
        {
            level.ruby_intel.var_b3ae50d99f2ac00d++;
            
            /#
                iprintlnbold( "<dev string:x24>" + self.script_noteworthy );
            #/
            
            if ( level.ruby_intel.var_b3ae50d99f2ac00d > 8 )
            {
                moon_landing = utility::getstruct( "ruby_document1_land" );
                level.ruby_intel.pluto moveto( moon_landing.origin, 0.5, 0.5 );
                wait 0.5;
                playfx( utility::getfx( "planet_puff" ), moon_landing.origin );
                playsoundatpos( moon_landing.origin, "eqp_frag_grenade_expl_trans" );
                level.ruby_intel.pluto delete();
                intel::spawn_intel_at_location( undefined, undefined, moon_landing.origin, moon_landing.angles, "zmintel_sat_ruby_document_1" );
                level.ruby_intel.planet_triggers = [];
                level notify( #"hash_2b1951f14a045a51" );
            }
            
            continue;
        }
        
        if ( int( self.script_noteworthy ) != level.ruby_intel.var_b3ae50d99f2ac00d - 1 )
        {
            level.ruby_intel.var_b3ae50d99f2ac00d = 1;
            
            /#
                iprintlnbold( "<dev string:x31>" );
            #/
        }
    }
    
    self delete();
}

