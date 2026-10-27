// scripts\common\smoke_manager.gsc  (hash_22b3a91b7876e671.gscc) (size: 2152 Bytes / 0x868 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x8934d0db (2301939931)
// size ...... 2152 (0x868)
// includes .. 2   (offset: 0x858)
// strings ... 0   (offset: 0x868)
// dev strs .. 0   (offset: 0x868)
// exports ... 10  (offset: 0x4a0)
// cseg ...... 0x58 + 0x448 (0x4a0)
// imports ... 19  (offset: 0x630)
// animtree1 . 0   (offset: 0x868)
// animtree2 . 0   (offset: 0x868)
#using scripts\common\callbacks;
#using scripts\common\utility;

#namespace smoke_manager;

// Namespace smoke_manager
// Params 0, eflags: 0x1
// Checksum 0x1d7ffd2a, Offset: 0x76
// Size: 0xc2
function autoexec init()
{
    level.var_763ad2b0eb339897 = { #instances:[], #var_cc7c9aaf61d3ac7e:0 };
    utility::registersharedfunc( #"smokemanager", #"hash_93bde91ae637affe", &function_18fda9b7bb634ebb );
    utility::registersharedfunc( #"smokemanager", #"register", &function_88fd520d1945a12e );
    utility::registersharedfunc( #"smokemanager", #"hash_8f0ee43079ae77e3", &function_56a8a7978fb489a7 );
    utility::registersharedfunc( #"smokemanager", #"hash_eee3d7a747ac525b", &function_45c992f6d2919b50 );
    callback::add( #"hash_68c2b2b3fda7e07f", &function_e55a1198880dd219 );
    callback::add( #"playerexitsmoke", &function_cf400fb2d65013e7 );
}

// Namespace smoke_manager
// Params 0
// Checksum 0x14dcb5a0, Offset: 0x140
// Size: 0x11, Type: bool
function function_18fda9b7bb634ebb()
{
    return !getdvarint( @"hash_938142be8a80a7cd", 0 );
}

// Namespace smoke_manager
// Params 0, eflags: 0x4
// Checksum 0x5e53e321, Offset: 0x15a
// Size: 0x3a
function private function_7c7b1508d2d1faae()
{
    id = level.var_763ad2b0eb339897.var_cc7c9aaf61d3ac7e + 1;
    level.var_763ad2b0eb339897.var_cc7c9aaf61d3ac7e++;
    return id;
}

// Namespace smoke_manager
// Params 6
// Checksum 0xf12a30b5, Offset: 0x19d
// Size: 0x111
function function_88fd520d1945a12e( trigger, origin, radius, height, lifetime, id = function_7c7b1508d2d1faae() )
{
    endtime = lifetime ? gettime() + lifetime : undefined;
    level.var_763ad2b0eb339897.instances[ id ] = { #endtime:endtime, #height:height ?? trigger.height, #radius:radius ?? trigger.radius, #origin:origin ?? trigger.origin, #trigger:trigger };
    trigger.smokeid = id;
    callback::callback( #"smoke_spawned", level.var_763ad2b0eb339897.instances[ id ] );
    return id;
}

// Namespace smoke_manager
// Params 1
// Checksum 0xf862558f, Offset: 0x2b7
// Size: 0x55
function function_56a8a7978fb489a7( var_e784cb75d3521446 )
{
    if ( !isdefined( var_e784cb75d3521446 ) )
    {
        return;
    }
    
    id = isnumber( var_e784cb75d3521446 ) ? var_e784cb75d3521446 : var_e784cb75d3521446.smokeid;
    
    if ( isdefined( id ) )
    {
        level.var_763ad2b0eb339897.instances[ id ] = undefined;
    }
}

// Namespace smoke_manager
// Params 1
// Checksum 0xa8c5a2c8, Offset: 0x314
// Size: 0xea, Type: bool
function function_45c992f6d2919b50( pos )
{
    timestamp = gettime();
    
    foreach ( id, asmoke in level.var_763ad2b0eb339897.instances )
    {
        if ( asmoke.endtime && timestamp > asmoke.endtime || !asmoke.trigger )
        {
            function_56a8a7978fb489a7( id );
            continue;
        }
        
        if ( ispointinvolume( pos, asmoke.trigger, 1 ) )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace smoke_manager
// Params 1
// Checksum 0x47f96632, Offset: 0x407
// Size: 0x36
function function_e55a1198880dd219( params )
{
    if ( params.bundle.var_9e40ef6aa8652378 )
    {
        params.player clearplayerburning();
    }
}

// Namespace smoke_manager
// Params 1
// Checksum 0xaf0dbeaf, Offset: 0x445
// Size: 0xc
function function_cf400fb2d65013e7( params )
{
    
}

// Namespace smoke_manager
// Params 1
// Checksum 0x1d617d3b, Offset: 0x459
// Size: 0x47
function clearplayerburning( immediate )
{
    utility::callsharedfunc( #"molotov", #"clearplayerburning", immediate );
    utility::callsharedfunc( #"napalm_strike", #"hash_50a3e263ce95377", 0.1, 1 );
}

