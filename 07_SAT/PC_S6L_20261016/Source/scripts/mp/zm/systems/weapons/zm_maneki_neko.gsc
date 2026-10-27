// scripts\mp\zm\systems\weapons\zm_maneki_neko.gsc  (hash_7f3d142a8fc37a4a.gscc) (size: 4048 Bytes / 0xfd0 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x2d9f6f82 (765423490)
// size ...... 4048 (0xfd0)
// includes .. 5   (offset: 0xed8)
// strings ... 14  (offset: 0xf00)
// dev strs .. 0   (offset: 0xfd0)
// exports ... 15  (offset: 0x894)
// cseg ...... 0x161 + 0x733 (0x894)
// imports ... 34  (offset: 0xaec)
// animtree1 . 0   (offset: 0xfd0)
// animtree2 . 0   (offset: 0xfd0)
#using scripts\common\callbacks;
#using scripts\common\system;
#using scripts\mp\common\utility\trigger;
#using scripts\mp\crafting_table;
#using scripts\mp\damage;

#namespace zm_maneki_neko;

// Namespace zm_maneki_neko
// Params 0, eflags: 0x5
// Checksum 0x7299c06d, Offset: 0x17f
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"zm_maneki_neko", #"maneki_neko", &main, undefined );
}

// Namespace zm_maneki_neko
// Params 0, eflags: 0x4
// Checksum 0xcbdaece8, Offset: 0x1a8
// Size: 0x4d
function private main()
{
    callback::add( #"player_offhand_pullback", &function_42ca9c787e73ec9c );
    callback::add( #"grenade_fire", &function_14fce744c7c053e0 );
    callback::add( #"maneki_neko_placed", &function_1dff160fff0074b9 );
    damage::register_scripted_damage_override_func( &on_player_damaged );
}

// Namespace zm_maneki_neko
// Params 10, eflags: 0x4
// Checksum 0xfda1a5db, Offset: 0x1fd
// Size: 0x93
function private on_player_damaged( einflictor, eattacker, idamage, idflags, smeansofdeath, objweapon, vpoint, vdir, shitloc, psoffsettime )
{
    if ( self.var_7611db099b00e722 )
    {
        if ( objweapon.basename && issubstr( objweapon.basename, "ranged_attack" ) )
        {
            return 0;
        }
    }
    
    return idamage;
}

// Namespace zm_maneki_neko
// Params 2, eflags: 0x4
// Checksum 0x6ccbef3a, Offset: 0x299
// Size: 0x62
function private maneki_neko_trigger_enter( player, trigger )
{
    if ( isplayer( player ) )
    {
        if ( !isdefined( player.var_cedd2caa8b177df7 ) )
        {
            player.var_cedd2caa8b177df7 = [];
        }
        
        player.var_cedd2caa8b177df7[ player.var_cedd2caa8b177df7.size ] = trigger;
        player.var_7611db099b00e722 = 1;
    }
}

// Namespace zm_maneki_neko
// Params 2, eflags: 0x4
// Checksum 0x7750f4f1, Offset: 0x303
// Size: 0x57
function private maneki_neko_trigger_exit( player, trigger )
{
    if ( isplayer( player ) )
    {
        player.var_cedd2caa8b177df7 = arrayremove( player.var_cedd2caa8b177df7, trigger );
        
        if ( player.var_cedd2caa8b177df7.size == 0 )
        {
            player.var_7611db099b00e722 = undefined;
        }
    }
}

// Namespace zm_maneki_neko
// Params 1, eflags: 0x4
// Checksum 0x2f45e165, Offset: 0x362
// Size: 0x2c
function private maneki_neko_cleanup_trigger( trigger )
{
    if ( !isdefined( trigger ) )
    {
        return;
    }
    
    trigger::cleanup_enter_exit_trigger( trigger, 1 );
    
    if ( isdefined( trigger ) )
    {
        trigger delete();
    }
}

// Namespace zm_maneki_neko
// Params 1, eflags: 0x4
// Checksum 0x46a0e97e, Offset: 0x396
// Size: 0x2a
function private function_42ca9c787e73ec9c( params )
{
    if ( params.objweapon.basename === "sat_maneki_neko_zm" )
    {
    }
}

// Namespace zm_maneki_neko
// Params 1, eflags: 0x4
// Checksum 0xf3a5b082, Offset: 0x3c8
// Size: 0x6a
function private function_14fce744c7c053e0( params )
{
    maneki_neko = params.grenade;
    player = maneki_neko.owner;
    
    if ( maneki_neko.weapon_name != "sat_maneki_neko_zm" || !isplayer( player ) )
    {
        return;
    }
    
    callback::callback( #"hash_4cc399a485ab171d", params );
}

// Namespace zm_maneki_neko
// Params 1
// Checksum 0xc0095a57, Offset: 0x43a
// Size: 0x23e
function function_1dff160fff0074b9( params )
{
    var_adbac5ed5088b381 = params.grenade.owner;
    v_org = params.grenade.origin;
    params.grenade delete();
    
    if ( isdefined( var_adbac5ed5088b381.maneki_neko ) )
    {
        level thread maneki_neko_death( var_adbac5ed5088b381.maneki_neko, "timeout" );
    }
    
    var_adbac5ed5088b381.maneki_neko = spawn( "script_model", v_org );
    var_adbac5ed5088b381.maneki_neko setmodel( "offhand_sat_wm_zm_beckoning_cat" );
    var_adbac5ed5088b381.maneki_neko scriptmodelplayanim( "sat_zm_beckoning_cat_wave_01" );
    
    foreach ( t_lava in level.a_t_lava )
    {
        if ( var_adbac5ed5088b381.maneki_neko istouching( t_lava ) && !t_lava.iscooled )
        {
            level thread maneki_neko_death( var_adbac5ed5088b381.maneki_neko, "lava" );
            return;
        }
    }
    
    var_adbac5ed5088b381.maneki_neko.t_maneki = spawn( "trigger_radius", v_org, 0, 100, 32 );
    trigger::makeenterexittrigger( var_adbac5ed5088b381.maneki_neko.t_maneki, &maneki_neko_trigger_enter, &maneki_neko_trigger_exit );
    var_adbac5ed5088b381.maneki_neko.t_maneki.var_7c00f823b7c297d4 = createnavobstaclebyent( var_adbac5ed5088b381.maneki_neko.t_maneki );
    var_adbac5ed5088b381.maneki_neko thread function_c5f4c69f0efbae1f();
    var_adbac5ed5088b381.maneki_neko thread maneki_neko_destroy();
    params = spawnstruct();
    params.owner = var_adbac5ed5088b381;
    callback::callback( #"hash_c677129e3ed530bc", params );
}

// Namespace zm_maneki_neko
// Params 2
// Checksum 0xed7e8f2f, Offset: 0x680
// Size: 0xeb
function maneki_neko_death( equip, var_5a74003d195f2cde )
{
    sc_fx = spawnscriptable( %"zmloot_sat_offhand_maneki_neko", equip.origin );
    sc_fx setscriptablepartstate( "zmloot_sat_offhand_maneki_neko", "hidden" );
    waitframe();
    
    if ( sc_fx )
    {
        if ( var_5a74003d195f2cde == "lava" )
        {
            sc_fx setscriptablepartstate( "zmloot_sat_offhand_maneki_neko", "lava" );
        }
        else if ( var_5a74003d195f2cde == "timeout" )
        {
            sc_fx setscriptablepartstate( "zmloot_sat_offhand_maneki_neko", "timeout" );
        }
    }
    
    if ( isdefined( equip.t_maneki.var_7c00f823b7c297d4 ) )
    {
        destroynavobstacle( equip.t_maneki.var_7c00f823b7c297d4 );
    }
    
    maneki_neko_cleanup_trigger( equip.t_maneki );
    waitframe();
    
    if ( isdefined( sc_fx ) )
    {
        sc_fx freescriptable();
    }
    
    if ( isdefined( equip ) )
    {
        equip delete();
    }
}

// Namespace zm_maneki_neko
// Params 2
// Checksum 0x23b8908e, Offset: 0x773
// Size: 0x7a
function maneki_neko_hint( usable, player )
{
    if ( player.interactions_disabled )
    {
        return { #var_26bbd300351fde34:0, #string:&"", #type:"HINT_NOICON" };
    }
    
    return { #var_26bbd300351fde34:0, #string:&"equipment/pickup", #type:"HINT_BUTTON" };
}

// Namespace zm_maneki_neko
// Params 1
// Checksum 0xa4627f01, Offset: 0x7f6
// Size: 0x3c
function function_9a4d0ba32b118c59( player )
{
    player crafting_table::craft_give_equipment( "equip_attractor", "secondary" );
    
    if ( isdefined( player.maneki_neko ) )
    {
        level thread maneki_neko_death( self, "timeout" );
    }
}

// Namespace zm_maneki_neko
// Params 0
// Checksum 0xfbe39e74, Offset: 0x83a
// Size: 0x24
function function_c5f4c69f0efbae1f()
{
    self endon( #"death" );
    wait 20;
    
    if ( isdefined( self ) )
    {
        level thread maneki_neko_death( self, "timeout" );
    }
}

// Namespace zm_maneki_neko
// Params 0
// Checksum 0x8261f83d, Offset: 0x866
// Size: 0x2e
function maneki_neko_destroy()
{
    self endon( #"death" );
    self waittill( #"maneki_neko_die" );
    
    if ( isdefined( self ) )
    {
        level thread maneki_neko_death( self, "timeout" );
    }
}

