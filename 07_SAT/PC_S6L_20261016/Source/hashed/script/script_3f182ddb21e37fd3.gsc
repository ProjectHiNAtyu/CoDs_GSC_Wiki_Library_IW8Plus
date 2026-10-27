// script_3f182ddb21e37fd3  (hash_3f182ddb21e37fd3.gscc) (size: 1923 Bytes / 0x783)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xa9210fa2 (2837516194)
// size ...... 1923 (0x783)
// includes .. 0   (offset: 0x743)
// strings ... 5   (offset: 0x743)
// dev strs .. 0   (offset: 0x783)
// exports ... 7   (offset: 0x4f7)
// cseg ...... 0x103 + 0x3f4 (0x4f7)
// imports ... 10  (offset: 0x60f)
// animtree1 . 0   (offset: 0x783)
// animtree2 . 0   (offset: 0x783)
#namespace namespace_3637061638c5e37a;

// Namespace namespace_3637061638c5e37a/gsc_rpc
// Params 1, eflags: 0x20
// Checksum 0xea73626a, Offset: 0x121
// Size: 0x148
function event_handler[gsc_rpc] rpc( rpc_params )
{
    if ( !isdefined( rpc_params.func_name ) || rpc_params.func_name == "" )
    {
        rpc_handleerror( rpc_params.id, 11, "No RPC function specified in the request, make sure the request has the func attribute" );
        return;
    }
    
    key = tolower( rpc_params.func_name );
    function_index = function_d55ddfb245d0337e( key );
    
    if ( !isdefined( function_index ) )
    {
        rpc_handleerror( rpc_params.id, 12, "Requested function -->" + rpc_params.func_name + "<-- is not found in the registered list" );
        return;
    }
    
    func = level.rpc.function_pointers[ function_index ];
    
    if ( rpc_params.nargs == 0 )
    {
        res = [[ func ]]();
    }
    else
    {
        res = [[ func ]]( rpc_params );
    }
    
    if ( !isdefined( res ) )
    {
        res = "";
    }
    
    if ( isstruct( res ) && isdefined( res.error ) )
    {
        function_8f0d9d60a5d9f985( rpc_params.id, res.error );
        return;
    }
    
    function_452481af837a3feb( rpc_params.id, res );
}

// Namespace namespace_3637061638c5e37a
// Params 3
// Checksum 0xe80e0f4b, Offset: 0x271
// Size: 0x10f
function function_6b8b68fa6ee6a023( function_name, function_pointer, function_category = "core" )
{
    if ( !level.rpc )
    {
        level.rpc = { #function_categories:[], #function_pointers:[], #function_names:[] };
    }
    
    func_name = tolower( function_name );
    function_index = function_d55ddfb245d0337e( func_name );
    
    if ( !isdefined( function_index ) )
    {
        level.rpc.function_names[ level.rpc.function_names.size ] = func_name;
        level.rpc.function_pointers[ level.rpc.function_pointers.size ] = function_pointer;
        level.rpc.function_categories[ level.rpc.function_categories.size ] = tolower( function_category );
    }
}

// Namespace namespace_3637061638c5e37a
// Params 1, eflags: 0x4
// Checksum 0x5b179d89, Offset: 0x388
// Size: 0x90
function private function_d55ddfb245d0337e( function_name )
{
    foreach ( index, registered_function in level.rpc.function_names )
    {
        if ( registered_function == function_name )
        {
            return index;
        }
    }
}

// Namespace namespace_3637061638c5e37a
// Params 2
// Checksum 0x91db4675, Offset: 0x420
// Size: 0x3c
function function_8ecfff37b1877ba2( error_id, error_message )
{
    res = spawnstruct();
    res.error = function_8cf0344f785bb62f( error_id, error_message );
    return res;
}

// Namespace namespace_3637061638c5e37a
// Params 2, eflags: 0x4
// Checksum 0x2dc6e958, Offset: 0x465
// Size: 0x43
function private function_8cf0344f785bb62f( error_id, error_message )
{
    error_struct = spawnstruct();
    error_struct.error_id = error_id;
    error_struct.message = error_message;
    return error_struct;
}

// Namespace namespace_3637061638c5e37a
// Params 3, eflags: 0x4
// Checksum 0xfc463be5, Offset: 0x4b1
// Size: 0x46
function private rpc_handleerror( id, error_id, error_message )
{
    assert( 0, error_message );
    error_res = function_8cf0344f785bb62f( error_id, error_message );
    function_8f0d9d60a5d9f985( id, error_res );
}

