// scripts\common\ai\aitypes\zombie_methone\zombie_methone.gsc  (hash_3431d6756ab98d1c.gscc) (size: 4377 Bytes / 0x1119 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x9a47e3bb (2588402619)
// size ...... 4377 (0x1119)
// includes .. 7   (offset: 0xf99)
// strings ... 25  (offset: 0xfd1)
// dev strs .. 0   (offset: 0x1119)
// exports ... 6   (offset: 0xa35)
// cseg ...... 0x1e1 + 0x854 (0xa35)
// imports ... 40  (offset: 0xb25)
// animtree1 . 0   (offset: 0x1119)
// animtree2 . 0   (offset: 0x1119)
#using script_16ea1b94f0f381b3;
#using scripts\asm\asm;
#using scripts\common\ai\aitypes\shared\zombie\zombie_knockdown;
#using scripts\common\ai\aitypes\shared\zombie\zombie_toxic_gas;
#using scripts\common\ai\aitypes\shared\zombie\zombie_utils;
#using scripts\common\callbacks;
#using scripts\common\utility;

#namespace zombie_methone;

// Namespace zombie_methone
// Params 2
// Checksum 0x9c95ddba, Offset: 0x1ff
// Size: 0x91
function precache( classname, aitypescriptbundle )
{
    if ( utility::flag( "init_" + aitypescriptbundle.subclass ) )
    {
        return;
    }
    
    utility::flag_set( "init_" + aitypescriptbundle.subclass );
    callback::add( "on_" + aitypescriptbundle.subclass + "_spawned", &on_zombie_methone_spawned );
    
    if ( !callback::exists( "on_zombie_ai_killed", &function_9f5dda3117821620 ) )
    {
        level callback::add( "on_zombie_ai_killed", &function_9f5dda3117821620 );
    }
}

