// scripts\common\interactive.gsc  (hash_6318547a70575ae4.gscc) (size: 1653 Bytes / 0x675 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x3c075784 (1007114116)
// size ...... 1653 (0x675)
// includes .. 0   (offset: 0x5e5)
// strings ... 12  (offset: 0x5e5)
// dev strs .. 0   (offset: 0x675)
// exports ... 7   (offset: 0x495)
// cseg ...... 0x16d + 0x328 (0x495)
// imports ... 2   (offset: 0x5ad)
// animtree1 . 0   (offset: 0x675)
// animtree2 . 0   (offset: 0x675)
#namespace interactive;

// Namespace interactive/entity_used
// Params 2, eflags: 0x20
// Checksum 0x326c6602, Offset: 0x18b
// Size: 0x70
function event_handler[entity_used] entity_used( entity, player )
{
    profilestart();
    
    if ( !isdefined( entity.interactive_used_func_id ) )
    {
        profilestop();
        return;
    }
    
    if ( !isdefined( level.interactive_used_funcs ) )
    {
        profilestop();
        return;
    }
    
    if ( !isdefined( level.interactive_used_funcs[ entity.interactive_used_func_id ] ) )
    {
        profilestop();
        return;
    }
    
    thread [[ level.interactive_used_funcs[ entity.interactive_used_func_id ] ]]( entity, player );
    profilestop();
}

// Namespace interactive
// Params 2
// Checksum 0xb6362b23, Offset: 0x203
// Size: 0x87
function interactive_addusedcallback( usedcallback, id )
{
    if ( !isdefined( level.interactive_used_funcs ) )
    {
        level.interactive_used_funcs = [];
        level.interactive_used_funcs_unique_id = 0;
    }
    
    if ( !isdefined( id ) )
    {
        while ( isdefined( level.interactive_used_funcs[ level.interactive_used_funcs_unique_id ] ) )
        {
            level.interactive_used_funcs_unique_id++;
        }
        
        id = level.interactive_used_funcs_unique_id;
        level.interactive_used_funcs_unique_id++;
    }
    
    level.interactive_used_funcs[ id ] = usedcallback;
    return id;
}

// Namespace interactive
// Params 1
// Checksum 0x83461e20, Offset: 0x293
// Size: 0x17
function interactive_addusedcallbacktoentity( id )
{
    self.interactive_used_func_id = id;
}

// Namespace interactive
// Params 0
// Checksum 0x88e5780f, Offset: 0x2b2
// Size: 0xc
function interactive_removeusedcallbackfromentity()
{
    self.interactive_used_func_id = undefined;
}

// Namespace interactive
// Params 2
// Checksum 0xc14c74c6, Offset: 0x2c6
// Size: 0x182
function function_bb62c739af2034bc( usable, player )
{
    if ( isdefined( usable.interact_hint_callback ) )
    {
        result = [[ usable.interact_hint_callback ]]( usable, player );
        
        if ( !isstruct( result ) || !isdefined( result.type ) || !( isdefined( result.string ) || isdefined( result.title ) ) )
        {
            message = "Result struct information is missing from interact hint callback. ";
            
            if ( !isdefined( result ) )
            {
                message += "Result is not defined.";
            }
            else
            {
                message += "type=" + result.type;
                message += ", string=" + result.string;
                message += ", title=" + result.title;
            }
            
            if ( !usable )
            {
                message += ", Usable is undefined.";
            }
            else
            {
                message += ", Usable type=" + usable.type;
                message += ", Usable icon=" + usable.icon;
                message += ", Usable model=" + usable.model;
                message += ", Usable origin=" + usable.origin;
            }
            
            if ( !player )
            {
                message += ", Player is undefined.";
            }
            else
            {
                message += ", Player origin=" + player.origin;
            }
            
            assertmsg( message );
        }
        
        return result;
    }
}

// Namespace interactive
// Params 2
// Checksum 0xd2dc7b85, Offset: 0x451
// Size: 0x43
function function_c4873dab195cf2fb( usable, player )
{
    if ( isdefined( usable.var_1e6940caec363c36 ) )
    {
        result = [[ usable.var_1e6940caec363c36 ]]( usable, player );
        return result;
    }
}

