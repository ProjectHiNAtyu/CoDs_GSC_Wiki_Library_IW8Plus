// scripts\mp\zm\maps\zm_sat_firefly\zm_sat_firefly_script_garage.gsc  (hash_40ef2aaf893fbec9.gscc) (size: 24119 Bytes / 0x5e37 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xf59baf52 (4120620882)
// size ...... 24119 (0x5e37)
// includes .. 20  (offset: 0x573b)
// strings ... 80  (offset: 0x57db)
// dev strs .. 12  (offset: 0x5d9f)
// exports ... 54  (offset: 0x3acb)
// cseg ...... 0x7b3 + 0x3318 (0x3acb)
// imports ... 157 (offset: 0x433b)
// animtree1 . 0   (offset: 0x5e37)
// animtree2 . 0   (offset: 0x5e37)
#using script_54d7585f0a1791e6;
#using scripts\common\callbacks;
#using scripts\common\devgui;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\common\vehicle;
#using scripts\common\vehicle_occupancy;
#using scripts\mp\currency;
#using scripts\mp\interaction;
#using scripts\mp\loot\common_item;
#using scripts\mp\overlord;
#using scripts\mp\zm\gametypes\zm_rb_survival;
#using scripts\mp\zm\maps\zm_sat_firefly\zm_sat_firefly_pap_quest;
#using scripts\mp\zm\systems\zm_interaction;
#using scripts\mp\zm\systems\zm_quest;
#using scripts\mp\zm\systems\zm_save;
#using scripts\mp\zm\systems\zm_vo;
#using scripts\mp\zm\systems\zone_manager;
#using scripts\mp\zm\zm_utility;
#using scripts\vehicle\pluto\pluto_shared;

#namespace zm_sat_firefly_script_garage;

