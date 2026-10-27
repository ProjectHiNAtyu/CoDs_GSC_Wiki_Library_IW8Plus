// scripts\mp\br\weapons\br_monkey_bomb.gsc  (hash_177814a24639f88a.gscc) (size: 4010 Bytes / 0xfaa / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x3d07ea91 (1023928977)
// size ...... 4010 (0xfaa)
// includes .. 7   (offset: 0xf06)
// strings ... 8   (offset: 0xf3e)
// dev strs .. 0   (offset: 0xfaa)
// exports ... 10  (offset: 0x9a2)
// cseg ...... 0x116 + 0x88c (0x9a2)
// imports ... 34  (offset: 0xb32)
// animtree1 . 0   (offset: 0xfaa)
// animtree2 . 0   (offset: 0xfaa)
#using script_16ea1b94f0f381b3;
#using scripts\common\callbacks;
#using scripts\common\utility;
#using scripts\mp\battlechatter_mp;
#using scripts\mp\common\equipment\monkey_bomb;
#using scripts\mp\equipment;
#using scripts\mp\outofbounds;

#namespace br_monkey_bomb;

// Namespace br_monkey_bomb
// Params 0
// Checksum 0x25504c74, Offset: 0x134
// Size: 0xc9
function init()
{
    monkey_bomb::monkey_bomb_init();
    level.var_546d1ce59a4bfdc5 = utility::getsharedfunc( #"equipment", #"hash_e0ab82e8a3d12d1d" );
    level.monkey_bomb_name = "sat_monkey_bomb_wz";
    level.var_8c94fee7994936ba = "t10_zm_monkey_bomb_dance_01";
    level.var_d49f16537ce71aee = undefined;
    level.var_546d1ce59a4bfdc5 = &function_2429348c666fc4af;
    level.var_b75db25d44709ee = 1;
    utility::registersharedfunc( #"gametype", #"ongrenadeused", &ongrenadeused );
    level callback::add( #"on_ai_killed_medal", &on_killed_medal );
    level callback::add( #"player_offhand_pullback", &function_2efc9df90a015b25 );
    level callback::add( #"grenade_fire", &function_11351e498adfad02 );
}

// Namespace br_monkey_bomb
// Params 1, eflags: 0x4
// Checksum 0x9dc9ccdc, Offset: 0x205
// Size: 0x435
function private on_killed_medal( params )
{
    if ( ( params.victim.aicategory == "normal" || params.victim.aicategory == "special" ) && !params.victim.b_ignore_monkey_bomb )
    {
        params.victim.var_2d2edd3d69cd5c3d = 1;
        params.victim.is_tatical_kill = 1;
        var_a75f2542aa4a8e6a = params.eattacker function_4a017065e05cffea( gettime() );
        
        if ( params.eattacker.monkey_grenade_kills[ var_a75f2542aa4a8e6a ].kills == 10 )
        {
            params.eattacker namespace_9d8e359c3b1041e5::doscoreeventsharedfunc( #"medal_monkeybusiness" );
            
            if ( utility::issharedfuncdefined( #"sound", #"play_scoreevent_vo", 0 ) && !params.eattacker utility::ent_flag( "disable_monkey_bomb_multikill_vo" ) )
            {
                utility::callsharedfunc( #"sound", #"play_scoreevent_vo", params.eattacker, #"bc_equipment_monkey_bomb_multikill" );
            }
            
            if ( utility::issharedfuncdefined( #"challenges", #"hash_4dbee06d8fb19056" ) )
            {
                params.eattacker utility::callsharedfunc( #"challenges", #"hash_4dbee06d8fb19056", #"medal_monkeybusiness" );
            }
        }
    }
    
    if ( !params.victim.var_2d2edd3d69cd5c3d && params.victim.target_attractor.source.model === "wm_jup_2h_zmb_monkey_bomb" && params.eattacker === params.victim.target_attractor.source.owner && isnumber( params.victim.target_attractor.source.fuse_start_time ) )
    {
        fusestarttime = params.victim.target_attractor.source.fuse_start_time;
        
        if ( !isdefined( params.eattacker.monkey_grenade_kills ) )
        {
            params.eattacker.monkey_grenade_kills = [];
        }
        
        if ( !isdefined( params.eattacker.monkey_grenade_kills[ fusestarttime ] ) )
        {
            params.eattacker.monkey_grenade_kills[ fusestarttime ] = { #fuse_time_start:fusestarttime, #kills:0 };
        }
        
        if ( params.eattacker.monkey_grenade_kills[ fusestarttime ].kills == 0 )
        {
            params.eattacker thread function_8aa3a0e19ccc7213( fusestarttime, params.victim.target_attractor.source.fuse_end_time + 100 );
        }
        
        params.eattacker.monkey_grenade_kills[ fusestarttime ].kills++;
        params.victim.is_tatical_kill = 1;
        
        if ( params.eattacker.monkey_grenade_kills[ fusestarttime ].kills == 10 )
        {
            params.eattacker namespace_9d8e359c3b1041e5::doscoreeventsharedfunc( #"medal_monkeybusiness" );
            
            if ( utility::issharedfuncdefined( #"challenges", #"hash_4dbee06d8fb19056" ) )
            {
                params.eattacker utility::callsharedfunc( #"challenges", #"hash_4dbee06d8fb19056", #"medal_monkeybusiness" );
            }
        }
    }
}

// Namespace br_monkey_bomb
// Params 2, eflags: 0x4
// Checksum 0x85c8db6e, Offset: 0x642
// Size: 0x49
function private function_8aa3a0e19ccc7213( birthtime, endtime )
{
    self endon( #"disconnect" );
    waitduration = ( endtime - gettime() ) / 1000;
    wait waitduration;
    self.monkey_grenade_kills[ birthtime ] = undefined;
}

// Namespace br_monkey_bomb
// Params 1, eflags: 0x4
// Checksum 0x39ec8697, Offset: 0x693
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

// Namespace br_monkey_bomb
// Params 1, eflags: 0x4
// Checksum 0xc9f20693, Offset: 0x7d0
// Size: 0x40
function private function_2efc9df90a015b25( params )
{
    if ( params.objweapon.basename === level.monkey_bomb_name )
    {
        thread function_b6605e6c0d73b0da( params.objweapon );
    }
}

// Namespace br_monkey_bomb
// Params 1, eflags: 0x4
// Checksum 0x14788129, Offset: 0x818
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

// Namespace br_monkey_bomb
// Params 1, eflags: 0x4
// Checksum 0x8948dbcd, Offset: 0x89f
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

// Namespace br_monkey_bomb
// Params 2
// Checksum 0x55795ea5, Offset: 0x94f
// Size: 0x2c
function ongrenadeused( weaponname, grenade )
{
    if ( issubstr( weaponname, "monkey_bomb" ) )
    {
        thread monkey_bomb::monkey_bomb_used( grenade );
    }
}

// Namespace br_monkey_bomb
// Params 1
// Checksum 0x9eb42f73, Offset: 0x983
// Size: 0x1e, Type: bool
function function_2429348c666fc4af( checkloc )
{
    return !outofbounds::ispointinoutofbounds( checkloc, self.team );
}

