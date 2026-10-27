// script_4880fce3c83f33ef  (hash_4880fce3c83f33ef.gscc) (size: 2431 Bytes / 0x97f / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xe3d698e0 (3822491872)
// size ...... 2431 (0x97f)
// includes .. 1   (offset: 0x977)
// strings ... 0   (offset: 0x97f)
// dev strs .. 0   (offset: 0x97f)
// exports ... 11  (offset: 0x5d7)
// cseg ...... 0x58 + 0x57f (0x5d7)
// imports ... 16  (offset: 0x78f)
// animtree1 . 0   (offset: 0x97f)
// animtree2 . 0   (offset: 0x97f)
#using scripts\common\vehicle;

#namespace namespace_258c393149f2e837;

// Namespace namespace_258c393149f2e837
// Params 0, eflags: 0x1
// Checksum 0xf6da2552, Offset: 0x76
// Size: 0x2
function autoexec main()
{
    
}

// Namespace namespace_258c393149f2e837
// Params 1, eflags: 0x4
// Checksum 0xf8c29e7, Offset: 0x80
// Size: 0x1a2
function private init_radar_ping( data )
{
    vehicle = self;
    
    if ( data.enabled )
    {
        assert( isdefined( vehicle.mtx ) );
        vehicle.mtx.radarping = spawnstruct();
        vehicle.mtx.radarping.sweepradius = data.radarpingsweepradius;
        vehicle.mtx.radarping.sweeptime = data.radarpingsweeptime;
        vehicle.mtx.radarping.sweeptimedelay = data.var_2962c1bc94835e40;
        vehicle.mtx.radarping.driveronly = data.var_28c00f2a5b9ec6e5;
        
        if ( isdefined( vehicle.occupants ) )
        {
            foreach ( occupant in vehicle.occupants )
            {
                start_radar_ping( vehicle, occupant );
            }
        }
        
        return;
    }
    
    vehicle.mtx.radarping = undefined;
}

// Namespace namespace_258c393149f2e837
// Params 2, eflags: 0x4
// Checksum 0xb8f96e11, Offset: 0x22a
// Size: 0xa7
function private start_radar_ping( vehicle, player )
{
    if ( isdefined( vehicle.mtx.radarping ) && !player.var_64cf52105a48848b )
    {
        data = vehicle.mtx.radarping;
        sweeptime = int( data.sweeptime * 1000 );
        sweepdelay = int( data.sweeptimedelay * 1000 );
        player.var_64cf52105a48848b = 1;
    }
}

// Namespace namespace_258c393149f2e837
// Params 2, eflags: 0x4
// Checksum 0x89a5fb43, Offset: 0x2d9
// Size: 0x48
function private stop_radar_ping( vehicle, player )
{
    if ( isdefined( vehicle.mtx.radarping ) && player.var_64cf52105a48848b )
    {
        player.var_64cf52105a48848b = undefined;
    }
}

// Namespace namespace_258c393149f2e837
// Params 2
// Checksum 0xf6fddecd, Offset: 0x329
// Size: 0x1f
function on_enter_vehicle( vehicle, player )
{
    start_radar_ping( vehicle, player );
}

// Namespace namespace_258c393149f2e837
// Params 2
// Checksum 0x9e6fc9b5, Offset: 0x350
// Size: 0x1f
function on_exit_vehicle( vehicle, player )
{
    stop_radar_ping( vehicle, player );
}

// Namespace namespace_258c393149f2e837
// Params 1
// Checksum 0x12c9a9aa, Offset: 0x377
// Size: 0x85
function function_c65ed663d13b2579( bundlename )
{
    vehicle = self;
    
    if ( !isdefined( bundlename ) )
    {
        bundlename = vehicle function_8722cd990f035753();
        
        if ( !isdefined( bundlename ) )
        {
            return;
        }
    }
    
    assert( isxhashasset( bundlename ) );
    data = getscriptbundlefieldvalues( bundlename, [ #"radarping" ] );
    
    if ( isdefined( data ) )
    {
        if ( isdefined( data.radarping ) )
        {
            vehicle init_radar_ping( data.radarping );
        }
    }
}

// Namespace namespace_258c393149f2e837
// Params 0
// Checksum 0x9b5f599f, Offset: 0x404
// Size: 0x7e
function function_6f973aa5086dcf35()
{
    vehicle = self;
    bundlename = vehicle function_8722cd990f035753();
    
    if ( !isdefined( bundlename ) )
    {
        vehicle.var_429d5e520209434f = undefined;
        return;
    }
    
    assert( isxhashasset( bundlename ) );
    bundledata = getscriptbundlefieldvalues( bundlename, [ #"collision" ] );
    vehicle.var_429d5e520209434f = bundledata.collision;
    vehicle update_max_health();
}

// Namespace namespace_258c393149f2e837
// Params 1, eflags: 0x4
// Checksum 0x1e7f06ba, Offset: 0x48a
// Size: 0x63
function private function_615b562c48bb83f8( newmaxhealth )
{
    if ( newmaxhealth == self.maxhealth )
    {
        return;
    }
    
    currenthealthpercentage = self.health / self.maxhealth;
    self.maxhealth = newmaxhealth;
    self.health = int( ceil( currenthealthpercentage * self.maxhealth ) );
}

// Namespace namespace_258c393149f2e837
// Params 0, eflags: 0x4
// Checksum 0xd7e7ecb7, Offset: 0x4f5
// Size: 0xe2
function private update_max_health()
{
    var_e2135a579d15e713 = self.var_429d5e520209434f;
    newmaxhealth = var_e2135a579d15e713.maxhealth;
    
    if ( newmaxhealth && newmaxhealth != 0 )
    {
        function_615b562c48bb83f8( newmaxhealth );
        return;
    }
    
    if ( !isdefined( var_e2135a579d15e713 ) )
    {
        bundledata = undefined;
        ref = vehicle::get_ref();
        
        if ( vehicle::has_data( ref ) )
        {
            bundledata = vehicle::get_data( ref );
        }
        
        if ( bundledata.damage.health && self.maxhealth != bundledata.damage.health )
        {
            function_615b562c48bb83f8( bundledata.damage.health );
        }
        
        return;
    }
    
    assert( newmaxhealth == 0 );
}