// Namespace zombie_methone
// Params 1, eflags: 0x4
// Checksum 0xfcd18ff7, Offset: 0x298
// Size: 0xc5
function private function_9f5dda3117821620( params )
{
    if ( !isplayer( params.eattacker ) || params.einflictor.subclass != "zombie_methone" )
    {
        return;
    }
    
    player = params.eattacker;
    
    if ( utility::issharedfuncdefined( #"medal", #"track_rapid_kill", 0 ) )
    {
        player utility::callsharedfunc( #"medal", #"track_rapid_kill", "zombie_methone_kill" );
        
        if ( player.rapidkill_data[ "zombie_methone_kill" ].rapidkill_count == 5 )
        {
            player namespace_9d8e359c3b1041e5::doscoreeventsharedfunc( #"medal_supercriticalcanine" );
        }
    }
}

// Namespace zombie_methone
// Params 1, eflags: 0x4
// Checksum 0x533cade3, Offset: 0x365
// Size: 0x1a
function private on_zombie_methone_spawned( params )
{
    self.death_explode_func = &zombie_methone_death_explode;
}

// Namespace zombie_methone
// Params 1, eflags: 0x4
// Checksum 0x647fe7d0, Offset: 0x387
// Size: 0x449
function private zombie_methone_death_explode( params )
{
    body = params.body;
    
    if ( !isdefined( body ) )
    {
        return;
    }
    
    body endon( #"death" );
    body endon( #"corpse_deleted" );
    eattacker = params.eattacker;
    var_e4608505a7697681 = 0.5;
    explode_vfx_time = 0.1;
    should_spawn_toxic_gas = 1;
    body utility::function_32b24db3127bff40( "base", "base_on" );
    
    if ( self.forceannihilate )
    {
        if ( self._blackboard.var_431d45d5a00efc3d && self._blackboard.vortexmode == "blackhole" )
        {
            should_spawn_toxic_gas = 0;
        }
        
        var_e4608505a7697681 = level.framedurationseconds;
        body.forceannihilate = 1;
    }
    else
    {
        if ( isdefined( self.asmname ) )
        {
            statename = self asmgetcurrentstate( self.asmname );
            animid = asm::asm_getanim( self.asmname, statename );
            xanim = asm::asm_getxanim( statename, animid );
            
            if ( isdefined( xanim ) )
            {
                animlength = getanimlength( xanim );
                
                if ( animhasnotetrack( xanim, "zombie_dog_explode" ) )
                {
                    var_adbcd06227e8326f = getnotetracktimes( xanim, "zombie_dog_explode" )[ 0 ];
                    var_e4608505a7697681 = animlength * var_adbcd06227e8326f;
                }
            }
        }
        
        var_e4608505a7697681 = self.explode_time_override ?? var_e4608505a7697681;
    }
    
    body.var_d6894f01a36b4ff3 = self.var_d6894f01a36b4ff3;
    body.var_e72fb3905a881007 = self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.var_a9eba73b4db0aec2;
    body.var_f8c9d15c3944d9e6 = self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.var_534e039a3993efd5;
    body.var_c0420d1e94a99058 = self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.var_9a69d405c47f8b4d;
    body.duration = self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.flameduration;
    body.round_number = zombie_utils::get_zombie_round_difficulty();
    body.subclass = self.subclass;
    body.var_7d1e526fec068901 = self.var_fe048a2106d8ef00[ #"explosionattack" ] ?? 1;
    body.toxic_gas_damage_multiplier = self.var_fe048a2106d8ef00[ #"hash_85b9f88a87622341" ] ?? 1;
    body.allowfriendlyfire = 1;
    body.var_a6599ef275f97079 = self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.var_6e1759bb096ae708 ?? 1;
    body function_dd258a3da9a2b4a1( body.duration + var_e4608505a7697681 + explode_vfx_time );
    results = body utility::waittill_any_return_params_or_timeout( var_e4608505a7697681, "corpse_thrown_explode" );
    body utility::function_32b24db3127bff40( "death", "explode_on" );
    
    if ( body.forceannihilate )
    {
        body utility::function_32b24db3127bff40( "death_annihilate", "death_annihilate" );
        body callback::callback( "on_annihilated" );
    }
    
    if ( results[ "message" ] == "corpse_thrown_explode" && results[ 0 ] )
    {
        var_b7b609abde6844aa = results[ 0 ];
    }
    else
    {
        var_b7b609abde6844aa = body gettagorigin( "j_spine2", 1 ) ?? body.origin;
    }
    
    var_b7b609abde6844aa = utility::groundpos( var_b7b609abde6844aa );
    body thread apply_explosion_damage( var_b7b609abde6844aa, eattacker );
    
    if ( should_spawn_toxic_gas )
    {
        toxic_gas = body zombie_toxic_gas::spawn_toxic_gas( body, var_b7b609abde6844aa, ( 0, 0, 0 ), "from_zombie_methone", body.duration, 64, 64, undefined, 1, body );
        toxic_gas.damage_owner = eattacker;
        toxic_gas.var_9722f23c01877fa2 = body.var_a6599ef275f97079;
    }
    
    wait explode_vfx_time;
    body hide();
    wait body.duration;
    body delete();
}

// Namespace zombie_methone
// Params 2, eflags: 0x4
// Checksum 0x63005a41, Offset: 0x7d8
// Size: 0x25d
function private apply_explosion_damage( origin, owner )
{
    level endon( #"game_ended" );
    radius = self.var_d6894f01a36b4ff3.explosionradius;
    potential_targets = getplayersandaiarrayinradius( origin, radius );
    var_ab98a896c3190bf9 = self.var_d6894f01a36b4ff3.explosiondamage;
    var_dc30d84b7d6d2c93 = self.var_7d1e526fec068901;
    base_zombie_max_health = namespace_9d8e359c3b1041e5::function_870440d8340968c0( "zombie_base", self.round_number );
    
    foreach ( target in potential_targets )
    {
        if ( !isalive( target ) )
        {
            continue;
        }
        
        if ( isplayer( target ) )
        {
            if ( target.team == self.team )
            {
                continue;
            }
            
            target namespace_9d8e359c3b1041e5::shellshocksharedfunc( self.var_d6894f01a36b4ff3.explosionshock, #"damage", 0.35 );
            var_65c55325765f1984 = int( var_ab98a896c3190bf9 * var_dc30d84b7d6d2c93 );
        }
        else
        {
            if ( target zombie_utils::function_33a24849a0dfd13b() )
            {
                continue;
            }
            
            if ( target.subclass == self.subclass )
            {
                continue;
            }
            
            if ( target.aicategory == "normal" && !issubstr( target.subclass, "zombie_base_armored" ) && !target zombie_knockdown::function_19d6107cb6bdff5c() )
            {
                target zombie_knockdown::function_6fc167d4a3590991( origin );
            }
            
            if ( target.aicategory == "normal" )
            {
                var_3b7c760575ea3a46 = 0.3;
            }
            else if ( target.aicategory == "special" )
            {
                var_3b7c760575ea3a46 = 0.1;
            }
            else
            {
                var_3b7c760575ea3a46 = 0.05;
            }
            
            var_65c55325765f1984 = int( base_zombie_max_health * var_3b7c760575ea3a46 );
        }
        
        target dodamage( var_65c55325765f1984, origin, owner ?? self, self, "MOD_EXPLOSIVE", "<explicitweaponnone>", "torso_lower", undefined, 65536 );
    }
}

