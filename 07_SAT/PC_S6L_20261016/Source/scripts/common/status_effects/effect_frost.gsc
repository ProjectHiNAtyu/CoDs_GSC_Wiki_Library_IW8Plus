// scripts\common\status_effects\effect_frost.gsc  (hash_53a8a0e046082048.gscc) (size: 2618 Bytes / 0xa3a / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x3d967c2e (1033272366)
// size ...... 2618 (0xa3a)
// includes .. 2   (offset: 0x9a6)
// strings ... 5   (offset: 0x9b6)
// dev strs .. 2   (offset: 0xa1a)
// exports ... 8   (offset: 0x66e)
// cseg ...... 0x8e + 0x5e0 (0x66e)
// imports ... 16  (offset: 0x7ae)
// animtree1 . 0   (offset: 0xa3a)
// animtree2 . 0   (offset: 0xa3a)
#using scripts\common\status_effects\status_effects;
#using scripts\common\utility;

#namespace effect_frost;

// Namespace effect_frost
// Params 3
// Checksum 0x666e8424, Offset: 0xac
// Size: 0x9c
function frost( cause_id, move_speed_multiplier, endcallback )
{
    assert( isstring( cause_id ), "<dev string:x24>" );
    assert( isnumber( move_speed_multiplier ), "<dev string:x41>" );
    
    if ( isscriptedai( self ) )
    {
        return 0;
    }
    
    effect = status_effects::function_93edde8d0fe48bb6( "frost", -2, cause_id, &start_frost, &end_frost, "cold" );
    effect.move_speed_multiplier = move_speed_multiplier;
    effect.var_ec9eab1b0cf732fb = endcallback;
    return status_effects::function_3747671c47b03216( effect );
}

// Namespace effect_frost
// Params 1, eflags: 0x4
// Checksum 0x2921f89e, Offset: 0x151
// Size: 0x11c
function private start_frost( effect )
{
    var_ec5dc28f09d7fdcc = undefined;
    
    foreach ( effect in self.status_effects[ "frost" ] )
    {
        if ( !isdefined( var_ec5dc28f09d7fdcc ) || effect.move_speed_multiplier < var_ec5dc28f09d7fdcc.move_speed_multiplier )
        {
            var_ec5dc28f09d7fdcc = effect;
        }
    }
    
    if ( isdefined( var_ec5dc28f09d7fdcc ) && var_ec5dc28f09d7fdcc.move_speed_multiplier < 1 )
    {
        utility::callsharedfunc( #"weapons", #"hash_4ccf3b3fcf5ae366", var_ec5dc28f09d7fdcc.unique_id, var_ec5dc28f09d7fdcc.move_speed_multiplier );
        utility::callsharedfunc( #"weapons", #"updatemovespeedscale" );
    }
    
    utility::function_32b24db3127bff40( "frost_fx", "frost_on" );
}

// Namespace effect_frost
// Params 1, eflags: 0x4
// Checksum 0x90fc8a6, Offset: 0x275
// Size: 0x17d
function private end_frost( effect )
{
    if ( !( isdefined( self ) && isdefined( self.status_effects ) && isdefined( effect ) ) )
    {
        return;
    }
    
    utility::callsharedfunc( #"weapons", #"hash_4ccf3b3fcf5ae366", effect.unique_id, 1 );
    var_e832c152ed9fd7f6 = 1;
    return_unique_id = undefined;
    
    foreach ( var_c6321cb8cd32b6a0 in self.status_effects[ "frost" ] )
    {
        if ( var_c6321cb8cd32b6a0.move_speed_multiplier < var_e832c152ed9fd7f6 )
        {
            var_e832c152ed9fd7f6 = var_c6321cb8cd32b6a0.move_speed_multiplier;
            return_unique_id = var_c6321cb8cd32b6a0.unique_id;
        }
    }
    
    if ( return_unique_id )
    {
        utility::callsharedfunc( #"weapons", #"hash_4ccf3b3fcf5ae366", return_unique_id, var_e832c152ed9fd7f6 );
    }
    
    utility::callsharedfunc( #"weapons", #"updatemovespeedscale" );
    
    if ( isdefined( effect.var_ec9eab1b0cf732fb ) )
    {
        self [[ effect.var_ec9eab1b0cf732fb ]]();
    }
    
    if ( !is_frosted() )
    {
        utility::function_7c10ea82c1e305b8( "frost_fx", "frost_off" );
    }
}

// Namespace effect_frost
// Params 1
// Checksum 0x53cefe7, Offset: 0x3fa
// Size: 0xe0
function stop_frost( cause_id )
{
    assert( isstring( cause_id ), "<dev string:x24>" );
    
    if ( !( isdefined( self ) && isdefined( self.status_effects ) ) )
    {
        return;
    }
    
    if ( !isarray( self.status_effects[ "frost" ] ) )
    {
        return;
    }
    
    foreach ( var_c6321cb8cd32b6a0 in self.status_effects[ "frost" ] )
    {
        if ( cause_id == var_c6321cb8cd32b6a0.unique_id )
        {
            var_c6321cb8cd32b6a0.var_efcde2142240af7 = 1;
        }
    }
}

// Namespace effect_frost
// Params 0
// Checksum 0x5ea6d8f4, Offset: 0x4e2
// Size: 0xb2
function stop_all_frost()
{
    if ( !( isdefined( self ) && isdefined( self.status_effects ) ) )
    {
        return;
    }
    
    if ( !isarray( self.status_effects[ "frost" ] ) )
    {
        return;
    }
    
    foreach ( var_c6321cb8cd32b6a0 in self.status_effects[ "frost" ] )
    {
        var_c6321cb8cd32b6a0.end_time = -1;
    }
}

// Namespace effect_frost
// Params 0
// Checksum 0xce91611a, Offset: 0x59c
// Size: 0xd
function is_frosted()
{
    return status_effects::has_status_effect_type( "frost" );
}

// Namespace effect_frost
// Params 1
// Checksum 0x5c6f2477, Offset: 0x5b2
// Size: 0xbb, Type: bool
function has_frost( cause_id )
{
    assert( isstring( cause_id ), "<dev string:x24>" );
    
    if ( !status_effects::has_status_effect_type( "frost" ) )
    {
        return false;
    }
    
    foreach ( var_c6321cb8cd32b6a0 in self.status_effects[ "frost" ] )
    {
        if ( cause_id == var_c6321cb8cd32b6a0.unique_id )
        {
            return true;
        }
    }
    
    return false;
}

