// scripts\mp\zm\maps\zm_sat_locust\zm_sat_locust_survival_lighthouse.gsc  (hash_480337a74044fe65.gscc) (size: 4114 Bytes / 0x1012 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x510089b4 (1358989748)
// size ...... 4114 (0x1012)
// includes .. 11  (offset: 0xe7a)
// strings ... 24  (offset: 0xed2)
// dev strs .. 0   (offset: 0x1012)
// exports ... 11  (offset: 0x8e2)
// cseg ...... 0x2a6 + 0x63c (0x8e2)
// imports ... 32  (offset: 0xa9a)
// animtree1 . 0   (offset: 0x1012)
// animtree2 . 0   (offset: 0x1012)
#using scripts\common\callbacks;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\mp\calloutmarkerping;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\doorbuy;
#using scripts\mp\magicbox;
#using scripts\mp\zm\gametypes\zm_rb_survival;
#using scripts\mp\zm\maps\zm_sat_locust\zm_sat_locust;
#using scripts\mp\zm\maps\zm_sat_locust\zm_sat_locust_survival_lighthouse_fishing_cs;
#using scripts\mp\zm\systems\zone_manager;

#namespace zm_sat_locust_survival_lighthouse;

// Namespace zm_sat_locust_survival_lighthouse
// Params 0, eflags: 0x5
// Checksum 0x6a204575, Offset: 0x2c4
// Size: 0x1d
function private autoexec __init__system__()
{
    system::register( #"hash_1b771955aac823e3", undefined, &pre_main_init, &post_main_init );
}

// Namespace zm_sat_locust_survival_lighthouse
// Params 0, eflags: 0x4
// Checksum 0x51cce3b4, Offset: 0x2e9
// Size: 0x18
function private pre_main_init()
{
    if ( !is_survival_lighthouse() )
    {
        return;
    }
    
    level.var_37c4ad7c326edf2b = 1;
}

// Namespace zm_sat_locust_survival_lighthouse
// Params 0, eflags: 0x4
// Checksum 0x19f4fb0d, Offset: 0x309
// Size: 0x47
function private post_main_init()
{
    if ( !is_survival_lighthouse() )
    {
        return;
    }
    
    level thread function_330b06dbd3494414();
    level thread function_49f64d5f02569edc();
    level thread function_2b41eff46793496d();
    level thread function_2a6eb5f38b1e4bdd();
    level callback::add( "doorbuy_opened", &function_a6906a3e23b75b0e );
    level thread zm_sat_locust_survival_lighthouse_fishing_cs::main();
}

// Namespace zm_sat_locust_survival_lighthouse
// Params 1
// Checksum 0x5a3a6cd4, Offset: 0x358
// Size: 0xbb
function function_a6906a3e23b75b0e( params )
{
    zone = zone_manager::function_90e5c3e2272b0130( params.door.origin );
    
    if ( zone.zone_name == "zone_lighthouse_back" || zone.zone_name == "zone_lighthouse_int" || zone.zone_name == "zone_lighthouse_back" || zone.zone_name == "zone_lighthouse" )
    {
        zone_manager::set_zone_enabled( "zone_lighthouse_boat_house", 1 );
        zone_manager::set_zone_enabled( "zone_lighthouse_int", 1 );
        zone_manager::set_zone_enabled( "zone_lighthouse_back", 1 );
        level.lighthouse_doorbuy_opened = 1;
    }
}

// Namespace zm_sat_locust_survival_lighthouse
// Params 0, eflags: 0x4
// Checksum 0xf2f782e7, Offset: 0x41b
// Size: 0xdd
function private function_330b06dbd3494414()
{
    level endon( #"game_ended" );
    utility::flag_wait( "zone_setup_finished" );
    level thread function_f41311c00a815c3f();
    utility::flag_wait( "survival_map_zone_setup_finished" );
    wait 1;
    zone_manager::set_zone_enabled( "zone_downtown", 0 );
    zone_manager::set_zone_enabled( "zone_downtown_shore", 0 );
    zone_manager::set_zone_enabled( "zone_downtown_south_street", 0 );
    zone_manager::set_zone_enabled( "zone_downtown_shop", 0 );
    zone_manager::set_zone_enabled( "zone_downtown_building", 0 );
    zone_manager::set_zone_enabled( "zone_downtown_dock", 0 );
    zone_manager::set_zone_enabled( "zone_downtown_meadhall", 0 );
    zone_manager::set_zone_enabled( "zone_downtown_middle_street", 0 );
    zone_manager::set_zone_enabled( "zone_downtown_north_street", 0 );
    
    if ( level.lighthouse_doorbuy_opened == 1 )
    {
        return;
    }
    
    zone_manager::set_zone_enabled( "zone_lighthouse_boat_house", 0 );
    zone_manager::set_zone_enabled( "zone_lighthouse_int", 0 );
    zone_manager::set_zone_enabled( "zone_lighthouse_back", 0 );
}

// Namespace zm_sat_locust_survival_lighthouse
// Params 0, eflags: 0x4
// Checksum 0x35a6056d, Offset: 0x500
// Size: 0x8c
function private function_f41311c00a815c3f()
{
    level endon( #"game_ended" );
    utility::flag_wait( "scriptables_ready" );
    utility::flag_set( "zone_lighthouse_barrier_broken" );
    blocker = getent( "wwq_lh_door_clip", #targetname );
    
    if ( isdefined( blocker ) )
    {
        door = getent( "wwq_door_2", #targetname );
        
        if ( isdefined( door ) )
        {
            door rotateyaw( -95, level.framedurationseconds );
        }
        
        blocker connectpaths();
        blocker delete();
    }
}

// Namespace zm_sat_locust_survival_lighthouse
// Params 0, eflags: 0x4
// Checksum 0xf7e3bd95, Offset: 0x594
// Size: 0x2a8
function private function_49f64d5f02569edc()
{
    level endon( #"game_ended" );
    utility::flag_wait( "doorbuy_init_complete" );
    
    foreach ( db in level.a_s_doorbuys )
    {
        if ( db doorbuy::function_f9df5874c38b508a() && isdefined( db.interact ) )
        {
            db.interact.var_df00f5fbf4a6d195 = 1;
            
            foreach ( door in db.interact.doors )
            {
                if ( isdefined( door.minimap_scriptable ) )
                {
                    door.minimap_scriptable calloutmarkerping::function_608710c894185549();
                    door.minimap_scriptable freescriptable();
                    door.minimap_scriptable = undefined;
                }
            }
            
            ascenders = getentitylessscriptablearray( "scriptable_t10_ascender_zipline_01", #classname, db.origin, 128 );
            
            foreach ( ascender in ascenders )
            {
                ascender.forcedisabled = 1;
            }
        }
        else
        {
            db.script_cost = 3000;
        }
        
        if ( db.target2 == "db_downtown_mead" )
        {
            foreach ( door in db.doors )
            {
                door thread doorbuy::function_f3160e450543b4f1();
            }
        }
    }
}

// Namespace zm_sat_locust_survival_lighthouse
// Params 0, eflags: 0x4
// Checksum 0x9f9dc748, Offset: 0x844
// Size: 0x2a
function private function_2b41eff46793496d()
{
    level endon( #"game_ended" );
    utility::flag_wait( "zone_setup_finished" );
    level thread zm_sat_locust::function_3efce57265da8ada();
    level thread zm_sat_locust::function_459d352ce27eca06();
}

// Namespace zm_sat_locust_survival_lighthouse
// Params 0, eflags: 0x4
// Checksum 0x6ffa1775, Offset: 0x876
// Size: 0x34
function private function_2a6eb5f38b1e4bdd()
{
    level endon( #"game_ended" );
    utility::flag_wait( "magicbox_ready" );
    magicbox::function_6c4ffb8218367c4b( %"hash_4e5e12b8328b46fd", 3 );
    magicbox::function_2e49cd8681e36211( 0 );
}

// Namespace zm_sat_locust_survival_lighthouse
// Params 0, eflags: 0x4
// Checksum 0xcefe0d3, Offset: 0x8b2
// Size: 0x2f, Type: bool
function private is_survival_lighthouse()
{
    if ( !game_utility::function_21211f3255f8ea58() )
    {
        return false;
    }
    
    poiname = zm_rb_survival::function_64c3a9143299dacb();
    
    if ( poiname != "zone_lighthouse" )
    {
        return false;
    }
    
    return true;
}

