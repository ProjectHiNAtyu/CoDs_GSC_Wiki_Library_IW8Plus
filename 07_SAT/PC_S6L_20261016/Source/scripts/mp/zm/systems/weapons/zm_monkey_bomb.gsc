// scripts\mp\zm\systems\weapons\zm_monkey_bomb.gsc  (hash_4cb594e3972c9e47.gscc) (size: 4671 Bytes / 0x123f / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xf4464276 (4098245238)
// size ...... 4671 (0x123f)
// includes .. 8   (offset: 0x117b)
// strings ... 9   (offset: 0x11bb)
// dev strs .. 1   (offset: 0x1233)
// exports ... 13  (offset: 0xaeb)
// cseg ...... 0x13e + 0x9ad (0xaeb)
// imports ... 40  (offset: 0xcf3)
// animtree1 . 0   (offset: 0x123f)
// animtree2 . 0   (offset: 0x123f)
#using script_16ea1b94f0f381b3;
#using scripts\common\callbacks;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\mp\battlechatter_mp;
#using scripts\mp\common\equipment\monkey_bomb;
#using scripts\mp\equipment;
#using scripts\mp\zm\systems\zm_equipment_oob;

#namespace zm_monkey_bomb;

// Namespace zm_monkey_bomb
// Params 0, eflags: 0x5
// Checksum 0xc46e6d9e, Offset: 0x15c
// Size: 0x19
function private autoexec __init__system__()
{
    system::register( #"zm_monkey_bomb", undefined, &init, undefined );
}

// Namespace zm_monkey_bomb
// Params 0
// Checksum 0x894b439b, Offset: 0x17d
// Size: 0xb5
function init()
{
    monkey_bomb::monkey_bomb_init();
    level.var_546d1ce59a4bfdc5 = &zm_equipment_oob::is_equipment_in_bounds;
    level.var_d49f16537ce71aee = &should_refund_monkey_bomb;
    weaponname = utility::get_scripted_weapon_name( #"monkey_bomb" );
    level.monkey_bomb_name = weaponname;
    level.var_8c94fee7994936ba = "t10_zm_monkey_bomb_dance_01";
    level thread register_on_kill_medal();
    level callback::add( #"on_ai_killed_medal", &function_f24ca47ec442468f );
    level callback::add( #"player_offhand_pullback", &function_2efc9df90a015b25 );
    level callback::add( #"grenade_fire", &function_11351e498adfad02 );
    level callback::add( "on_round_end", &on_round_end );
}

// Namespace zm_monkey_bomb
// Params 1, eflags: 0x4
// Checksum 0x1a94896f, Offset: 0x23a
// Size: 0xc1
function private should_refund_monkey_bomb( monkey_bomb )
{
    if ( self.is_free_grenade )
    {
        println( "<dev string:x24>" );
        return 0;
    }
    
    if ( self.owner utility::ent_flag( "is_usurped_power_grabbed" ) || self.owner.var_87522aee8be7890b.ref || self.owner.var_819dfee5ff9a56d6 )
    {
        return;
    }
    
    if ( monkey_bomb.owner.var_966a8c354456247d )
    {
        return 0;
    }
    
    if ( isplayer( monkey_bomb.owner ) )
    {
        monkey_bomb.owner.var_966a8c354456247d = 1;
    }
    
    return 1;
}

// Namespace zm_monkey_bomb
// Params 1, eflags: 0x4
// Checksum 0xa39b48c, Offset: 0x303
// Size: 0x87
function private on_round_end( params )
{
    foreach ( player in level.players )
    {
        player.var_966a8c354456247d = undefined;
    }
}

// Namespace zm_monkey_bomb
// Params 0, eflags: 0x4
// Checksum 0xe48ad324, Offset: 0x392
// Size: 0x52
function private register_on_kill_medal()
{
    level utility::flag_wait( "StartGameTypeCallbackFinished" );
    
    if ( utility::issharedfuncdefined( #"medal", #"register_on_kill_medal_callback", 0 ) )
    {
        utility::callsharedfunc( #"medal", #"register_on_kill_medal_callback", level.monkey_bomb_name, &function_9c37dab83025b0c2 );
    }
}

// Namespace zm_monkey_bomb
// Params 4, eflags: 0x4
// Checksum 0xf59fa4a9, Offset: 0x3ec
// Size: 0x14a
function private function_9c37dab83025b0c2( victim, einflictor, smeansofdeath, sweapon )
{
    if ( ( victim.aicategory == "normal" || victim.aicategory == "special" ) && !victim.b_ignore_monkey_bomb )
    {
        victim.var_2d2edd3d69cd5c3d = 1;
        victim.is_tatical_kill = 1;
        var_a75f2542aa4a8e6a = function_4a017065e05cffea( gettime() );
        
        if ( self.monkey_grenade_kills[ var_a75f2542aa4a8e6a ].kills == 10 )
        {
            namespace_9d8e359c3b1041e5::doscoreeventsharedfunc( #"medal_monkeybusiness" );
            
            if ( utility::issharedfuncdefined( #"sound", #"play_scoreevent_vo", 0 ) && !utility::ent_flag( "disable_monkey_bomb_multikill_vo" ) )
            {
                utility::callsharedfunc( #"sound", #"play_scoreevent_vo", self, #"bc_equipment_monkey_bomb_multikill" );
            }
            
            if ( utility::issharedfuncdefined( #"challenges", #"hash_4dbee06d8fb19056" ) )
            {
                utility::callsharedfunc( #"challenges", #"hash_4dbee06d8fb19056", #"medal_monkeybusiness" );
            }
        }
    }
}

// Namespace zm_monkey_bomb
// Params 1, eflags: 0x4
// Checksum 0x903cdb93, Offset: 0x53e
// Size: 0x2a0
function private function_f24ca47ec442468f( params )
{
    if ( !params.victim.var_2d2edd3d69cd5c3d && params.victim.target_attractor.source.model === "wm_jup_2h_zmb_monkey_bomb" && params.attacker === params.victim.target_attractor.source.owner && isnumber( params.victim.target_attractor.source.fuse_start_time ) )
    {
        fusestarttime = params.victim.target_attractor.source.fuse_start_time;
        
        if ( !isdefined( params.attacker.monkey_grenade_kills ) )
        {
            params.attacker.monkey_grenade_kills = [];
        }
        
        if ( !isdefined( params.attacker.monkey_grenade_kills[ fusestarttime ] ) )
        {
            params.attacker.monkey_grenade_kills[ fusestarttime ] = { #fuse_time_start:fusestarttime, #kills:0 };
        }
        
        if ( params.attacker.monkey_grenade_kills[ fusestarttime ].kills == 0 )
        {
            params.attacker thread function_8aa3a0e19ccc7213( fusestarttime, params.victim.target_attractor.source.fuse_end_time + 100 );
        }
        
        params.attacker.monkey_grenade_kills[ fusestarttime ].kills++;
        params.victim.is_tatical_kill = 1;
        
        if ( params.attacker.monkey_grenade_kills[ fusestarttime ].kills == 10 )
        {
            params.attacker namespace_9d8e359c3b1041e5::doscoreeventsharedfunc( #"medal_monkeybusiness" );
            
            if ( utility::issharedfuncdefined( #"challenges", #"hash_4dbee06d8fb19056" ) )
            {
                params.attacker utility::callsharedfunc( #"challenges", #"hash_4dbee06d8fb19056", #"medal_monkeybusiness" );
            }
        }
    }
}

// Namespace zm_monkey_bomb
// Params 2, eflags: 0x4
// Checksum 0x2856c4d2, Offset: 0x7e6
// Size: 0x49
function private function_8aa3a0e19ccc7213( birthtime, endtime )
{
    self endon( #"disconnect" );
    waitduration = ( endtime - gettime() ) / 1000;
    wait waitduration;
    self.monkey_grenade_kills[ birthtime ] = undefined;
}

// Namespace zm_monkey_bomb
// Params 1, eflags: 0x4
// Checksum 0x9472992b, Offset: 0x837
// Size: 0x134
function private function_4a017065e05cffea( current_time )
{
    var_a75f2542aa4a8e6a = int( current_time - 8500 );
    
    if ( !isdefined( self.monkey_grenade_kills ) )
    {
        self.monkey_grenade_kills = [];
    }
    
    foreach ( killstruct in self.monkey_grenade_kills )
    {
        if ( abs( killstruct.fuse_time_start - var_a75f2542aa4a8e6a ) < 200 )
        {
            killstruct.kills++;
            return killstruct.fuse_time_start;
        }
    }
    
    if ( !isdefined( self.monkey_grenade_kills[ var_a75f2542aa4a8e6a ] ) )
    {
        self.monkey_grenade_kills[ var_a75f2542aa4a8e6a ] = { #fuse_time_start:var_a75f2542aa4a8e6a, #kills:0 };
    }
    
    thread function_8aa3a0e19ccc7213( var_a75f2542aa4a8e6a, current_time + 100 );
    self.monkey_grenade_kills[ var_a75f2542aa4a8e6a ].kills++;
    return var_a75f2542aa4a8e6a;
}

// Namespace zm_monkey_bomb
// Params 1, eflags: 0x4
// Checksum 0x646c192f, Offset: 0x974
// Size: 0x40
function private function_2efc9df90a015b25( params )
{
    if ( params.objweapon.basename === level.monkey_bomb_name )
    {
        thread function_b6605e6c0d73b0da( params.objweapon );
    }
}

// Namespace zm_monkey_bomb
// Params 1, eflags: 0x4
// Checksum 0x7f7acf20, Offset: 0x9bc
// Size: 0x7f
function private function_b6605e6c0d73b0da( weapon )
{
    self endon( #"death" );
    b_success = 0;
    
    if ( randomint( 100 ) < 25 )
    {
        equipmentbundle = equipment_mp::getEquipmentBundleFromWeaponName( weapon.basename );
        b_success = battlechatter_mp::trysaylocalsound( self, equipmentbundle.var_cf29f1d5de231a0f );
    }
    
    if ( b_success )
    {
        utility::ent_flag_set( "disable_monkey_bomb_multikill_vo" );
        return;
    }
    
    self playsoundonmovingent( "dx_zm_aimb_bomb_mnky_monkeyraise" );
}

// Namespace zm_monkey_bomb
// Params 1, eflags: 0x4
// Checksum 0x24d6c471, Offset: 0xa43
// Size: 0xa8
function private function_11351e498adfad02( params )
{
    monkey_bomb = params.grenade;
    
    if ( monkey_bomb.weapon_name != level.monkey_bomb_name || !isplayer( monkey_bomb.owner ) )
    {
        return;
    }
    
    player = monkey_bomb.owner;
    player endon( #"disable_monkey_bomb_multikill_vo" );
    monkey_bomb waittill( #"explode" );
    wait 1;
    
    if ( isdefined( player ) && player utility::ent_flag( "disable_monkey_bomb_multikill_vo" ) )
    {
        player utility::ent_flag_clear( "disable_monkey_bomb_multikill_vo" );
    }
}

