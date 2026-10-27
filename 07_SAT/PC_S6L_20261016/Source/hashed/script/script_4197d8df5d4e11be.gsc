// script_4197d8df5d4e11be  (hash_4197d8df5d4e11be.gscc) (size: 3953 Bytes / 0xf71 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x61c2b6fd (1640150781)
// size ...... 3953 (0xf71)
// includes .. 4   (offset: 0xd99)
// strings ... 23  (offset: 0xdb9)
// dev strs .. 9   (offset: 0xf05)
// exports ... 11  (offset: 0x895)
// cseg ...... 0x333 + 0x562 (0x895)
// imports ... 28  (offset: 0xa4d)
// animtree1 . 0   (offset: 0xf71)
// animtree2 . 0   (offset: 0xf71)
#using scripts\common\callbacks;
#using scripts\common\devgui;
#using scripts\common\utility;
#using scripts\common\values;

#namespace namespace_8feb0d461816c715;

// Namespace namespace_8feb0d461816c715
// Params 0, eflags: 0x1
// Checksum 0x1859e483, Offset: 0x351
// Size: 0x31
function autoexec main()
{
    if ( !getdvarint( @"scr_saw_haunting_jumpscare_enabled", 1 ) )
    {
        return;
    }
    
    level thread init();
    level thread init_jumpscare();
    
    /#
        level thread debug_init();
    #/
}

// Namespace namespace_8feb0d461816c715
// Params 0, eflags: 0x4
// Checksum 0x40c1529, Offset: 0x38a
// Size: 0x21
function private init()
{
    level utility::flag_wait( "scriptables_ready" );
    level callback::add( "lootcache_looted", &check_for_jumpscare );
}

