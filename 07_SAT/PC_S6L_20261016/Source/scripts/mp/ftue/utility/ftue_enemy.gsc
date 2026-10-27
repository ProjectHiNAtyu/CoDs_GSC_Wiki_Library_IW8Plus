// scripts\mp\ftue\utility\ftue_enemy.gsc  (hash_3f3c7170aedfefd7.gscc) (size: 1911 Bytes / 0x777 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x23a2107f (597823615)
// size ...... 1911 (0x777)
// includes .. 2   (offset: 0x743)
// strings ... 3   (offset: 0x753)
// dev strs .. 0   (offset: 0x777)
// exports ... 8   (offset: 0x4f3)
// cseg ...... 0xa7 + 0x44c (0x4f3)
// imports ... 9   (offset: 0x633)
// animtree1 . 0   (offset: 0x777)
// animtree2 . 0   (offset: 0x777)
#using scripts\common\utility;
#using scripts\mp\ftue\utility\ftue_camera;

#namespace ftue_enemy;

// Namespace ftue_enemy
// Params 1
// Checksum 0xa9a255cc, Offset: 0xc5
// Size: 0x37
function function_ce599a01d4e10939( callback )
{
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    self waittill( #"hash_ff569078340e8cc2" );
    self [[ callback ]]();
}

// Namespace ftue_enemy
// Params 3
// Checksum 0x8f12475e, Offset: 0x104
// Size: 0xc3
function function_881bf60afbf4f8d2( delta, callback, onlybots )
{
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    
    foreach ( enemy in level.players )
    {
        if ( onlybots )
        {
            if ( !isbot( enemy ) )
            {
                continue;
            }
        }
        
        function_cdf8209cee254414( enemy, delta, callback );
    }
}

// Namespace ftue_enemy
// Params 3
// Checksum 0xa804006b, Offset: 0x1cf
// Size: 0xed
function function_cdf8209cee254414( enemy, delta, callback )
{
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    self endon( #"hash_53ec9f3d22255466" );
    self.var_584e86531718eb52 = callback;
    
    if ( !isalliedsentient( self, enemy ) )
    {
        foreach ( item in enemy.var_d5e836adfb09a0ef )
        {
            if ( !isdefined( item ) )
            {
                continue;
            }
            
            childthread ftue_camera::function_7c311fa7c48e8381( item.origin, delta, &function_60388fa5ccb58ff0 );
        }
    }
}

// Namespace ftue_enemy
// Params 2
// Checksum 0x71d952b8, Offset: 0x2c4
// Size: 0xb9
function function_d571f29fec698d6e( callback, onlybots )
{
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    
    foreach ( enemy in level.players )
    {
        if ( onlybots )
        {
            if ( !isbot( enemy ) )
            {
                continue;
            }
        }
        
        function_43a36afe8d63fa08( enemy, callback );
    }
}

// Namespace ftue_enemy
// Params 2
// Checksum 0x8d7836d, Offset: 0x385
// Size: 0xbe
function function_43a36afe8d63fa08( enemy, callback )
{
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    
    if ( !isalliedsentient( self, enemy ) )
    {
        foreach ( item in enemy.var_d5e836adfb09a0ef )
        {
            if ( !isdefined( item ) )
            {
                continue;
            }
            
            thread function_9f7617e8618a5067( item, callback );
        }
    }
}

// Namespace ftue_enemy
// Params 0
// Checksum 0x8e91ed19, Offset: 0x44b
// Size: 0x33
function function_60388fa5ccb58ff0()
{
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    self [[ self.var_584e86531718eb52 ]]();
    self notify( #"hash_53ec9f3d22255466" );
}

// Namespace ftue_enemy
// Params 2
// Checksum 0x288af187, Offset: 0x486
// Size: 0x6d
function function_9f7617e8618a5067( item, callback )
{
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    self endon( #"hash_31edcd8fb3f7e756" );
    utility::waittill_any( "self_pickedupitem_plunder", "self_pickedupitem_weapon", "self_pickedupitem_" + item.type );
    self [[ callback ]]();
    self notify( #"hash_31edcd8fb3f7e756" );
}

