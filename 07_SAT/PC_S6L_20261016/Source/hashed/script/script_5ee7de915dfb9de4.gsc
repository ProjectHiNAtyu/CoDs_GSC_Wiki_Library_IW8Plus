// script_5ee7de915dfb9de4  (hash_5ee7de915dfb9de4.gscc) (size: 2725 Bytes / 0xaa5 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x122af98 (19050392)
// size ...... 2725 (0xaa5)
// includes .. 3   (offset: 0xa2d)
// strings ... 8   (offset: 0xa45)
// dev strs .. 0   (offset: 0xaa5)
// exports ... 11  (offset: 0x5c5)
// cseg ...... 0x14b + 0x47a (0x5c5)
// imports ... 22  (offset: 0x77d)
// animtree1 . 0   (offset: 0xaa5)
// animtree2 . 0   (offset: 0xaa5)
#using scripts\common\ai;
#using scripts\common\utility;
#using scripts\mp\ai_behavior;

#namespace namespace_c522e27d9c6b70c9;

// Namespace namespace_c522e27d9c6b70c9
// Params 3
// Checksum 0xd34e1e65, Offset: 0x169
// Size: 0x99
function function_e875f085e6e6363b( guy, useinplace, var_352241c1dec9c073 )
{
    if ( !isalive( guy ) )
    {
        printerror( "Armor plate guy passed in undefined or dead!?" );
        return;
    }
    
    id = undefined;
    
    if ( useinplace )
    {
        id = guy function_82c4f276db9917d();
    }
    else
    {
        guy endon( #"death" );
        guy ai_behavior::function_52624f664c165308( guy );
        
        if ( !isdefined( var_352241c1dec9c073 ) )
        {
            var_352241c1dec9c073 = 5;
        }
        
        guy thread function_1c45d7ae620bd971( self, var_352241c1dec9c073 );
        self waittill( #"hash_6845994ba4ea8a79" );
        id = guy function_82c4f276db9917d();
    }
    
    return id;
}

// Namespace namespace_c522e27d9c6b70c9
// Params 2
// Checksum 0x4b419a75, Offset: 0x20b
// Size: 0x1e3
function function_a4e32abcc0e367d4( dyingguy, helper )
{
    if ( !isalive( dyingguy ) )
    {
        printerror( "Dying guy passed in undefined or dead!?" );
        return;
    }
    
    if ( dyingguy utility::doinglongdeath() )
    {
        return dyingguy getinteractionid();
    }
    
    var_759c7a2961dbeb3a = dyingguy.var_38a06ee92c60ee9e;
    skippingcrawl = 0;
    skippingintro = 0;
    
    if ( isdefined( helper ) )
    {
        var_cd049ee24cdd37fb = function_91a3f1d0865308eb();
        
        if ( !isdefined( var_cd049ee24cdd37fb ) )
        {
            printerror( "AI Code Bhvr bundle not found!" );
            return;
        }
        
        interactionname = var_cd049ee24cdd37fb.airevival;
        interactionid = spawninteraction( interactionname, dyingguy.origin, dyingguy.angles );
        
        if ( isdefined( interactionid ) )
        {
            function_6af2641d7a4923c6( dyingguy );
            dyingguy.var_38a06ee92c60ee9e = 0;
            dyingguy ai::function_f87586c8c1aaa78d( skippingcrawl, skippingintro );
            timeout = gettime() + 1000;
            
            while ( dyingguy.longdeathstarting && timeout > gettime() )
            {
                waitframe();
            }
            
            dyingguy.var_38a06ee92c60ee9e = 1;
            dyingguy function_895b16b8fcd857ba( interactionid, "dying_guy" );
            helper function_895b16b8fcd857ba( interactionid );
            dyingguy thread function_56893e3341aad847( var_759c7a2961dbeb3a );
            dyingguy thread function_c9fbc5fb08511c15( interactionid );
        }
        else
        {
            printerror( "cannot spawn revival interaction" );
        }
        
        return interactionid;
    }
    
    dyingguy.var_38a06ee92c60ee9e = 1;
    dyingguy ai::function_f87586c8c1aaa78d( skippingcrawl, skippingintro );
    timeout = gettime() + 2000;
    
    while ( !isdefined( dyingguy getinteractionid() ) && timeout > gettime() )
    {
        waitframe();
    }
    
    intid = dyingguy getinteractionid();
    
    if ( isdefined( intid ) )
    {
        dyingguy thread function_56893e3341aad847( var_759c7a2961dbeb3a );
    }
    else
    {
        dyingguy.var_38a06ee92c60ee9e = var_759c7a2961dbeb3a;
    }
    
    return intid;
}

// Namespace namespace_c522e27d9c6b70c9
// Params 0, eflags: 0x4
// Checksum 0x5f38f8c3, Offset: 0x3f6
// Size: 0x87
function private function_82c4f276db9917d()
{
    var_cd049ee24cdd37fb = function_91a3f1d0865308eb();
    
    if ( !isdefined( var_cd049ee24cdd37fb ) )
    {
        printerror( "Undefined Bundle" );
        return;
    }
    
    interactionname = var_cd049ee24cdd37fb.soloarmorplate;
    interactionid = spawninteraction( interactionname, self.origin, self.angles );
    
    if ( isdefined( interactionid ) )
    {
        self function_895b16b8fcd857ba( interactionid );
        thread function_1196eafd8cfe449b( interactionid );
    }
    else
    {
        printerror( "cannot spawn armor plate interaction" );
    }
    
    return interactionid;
}

// Namespace namespace_c522e27d9c6b70c9
// Params 1, eflags: 0x4
// Checksum 0x905890a0, Offset: 0x486
// Size: 0x20
function private function_1196eafd8cfe449b( id )
{
    self waittill( #"hash_d88e44832873b6d8" );
    despawninteraction( id );
}

// Namespace namespace_c522e27d9c6b70c9
// Params 1, eflags: 0x4
// Checksum 0x3f9320cc, Offset: 0x4ae
// Size: 0x20
function private function_c9fbc5fb08511c15( id )
{
    self waittill( #"end_revival" );
    despawninteraction( id );
}

// Namespace namespace_c522e27d9c6b70c9
// Params 1, eflags: 0x4
// Checksum 0x23607c8, Offset: 0x4d6
// Size: 0x24
function private function_56893e3341aad847( var_759c7a2961dbeb3a )
{
    self waittill( #"cap_exit_completed" );
    self.var_38a06ee92c60ee9e = var_759c7a2961dbeb3a;
}

// Namespace namespace_c522e27d9c6b70c9
// Params 2, eflags: 0x4
// Checksum 0xc586440e, Offset: 0x502
// Size: 0x4c
function private function_1c45d7ae620bd971( levelscr, timeout )
{
    self endon( #"death" );
    utility::waittill_any_timeout( timeout, "goal" );
    
    while ( self.arriving )
    {
        waitframe();
    }
    
    levelscr notify( #"hash_6845994ba4ea8a79" );
}

// Namespace namespace_c522e27d9c6b70c9
// Params 1, eflags: 0x4
// Checksum 0xd9592fe1, Offset: 0x556
// Size: 0x29
function private function_6af2641d7a4923c6( guy )
{
    if ( !isdefined( guy.revive_bleedouttime ) )
    {
        guy.revive_bleedouttime = 5000;
    }
}

// Namespace namespace_c522e27d9c6b70c9
// Params 0, eflags: 0x4
// Checksum 0x7fb7f9cc, Offset: 0x587
// Size: 0xf
function private function_91a3f1d0865308eb()
{
    return getscriptbundle( %"hash_808ddc26c257759" );
}

// Namespace namespace_c522e27d9c6b70c9
// Params 1, eflags: 0x4
// Checksum 0xaf66034a, Offset: 0x59f
// Size: 0x26
function private printerror( msg )
{
    /#
        if ( getdvar( @"hash_cd2a202ccf770735" ) )
        {
            println( msg );
        }
    #/
}

