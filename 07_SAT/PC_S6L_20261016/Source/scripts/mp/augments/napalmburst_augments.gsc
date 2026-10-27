// scripts\mp\augments\napalmburst_augments.gsc  (hash_15351d986b06f813.gscc) (size: 5781 Bytes / 0x1695 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x7f641034 (2137264180)
// size ...... 5781 (0x1695)
// includes .. 9   (offset: 0x1589)
// strings ... 14  (offset: 0x15d1)
// dev strs .. 0   (offset: 0x1695)
// exports ... 11  (offset: 0xe79)
// cseg ...... 0x177 + 0xd02 (0xe79)
// imports ... 45  (offset: 0x1031)
// animtree1 . 0   (offset: 0x1695)
// animtree2 . 0   (offset: 0x1695)
#using script_16ea1b94f0f381b3;
#using scripts\common\ai\aitypes\shared\zombie\zombie_utils;
#using scripts\common\callbacks;
#using scripts\common\status_effects\effect_burn;
#using scripts\common\system;
#using scripts\common\throttle;
#using scripts\common\utility;
#using scripts\mp\ammomods\napalmburst;
#using scripts\mp\common\equipment\molotov;

#namespace napalmburst_augments;

// Namespace napalmburst_augments
// Params 0, eflags: 0x5
// Checksum 0x8d84d3f6, Offset: 0x195
// Size: 0x19
function private autoexec __init__system__()
{
    system::register( #"napalmburst_augments", undefined, &init_napalmburst_augments, undefined );
}

// Namespace napalmburst_augments
// Params 0
// Checksum 0xcba69db6, Offset: 0x1b6
// Size: 0x63
function init_napalmburst_augments()
{
    if ( !level.zombie_augments_in_use )
    {
        return;
    }
    
    level._effect[ "napalmburst_pyro_vfx" ] = loadfxasset( "vfx_t10_gameplay_zm_weapons_perk_burnination_lvl5_aoe" );
    level callback::add( "napalmburst_proc", &on_napalmburst_proc );
    level callback::add( #"on_ai_killed", &function_9238338f068b6568 );
    level callback::add( "napalm_burned_end", &function_70da5c01e16f5f82 );
}

// Namespace napalmburst_augments
// Params 1, eflags: 0x4
// Checksum 0xd5db260, Offset: 0x221
// Size: 0x5f1
function private on_napalmburst_proc( params )
{
    if ( !isplayer( params.attacker ) )
    {
        return;
    }
    
    if ( params.var_9f3ca9dcada2e0ef )
    {
        return;
    }
    
    if ( params.attacker utility::callsharedfunc( #"zombie", #"player_has_augment", #"napalmburst_petrol" ) )
    {
        var_4d1c881b347ff38a = level.zombie_augments[ #"napalmburst_petrol" ].var_20e83da0ad4ce9b5 ?? 5;
        
        if ( !params.attacker.var_da9b4fe4efa2961 )
        {
            var_17d23fa62b2c9d1d = level.zombie_augments[ #"napalmburst_petrol" ].var_12c5c415f6201068 ?? 0.2;
            var_774f6bd817f2f8d6 = level.zombie_augments[ #"napalmburst_petrol" ].var_b5976018c5497c6e ?? 1;
            var_638561c49234709 = level.zombie_augments[ #"napalmburst_petrol" ].var_8b2d8b0bc90363b1 ?? 0.9;
            var_754017d3a13ff852 = level.zombie_augments[ #"napalmburst_petrol" ].var_ba435edcc19c8512 ?? 1.9;
            round_difficulty = namespace_9d8e359c3b1041e5::function_57de0ca2e80536a1( self.origin );
            zombie_base_health = namespace_9d8e359c3b1041e5::function_870440d8340968c0( "zombie_base", round_difficulty );
            damage = int( zombie_base_health * var_17d23fa62b2c9d1d );
            
            if ( params.attacker utility::callsharedfunc( #"zombie", #"player_has_augment", #"napalmburst_contact_burn" ) )
            {
                var_d3d2df821bd21347 = level.zombie_augments[ #"napalmburst_contact_burn" ].var_4429de877ae5451 ?? 0.25;
                var_b64ff729ae8c7d4 = int( damage * var_d3d2df821bd21347 ) + damage;
            }
            
            var_b7b609abde6844aa = self getcentroid();
            var_b7b609abde6844aa = utility::groundpos( var_b7b609abde6844aa );
            var_a2ed83ab36ec43c8 = spawn( "script_model", var_b7b609abde6844aa );
            var_a2ed83ab36ec43c8.owner = params.attacker;
            var_a2ed83ab36ec43c8.prevent_knockdown = 1;
            var_a2ed83ab36ec43c8.var_d7594a5edcf54e30 = &function_d7594a5edcf54e30;
            burnbundle = spawnstruct();
            
            if ( !isdefined( level.var_4bfc8999918aee3b ) )
            {
                level.var_4bfc8999918aee3b = makeweapon( %"sat_molotov_zm_napalmburst" );
            }
            
            if ( isdefined( level.var_4bfc8999918aee3b ) )
            {
                burnbundle.useweapon = level.var_4bfc8999918aee3b;
            }
            
            burnbundle.var_35807474702938c6 = 1;
            burnbundle.var_c3f25b11c2247a29 = var_b64ff729ae8c7d4 ?? damage;
            burnbundle.var_78880e1476d45684 = damage;
            burnbundle.var_7ceb375188b38c13 = damage;
            burnbundle.var_b4261d601af6a28a = var_4d1c881b347ff38a;
            burnbundle.var_797382a688d68a64 = var_4d1c881b347ff38a;
            burnbundle.var_209153533613c440 = var_638561c49234709;
            burnbundle.var_726e9b33a65af54f = var_754017d3a13ff852;
            burnbundle.var_29dd3c8b7a515774 = var_774f6bd817f2f8d6;
            burnbundle.var_13727c7357581d8d = 0;
            burnbundle.var_61041a515545d346 = "_nburst";
            var_a2ed83ab36ec43c8.var_5b038f631de3ad97 = burnbundle;
            var_a2ed83ab36ec43c8.blueprintdefindex = 0;
            var_a2ed83ab36ec43c8.weapon_object = level.var_4bfc8999918aee3b;
            var_a2ed83ab36ec43c8.weapon_name = %"sat_molotov_zm_napalmburst";
            params.attacker.petrolstarttime = gettime();
            params.attacker.var_156510188aec02a4 = params.sweapon;
            thread molotov::molotov_simulate_impact( var_a2ed83ab36ec43c8, var_b7b609abde6844aa, ( 0, 0, 1 ), undefined, ( 0, 0, 100 ), gettime(), "napalmburst_augment_pool" );
            params.attacker thread function_136fe9c461a4b463();
        }
    }
    
    if ( params.attacker utility::callsharedfunc( #"zombie", #"player_has_augment", #"napalmburst_incendiary" ) )
    {
        thread function_66a997e2b919b92e( params );
    }
    
    if ( params.attacker utility::callsharedfunc( #"zombie", #"player_has_augment", #"napalmburst_contact_burn" ) )
    {
        var_d3d2df821bd21347 = level.zombie_augments[ #"napalmburst_contact_burn" ].var_4429de877ae5451 ?? 0.25;
        duration = 1;
        
        if ( params.attacker utility::callsharedfunc( #"zombie", #"player_has_augment", #"napalmburst_damage_boost" ) )
        {
            var_d3d2df821bd21347 += var_d3d2df821bd21347 * ( level.zombie_augments[ #"napalmburst_damage_boost" ].var_e3d0eb79fd6fe167 ?? 0.5 );
        }
        
        var_6a8c6c80ec0fa2ae = var_d3d2df821bd21347 * params.napalmburstdamage + params.napalmburstdamage;
        self.napalmburst_proc_weapon = params.sweapon;
        self.var_39cae9e1bcaca810 = 1;
        effect_burn::burn( duration, var_6a8c6c80ec0fa2ae, duration, params.attacker, "napalmburst", "_nburst", undefined, "fire", undefined, undefined, params.var_39b5b4282d55b138 );
        wait 1;
        
        if ( isplayer( params.attacker ) )
        {
            effect_burn::burn( params.napalmbursttime, params.napalmburstdamage, 1, params.attacker, "napalmburst", "_nburst", undefined, "fire", undefined, undefined, params.var_39b5b4282d55b138 );
        }
    }
}

// Namespace napalmburst_augments
// Params 0
// Checksum 0xd0ff265a, Offset: 0x81a
// Size: 0x5a
function function_136fe9c461a4b463()
{
    self endon( #"disconnect" );
    var_4d1c881b347ff38a = level.zombie_augments[ #"napalmburst_petrol" ].var_20e83da0ad4ce9b5 ?? 5;
    self.var_da9b4fe4efa2961 = 1;
    wait var_4d1c881b347ff38a - 1.5;
    self.var_da9b4fe4efa2961 = undefined;
}

// Namespace napalmburst_augments
// Params 0
// Checksum 0x136cd17b, Offset: 0x87c
// Size: 0x2
function function_d7594a5edcf54e30()
{
    
}

// Namespace napalmburst_augments
// Params 1, eflags: 0xc
// Checksum 0xfa8d7e5d, Offset: 0x886
// Size: 0x4d
function private function_66a997e2b919b92e( params )
{
    self notify( #"hash_b5425ddf3fec83b4" );
    self endon( #"hash_b5425ddf3fec83b4" );
    self endon( #"death" );
    
    while ( utility::ent_flag( "napalm_burned" ) )
    {
        thread function_a11ad7b6c1ef1f50( params );
        wait 1;
    }
}

// Namespace napalmburst_augments
// Params 1, eflags: 0x4
// Checksum 0xd6f7b797, Offset: 0x8db
// Size: 0xb8
function private function_a11ad7b6c1ef1f50( params )
{
    if ( !isalive( self ) )
    {
        return;
    }
    
    if ( !isplayer( params.attacker ) )
    {
        return;
    }
    
    if ( params.attacker utility::callsharedfunc( #"zombie", #"player_has_augment", #"napalmburst_petrol" ) )
    {
        if ( params.attacker.var_da9b4fe4efa2961 )
        {
            return;
        }
    }
    
    if ( self.napalmburst_incendiary_burnt )
    {
        return;
    }
    
    if ( self.napalmburst_incendiary_count >= ( level.zombie_augments[ #"napalmburst_incendiary" ].var_e029eef52087052b ?? 2 ) )
    {
        return;
    }
    
    run_incendiary( params );
}

// Namespace napalmburst_augments
// Params 1, eflags: 0xc
// Checksum 0xc37fbdc2, Offset: 0x99b
// Size: 0x1be
function private run_incendiary( params )
{
    self notify( #"hash_a0cf98f488ce7735" );
    self endon( #"hash_a0cf98f488ce7735" );
    
    if ( !isplayer( params.attacker ) )
    {
        return;
    }
    
    params.attacker endon( #"death" );
    
    if ( utility::percent_chance( level.zombie_augments[ #"napalmburst_incendiary" ].var_86ec12e2f4f2f7dd ?? 5 ) )
    {
        var_8c2fbdea85b949d = level.zombie_augments[ #"napalmburst_incendiary" ].var_d09f0ee78d7dd178 ?? 55;
        var_fdc5e4472f1e2a76 = getaiarrayinradius( self.origin, var_8c2fbdea85b949d );
        var_fdc5e4472f1e2a76 = arrayremove( var_fdc5e4472f1e2a76, self );
        
        if ( isplayer( params.attacker ) )
        {
            if ( utility::issharedfuncdefined( #"zm", #"hash_275603844e04e7ac" ) )
            {
                var_fdc5e4472f1e2a76 = level [[ utility::getsharedfunc( #"zm", #"hash_275603844e04e7ac" ) ]]( var_fdc5e4472f1e2a76, params.attacker );
            }
        }
        
        enemyai = utility::array_random( var_fdc5e4472f1e2a76 );
        
        if ( isalive( enemyai ) && !enemyai zombie_utils::function_bf1464d09f4e4b40() )
        {
            enemyai thread napalmburst::function_c4bcd20083d8d745( 0, params.attacker, "MOD_UNKNOWN", params.sweapon, params.vpoint, params.shitloc, params.modelindex, 1 );
            
            if ( !isdefined( self.napalmburst_incendiary_count ) )
            {
                self.napalmburst_incendiary_count = 0;
            }
            
            self.napalmburst_incendiary_count++;
            enemyai.napalmburst_incendiary_burnt = 1;
        }
    }
}

// Namespace napalmburst_augments
// Params 1, eflags: 0x4
// Checksum 0x672c8a70, Offset: 0xb61
// Size: 0x2bb
function private function_9238338f068b6568( params )
{
    level endon( #"game_ended" );
    
    if ( !isagent( self ) )
    {
        return;
    }
    
    if ( !isplayer( params.eattacker ) )
    {
        return;
    }
    
    if ( self.napalmburst_pyro_burned )
    {
        return;
    }
    
    napalmkilled = utility::ent_flag( "napalm_burned" );
    
    if ( napalmkilled && ( self.var_56bb046d7e4c8043 || params.eattacker utility::callsharedfunc( #"zombie", #"player_has_augment", #"napalmburst_pyro" ) ) )
    {
        var_29de6bf7ca3c5f0e = ( 0, 0, 0 );
        
        if ( self tagexists( "j_spine4" ) )
        {
            var_29de6bf7ca3c5f0e = self gettagorigin( "j_spine4" );
        }
        else
        {
            var_29de6bf7ca3c5f0e = self getcentroid();
        }
        
        self playsound( #"hash_7785761c71f2202a" );
        
        if ( !params.eattacker.var_45e1883829c0947c )
        {
            playfx( utility::getfx( "napalmburst_pyro_vfx" ), var_29de6bf7ca3c5f0e );
        }
        
        var_8c2fbdea85b949d = level.zombie_augments[ #"napalmburst_pyro" ].var_b257aef73527246a ?? 25;
        var_fdc5e4472f1e2a76 = getaiarrayinradius( self.origin, var_8c2fbdea85b949d );
        
        if ( !isdefined( level.napalmburst_augment_pyro ) )
        {
            level.napalmburst_augment_pyro = throttle::throttle_initialize( "napalmburst_augment_pyro", 1 );
        }
        
        foreach ( enemyai in var_fdc5e4472f1e2a76 )
        {
            if ( params.eattacker && utility::issharedfuncdefined( #"zm", #"hash_8e5cbc74839b479b" ) )
            {
                if ( !level [[ utility::getsharedfunc( #"zm", #"hash_8e5cbc74839b479b" ) ]]( params.eattacker, enemyai ) )
                {
                    continue;
                }
            }
            
            if ( isalive( enemyai ) && !enemyai zombie_utils::function_bf1464d09f4e4b40() )
            {
                throttle::throttle_wait_in_queue( level.napalmburst_augment_pyro, enemyai );
                enemyai.napalmburst_pyro_burned = 1;
                enemyai napalmburst::function_c4bcd20083d8d745( 0, params.eattacker, params.smeansofdeath, params.sweapon, params.vpoint, params.shitloc, params.modelindex, 1 );
            }
        }
    }
}

// Namespace napalmburst_augments
// Params 1
// Checksum 0xd72f6d04, Offset: 0xe24
// Size: 0x55
function function_70da5c01e16f5f82( params )
{
    if ( isagent( self ) )
    {
        self.napalmburst_incendiary_burnt = 0;
        wait 1;
        
        if ( isagent( self ) && self.var_39cae9e1bcaca810 )
        {
            self.var_39cae9e1bcaca810 = undefined;
            return;
        }
        
        if ( isagent( self ) )
        {
            self.napalmburst_proc_weapon = undefined;
        }
    }
}

