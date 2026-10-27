// script_52f4e2b322ec41ef  (hash_52f4e2b322ec41ef.gscc) (size: 3527 Bytes / 0xdc7 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xa346577f (2739296127)
// size ...... 3527 (0xdc7)
// includes .. 8   (offset: 0xc57)
// strings ... 23  (offset: 0xc97)
// dev strs .. 1   (offset: 0xdbb)
// exports ... 11  (offset: 0x6ef)
// cseg ...... 0x262 + 0x48d (0x6ef)
// imports ... 33  (offset: 0x8a7)
// animtree1 . 0   (offset: 0xdc7)
// animtree2 . 0   (offset: 0xdc7)
#using scripts\common\ai\aitypes\shared\zombie\zombie_attractor_manager;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\mp\zm\ztron\ztron_item;
#using scripts\mp\zm\ztron\ztron_player_utility;
#using scripts\mp\zm\ztron\ztron_sound;
#using scripts\mp\zm\ztron\ztron_utility;

#namespace namespace_2363734efed6552;

// Namespace namespace_2363734efed6552
// Params 0, eflags: 0x5
// Checksum 0x7e8c064, Offset: 0x280
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"hash_e1de5fd2a9240bf5", #"ztron_item", undefined, &init );
}

// Namespace namespace_2363734efed6552
// Params 0
// Checksum 0xc5bcbed9, Offset: 0x2a9
// Size: 0x64
function init()
{
    ztron_item::function_5844a9c240f7dc8d( #"monkey_bomb", #"use", &use_monkey_bomb );
    ztron_sound::function_4ac735395b173fe( "ztron_pickup_monkey_goodbye_explo_OS", "evt_ztron_pickup_monkeybomb_byebye" );
    ztron_sound::function_4ac735395b173fe( "ztron_pickup_monkey_go_boom", "evt_ztron_pickup_monkeybomb_explode" );
    utility::add_fx( "monkey_reveal", "vfx_t10_gameplay_zm_equip_monkey_bomb_oob" );
    utility::add_fx( "monkey_detonate", "vfx_sat_exp_rpg_purple_ztron" );
}

// Namespace namespace_2363734efed6552
// Params 1, eflags: 0x4
// Checksum 0xfa8cf901, Offset: 0x315
// Size: 0xfa
function private use_monkey_bomb( params )
{
    /#
        iprintlnbold( "<dev string:x24>" );
    #/
    
    owner = params.player;
    ground_pos = ztron_util::function_3fe38741460a4a49( params.scriptable.origin );
    monkey_bomb_model = utility::spawn_model( "ztron_monkey_bomb", ground_pos );
    monkey_bomb_model.owner = owner;
    monkey_bomb_model thread ztron_monkey_bomb_play_vfx();
    monkey_bomb_model thread ztron_monkey_bomb_play_sound();
    radius = 384;
    
    if ( owner.ztron.upgradeMask & 8192 )
    {
        radius *= 2;
    }
    
    monkey_bomb_model.attractor = zombie_attractor_manager::add_attractor( monkey_bomb_model, 7, radius, 0, undefined, &function_3b6f15358945b9d8, 0, undefined, 1 );
    monkey_bomb_model thread ztron_monkey_bomb_dance();
    monkey_bomb_model thread function_d878d33d958be60d();
    monkey_bomb_model thread monkey_bomb_detonate();
}

// Namespace namespace_2363734efed6552
// Params 0, eflags: 0x4
// Checksum 0x23e509c5, Offset: 0x417
// Size: 0x54
function private ztron_monkey_bomb_dance()
{
    self endon( #"death" );
    self endon( #"detonate_bomb" );
    self scriptmodelplayanim( "ztron_monkey_bomb_dance" );
    time = self.owner ztron_player_utility::function_10777122eee28fa8( 6.5 );
    wait time;
    self notify( #"detonate_bomb" );
}

// Namespace namespace_2363734efed6552
// Params 0, eflags: 0x4
// Checksum 0xd753e5aa, Offset: 0x473
// Size: 0xd8
function private monkey_bomb_detonate()
{
    level endon( #"ztron_game_is_over" );
    self endon( #"death" );
    self waittill( #"detonate_bomb" );
    playfx( utility::getfx( "monkey_reveal" ), self.origin );
    wait 1;
    
    if ( isent( self.owner ) )
    {
        radiusdamage( self.origin, 256, 6000, 4000, self.owner, "MOD_EXPLOSIVE", makeweapon( "sat_ztron_monkey_bomb_missile" ) );
        playfx( utility::getfx( "monkey_detonate" ), self.origin, anglestoup( self.angles ) );
        ztron_sound::ztron_playsound( "ztron_pickup_monkey_goodbye_explo_OS", self.origin );
        ztron_sound::ztron_playsound( "ztron_pickup_monkey_go_boom", self.origin );
    }
    
    thread function_d0847b43294014bd();
}

// Namespace namespace_2363734efed6552
// Params 0, eflags: 0x4
// Checksum 0x86e7ad7, Offset: 0x553
// Size: 0x37
function private function_d878d33d958be60d()
{
    level endon( #"ztron_game_is_over" );
    result = level utility::waittill_any_return( "ztron_exit_taken", "ztron_teleporter_taken" );
    self notify( #"detonate_bomb" );
}

// Namespace namespace_2363734efed6552
// Params 0, eflags: 0x4
// Checksum 0x76c39265, Offset: 0x592
// Size: 0x25
function private ztron_monkey_bomb_play_vfx()
{
    self endon( #"death" );
    wait 0.15;
    utility::function_7c10ea82c1e305b8( "vfx", "active" );
}

// Namespace namespace_2363734efed6552
// Params 0, eflags: 0x4
// Checksum 0x2c95d5ac, Offset: 0x5bf
// Size: 0x25
function private ztron_monkey_bomb_play_sound()
{
    self endon( #"death" );
    wait 0.3;
    utility::function_7c10ea82c1e305b8( "sound", "song" );
}

// Namespace namespace_2363734efed6552
// Params 0, eflags: 0x4
// Checksum 0xb969e5f5, Offset: 0x5ec
// Size: 0x30
function private function_d0847b43294014bd()
{
    self endon( #"death" );
    self hide();
    zombie_attractor_manager::remove_attractor( self.attractor );
    wait 0.15;
    self delete();
}

// Namespace namespace_2363734efed6552
// Params 2, eflags: 0x4
// Checksum 0x2ae66203, Offset: 0x624
// Size: 0xcb
function private function_3b6f15358945b9d8( attractor, zombie )
{
    if ( zombie.b_ignore_monkey_bomb )
    {
        return 0;
    }
    
    if ( !val::get( "allow_secondary_attack_damage" ) )
    {
        return 0;
    }
    
    if ( zombie.subclass == "zombie_hellhound" )
    {
        return 0;
    }
    
    if ( zombie.var_840153567385cc6b )
    {
        return 0;
    }
    
    if ( zombie.aicategory == "normal" || zombie.aicategory == "special" || zombie.aicategory == "elite" )
    {
        if ( zombie.team != attractor.source.team )
        {
            return 1;
        }
        else
        {
            return 0;
        }
        
        return;
    }
    
    return 0;
}

