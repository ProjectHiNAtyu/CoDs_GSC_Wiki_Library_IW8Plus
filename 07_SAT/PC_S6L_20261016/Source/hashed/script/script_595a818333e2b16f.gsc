// script_595a818333e2b16f  (hash_595a818333e2b16f.gscc) (size: 1034 Bytes / 0x40a)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xb42ff15f (3023040863)
// size ...... 1034 (0x40a)
// includes .. 0   (offset: 0x3fe)
// strings ... 1   (offset: 0x3fe)
// dev strs .. 0   (offset: 0x40a)
// exports ... 5   (offset: 0x272)
// cseg ...... 0x5c + 0x216 (0x272)
// imports ... 7   (offset: 0x33a)
// animtree1 . 0   (offset: 0x40a)
// animtree2 . 0   (offset: 0x40a)
#namespace namespace_ccb8146258a62bd2;

// Namespace namespace_ccb8146258a62bd2
// Params 1
// Checksum 0xb3a3232, Offset: 0x7a
// Size: 0x58
function function_218c01c52fe77060( filenamerequested )
{
    if ( !isdefined( level.var_b0f4fb9a3d68600c ) )
    {
        level.var_b0f4fb9a3d68600c = [];
    }
    
    fileobject = function_12e6fda6de17696b( filenamerequested );
    
    if ( !isdefined( fileobject ) )
    {
        fileobject = function_6e82911d8566ac0c( filenamerequested );
        
        if ( fileobject )
        {
            function_45d594b2a943f769( filenamerequested, fileobject );
        }
    }
    
    return fileobject;
}

// Namespace namespace_ccb8146258a62bd2
// Params 2, eflags: 0x4
// Checksum 0x25e766c8, Offset: 0xdb
// Size: 0x61, Type: bool
function private function_45d594b2a943f769( filename, fileobject )
{
    if ( fileobject )
    {
        var_819221b33f80c3f6 = spawnstruct();
        var_819221b33f80c3f6.id = filename;
        var_819221b33f80c3f6.object = fileobject;
        level.var_b0f4fb9a3d68600c[ level.var_b0f4fb9a3d68600c.size ] = var_819221b33f80c3f6;
        return true;
    }
    
    return false;
}

// Namespace namespace_ccb8146258a62bd2
// Params 1, eflags: 0x4
// Checksum 0x48bf3044, Offset: 0x145
// Size: 0x99
function private function_12e6fda6de17696b( filerequested )
{
    foreach ( var_b43c6bcdd5d62876 in level.var_b0f4fb9a3d68600c )
    {
        if ( var_b43c6bcdd5d62876.id == filerequested )
        {
            return var_b43c6bcdd5d62876.object;
        }
    }
}

// Namespace namespace_ccb8146258a62bd2
// Params 1, eflags: 0x4
// Checksum 0xe38f435c, Offset: 0x1e7
// Size: 0x8a
function private function_6e82911d8566ac0c( filerequested )
{
    while ( level.var_4024fd7ea8e4c7d4 )
    {
        waitframe();
    }
    
    if ( function_82a2869de5339ee6( filerequested ) )
    {
        level.var_4024fd7ea8e4c7d4 = 1;
        filename = "";
        fileobject = undefined;
        succeed = 0;
        
        while ( filename != filerequested )
        {
            level waittill( #"hash_f380f91feee0abea", succeed, filename );
        }
        
        if ( succeed )
        {
            fileobject = function_d6a3470c4d6b4bc5();
        }
        
        level.var_4024fd7ea8e4c7d4 = 0;
        return fileobject;
    }
}

