// scripts\common\ai\aitypes\zombie_base_toxic\zombie_base_toxic.gsc  (hash_7f929d229cac0df8.gscc) (size: 2280 Bytes / 0x8e8 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xb44b7974 (3024845172)
// size ...... 2280 (0x8e8)
// includes .. 7   (offset: 0x814)
// strings ... 12  (offset: 0x84c)
// dev strs .. 0   (offset: 0x8e8)
// exports ... 4   (offset: 0x540)
// cseg ...... 0x12f + 0x411 (0x540)
// imports ... 20  (offset: 0x5e0)
// animtree1 . 0   (offset: 0x8e8)
// animtree2 . 0   (offset: 0x8e8)
#using script_16ea1b94f0f381b3;
#using scripts\common\ai\aitypes\shared\zombie\zombie_toxic_gas;
#using scripts\common\ai\aitypes\shared\zombie\zombie_utils;
#using scripts\common\callbacks;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\mp\common\utility\player_utility;

#namespace zombie_base_toxic;

// Namespace zombie_base_toxic
// Params 2
// Checksum 0x337f4de7, Offset: 0x14d
// Size: 0x53
function precache( classname, aitypescriptbundle )
{
    if ( utility::flag( "init_zombie_base_toxic" ) )
    {
        return;
    }
    
    utility::flag_set( "init_zombie_base_toxic" );
    callback::add( "on_" + aitypescriptbundle.subclass + "_spawned", &function_c96663b844d1bd03 );
}

// Namespace zombie_base_toxic
// Params 1, eflags: 0x4
// Checksum 0xb85fd0cb, Offset: 0x1a8
// Size: 0x3a
function private function_c96663b844d1bd03( params )
{
    callback::add( "on_zombie_ai_killed", &function_a601ed3e064ed992 );
    self.forceannihilate = 1;
    val::set( "zombie_base_toxic", "allow_dismember", 0 );
}

// Namespace zombie_base_toxic
// Params 1, eflags: 0x4
// Checksum 0x384f58f5, Offset: 0x1ea
// Size: 0x356
function private function_a601ed3e064ed992( params )
{
    if ( val::get( "disable_elemental_effect" ) )
    {
        self.forceannihilate = undefined;
        return;
    }
    
    var_46063ece3767f60b = self.origin;
    
    if ( self.var_9cf9051d40e9cd4e )
    {
        if ( self.owner )
        {
            settings_override = self.var_d6894f01a36b4ff3;
        }
    }
    
    duration = 1;
    
    if ( isdefined( self.toxic_gas_duration ) )
    {
        duration = self.toxic_gas_duration;
    }
    else if ( !isdefined( self.toxic_gas_notify ) )
    {
        duration = 4;
    }
    
    should_spawn_toxic_gas = 1;
    
    if ( isdefined( self.var_7a679e69584d580c ) )
    {
        should_spawn_toxic_gas = [[ self.var_7a679e69584d580c ]]( var_46063ece3767f60b, 64, self.owner );
    }
    
    if ( self._blackboard.var_431d45d5a00efc3d && self._blackboard.vortexmode == "blackhole" )
    {
        should_spawn_toxic_gas = 0;
    }
    
    if ( should_spawn_toxic_gas )
    {
        thread zombie_toxic_gas::spawn_toxic_gas( self.owner ?? self, var_46063ece3767f60b, ( 0, 0, 0 ), "from_zombie_base_toxic", duration, 64, 64, self.toxic_gas_notify, undefined, undefined, settings_override );
    }
    
    players = function_d63fe6a4c08ba6f5( var_46063ece3767f60b, self.var_d6894f01a36b4ff3.explosionradius, 200 );
    
    foreach ( player in players )
    {
        if ( !player_utility::playersareenemies( self, player ) )
        {
            continue;
        }
        
        player namespace_9d8e359c3b1041e5::shellshocksharedfunc( self.var_d6894f01a36b4ff3.explosionshock, #"damage", 0.35 );
        player dodamage( self.var_d6894f01a36b4ff3.explosiondamage * ( self.var_fe048a2106d8ef00[ #"explosionattack" ] ?? 1 ), var_46063ece3767f60b, self, self, "MOD_EXPLOSIVE", undefined, "head" );
    }
    
    enemies = self function_f017e352a29a57a1( var_46063ece3767f60b, self.var_d6894f01a36b4ff3.explosionradius );
    ai_damage = namespace_9d8e359c3b1041e5::function_870440d8340968c0( "zombie_base", namespace_9d8e359c3b1041e5::function_57de0ca2e80536a1( var_46063ece3767f60b ) );
    
    foreach ( enemy in enemies )
    {
        if ( isai( enemy ) && !enemy zombie_utils::function_33a24849a0dfd13b() && !enemy.teamshifted )
        {
            damage_multiplier = enemy.var_789cb6b6be71394b ?? 1;
            enemy dodamage( ai_damage * damage_multiplier, var_46063ece3767f60b, self, self, "MOD_EXPLOSIVE", undefined, "head", undefined, 1073741824 );
        }
    }
}