// Namespace zm_sat_firefly_script_garage
// Params 0, eflags: 0x5
// Checksum 0x81099136, Offset: 0x7d1
// Size: 0x92
function private autoexec init()
{
    if ( zm_rb_survival::is_survival_poi( "ashwood" ) )
    {
        level function_8c4ebd807b2b2e6a();
        return;
    }
    else if ( !getdvarint( @"hash_f7b9b049c411f899", 1 ) || !pluto_veh::function_bdd68e56b5bb1269() )
    {
        level function_2063b819233f3b35();
        return;
    }
    
    utility::registersharedfunc( #"veh_pluto", #"hash_4b9482ccfc73d4d2", &function_8faa213388e59619 );
    utility::registersharedfunc( #"veh_pluto", #"hash_c662103c9de1c046", &function_d696b1e2e8b90e1d );
    level thread setup_garage_assets();
    
    /#
        level setup_garage_debug();
    #/
}

// Namespace zm_sat_firefly_script_garage
// Params 0, eflags: 0x4
// Checksum 0xa74bf33d, Offset: 0x86b
// Size: 0x128
function private setup_garage_assets()
{
    level endon( #"game_ended" );
    level._effect[ "firefly_vehicle_teleport_in" ] = loadfxasset( "vfx_sat_levels_zm_firefly_vehicle_show" );
    level._effect[ "firefly_vehicle_teleport_out" ] = loadfxasset( "vfx_sat_levels_zm_firefly_vehicle_teleport_out" );
    level._effect[ "garage_player_teleport_out" ] = loadfxasset( "vfx_sat_firefly_player_teleporting_out" );
    level._effect[ "garage_player_teleport_in" ] = loadfxasset( "vfx_sat_firefly_player_teleporting_into_seat" );
    level utility::flag_wait( "zm_sat_firefly_script_garage_cs_completed" );
    level.s_garage = utility::getstruct( "s_garage", "targetname" );
    assert( isdefined( level.s_garage ), "<dev string:x24>" );
    level.s_garage.s_pluto_spawn = utility::getstruct( "garage_pluto_spawn", "targetname" );
    level setup_garage_doors();
    level.s_garage setup_upgrade_station();
    level.s_garage setup_summon_station();
    level.s_garage setup_player_teleport_station();
    level.s_garage setup_boss_player_teleport_station();
    level utility::flag_set( "firefly_garage_init" );
}

// Namespace zm_sat_firefly_script_garage
// Params 0, eflags: 0x4
// Checksum 0x6b06545b, Offset: 0x99b
// Size: 0x2d2
function private function_8c4ebd807b2b2e6a()
{
    level endon( #"game_ended" );
    level._effect[ "firefly_vehicle_teleport_in" ] = loadfxasset( "vfx_sat_levels_zm_firefly_vehicle_show" );
    level._effect[ "firefly_vehicle_teleport_out" ] = loadfxasset( "vfx_sat_levels_zm_firefly_vehicle_teleport_out" );
    level._effect[ "garage_player_teleport_out" ] = loadfxasset( "vfx_sat_firefly_player_teleporting_out" );
    level._effect[ "garage_player_teleport_in" ] = loadfxasset( "vfx_sat_firefly_player_teleporting_into_seat" );
    level utility::flag_wait( "zm_sat_firefly_script_garage_cs_completed" );
    level.s_garage = utility::getstruct( "s_garage", "targetname" );
    level.s_garage.s_pluto_spawn = utility::getstruct( "garage_pluto_spawn", "targetname" );
    level.s_garage.a_doors = [];
    a_s_doors = utility::getstructarray( "garage_door", "targetname" );
    
    foreach ( struct in a_s_doors )
    {
        door_sbl = spawnscriptable( %"zm_sat_firefly_garage_door", struct.origin, struct.angles );
        door_sbl.obstacleid = createnavobstaclebybounds( door_sbl.origin, ( 200, 10, 200 ), door_sbl.angles );
        door_sbl setscriptablepartstate( "body", struct.script_noteworthy );
        level.s_garage.a_doors[ level.s_garage.a_doors.size ] = door_sbl;
    }
    
    s_summon_station = utility::getstruct( "garage_summon_station", "targetname" );
    summon_station_sbl = spawnscriptable( %"zm_sat_firefly_garage_summon_station", s_summon_station.origin, s_summon_station.angles );
    summon_station_sbl setscriptablepartstate( "zm_sat_firefly_garage_summon_station_button", "unusable" );
    s_upgrade_station = utility::getstruct( "garage_upgrade_station", "targetname" );
    spawnscriptable( %"zm_sat_firefly_garage_upgrade_station", s_upgrade_station.origin, s_upgrade_station.angles );
    s_player_teleport_station = utility::getstruct( "garage_player_teleport_station", "targetname" );
    spawnscriptable( %"zm_sat_firefly_garage_player_teleport_station", s_player_teleport_station.origin, s_player_teleport_station.angles );
    level thread function_ef681de447c0f3d3();
}

// Namespace zm_sat_firefly_script_garage
// Params 0, eflags: 0x4
// Checksum 0x639c8e9b, Offset: 0xc75
// Size: 0x222
function private function_2063b819233f3b35()
{
    level endon( #"game_ended" );
    level utility::flag_wait( "zm_sat_firefly_script_garage_cs_completed" );
    s_garage = utility::getstruct( "s_garage", "targetname" );
    s_garage.a_doors = [];
    a_s_doors = utility::getstructarray( "garage_door", "targetname" );
    
    foreach ( struct in a_s_doors )
    {
        door_sbl = spawnscriptable( %"zm_sat_firefly_garage_door", struct.origin, struct.angles );
        door_sbl.obstacleid = createnavobstaclebybounds( door_sbl.origin, ( 200, 10, 200 ), door_sbl.angles );
        door_sbl setscriptablepartstate( "body", struct.script_noteworthy );
    }
    
    s_summon_station = utility::getstruct( "garage_summon_station", "targetname" );
    summon_station_sbl = spawnscriptable( %"zm_sat_firefly_garage_summon_station", s_summon_station.origin, s_summon_station.angles );
    summon_station_sbl setscriptablepartstate( "zm_sat_firefly_garage_summon_station_button", "unusable" );
    s_upgrade_station = utility::getstruct( "garage_upgrade_station", "targetname" );
    upgrade_station_sbl = spawnscriptable( %"zm_sat_firefly_garage_upgrade_station", s_upgrade_station.origin, s_upgrade_station.angles );
    s_player_teleport_station = utility::getstruct( "garage_player_teleport_station", "targetname" );
    player_teleport_station_sbl = spawnscriptable( %"zm_sat_firefly_garage_player_teleport_station", s_player_teleport_station.origin, s_player_teleport_station.angles );
}

// Namespace zm_sat_firefly_script_garage
// Params 0, eflags: 0x4
// Checksum 0x543a6b2d, Offset: 0xe9f
// Size: 0x144
function private setup_garage_doors()
{
    level.s_garage.a_doors = [];
    a_s_doors = utility::getstructarray( "garage_door", "targetname" );
    
    foreach ( struct in a_s_doors )
    {
        door_sbl = spawnscriptable( %"zm_sat_firefly_garage_door", struct.origin, struct.angles );
        door_sbl.obstacleid = createnavobstaclebybounds( door_sbl.origin, ( 200, 10, 200 ), door_sbl.angles );
        door_sbl setscriptablepartstate( "body", struct.script_noteworthy );
        level.s_garage.a_doors[ level.s_garage.a_doors.size ] = door_sbl;
    }
    
    level thread function_674b9aafcba3b2fa();
}

// Namespace zm_sat_firefly_script_garage
// Params 0, eflags: 0x4
// Checksum 0x6c59a9a9, Offset: 0xfeb
// Size: 0x48
function private function_674b9aafcba3b2fa()
{
    level endon( #"game_ended" );
    level endon( #"hash_fcd5fe312810e911" );
    
    if ( zm_save::function_1dda3554974a999e() )
    {
        level zm_save::function_1f44a48caae2acbf();
    }
    
    level utility::flag_wait( "power_on3" );
    level function_3fc1fa26f0da7cdc();
    level garage_turn_on_power();
}

// Namespace zm_sat_firefly_script_garage
// Params 0, eflags: 0x4
// Checksum 0x7e347b0e, Offset: 0x103b
// Size: 0xdc
function private function_ef681de447c0f3d3()
{
    level endon( #"game_ended" );
    level endon( #"hash_fcd5fe312810e911" );
    
    if ( zm_save::function_1dda3554974a999e() )
    {
        level zm_save::function_1f44a48caae2acbf();
    }
    
    level utility::flag_wait( "power_on3" );
    level function_3fc1fa26f0da7cdc();
    level utility::flag_set( "garage_opened" );
    
    foreach ( door in level.s_garage.a_doors )
    {
        door thread open_garage_door();
    }
    
    level notify( #"hash_9dbe2e17bffd3b9" );
}

// Namespace zm_sat_firefly_script_garage
// Params 0, eflags: 0x4
// Checksum 0x61388e96, Offset: 0x111f
// Size: 0x57
function private function_3fc1fa26f0da7cdc()
{
    level endon( #"game_ended" );
    level endon( #"hash_fcd5fe312810e911" );
    
    while ( true )
    {
        n_players = getplayersinradius( level.s_garage.origin, 600 );
        
        if ( n_players.size > 0 )
        {
            return;
        }
        
        wait 0.2;
    }
}

// Namespace zm_sat_firefly_script_garage
// Params 0, eflags: 0x4
// Checksum 0x1080426e, Offset: 0x117e
// Size: 0x166
function private garage_turn_on_power()
{
    if ( level.var_6f60871b44475daa )
    {
        return;
    }
    
    level utility::flag_set( "garage_opened" );
    level utility::flag_set( "enable_shed_repair" );
    level zm_sat_firefly_pap_quest::pap_on_garage_opened();
    level.s_garage.upgrade_station_sbl setscriptablepartstate( "body", "usable" );
    level.s_garage.player_teleport_station_sbl setscriptablepartstate( "body", "usable" );
    level.s_garage.summon_station_sbl utility::function_32b24db3127bff40( "fx", "unavailable" );
    level.s_garage.player_teleport_station_sbl utility::function_32b24db3127bff40( "fx", "available" );
    
    foreach ( door in level.s_garage.a_doors )
    {
        door thread open_garage_door();
    }
    
    if ( !level callback::exists( "tessie_task_initiated", &function_d696b1e2e8b90e1d ) )
    {
        callback::add( "tessie_task_initiated", &function_d696b1e2e8b90e1d );
    }
}

// Namespace zm_sat_firefly_script_garage
// Params 0, eflags: 0x4
// Checksum 0x740dab27, Offset: 0x12ec
// Size: 0xde
function private open_garage_door()
{
    level endon( #"game_ended" );
    
    if ( utility::ent_flag( "moving" ) )
    {
        return;
    }
    
    utility::ent_flag_set( "moving" );
    ent = utility::spawn_model( "tag_origin", self.origin, self.angles );
    waitframe();
    utility::scriptable_setparententity( ent );
    self setscriptablepartstate( "audio", "open" );
    ent moveto( ent.origin + ( 0, 0, -172 ), 2.5 );
    ent waittill( #"movedone" );
    self setscriptablepartstate( "audio", "open_complete" );
    waitframe();
    utility::scriptable_clearparententity();
    ent delete();
    destroynavobstacle( self.obstacleid );
    utility::ent_flag_clear( "moving" );
    self freescriptable();
}

// Namespace zm_sat_firefly_script_garage
// Params 0
// Checksum 0x5539bfd2, Offset: 0x13d2
// Size: 0x50
function function_4aaca8864b49d3b7()
{
    level endon( #"game_ended" );
    level utility::flag_wait( "firefly_garage_init" );
    
    if ( zm_save::function_1dda3554974a999e() )
    {
        level zm_save::function_1f44a48caae2acbf();
    }
    
    if ( level utility::flag( "garage_opened" ) )
    {
        return;
    }
    
    level notify( #"hash_fcd5fe312810e911" );
    level garage_turn_on_power();
}

// Namespace zm_sat_firefly_script_garage
// Params 0, eflags: 0x4
// Checksum 0x66bf213b, Offset: 0x142a
// Size: 0xd9
function private setup_upgrade_station()
{
    s_upgrade_station = utility::getstruct( "garage_upgrade_station", "targetname" );
    
    if ( !isdefined( s_upgrade_station ) )
    {
        logprint( "No upgrade station set up for garage" );
        return;
    }
    
    upgrade_station_sbl = spawnscriptable( %"zm_sat_firefly_garage_upgrade_station", s_upgrade_station.origin, s_upgrade_station.angles );
    level.s_garage.upgrade_station_sbl = upgrade_station_sbl;
    upgrade_station_sbl.interaction = interaction::register_scriptable_interact( upgrade_station_sbl, &function_c4894d05efc131fd, undefined, undefined, &upgrade_station_hint );
    s_pap_part = utility::getstruct( "garage_pap_hanging_part", "targetname" );
    self.pap_part_sbl = spawnscriptable( %"zm_sat_firefly_garage_pap_part", s_pap_part.origin, s_pap_part.angles );
}

// Namespace zm_sat_firefly_script_garage
// Params 2, eflags: 0x4
// Checksum 0x9e68043a, Offset: 0x150b
// Size: 0x280
function private upgrade_station_hint( interact, player )
{
    if ( isdefined( player ) && player.interactions_disabled )
    {
        return { #string:&"", #type:"HINT_NOBUTTON" };
    }
    
    if ( interact.b_in_use )
    {
        return { #string:&"", #type:"HINT_NOBUTTON" };
    }
    
    if ( level.wonder_veh.var_7493baa2cd62443 == 4 )
    {
        return { #string:&"", #type:"HINT_NOBUTTON" };
    }
    
    hintstring_obj = { #icon:"ui_icon_zm_ping_work_bench", #buttoncallout:&"zm_sat_firefly/pluto_install", #description:&"zm_sat_firefly/shed_upgrade_desc", #title:&"zm_sat_firefly/shed_upgrade_title", #type:"HINT_BUTTON" };
    
    if ( !function_8faa213388e59619() )
    {
        hintstring_obj.aux_text = &"zm_sat_firefly/shed_upgrade_aux_pluto";
        hintstring_obj.interactable = 0;
        return hintstring_obj;
    }
    
    if ( !utility::issharedfuncdefined( #"veh_pluto", #"hash_65c3903a874d7bdb" ) )
    {
        hintstring_obj.aux_text = &"zm_sat_firefly/shed_need_parts";
        hintstring_obj.interactable = 0;
        return hintstring_obj;
    }
    else if ( !utility::callsharedfunc( #"veh_pluto", #"hash_65c3903a874d7bdb" ) )
    {
        hintstring_obj.aux_text = &"zm_sat_firefly/shed_need_parts";
        hintstring_obj.interactable = 0;
        return hintstring_obj;
    }
    else
    {
        upgrade_stage = utility::callsharedfunc( #"veh_pluto", #"hash_65c3903a874d7bdb" );
        
        switch ( upgrade_stage )
        {
            case 2:
                hintstring_obj.description = &"zm_sat_firefly/shed_upgrade_pluto_stage_2";
                break;
            case 3:
                hintstring_obj.description = &"zm_sat_firefly/shed_upgrade_pluto_stage_3";
                break;
            case 4:
                hintstring_obj.description = &"zm_sat_firefly/shed_upgrade_pluto_stage_4";
                break;
            default:
                assertmsg( "<dev string:x3d>" );
                break;
        }
    }
    
    return hintstring_obj;
}

// Namespace zm_sat_firefly_script_garage
// Params 1, eflags: 0x4
// Checksum 0xdbc3c786, Offset: 0x1794
// Size: 0x168
function private function_c4894d05efc131fd( player )
{
    level endon( #"game_ended" );
    
    if ( isdefined( player ) && player.interactions_disabled )
    {
        return;
    }
    
    if ( level.wonder_veh.var_7493baa2cd62443 == 4 )
    {
        return;
    }
    
    if ( self.b_in_use )
    {
        return;
    }
    
    pluto = function_8faa213388e59619();
    
    if ( !pluto )
    {
        return;
    }
    
    if ( utility::issharedfuncdefined( #"veh_pluto", #"hash_65c3903a874d7bdb" ) )
    {
        stage = utility::callsharedfunc( #"veh_pluto", #"hash_65c3903a874d7bdb" );
    }
    
    if ( !stage )
    {
        return;
    }
    
    level function_eac021fc543541e2( stage );
    level vehicle_occupancy::eject_all_occupants( pluto );
    level pluto_veh::set_vehicle_usable_state( pluto, 0 );
    self.b_in_use = 1;
    player function_9a9f1780b2aba82b();
    result = function_f97ec173d2ad762d( &"zm_sat_firefly/shed_upgrade_caption", undefined, self, player );
    
    if ( isdefined( player ) )
    {
        player val::reset_all( "upgrading_pluto" );
    }
    
    if ( result )
    {
        pluto thread function_59b20dd58f1292f1( stage, player );
        playsoundatpos( pluto.origin + ( 0, 0, 50 ), "evt_zm_vehicle_upgrade_oneshot" );
    }
    else
    {
        wait 0.25;
    }
    
    level pluto_veh::set_vehicle_usable_state( pluto, 1 );
    self.b_in_use = 0;
}

// Namespace zm_sat_firefly_script_garage
// Params 0, eflags: 0x4
// Checksum 0xe0d706bd, Offset: 0x1904
// Size: 0x14
function private function_9a9f1780b2aba82b()
{
    val::set( "upgrading_pluto", "killstreaks", 0 );
}

// Namespace zm_sat_firefly_script_garage
// Params 1, eflags: 0x4
// Checksum 0x89cac636, Offset: 0x1920
// Size: 0x5c
function private function_eac021fc543541e2( stage )
{
    switch ( stage )
    {
        case 2:
            break;
        case 3:
            break;
        case 4:
            break;
        default:
            assertmsg( "<dev string:x3d>" );
            break;
    }
}

// Namespace zm_sat_firefly_script_garage
// Params 2, eflags: 0x4
// Checksum 0xff348a76, Offset: 0x1984
// Size: 0x5e
function private function_59b20dd58f1292f1( stage, player )
{
    level endon( #"game_ended" );
    pluto = self;
    level vehicle_occupancy::eject_all_occupants( pluto );
    pluto.stagerequested = stage;
    pluto.var_17aacd04863e2127 = player;
    level function_f5663dbfa260bd4f( stage );
}

// Namespace zm_sat_firefly_script_garage
// Params 1, eflags: 0x4
// Checksum 0xb51ea81c, Offset: 0x19ea
// Size: 0x8c
function private function_f5663dbfa260bd4f( stage )
{
    switch ( stage )
    {
        case 2:
            level thread function_6aa7df51af5971f1();
            level thread function_102a2b6455cb506a();
            break;
        case 3:
            level thread function_bb0b3f782f531fa9();
            level thread function_e3c9a4bcb7b0a8c2();
            break;
        case 4:
            level thread function_d960c5dc887630e0();
            level thread function_715b7b9d85eaa0b7();
            break;
        default:
            assertmsg( "<dev string:x3d>" );
            break;
    }
}

// Namespace zm_sat_firefly_script_garage
// Params 0
// Checksum 0x9fbe508, Offset: 0x1a7e
// Size: 0x105
function function_51dc48d237696103()
{
    if ( isdefined( level.s_garage.var_61aaeb1dd6855b47 ) )
    {
        return;
    }
    
    s_loc = utility::getstruct( "garage_abom_part", "targetname" );
    spawnoptions = common_item::function_bc5ff2958b71a708( s_loc.origin, s_loc.angles );
    spawnoptions.var_fd47e835523b473f = 1;
    spawnoptions.dropradiusscale = 0;
    spawnoptions.critical = 1;
    positioningdata = common_item::function_b4bee4333994e45a( s_loc.origin, s_loc.angles );
    itembundle = getscriptbundle( %"hash_7130b9e2c7db5079" );
    level.s_garage.var_61aaeb1dd6855b47 = common_item::function_2352d25db9e97696( itembundle, 1, positioningdata, spawnoptions );
    level.s_garage.var_61aaeb1dd6855b47 setscriptablepartstate( "zmloot_quest_firefly_pluto_abom_carcass", "visible_unusable" );
}

// Namespace zm_sat_firefly_script_garage
// Params 0
// Checksum 0x1fa40780, Offset: 0x1b8b
// Size: 0x6d
function function_8ec246c4c83d94a0()
{
    if ( isdefined( level.s_garage.turret_part_sbl ) )
    {
        return;
    }
    
    s_part = utility::getstruct( "garage_turret_part", "targetname" );
    level.s_garage.turret_part_sbl = spawnscriptable( %"zm_sat_firefly_garage_turret_part", s_part.origin, s_part.angles );
}

// Namespace zm_sat_firefly_script_garage
// Params 0
// Checksum 0xdf970464, Offset: 0x1c00
// Size: 0x7b
function function_102a2b6455cb506a()
{
    level endon( #"game_ended" );
    
    if ( isdefined( level.s_garage.pap_part_sbl ) )
    {
        level.s_garage.pap_part_sbl setscriptablepartstate( "body", "clean_up" );
        wait 0.2;
        
        if ( level.s_garage.pap_part_sbl )
        {
            level.s_garage.pap_part_sbl freescriptable();
        }
    }
}

// Namespace zm_sat_firefly_script_garage
// Params 0
// Checksum 0xb496623e, Offset: 0x1c83
// Size: 0x68
function function_e3c9a4bcb7b0a8c2()
{
    level endon( #"game_ended" );
    
    if ( isdefined( level.s_garage.var_61aaeb1dd6855b47 ) )
    {
        level.s_garage.var_61aaeb1dd6855b47 setscriptablepartstate( "zmloot_quest_firefly_pluto_abom_carcass", "garage_clean_up" );
        wait 0.2;
        level thread common_item::function_869d7676e359a627( level.s_garage.var_61aaeb1dd6855b47 );
    }
}

// Namespace zm_sat_firefly_script_garage
// Params 0
// Checksum 0xcb01734b, Offset: 0x1cf3
// Size: 0x65
function function_715b7b9d85eaa0b7()
{
    level endon( #"game_ended" );
    
    if ( isdefined( level.s_garage.turret_part_sbl ) )
    {
        level.s_garage.turret_part_sbl setscriptablepartstate( "body", "clean_up" );
        wait 0.2;
        level.s_garage.turret_part_sbl freescriptable();
    }
}

// Namespace zm_sat_firefly_script_garage
// Params 0, eflags: 0x4
// Checksum 0x46e30aa6, Offset: 0x1d60
// Size: 0x9b
function private setup_summon_station()
{
    s_summon_station = utility::getstruct( "garage_summon_station", "targetname" );
    
    if ( !isdefined( s_summon_station ) )
    {
        logprint( "No summon station set up for garage" );
        return;
    }
    
    summon_station_sbl = spawnscriptable( %"zm_sat_firefly_garage_summon_station", s_summon_station.origin, s_summon_station.angles );
    level.s_garage.summon_station_sbl = summon_station_sbl;
    summon_station_sbl.interaction = interaction::register_scriptable_interact( summon_station_sbl, &function_be367aedef9c1b0, undefined, undefined, &summon_station_hint );
    level thread function_faf428e6e9d26b01();
}

// Namespace zm_sat_firefly_script_garage
// Params 0, eflags: 0x4
// Checksum 0x7845d56, Offset: 0x1e03
// Size: 0x22e
function private function_faf428e6e9d26b01()
{
    level endon( #"game_ended" );
    
    while ( true )
    {
        if ( level utility::flag( "warping_pluto" ) )
        {
            wait 1;
            continue;
        }
        
        pluto_zone = zone_manager::function_90e5c3e2272b0130( level.wonder_veh.origin );
        
        if ( !level utility::flag( "garage_opened" ) )
        {
            waitframe();
            continue;
        }
        
        if ( !isdefined( pluto_zone ) )
        {
            level utility::flag_set( "garage_summon_available" );
            
            if ( level.s_garage.summon_station_sbl getscriptablepartstate( "fx" ) != "cooldown" )
            {
                if ( level function_9e072546e720b7d6() )
                {
                    level.s_garage.summon_station_sbl utility::function_32b24db3127bff40( "fx", "ready" );
                }
                else
                {
                    level.s_garage.summon_station_sbl utility::function_32b24db3127bff40( "fx", "unavailable" );
                }
            }
        }
        else if ( level.wonder_veh.occupants.size == 0 && pluto_zone.occupants.size == 0 )
        {
            level utility::flag_set( "garage_summon_available" );
            
            if ( level.s_garage.summon_station_sbl getscriptablepartstate( "fx" ) != "cooldown" )
            {
                if ( level function_9e072546e720b7d6() )
                {
                    level.s_garage.summon_station_sbl utility::function_32b24db3127bff40( "fx", "ready" );
                }
                else
                {
                    level.s_garage.summon_station_sbl utility::function_32b24db3127bff40( "fx", "unavailable" );
                }
            }
        }
        else if ( level.wonder_veh.occupants.size > 0 || pluto_zone.occupants.size > 0 )
        {
            level utility::flag_clear( "garage_summon_available" );
            
            if ( level.s_garage.summon_station_sbl getscriptablepartstate( "fx" ) != "cooldown" )
            {
                level.s_garage.summon_station_sbl utility::function_32b24db3127bff40( "fx", "unavailable" );
            }
        }
        
        wait 1;
    }
}

// Namespace zm_sat_firefly_script_garage
// Params 2, eflags: 0x4
// Checksum 0x3f598673, Offset: 0x2039
// Size: 0x21e
function private summon_station_hint( interact, player )
{
    if ( isdefined( player ) && player.interactions_disabled )
    {
        return { #string:&"", #type:"HINT_NOBUTTON" };
    }
    
    hintstring_obj = { #icon_text_value:1000, #var_776a268784e089af:&"SHARED_HINTSTRINGS/COST_ESSENCE", #icon:"sat_ui_icon_zm_vehicle_summoning_station", #buttoncallout:&"SHARED_HINTSTRINGS/BUY", #description:&"zm_sat_firefly/shed_summon_desc", #title:&"zm_sat_firefly/shed_summon_title", #type:"HINT_BUTTON" };
    
    if ( !level utility::flag( "garage_opened" ) )
    {
        hintstring_obj.aux_text = &"SHARED_HINTSTRINGS/NEED_POWER_RED";
        hintstring_obj.interactable = 0;
        return hintstring_obj;
    }
    
    if ( level utility::flag( "garage_summon_cooling_down" ) )
    {
        hintstring_obj.aux_text = &"zm_sat_firefly/shed_summon_cooldown_aux";
        hintstring_obj.var_776a268784e089af = &"zm_sat_firefly/shed_summon_timer_text";
        hintstring_obj.icon_text_value = level.s_garage.var_1b29769ac8e13b72;
        hintstring_obj.interactable = 0;
        return hintstring_obj;
    }
    
    if ( level function_8faa213388e59619() )
    {
        hintstring_obj.aux_text = &"zm_sat_firefly/shed_pluto_here_aux";
        hintstring_obj.interactable = 0;
        return hintstring_obj;
    }
    
    if ( !level utility::flag( "garage_summon_available" ) )
    {
        hintstring_obj.aux_text = &"zm_sat_firefly/shed_summon_pluto_abandon";
        hintstring_obj.interactable = 0;
        return hintstring_obj;
    }
    
    if ( !player currency::can_afford( #"essence", 1000 ) )
    {
        hintstring_obj.aux_text = &"SHARED_HINTSTRINGS/NOT_ENOUGH_ESSENCE";
        hintstring_obj.var_776a268784e089af = &"SHARED_HINTSTRINGS/COST_ESSENCE_NOT_ENOUGH";
        hintstring_obj.interactable = 0;
        return hintstring_obj;
    }
    
    return hintstring_obj;
}

// Namespace zm_sat_firefly_script_garage
// Params 1, eflags: 0x4
// Checksum 0x90165005, Offset: 0x2260
// Size: 0x67
function private function_be367aedef9c1b0( player )
{
    if ( isdefined( player ) && player.interactions_disabled )
    {
        return;
    }
    
    if ( !level function_9e072546e720b7d6( player ) )
    {
        return;
    }
    
    player currency::attempt_purchase( #"essence", 1000 );
    level thread function_f267de13efa4d91b();
    level thread function_dc659749a37ca47( player );
    level.wonder_veh function_d696b1e2e8b90e1d();
}

// Namespace zm_sat_firefly_script_garage
// Params 0, eflags: 0x4
// Checksum 0x6546acfa, Offset: 0x22cf
// Size: 0x110
function private function_f267de13efa4d91b()
{
    level endon( #"game_ended" );
    level.s_garage.var_1b29769ac8e13b72 = 30;
    level utility::flag_set( "garage_summon_cooling_down" );
    level.s_garage.summon_station_sbl utility::function_32b24db3127bff40( "fx", "cooldown" );
    
    while ( true )
    {
        if ( level.s_garage.var_1b29769ac8e13b72 <= 0 )
        {
            level utility::flag_clear( "garage_summon_cooling_down" );
            level.s_garage.summon_station_sbl setscriptablepartstate( "additional_sfx", "cooldown_finished" );
            
            if ( function_9e072546e720b7d6() )
            {
                level.s_garage.summon_station_sbl utility::function_32b24db3127bff40( "fx", "ready" );
                return;
            }
            
            level.s_garage.summon_station_sbl utility::function_32b24db3127bff40( "fx", "unavailable" );
            return;
        }
        
        level.s_garage.var_1b29769ac8e13b72--;
        wait 1;
    }
}

// Namespace zm_sat_firefly_script_garage
// Params 1, eflags: 0x4
// Checksum 0xda97546a, Offset: 0x23e7
// Size: 0x88, Type: bool
function private function_9e072546e720b7d6( player )
{
    if ( !level utility::flag( "garage_summon_available" ) )
    {
        return false;
    }
    
    if ( level utility::flag( "garage_summon_cooling_down" ) )
    {
        return false;
    }
    
    if ( isdefined( player ) )
    {
        if ( !player currency::can_afford( #"essence", 1000 ) )
        {
            return false;
        }
    }
    
    if ( level function_8faa213388e59619() )
    {
        return false;
    }
    
    if ( !level utility::flag( "garage_opened" ) )
    {
        return false;
    }
    
    if ( level.wonder_veh utility::ent_flag( "hermes_ufo_activated" ) )
    {
        return false;
    }
    
    return true;
}

// Namespace zm_sat_firefly_script_garage
// Params 0, eflags: 0x4
// Checksum 0xc3ae078b, Offset: 0x2478
// Size: 0xa5
function private setup_player_teleport_station()
{
    s_player_teleport_station = utility::getstruct( "garage_player_teleport_station", "targetname" );
    
    if ( !isdefined( s_player_teleport_station ) )
    {
        logprint( "No player teleport station set up for garage" );
        return;
    }
    
    player_teleport_station_sbl = spawnscriptable( %"zm_sat_firefly_garage_player_teleport_station", s_player_teleport_station.origin, s_player_teleport_station.angles );
    level.s_garage.player_teleport_station_sbl = player_teleport_station_sbl;
    player_teleport_station_sbl.interaction = interaction::register_scriptable_interact( player_teleport_station_sbl, &function_6a148ae0a87b28d2, undefined, undefined, &player_teleport_station_hint );
    player_teleport_station_sbl.interaction thread player_teleport_station_state_watcher();
}

// Namespace zm_sat_firefly_script_garage
// Params 0, eflags: 0x4
// Checksum 0x77158cf8, Offset: 0x2525
// Size: 0x131
function private setup_boss_player_teleport_station()
{
    var_8615e948578b90d = [];
    var_8615e948578b90d = utility::getstructarray( "boss_garage_player_teleport_station", "targetname" );
    
    foreach ( struct in var_8615e948578b90d )
    {
        if ( !isdefined( struct ) )
        {
            logprint( "No Boss player teleport station set up for garage" );
            return;
        }
        
        var_6550a2279a3c6572 = spawnscriptable( %"zm_sat_firefly_garage_player_teleport_station", struct.origin, struct.angles );
        level.s_garage.var_6550a2279a3c6572 = var_6550a2279a3c6572;
        level.s_garage.var_6550a2279a3c6572 setscriptablepartstate( "Body", "usable" );
        var_6550a2279a3c6572.interaction = interaction::register_scriptable_interact( var_6550a2279a3c6572, &function_6a148ae0a87b28d2, undefined, undefined, &player_teleport_station_hint );
        var_6550a2279a3c6572.interaction thread player_teleport_station_state_watcher();
    }
}

// Namespace zm_sat_firefly_script_garage
// Params 2, eflags: 0x4
// Checksum 0x7aa86718, Offset: 0x265e
// Size: 0x244
function private player_teleport_station_hint( interact, player )
{
    if ( isdefined( player ) && player.interactions_disabled )
    {
        return { #string:&"", #type:"HINT_NOBUTTON" };
    }
    
    hintstring_obj = { #icon_text_value:500, #var_776a268784e089af:&"SHARED_HINTSTRINGS/COST_ESSENCE", #icon:"sat_ui_icon_zm_player_teleport_station", #buttoncallout:&"SHARED_HINTSTRINGS/BUY", #description:&"zm_sat_firefly/shed_player_desc", #title:&"zm_sat_firefly/shed_player_title", #type:"HINT_BUTTON" };
    
    if ( level.wonder_veh utility::ent_flag( "hermes_ufo_activated" ) )
    {
        hintstring_obj.aux_text = &"zm_sat_firefly/shed_player_pluto_boss";
        hintstring_obj.interactable = 0;
        return hintstring_obj;
    }
    
    if ( level.wonder_veh getscriptablepartstate( "single" ) == "vehicle_unusable" )
    {
        hintstring_obj.aux_text = &"zm_sat_firefly/shed_teleport_pad_pluto_broken_aux";
        hintstring_obj.interactable = 0;
        return hintstring_obj;
    }
    
    if ( level.firefly_ww_quest.var_7beabd5eecea599c.player == player )
    {
        hintstring_obj.aux_text = &"zm_sat_firefly/shed_player_has_ab";
        hintstring_obj.interactable = 0;
        return hintstring_obj;
    }
    
    if ( level utility::flag( "warping_pluto" ) )
    {
        hintstring_obj.aux_text = &"zm_sat_firefly/shed_player_pluto_go_in_progress";
        hintstring_obj.interactable = 0;
        return hintstring_obj;
    }
    
    if ( level function_8faa213388e59619() )
    {
        hintstring_obj.aux_text = &"zm_sat_firefly/shed_player_pluto_here_aux";
        hintstring_obj.interactable = 0;
        return hintstring_obj;
    }
    
    if ( !player currency::can_afford( #"essence", 500 ) )
    {
        hintstring_obj.aux_text = &"SHARED_HINTSTRINGS/NOT_ENOUGH_ESSENCE";
        hintstring_obj.var_776a268784e089af = &"SHARED_HINTSTRINGS/COST_ESSENCE_NOT_ENOUGH";
        hintstring_obj.interactable = 0;
        return hintstring_obj;
    }
    
    return hintstring_obj;
}

// Namespace zm_sat_firefly_script_garage
// Params 1, eflags: 0x4
// Checksum 0x343708af, Offset: 0x28ab
// Size: 0x67
function private function_6a148ae0a87b28d2( player )
{
    if ( !can_use_player_teleport_station( player ) )
    {
        return;
    }
    
    if ( player currency::attempt_purchase( #"essence", 500, 0 ) )
    {
        level.s_garage.player_teleport_station_sbl setscriptablepartstate( "sfx", "activate" );
        player thread function_e754ea0c2844aedc( self );
        level thread function_4aea76ff16b1ab8b( player );
    }
}

// Namespace zm_sat_firefly_script_garage
// Params 1, eflags: 0x4
// Checksum 0x3637bb40, Offset: 0x291a
// Size: 0x56, Type: bool
function private can_use_player_teleport_station( player )
{
    if ( isdefined( player ) && player.interactions_disabled )
    {
        return false;
    }
    
    if ( level.firefly_ww_quest.var_7beabd5eecea599c.player == player )
    {
        return false;
    }
    
    if ( !function_600acd31f16ed0f9() )
    {
        return false;
    }
    
    return true;
}

// Namespace zm_sat_firefly_script_garage
// Params 0, eflags: 0x4
// Checksum 0x4b9e7993, Offset: 0x2979
// Size: 0x4d, Type: bool
function private function_600acd31f16ed0f9()
{
    if ( !level.wonder_veh )
    {
        return false;
    }
    
    if ( level utility::flag( "warping_pluto" ) )
    {
        return false;
    }
    
    if ( level function_8faa213388e59619() )
    {
        return false;
    }
    
    if ( level.wonder_veh getscriptablepartstate( "single" ) == "vehicle_unusable" )
    {
        return false;
    }
    
    return true;
}

// Namespace zm_sat_firefly_script_garage
// Params 0, eflags: 0x4
// Checksum 0xb9231a9, Offset: 0x29cf
// Size: 0x5d
function private player_teleport_station_state_watcher()
{
    level endon( #"game_ended" );
    
    while ( true )
    {
        if ( self getscriptablepartstate( "fx" ) == "teleport_in_progress" )
        {
            waitframe();
            continue;
        }
        
        if ( !function_600acd31f16ed0f9() )
        {
            utility::function_32b24db3127bff40( "fx", "unavailable" );
        }
        else
        {
            utility::function_32b24db3127bff40( "fx", "available" );
        }
        
        waitframe();
    }
}

// Namespace zm_sat_firefly_script_garage
// Params 1, eflags: 0x4
// Checksum 0xe2eb69da, Offset: 0x2a34
// Size: 0x11b
function private function_e754ea0c2844aedc( station_sbl )
{
    if ( !isdefined( level.wonder_veh ) )
    {
        /#
            logprint( "<dev string:x69>" );
        #/
        
        return;
    }
    
    level endon( #"game_ended" );
    
    if ( isdefined( station_sbl ) )
    {
        station_sbl disablescriptableplayeruse( self );
    }
    
    player = self;
    player endon( #"death_or_disconnect" );
    player val::set( "garage_teleport", "allow_movement", 0 );
    player val::set( "garage_teleport", "damage", 0 );
    player val::set( "garage_teleport", "killstreaks", 0 );
    
    if ( isdefined( station_sbl ) )
    {
        station_sbl setscriptablepartstate( "fx", "teleport_in_progress" );
    }
    
    player thread zm_utility::white_screen_flash( 1, 0.2 );
    player playsoundtoplayer( #"hash_1fcabd3140b32dab", player );
    playfx( level._effect[ "garage_player_teleport_out" ], player.origin );
    wait 0.25;
    player function_ac0b2ab76cef42d2();
    player val::reset_all( "garage_teleport" );
    
    if ( isdefined( station_sbl ) )
    {
        station_sbl enablescriptableplayeruse( self );
    }
}

// Namespace zm_sat_firefly_script_garage
// Params 0, eflags: 0x4
// Checksum 0x838dd6d1, Offset: 0x2b57
// Size: 0x1a7
function private function_ac0b2ab76cef42d2()
{
    level endon( #"game_ended" );
    self endon( #"death_or_disconnect" );
    
    if ( level.wonder_veh getscriptablepartstate( "single" ) == "vehicle_unusable" )
    {
        /#
            logprint( "<dev string:xa7>" );
        #/
        
        return;
    }
    
    self playsoundtoplayer( #"hash_165d13d526eca172", self );
    
    if ( vehicle_occupancy::is_seat_available( level.wonder_veh, "driver", self ) && getdvarint( @"hash_6e854b0e361d667c" ) == 0 )
    {
        seat_id = "driver";
    }
    else
    {
        seat_id = vehicle_occupancy::function_79f80964bb18e6c6( level.wonder_veh, self, "driver" );
    }
    
    if ( !isdefined( seat_id ) )
    {
        seat_id = "driver";
    }
    
    self function_b14dead5d492aa48( 1 );
    thread vehicle_occupancy::enter( level.wonder_veh, seat_id, self );
    currtime = 0;
    
    while ( !vehicle::is_in_vehicle() )
    {
        if ( currtime >= 3 )
        {
            return;
        }
        
        wait 0.1;
        currtime += 0.1;
    }
    
    self function_b14dead5d492aa48( 0 );
    
    switch ( seat_id )
    {
        case #"hash_1c567a9fd8fadb0a":
            tag = "tag_gunner_turret1";
            break;
        case #"hash_b19724c2fdfb9d3f":
            tag = "tag_seat_0";
            break;
        case #"hash_d483a45eab71d645":
            tag = "tag_seat_1";
            break;
        case #"hash_5173951ca5f38fce":
            tag = "tag_seat_2";
            break;
        case #"hash_d3214a911a48d323":
            tag = "tag_seat_3";
            break;
    }
    
    playfxontag( level._effect[ "garage_player_teleport_in" ], level.wonder_veh, tag );
}

// Namespace zm_sat_firefly_script_garage
// Params 0, eflags: 0x4
// Checksum 0x8e56b3e6, Offset: 0x2d06
// Size: 0x168
function private function_b81057cc8a07039a()
{
    var_a16811a742ca0143 = [];
    
    for ( i = 1; i <= 4 ; i++ )
    {
        str_tag = "tag_passenger_" + i;
        var_24efaf9a2fadc0b8 = spawnstruct();
        var_24efaf9a2fadc0b8.origin = level.wonder_veh gettagorigin( str_tag );
        var_24efaf9a2fadc0b8.angles = level.wonder_veh gettagangles( str_tag );
        var_a16811a742ca0143[ var_a16811a742ca0143.size ] = var_24efaf9a2fadc0b8;
    }
    
    assert( var_a16811a742ca0143.size > 0, "<dev string:xe8>" );
    chosen_tag = var_a16811a742ca0143[ 0 ];
    furthest_dist = 0;
    
    foreach ( var_24efaf9a2fadc0b8 in var_a16811a742ca0143 )
    {
        closest_player = utility::function_4325398d215ecda5( var_24efaf9a2fadc0b8.origin, level.players );
        closest_player_dist = distance2d( closest_player.origin, var_24efaf9a2fadc0b8.origin );
        
        if ( closest_player_dist > furthest_dist )
        {
            furthest_dist = closest_player_dist;
            chosen_tag = var_24efaf9a2fadc0b8;
        }
    }
    
    return chosen_tag;
}

// Namespace zm_sat_firefly_script_garage
// Params 0
// Checksum 0x3a5ba112, Offset: 0x2e77
// Size: 0x26
function function_82f0c80b5da6df1d()
{
    self notify( #"hash_2a16ad9df2fb60a8" );
    self endon( #"hash_2a16ad9df2fb60a8" );
    level endon( #"game_ended" );
}

// Namespace zm_sat_firefly_script_garage
// Params 0, eflags: 0x4
// Checksum 0xbc70e2ee, Offset: 0x2ea5
// Size: 0x55
function private function_42bfb931b6829384()
{
    level endon( #"game_ended" );
    
    while ( true )
    {
        if ( level.wonder_veh.health > 50 )
        {
            level.s_garage.player_teleport_station_sbl utility::function_32b24db3127bff40( "fx", "available" );
            return;
        }
        
        waitframe();
    }
}

// Namespace zm_sat_firefly_script_garage
// Params 1
// Checksum 0x73a9c144, Offset: 0x2f02
// Size: 0x89
function function_d696b1e2e8b90e1d( params )
{
    level endon( #"game_ended" );
    level utility::flag_clear( "garage_summon_available" );
    pluto = self;
    level.wonder_veh pluto_veh::function_934c783b411fa6cc( level.s_garage.s_pluto_spawn.origin, level.s_garage.s_pluto_spawn.angles, ( 0, 20, 0 ) );
}

// Namespace zm_sat_firefly_script_garage
// Params 0, eflags: 0x4
// Checksum 0x1fd12d2, Offset: 0x2f93
// Size: 0xe0
function private function_8faa213388e59619()
{
    var_add18175a5765096 = vehicle_getarrayinradius( level.s_garage.origin, level.s_garage.radius );
    
    foreach ( veh in var_add18175a5765096 )
    {
        if ( veh.var_b6a3f46ec4332fd8 )
        {
            pluto_zone = zone_manager::function_90e5c3e2272b0130( veh.origin );
            
            if ( pluto_zone.script_zone_name == "zone_sunken_garage" )
            {
                return veh;
            }
        }
    }
    
    return 0;
}

// Namespace zm_sat_firefly_script_garage
// Params 4, eflags: 0x4
// Checksum 0xcf6a6d89, Offset: 0x307c
// Size: 0xd5
function private function_f97ec173d2ad762d( var_3f77d5fa92c1edbb, str_caption, interact_ent, player )
{
    level endon( #"game_ended" );
    player.is_upgrading = 1;
    waitframe();
    player thread zm_interaction::function_307c21197e0798d4( var_3f77d5fa92c1edbb, str_caption );
    player zm_quest::function_eb3a5a6c3f4f3ba6( { #craft_reason:"upgrading_pluto" } );
    player playloopsound( "amb_zm_garage_upgrade_station_craft_lp" );
    result = player zm_interaction::function_df340931f1a0fe6e( undefined, interact_ent, 128 );
    
    if ( isdefined( player.var_a0de55e36be21b7a ) )
    {
        player thread zm_interaction::function_7c7ed762cd4d0333();
    }
    
    player.is_upgrading = 0;
    player zm_quest::function_b94186b3fb991490( { #craft_reason:"upgrading_pluto" } );
    player stoploopsound( "amb_zm_garage_upgrade_station_craft_lp" );
    return result;
}

// Namespace zm_sat_firefly_script_garage
// Params 0, eflags: 0x4
// Checksum 0xe62367b5, Offset: 0x315a
// Size: 0x2c4
function private function_6aa7df51af5971f1()
{
    level endon( #"game_ended" );
    
    foreach ( flag in level.var_bbe2ae9963c25f75 )
    {
        if ( level utility::flag( flag ) )
        {
            return;
        }
    }
    
    if ( utility::percent_chance( 50 ) )
    {
        snd_event = #"hash_cee4ccd360375d2d";
    }
    else
    {
        snd_event = #"hash_c625682c7e13a507";
    }
    
    level.wonder_veh utility::callsharedfunc( #"veh_pluto", #"hash_df3c234ed94054f7", snd_event, 1 );
    a_players = getplayersinradius( level.wonder_veh.origin, 500 );
    
    foreach ( player in a_players )
    {
        var_db75d3de862ce072 = player namespace_c0b4f2882c9d100f::function_8c1a12974bd11f01( #"hash_d9b0f7f9f6c1fc8" );
        
        if ( var_db75d3de862ce072 )
        {
            break;
        }
    }
    
    overlord::playevent( #"entity_first_time", level.players, 5 );
    
    while ( true )
    {
        if ( !overlord::function_dce0a14273dfa0a8() )
        {
            break;
        }
        
        waitframe();
    }
    
    a_players = arrayrandomize( level.players );
    
    foreach ( player in a_players )
    {
        var_db75d3de862ce072 = player namespace_c0b4f2882c9d100f::function_8c1a12974bd11f01( #"entity_first_time_response" );
        
        if ( var_db75d3de862ce072 )
        {
            return;
        }
    }
    
    foreach ( player in a_players )
    {
        var_db75d3de862ce072 = player namespace_c0b4f2882c9d100f::function_8c1a12974bd11f01( #"entity_first_time_response", #"hash_5212ed7ec42f115a" );
        
        if ( var_db75d3de862ce072 )
        {
            return;
        }
    }
}

// Namespace zm_sat_firefly_script_garage
// Params 0, eflags: 0x4
// Checksum 0xb2eb816b, Offset: 0x3426
// Size: 0x12a
function private function_bb0b3f782f531fa9()
{
    level endon( #"game_ended" );
    level.wonder_veh endon( #"death" );
    
    if ( utility::percent_chance( 50 ) )
    {
        snd_event = #"hash_cee4ccd360375d2d";
    }
    else
    {
        snd_event = #"hash_c625572c7e138824";
    }
    
    level.wonder_veh utility::callsharedfunc( #"veh_pluto", #"hash_df3c234ed94054f7", snd_event, 1 );
    a_players = getplayersinradius( level.wonder_veh.origin, 500 );
    a_players = arrayrandomize( a_players );
    
    foreach ( player in a_players )
    {
        var_db75d3de862ce072 = player namespace_c0b4f2882c9d100f::function_8c1a12974bd11f01( #"pluto_upgrade_response" );
        
        if ( var_db75d3de862ce072 )
        {
            return;
        }
    }
}

// Namespace zm_sat_firefly_script_garage
// Params 0, eflags: 0x4
// Checksum 0x6d8382a9, Offset: 0x3558
// Size: 0x12a
function private function_d960c5dc887630e0()
{
    level endon( #"game_ended" );
    level.wonder_veh endon( #"death" );
    
    if ( utility::percent_chance( 50 ) )
    {
        snd_event = #"hash_ced8771285b7948d";
    }
    else
    {
        snd_event = #"hash_131a1fd3868ad1a8";
    }
    
    level.wonder_veh utility::callsharedfunc( #"veh_pluto", #"hash_df3c234ed94054f7", snd_event, 1 );
    a_players = getplayersinradius( level.wonder_veh.origin, 500 );
    a_players = arrayrandomize( a_players );
    
    foreach ( player in a_players )
    {
        var_db75d3de862ce072 = player namespace_c0b4f2882c9d100f::function_8c1a12974bd11f01( #"pluto_upgrade_response" );
        
        if ( var_db75d3de862ce072 )
        {
            return;
        }
    }
}

// Namespace zm_sat_firefly_script_garage
// Params 1, eflags: 0x4
// Checksum 0x2712d966, Offset: 0x368a
// Size: 0x192
function private function_dc659749a37ca47( activating_player )
{
    level endon( #"game_ended" );
    wait 0.1;
    level utility::flag_waitopen( "warping_pluto" );
    wait 0.5;
    
    if ( !level.s_garage.var_35c9924182ecb07 )
    {
        level.s_garage.var_35c9924182ecb07 = 0;
    }
    
    if ( gettime() - level.s_garage.var_35c9924182ecb07 <= utility::function_4b74c15943231980( 180 ) )
    {
        return;
    }
    
    if ( isalive( activating_player ) && activating_player namespace_c0b4f2882c9d100f::is_hero_operator() )
    {
        var_db75d3de862ce072 = activating_player namespace_c0b4f2882c9d100f::function_8c1a12974bd11f01( #"pluto_summon" );
        
        if ( var_db75d3de862ce072 )
        {
            return;
        }
    }
    
    a_players = getplayersinradius( level.s_garage.s_pluto_spawn.origin, 500 );
    
    foreach ( player in a_players )
    {
        if ( player namespace_c0b4f2882c9d100f::is_hero_operator() )
        {
            var_db75d3de862ce072 = player namespace_c0b4f2882c9d100f::function_8c1a12974bd11f01( #"pluto_summon" );
            
            if ( var_db75d3de862ce072 )
            {
                break;
            }
        }
    }
    
    if ( var_db75d3de862ce072 )
    {
        level.s_garage.var_35c9924182ecb07 = gettime();
    }
}

// Namespace zm_sat_firefly_script_garage
// Params 1, eflags: 0x4
// Checksum 0x6471f9aa, Offset: 0x3824
// Size: 0xb6
function private function_4aea76ff16b1ab8b( player )
{
    level endon( #"game_ended" );
    player endon( #"death_or_disconnect" );
    wait 0.75;
    
    if ( !level.s_garage.var_911a07bc8493433c )
    {
        level.s_garage.var_911a07bc8493433c = 0;
    }
    
    if ( gettime() - level.s_garage.var_911a07bc8493433c <= utility::function_4b74c15943231980( 30 ) )
    {
        return;
    }
    
    var_db75d3de862ce072 = player namespace_c0b4f2882c9d100f::function_8c1a12974bd11f01( #"hash_f74ddb3bbdc48dbb" );
    
    if ( var_db75d3de862ce072 )
    {
        level.s_garage.var_911a07bc8493433c = gettime();
    }
}

/#

    // Namespace zm_sat_firefly_script_garage
    // Params 0, eflags: 0x4
    // Checksum 0x399e944, Offset: 0x38e2
    // Size: 0x5a, Type: dev
    function private setup_garage_debug()
    {
        devgui::function_9082edeb5db93280( "<dev string:x114>" );
        devgui::add_devgui_func( "<dev string:x12b>", "<dev string:x141>", &function_4519df615bf6d071 );
        devgui::add_devgui_func( "<dev string:x156>", "<dev string:x16c>", &function_e0ab4db43131a3c9 );
        devgui::add_devgui_func( "<dev string:x181>", "<dev string:x199>", &function_d710859227cac1d2 );
        devgui::function_77df7fe7dd273e10();
    }

    // Namespace zm_sat_firefly_script_garage
    // Params 0, eflags: 0x4
    // Checksum 0x3200afaa, Offset: 0x3944
    // Size: 0x123, Type: dev
    function private function_4519df615bf6d071()
    {
        cached_origin = level.players[ 0 ].origin;
        a_players = getplayersinradius( level.players[ 0 ].origin, 115 );
        
        foreach ( player in a_players )
        {
            v_dir = vectornormalize( player.origin - level.players[ 0 ].origin + ( 1, 0, 0 ) );
            player knockback( v_dir, 350 );
        }
        
        wait 0.2;
        level.wonder_veh vehicle_teleport( cached_origin, level.wonder_veh.angles );
    }

    // Namespace zm_sat_firefly_script_garage
    // Params 0, eflags: 0x4
    // Checksum 0xb9c23e77, Offset: 0x3a6f
    // Size: 0x3f, Type: dev
    function private function_d710859227cac1d2()
    {
        player = level.players[ getdvarint( @"hash_a21345761e50cec9", 0 ) ];
        player endon( #"death_or_disconnect" );
        player function_e754ea0c2844aedc();
    }

    // Namespace zm_sat_firefly_script_garage
    // Params 0, eflags: 0x4
    // Checksum 0x2c9600f2, Offset: 0x3ab6
    // Size: 0x15, Type: dev
    function private function_e0ab4db43131a3c9()
    {
        level.wonder_veh function_d696b1e2e8b90e1d();
    }

#/
