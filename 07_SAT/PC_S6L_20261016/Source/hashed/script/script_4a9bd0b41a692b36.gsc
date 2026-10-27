// script_4a9bd0b41a692b36  (hash_4a9bd0b41a692b36.gscc) (size: 1352 Bytes / 0x548 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xf0bfd858 (4039104600)
// size ...... 1352 (0x548)
// includes .. 1   (offset: 0x540)
// strings ... 0   (offset: 0x548)
// dev strs .. 0   (offset: 0x548)
// exports ... 4   (offset: 0x310)
// cseg ...... 0x58 + 0x2b8 (0x310)
// imports ... 14  (offset: 0x3b0)
// animtree1 . 0   (offset: 0x548)
// animtree2 . 0   (offset: 0x548)
#using scripts\common\utility;

#namespace namespace_596a3d95ffe56af7;

// Namespace namespace_596a3d95ffe56af7
// Params 0, eflags: 0x1
// Checksum 0xe9b23aae, Offset: 0x76
// Size: 0x20
function autoexec main()
{
    utility::registersharedfunc( #"targetfinder", #"hash_d2ecc9c85468418f", &function_24d07d29a457f399 );
}

// Namespace namespace_596a3d95ffe56af7
// Params 2, eflags: 0x4
// Checksum 0x85c15b5, Offset: 0x9e
// Size: 0x1e3
function private function_24d07d29a457f399( enemies, var_30193c348faeb4e1 )
{
    if ( !self.var_53daf58b22e23e03 )
    {
        self.var_53daf58b22e23e03 = 1;
        thread function_9d65a41a6b196449();
    }
    
    if ( !isarray( self.var_a2cdb3d1626a9cbd ) )
    {
        return enemies;
    }
    
    if ( var_30193c348faeb4e1.size >= 10 )
    {
        return enemies;
    }
    
    result = [];
    
    foreach ( ent in enemies )
    {
        if ( var_30193c348faeb4e1[ ent.entnum ?? utility::get_entity_number( ent ) ] )
        {
            var_30193c348faeb4e1[ ent.entnum ] = ent;
        }
    }
    
    ai_array = self.var_a2cdb3d1626a9cbd;
    
    if ( ai_array.size == 0 )
    {
        return result;
    }
    
    max_add = int( max( 0, 10 - result.size ) );
    
    if ( ai_array.size <= max_add )
    {
        random_ai = ai_array;
    }
    else
    {
        random_ai = utility::array_random_slice( ai_array, max_add );
    }
    
    foreach ( ai in random_ai )
    {
        if ( !isdefined( result[ ai.entnum ?? utility::get_entity_number( ai ) ] ) )
        {
            result[ ai.entnum ] = ai;
        }
    }
    
    return result;
}

// Namespace namespace_596a3d95ffe56af7
// Params 0, eflags: 0x4
// Checksum 0xa911a970, Offset: 0x28a
// Size: 0x86
function private function_9d65a41a6b196449()
{
    level endon( #"game_end" );
    self endon( #"death_or_disconnect" );
    waitframe();
    
    if ( self )
    {
        eye_pos = self getvieworigin();
        eye_angles = self getgunangles();
        ai_array = getaiarrayinradius( eye_pos + anglestoforward( eye_angles ) * 2000 * 0.45, 2000 );
    }
    
    waitframe();
    
    if ( self )
    {
        ai_array = sortbydistance( ai_array, eye_pos );
        self.var_a2cdb3d1626a9cbd = ai_array;
        self.var_53daf58b22e23e03 = 0;
    }
}

