// scripts\mp\maps\mp_sat_green_screen\mp_sat_green_screen.gsc  (hash_42fe721051635645.gscc) (size: 2270 Bytes / 0x8de / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xd8b927e1 (3636013025)
// size ...... 2270 (0x8de)
// includes .. 8   (offset: 0x802)
// strings ... 13  (offset: 0x842)
// dev strs .. 0   (offset: 0x8de)
// exports ... 11  (offset: 0x3de)
// cseg ...... 0x117 + 0x2c7 (0x3de)
// imports ... 22  (offset: 0x596)
// animtree1 . 0   (offset: 0x8de)
// animtree2 . 0   (offset: 0x8de)
#using scripts\common\callbacks;
#using scripts\mp\common\utility\player;
#using scripts\mp\compass;
#using scripts\mp\load;
#using scripts\mp\maps\mp_sat_green_screen\gen\mp_sat_green_screen_art;
#using scripts\mp\maps\mp_sat_green_screen\mp_sat_green_screen_fx;
#using scripts\mp\maps\mp_sat_green_screen\mp_sat_green_screen_lighting;
#using scripts\mp\weapons;

#namespace mp_sat_green_screen;

// Namespace mp_sat_green_screen
// Params 0
// Checksum 0x91e733d8, Offset: 0x135
// Size: 0x9c
function main()
{
    mp_sat_green_screen_art::main();
    mp_sat_green_screen_fx::main();
    mp_sat_green_screen_lighting::main();
    level.var_f0f4fdb2281e1851 = 1;
    load::main();
    level.outofboundstriggers = getentarray( "OutOfBounds", "targetname" );
    compass::setupminimap( "compass_map_mp_sat_green_screen" );
    callback::add( #"player_spawned", &on_player_spawn );
    game[ "attackers" ] = "allies";
    game[ "defenders" ] = "axis";
    game[ "allies_outfit" ] = "urban";
    game[ "axis_outfit" ] = "woodland";
    function_96c44a30352c34b();
}

/#

    // Namespace mp_sat_green_screen
    // Params 0
    // Checksum 0xee9a829c, Offset: 0x1d9
    // Size: 0x5, Type: dev
    function function_688f87c194439d9c()
    {
        
    }

#/

// Namespace mp_sat_green_screen
// Params 0
// Checksum 0x24e0ee1b, Offset: 0x1e6
// Size: 0x1e
function function_96c44a30352c34b()
{
    level.onplayerconnect = &on_player_connect;
    level.weapondropfunction = &on_drop_weapon;
}

// Namespace mp_sat_green_screen
// Params 1, eflags: 0x4
// Checksum 0xa207d2d4, Offset: 0x20c
// Size: 0x39
function private on_player_connect( e_player )
{
    e_player thread function_beabcc9dd4496701();
    
    if ( isbot( e_player ) )
    {
        return;
    }
    
    e_player thread function_b53d6be7f4ad1344();
    e_player notifyonplayercommand( "clean_map", "+actionslot 2" );
}

// Namespace mp_sat_green_screen
// Params 1, eflags: 0x4
// Checksum 0x45292a8c, Offset: 0x24d
// Size: 0x27
function private on_player_spawn( params )
{
    if ( getdvarint( @"scr_mp_sat_green_screen_hide_minimap", 1 ) )
    {
        player::hideminimap( 1 );
    }
}

// Namespace mp_sat_green_screen
// Params 0, eflags: 0x4
// Checksum 0x6241b2f0, Offset: 0x27c
// Size: 0x4f
function private function_beabcc9dd4496701()
{
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    
    while ( true )
    {
        self waittill( #"death" );
        var_8b17ee2294ae2a72 = self getcorpseentity();
        
        if ( isdefined( var_8b17ee2294ae2a72 ) )
        {
            var_8b17ee2294ae2a72 thread function_6358e3d0935d98ef();
        }
    }
}

// Namespace mp_sat_green_screen
// Params 0, eflags: 0x4
// Checksum 0x436a95a2, Offset: 0x2d3
// Size: 0x3b
function private function_b53d6be7f4ad1344()
{
    level endon( #"hash_594245877812755f" );
    self endon( #"disconnect" );
    
    while ( true )
    {
        self waittill( #"clean_map" );
        level notify( #"clean_map" );
    }
}

// Namespace mp_sat_green_screen
// Params 4, eflags: 0x4
// Checksum 0xded57f8b, Offset: 0x316
// Size: 0x4e
function private on_drop_weapon( e_attacker, str_means_of_death, str_weapon_override, n_damage )
{
    e_weapon_drop = weapons::dropweaponfordeath( e_attacker, str_means_of_death, str_weapon_override, n_damage );
    
    if ( isdefined( e_weapon_drop ) )
    {
        e_weapon_drop thread function_f15aeeeb79e99d8d();
    }
}

// Namespace mp_sat_green_screen
// Params 0, eflags: 0x4
// Checksum 0x56d77889, Offset: 0x36c
// Size: 0x35
function private function_f15aeeeb79e99d8d()
{
    level endon( #"game_ended" );
    self endon( #"death" );
    
    while ( true )
    {
        level waittill( #"clean_map" );
        self delete();
    }
}

// Namespace mp_sat_green_screen
// Params 0, eflags: 0x4
// Checksum 0x779427ca, Offset: 0x3a9
// Size: 0x35
function private function_6358e3d0935d98ef()
{
    level endon( #"game_ended" );
    self endon( #"death" );
    
    while ( true )
    {
        level waittill( #"clean_map" );
        self delete();
    }
}

