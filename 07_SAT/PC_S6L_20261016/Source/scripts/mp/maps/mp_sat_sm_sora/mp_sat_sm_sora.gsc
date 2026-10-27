// scripts\mp\maps\mp_sat_sm_sora\mp_sat_sm_sora.gsc  (hash_62434cfc33b7b761.gscc) (size: 2321 Bytes / 0x911 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xd6b5fe29 (3602251305)
// size ...... 2321 (0x911)
// includes .. 7   (offset: 0x819)
// strings ... 16  (offset: 0x851)
// dev strs .. 0   (offset: 0x911)
// exports ... 5   (offset: 0x4c9)
// cseg ...... 0x165 + 0x364 (0x4c9)
// imports ... 22  (offset: 0x591)
// animtree1 . 0   (offset: 0x911)
// animtree2 . 0   (offset: 0x911)
#using scripts\common\active_env\moving_platforms;
#using scripts\common\active_env\utility;
#using scripts\mp\compass;
#using scripts\mp\load;
#using scripts\mp\maps\mp_sat_sm_sora\gen\mp_sat_sm_sora_art;
#using scripts\mp\maps\mp_sat_sm_sora\mp_sat_sm_sora_fx;
#using scripts\mp\maps\mp_sat_sm_sora\mp_sat_sm_sora_lighting;

#namespace mp_sat_sm_sora;

// Namespace mp_sat_sm_sora
// Params 0
// Checksum 0x7a2df89d, Offset: 0x183
// Size: 0xfb
function main()
{
    mp_sat_sm_sora_art::main();
    mp_sat_sm_sora_fx::main();
    mp_sat_sm_sora_lighting::main();
    load::main();
    level.kill_border_triggers = getentarray( "kill_border_trigger", #targetname );
    level.outofboundstriggers = getentarray( "OutOfBounds", #targetname );
    level.var_750dbf45607817fd = getentarray( "Drone_OutOfBounds", #targetname );
    level.var_f11fa8013d4e241c = getentarray( "VTOL_OutOfBounds", #targetname );
    compass::setupminimap( "compass_map_mp_sat_sm_sora" );
    game[ "attackers" ] = "allies";
    game[ "defenders" ] = "axis";
    game[ "allies_outfit" ] = "urban";
    game[ "axis_outfit" ] = "woodland";
    level thread moving_platforms::moving_platforms_init();
    weaponfilter = [ #"drone_launcher":1 ];
    utility::setup_no_deploy_zones( weaponfilter );
    function_d7f9958b36b16eff();
}

// Namespace mp_sat_sm_sora
// Params 0, eflags: 0x4
// Checksum 0xd018cd3e, Offset: 0x286
// Size: 0x15d
function private function_d7f9958b36b16eff()
{
    var_98c5c0a7dc9ff235 = getdvarint( @"hash_7bd6b0ac8e8cbff3", 0 );
    a_t_damage = getentarray( "sora_damage_trigger", #script_noteworthy );
    var_5acd2f6fd6c4c28b = getent( "damage_trigger_model", #targetname );
    
    if ( !isdefined( var_5acd2f6fd6c4c28b ) )
    {
        return;
    }
    
    var_5acd2f6fd6c4c28b hide();
    var_5acd2f6fd6c4c28b notsolid();
    
    if ( var_98c5c0a7dc9ff235 )
    {
        foreach ( var_e49e01b230f55732 in a_t_damage )
        {
            var_e49e01b230f55732 hide();
        }
        
        return;
    }
    
    foreach ( var_e49e01b230f55732 in a_t_damage )
    {
        var_e49e01b230f55732 show();
        var_e49e01b230f55732.b_used = 0;
        var_e49e01b230f55732 thread function_9fb7dd663efe6f83( var_5acd2f6fd6c4c28b );
    }
}

// Namespace mp_sat_sm_sora
// Params 1, eflags: 0x4
// Checksum 0x82c356d, Offset: 0x3eb
// Size: 0x4a
function private function_9fb7dd663efe6f83( var_5acd2f6fd6c4c28b )
{
    level endon( #"game_ended" );
    
    while ( self.b_used === 0 )
    {
        self waittill( #"trigger" );
        self.b_used = 1;
        reflective_perimeter( var_5acd2f6fd6c4c28b );
    }
}

// Namespace mp_sat_sm_sora
// Params 1, eflags: 0x4
// Checksum 0x29d0ef75, Offset: 0x43d
// Size: 0x8c
function private reflective_perimeter( var_5acd2f6fd6c4c28b )
{
    level endon( #"game_ended" );
    e_new_model = spawn( "script_model", var_5acd2f6fd6c4c28b.origin );
    e_new_model.angles = var_5acd2f6fd6c4c28b.angles;
    e_new_model setscale( 10 );
    e_new_model setmodel( var_5acd2f6fd6c4c28b.model );
    e_new_model notsolid();
    e_new_model linkto( var_5acd2f6fd6c4c28b );
    moving_platforms::moving_platform_activate( var_5acd2f6fd6c4c28b );
    wait 9;
    e_new_model hide();
}

