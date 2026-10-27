// scripts\mp\augments\elemental_pop_augments.gsc  (hash_0cd0673e11f13ffb.gscc) (size: 5555 Bytes / 0x15b3 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x7b8dbbb3 (2072886195)
// size ...... 5555 (0x15b3)
// includes .. 8   (offset: 0x144b)
// strings ... 21  (offset: 0x148b)
// dev strs .. 0   (offset: 0x15b3)
// exports ... 13  (offset: 0xcaf)
// cseg ...... 0x1ef + 0xac0 (0xcaf)
// imports ... 48  (offset: 0xeb7)
// animtree1 . 0   (offset: 0x15b3)
// animtree2 . 0   (offset: 0x15b3)
#using script_16ea1b94f0f381b3;
#using scripts\common\ai\aitypes\shared\zombie\zombie_utils;
#using scripts\common\callbacks;
#using scripts\common\status_effects\effect_stun;
#using scripts\common\system;
#using scripts\common\throttle;
#using scripts\common\utility;
#using scripts\mp\equipment;

#namespace elemental_pop_augments;

// Namespace elemental_pop_augments
// Params 0, eflags: 0x5
// Checksum 0x6e3d2f0d, Offset: 0x20d
// Size: 0x19
function private autoexec __init__system__()
{
    system::register( #"elemental_pop_augments", undefined, undefined, &function_5096d11544eb171b );
}

// Namespace elemental_pop_augments
// Params 0
// Checksum 0x8141bade, Offset: 0x22e
// Size: 0x18
function function_5096d11544eb171b()
{
    if ( !level.zombie_augments_in_use )
    {
        return;
    }
    
    level thread function_144e4c70353af0d2();
}

// Namespace elemental_pop_augments
// Params 0
// Checksum 0xbb73b67d, Offset: 0x24e
// Size: 0xa0
function function_144e4c70353af0d2()
{
    if ( !level.zombie_augments_in_use )
    {
        return;
    }
    
    callback::add( "zm_perk_obtained", &function_288f120db5b6defb );
    callback::add( #"player_item_pickup", &on_item_pickup );
    callback::add( #"on_ai_killed", &elemental_pop_on_ai_killed );
    utility::registersharedfunc( #"zombie", #"hash_931449f5e45bb9e2", &function_b24ce1fab233a12 );
    utility::registersharedfunc( #"zombie", #"hash_844ec3842490d875", &is_equipment_proc );
    level._effect[ "elemental_equipment_proc" ] = loadfxasset( "vfx_perk_pdh_torso_burst" );
}

// Namespace elemental_pop_augments
// Params 1, eflags: 0x4
// Checksum 0x9ef56559, Offset: 0x2f6
// Size: 0x43
function private function_288f120db5b6defb( params )
{
    if ( utility::callsharedfunc( #"zombie", #"hash_3930894d8d2f0ee6", "specialty_elemental_pop", #"elemental_pop_electric_cherry" ) )
    {
        thread watchreload();
        thread function_f16232e20232bc2b();
    }
}

// Namespace elemental_pop_augments
// Params 0, eflags: 0x4
// Checksum 0xf178c6aa, Offset: 0x341
// Size: 0x123
function private watchreload()
{
    self endon( #"disconnect" );
    level endon( #"game_ended" );
    self endon( "specialty_elemental_pop" + "_stop" );
    self.var_da857539a11929b4 = 0;
    
    while ( true )
    {
        self waittill( #"reload_start" );
        
        if ( isplayer( self ) && isalive( self ) )
        {
            if ( !isdefined( self.last_electric_cherry ) )
            {
                self.last_electric_cherry = 0;
            }
            
            if ( !isdefined( self.electric_cherry_wait_on_reload ) )
            {
                self.electric_cherry_wait_on_reload = [];
            }
            
            current_weapon = self getcurrentweapon();
            
            if ( arraycontains( self.electric_cherry_wait_on_reload, current_weapon ) )
            {
                continue;
            }
            
            cooldowntime = utility::function_4b74c15943231980( level.zombie_augments[ #"elemental_pop_electric_cherry" ].cooldowntime );
            
            if ( gettime() > self.last_electric_cherry + cooldowntime )
            {
                self.var_da857539a11929b4 = 0;
            }
            
            self.electric_cherry_wait_on_reload = arraycombineunique( self.electric_cherry_wait_on_reload, [ current_weapon ] );
            self.var_da857539a11929b4++;
            thread function_6e336800c72a315c();
        }
    }
}

// Namespace elemental_pop_augments
// Params 0, eflags: 0x4
// Checksum 0x2a929589, Offset: 0x46c
// Size: 0x8d
function private function_f16232e20232bc2b()
{
    self endon( #"disconnect" );
    level endon( #"game_ended" );
    self endon( "specialty_elemental_pop" + "_stop" );
    
    while ( true )
    {
        self waittill( #"reload_ammo_added" );
        
        if ( isplayer( self ) )
        {
            if ( isarray( self.electric_cherry_wait_on_reload ) )
            {
                current_weapon = self getcurrentweapon();
                self.electric_cherry_wait_on_reload = utility::function_d751969553a4bddd( self.electric_cherry_wait_on_reload, current_weapon );
                self.last_electric_cherry = gettime();
            }
        }
    }
}

// Namespace elemental_pop_augments
// Params 1, eflags: 0x4
// Checksum 0x60e4d1b4, Offset: 0x501
// Size: 0xa3
function private on_item_pickup( params )
{
    if ( !isdefined( params.item.weaponobj ) )
    {
        return;
    }
    
    if ( isplayer( self ) )
    {
        if ( utility::callsharedfunc( #"zombie", #"hash_3930894d8d2f0ee6", "specialty_elemental_pop", #"elemental_pop_electric_cherry" ) )
        {
            if ( isarray( self.electric_cherry_wait_on_reload ) )
            {
                var_58445c6c78ac9ddf = params.item.weaponobj;
                self.electric_cherry_wait_on_reload = utility::function_d751969553a4bddd( self.electric_cherry_wait_on_reload, var_58445c6c78ac9ddf );
            }
        }
    }
}

// Namespace elemental_pop_augments
// Params 0, eflags: 0x4
// Checksum 0x18b23336, Offset: 0x5ac
// Size: 0x45b
function private function_6e336800c72a315c()
{
    self endon( #"disconnect" );
    level endon( #"game_ended" );
    
    if ( !isplayer( self ) )
    {
        return;
    }
    
    damagemax = level.zombie_augments[ #"elemental_pop_electric_cherry" ].electriccherrymaxdamage;
    damagemin = level.zombie_augments[ #"elemental_pop_electric_cherry" ].electriccherrymindamage;
    radiusmax = level.zombie_augments[ #"elemental_pop_electric_cherry" ].var_af9fe7a63afa4398;
    radiusmin = level.zombie_augments[ #"elemental_pop_electric_cherry" ].var_afc3dda63b22a852;
    weapon = self getcurrentweapon();
    currentammo = self getcurrentweaponclipammo();
    maxammo = weaponclipsize( weapon );
    
    if ( maxammo <= 0 )
    {
        return;
    }
    
    var_361f9c4ebf7a714f = 1 - currentammo / maxammo;
    clamp( var_361f9c4ebf7a714f, 0, 1 );
    var_5d05503c69d97725 = mapfloat( 0, 1, radiusmin, radiusmax, var_361f9c4ebf7a714f );
    var_ebcc90c69d045cb1 = mapfloat( 0, 1, damagemin, damagemax, var_361f9c4ebf7a714f );
    radius = var_5d05503c69d97725;
    ai_array = getaiarrayinradius( self.origin, radius );
    stun_duration = level.zombie_augments[ #"elemental_pop_electric_cherry" ].electriccherrystunduration;
    var_1750e29c4552e157 = 0;
    
    switch ( self.var_da857539a11929b4 )
    {
        case 0:
        case 1:
            var_1750e29c4552e157 = undefined;
            break;
        case 2:
            var_1750e29c4552e157 = 8;
            break;
        case 3:
            var_1750e29c4552e157 = 4;
            break;
        case 4:
            var_1750e29c4552e157 = 2;
            break;
        default:
            var_1750e29c4552e157 = 0;
            break;
    }
    
    if ( self.var_da857539a11929b4 <= 4 )
    {
        utility::function_32b24db3127bff40( "electric_cherry_fx", "electric_cherry_fx_on" );
        self playsoundonmovingent( #"hash_c78df0e50556dec7" );
    }
    
    foreach ( index, enemy in ai_array )
    {
        if ( !isagent( enemy ) || !isalive( enemy ) )
        {
            continue;
        }
        
        if ( index >= var_1750e29c4552e157 )
        {
            continue;
        }
        
        if ( utility::issharedfuncdefined( #"game", #"hash_1e485ee80b4faab7" ) && isdefined( enemy.aicategory ) )
        {
            var_ebcc90c69d045cb1 = [[ utility::getsharedfunc( #"game", #"hash_1e485ee80b4faab7" ) ]]( var_ebcc90c69d045cb1, namespace_9d8e359c3b1041e5::function_57de0ca2e80536a1( self.origin ), #"hash_2997dbc56f363f39", enemy.aicategory, undefined, undefined );
        }
        
        if ( !isdefined( level.electric_cherry_throttle ) )
        {
            level.electric_cherry_throttle = throttle::throttle_initialize( "electric_cherry_throttle", 1 );
        }
        
        level throttle::throttle_wait_in_queue( level.electric_cherry_throttle, enemy );
        
        if ( isalive( enemy ) && enemy.health - var_ebcc90c69d045cb1 <= 0 )
        {
            enemy.electric_cherry_kill = 1;
        }
        
        if ( enemy.aicategory == "normal" && !enemy zombie_utils::function_bf1464d09f4e4b40() )
        {
            enemy namespace_f4f7019540228268::stun( "electric_cherry", stun_duration, self, undefined, undefined, "electrical" );
        }
        
        enemy dodamage( var_ebcc90c69d045cb1, enemy.origin, self, self, "MOD_ELEMENTAL_ELEC", "<explicitweaponnone>", "none", undefined, 65536 );
        chance = level.zombie_augments[ #"elemental_pop_electric_cherry" ].var_152f186928756d4;
        callback::callback( "shocked" );
        enemy utility::function_32b24db3127bff40( "shocked_lightning_electric_cherry", "shocked_on" );
        enemy thread function_a58ad5a4586df87c( stun_duration );
    }
    
    wait 1.5;
    utility::function_32b24db3127bff40( "electric_cherry_fx", "electric_cherry_fx_off" );
}

// Namespace elemental_pop_augments
// Params 1, eflags: 0x4
// Checksum 0x4f8750db, Offset: 0xa0f
// Size: 0x2c
function private function_a58ad5a4586df87c( duration )
{
    self endon( #"death" );
    wait duration;
    utility::function_32b24db3127bff40( "shocked_lightning_electric_cherry", "shocked_off" );
}

// Namespace elemental_pop_augments
// Params 2
// Checksum 0xf68712ac, Offset: 0xa43
// Size: 0x36
function function_b24ce1fab233a12( chance, weapon )
{
    chance = level.zombie_augments[ #"elemental_pop_elemental_equipment" ].var_bed21b6f8f805e59;
    return chance;
}

// Namespace elemental_pop_augments
// Params 1
// Checksum 0xd41e8243, Offset: 0xa82
// Size: 0x7c, Type: bool
function is_equipment_proc( weapon )
{
    if ( isweapon( weapon ) )
    {
        weaponref = undefined;
        
        if ( utility::issharedfuncdefined( #"equipment", #"getequipmentreffromweapon" ) )
        {
            weaponref = [[ utility::getsharedfunc( #"equipment", #"getequipmentreffromweapon" ) ]]( weapon );
        }
        
        if ( isdefined( weaponref ) )
        {
            if ( equipment_mp::isequipmentlethal( weaponref ) || equipment_mp::isequipmenttactical( weaponref ) )
            {
                return true;
            }
        }
    }
    
    return false;
}

// Namespace elemental_pop_augments
// Params 1, eflags: 0x4
// Checksum 0x4969f5c4, Offset: 0xb07
// Size: 0x1a8
function private elemental_pop_on_ai_killed( sparams )
{
    if ( isplayer( sparams.eattacker ) && sparams.eattacker utility::callsharedfunc( #"zombie", #"hash_3930894d8d2f0ee6", "specialty_elemental_pop", #"elemental_pop_refresh_mint" ) )
    {
        if ( self.aicategory == "special" || self.aicategory == "elite" )
        {
            currentcooldown = 0;
            cooldownmult = level.perkbundles[ "specialty_elemental_pop" ].var_54d8132e73b1be17 ?? 2;
            
            if ( isdefined( sparams.eattacker.var_9db3c6b649ecf485 ) )
            {
                currentcooldown = level.ammo_mods[ sparams.eattacker.var_9db3c6b649ecf485 ].var_d8565ba5d24b8a01;
            }
            
            cooldown = cooldownmult * currentcooldown;
            
            if ( cooldown < level.perkbundles[ "specialty_elemental_pop" ].var_8b4c0ca328de0b6d )
            {
                cooldown = level.perkbundles[ "specialty_elemental_pop" ].var_8b4c0ca328de0b6d;
            }
            
            if ( sparams.eattacker utility::callsharedfunc( #"zombie", #"hash_3930894d8d2f0ee6", "specialty_elemental_pop", #"elemental_pop_more_pop" ) )
            {
                cooldown -= cooldown * level.zombie_augments[ #"elemental_pop_more_pop" ].var_10fca521ede5ea4e;
            }
            
            sparams.eattacker.var_436d1d31c48df750 = 0;
        }
    }
}