// Namespace namespace_8feb0d461816c715
// Params 0, eflags: 0x4
// Checksum 0x19061a3c, Offset: 0x3b3
// Size: 0x148
function private init_jumpscare()
{
    level.jumpscare_data = {};
    level.jumpscare_data.rate = getdvarint( @"scr_saw_haunting_jumpscare_rate", 10 );
    level.jumpscare_data.timeout = getdvarfloat( @"scr_saw_haunting_jumpscare_timeout", 30 );
    utility::add_fx( "manticore_haunting_jumpscare_1", "vfx_sat_levels_mp_saw_manticore_ee_jump_scare_bf" );
    utility::add_fx( "manticore_haunting_jumpscare_2", "vfx_sat_levels_mp_saw_manticore_ee_jump_scare_jl" );
    utility::add_fx( "manticore_haunting_jumpscare_3", "vfx_sat_levels_mp_saw_manticore_ee_jump_scare_pk" );
    utility::add_fx( "manticore_haunting_jumpscare_4", "vfx_sat_levels_mp_saw_manticore_ee_jump_scare_sc" );
    level.jumpscare_data.jumpscares = [ { #sfx:"evt_jump_scare_bigfoot", #vfx:"manticore_haunting_jumpscare_1" }, { #sfx:"evt_jump_scare_jackalope", #vfx:"manticore_haunting_jumpscare_2" }, { #sfx:"evt_jump_scare_pumpkin", #vfx:"manticore_haunting_jumpscare_3" }, { #sfx:"evt_jump_scare_scarecrow", #vfx:"manticore_haunting_jumpscare_4" } ];
    level.jumpscare_data.forced_index = -1;
}

// Namespace namespace_8feb0d461816c715
// Params 1, eflags: 0x4
// Checksum 0xb04172c7, Offset: 0x503
// Size: 0xf4
function private check_for_jumpscare( params )
{
    level endon( #"game_ended" );
    
    if ( !isdefined( self.var_dc30236edc85042c ) )
    {
        self.var_dc30236edc85042c = 1;
    }
    
    log_string = "manticore_s6_jumpscare::check_for_jumpscare " + self.name + "\n" + "requestGamerProfile start time: " + gettime() + "\n";
    
    if ( !utility::requestgamerprofile( "jumpScareEnabled" ) || !self.var_dc30236edc85042c )
    {
        return;
    }
    
    log_string = log_string + "requestGamerProfile end time: " + gettime() + "\n";
    jumpscare_rate = level.jumpscare_data.forced_index == -1 ? level.jumpscare_data.rate : 100;
    
    if ( !utility::percent_chance( jumpscare_rate ) )
    {
        return;
    }
    
    self.var_dc30236edc85042c = 0;
    logstring( log_string );
    perform_jump_scare();
}

// Namespace namespace_8feb0d461816c715
// Params 0
// Checksum 0xcddeafce, Offset: 0x5ff
// Size: 0x172
function perform_jump_scare()
{
    level endon( #"game_ended" );
    self endon( #"death_or_disconnect" );
    log_string = "manticore_s6_jumpscare::perform_jump_scare " + self.name + "\n" + "requestGamerProfile start time: " + gettime() + "\n";
    
    if ( !utility::requestgamerprofile( "jumpScareEnabled" ) )
    {
        return;
    }
    
    log_string = log_string + "requestGamerProfile end time: " + gettime() + "\n";
    
    if ( level.jumpscare_data.forced_index == -1 )
    {
        jumpscare = utility::function_879489791c3d805( level.jumpscare_data.jumpscares, [ self.last_jumpscare ] );
    }
    else
    {
        jumpscare = level.jumpscare_data.jumpscares[ level.jumpscare_data.forced_index ];
    }
    
    level.jumpscare_data.forced_index = -1;
    val::set( "saw_haunting_jumpscare", "show_hud", 0 );
    playfxontagforclients( utility::getfx( jumpscare.vfx ), self, "j_head", self );
    self playsoundtoplayer( jumpscare.sfx, self );
    thread function_872e15b1fcb98a00();
    self.last_jumpscare = jumpscare;
    logstring( log_string );
    utility::delaythread( 1.8, &val::reset, "saw_haunting_jumpscare", "show_hud" );
}

// Namespace namespace_8feb0d461816c715
// Params 0, eflags: 0x4
// Checksum 0x6d24abba, Offset: 0x779
// Size: 0x39
function private function_872e15b1fcb98a00()
{
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    wait level.jumpscare_data.timeout;
    self.var_dc30236edc85042c = 1;
}

/#

    // Namespace namespace_8feb0d461816c715
    // Params 0
    // Checksum 0xd370759b, Offset: 0x7ba
    // Size: 0x5, Type: dev
    function function_281fd8b149568957()
    {
        
    }

    // Namespace namespace_8feb0d461816c715
    // Params 0, eflags: 0x4
    // Checksum 0xbee005bb, Offset: 0x7c7
    // Size: 0xc, Type: dev
    function private debug_init()
    {
        devgui_init();
    }

    // Namespace namespace_8feb0d461816c715
    // Params 0, eflags: 0x4
    // Checksum 0xf902dcec, Offset: 0x7db
    // Size: 0x70, Type: dev
    function private devgui_init()
    {
        devgui::function_9082edeb5db93280( "<dev string:x24>" );
        devgui::function_cd4e263c1f3018ae( "<dev string:x32>", "<dev string:x4a>", &function_3b6ab224fd182cfa );
        devgui::function_cd4e263c1f3018ae( "<dev string:x6a>", "<dev string:x84>", &function_3b6ab224fd182cfa );
        devgui::function_cd4e263c1f3018ae( "<dev string:xa4>", "<dev string:xbc>", &function_3b6ab224fd182cfa );
        devgui::function_cd4e263c1f3018ae( "<dev string:xdc>", "<dev string:xf6>", &function_3b6ab224fd182cfa );
        devgui::function_77df7fe7dd273e10();
    }

    // Namespace namespace_8feb0d461816c715
    // Params 1, eflags: 0x4
    // Checksum 0xe579a9f1, Offset: 0x853
    // Size: 0x42, Type: dev
    function private function_3b6ab224fd182cfa( params )
    {
        level.players[ 0 ].var_dc30236edc85042c = 1;
        level.jumpscare_data.forced_index = int( params[ 0 ] );
    }

#/
