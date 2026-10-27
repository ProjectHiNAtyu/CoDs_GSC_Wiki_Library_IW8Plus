// scripts\mp\ob\systems\ob_resource_manager.gsc  (hash_78c71390bb3043df.gscc) (size: 13476 Bytes / 0x34a4 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xdbf93669 (3690542697)
// size ...... 13476 (0x34a4)
// includes .. 8   (offset: 0x30b4)
// strings ... 28  (offset: 0x30f4)
// dev strs .. 20  (offset: 0x339c)
// exports ... 35  (offset: 0x22d8)
// cseg ...... 0x262 + 0x2076 (0x22d8)
// imports ... 62  (offset: 0x2850)
// animtree1 . 0   (offset: 0x34a4)
// animtree2 . 0   (offset: 0x34a4)
#using scripts\common\activity_nexus\activity_definition_utils;
#using scripts\common\activity_nexus\activity_instance_common;
#using scripts\common\callbacks;
#using scripts\common\utility;
#using scripts\common\vehicle;
#using scripts\common\vehicle_tracking;
#using scripts\mp\ob\systems\ob_activity_manager;
#using scripts\mp\ob\systems\ob_resource_manager_debug;

#namespace ob_resource_manager;

// Namespace ob_resource_manager
// Params 0
// Checksum 0x5b4bbeae, Offset: 0x280
// Size: 0x1c6
function ob_resource_manager_init()
{
    /#
        ob_resource_manager_debug::ob_resource_manager_debug_init();
    #/
    
    if ( !function_516cca136bef547f() )
    {
        return;
    }
    
    if ( isdefined( level.var_b447b86d9f2c6586 ) )
    {
        assertmsg( "<dev string:x24>" );
        return;
    }
    
    level.var_b447b86d9f2c6586 = spawnstruct();
    level.var_b447b86d9f2c6586.limits = ob_activity_manager::function_7b19c0b83db8fcdc();
    level.var_b447b86d9f2c6586.var_134b19f98368bff0 = [];
    level.var_b447b86d9f2c6586.counts = undefined;
    level.var_b447b86d9f2c6586.var_4d31ff9ee6ed3974 = function_8f8b736001dcdbb5();
    level.var_b447b86d9f2c6586.entities = [];
    level.var_b447b86d9f2c6586.scriptables = [];
    level.var_b447b86d9f2c6586.vehicles = [];
    
    if ( getbuildversion() != "SHIP" )
    {
        level.var_b447b86d9f2c6586.profileenabled = 1;
        level.var_b447b86d9f2c6586.var_586b30d2c3c0f071 = function_33913e883ed9bb61();
    }
    
    level.var_5e65abc19ba3eb5 = &ob_spawn_entity;
    level.var_e329c742a19114f5 = &ob_spawn_scriptable;
    level.var_7d97c947e61323ca = &ob_spawn_vehicle;
    function_6b9b0a698b7b6527();
    
    if ( istrue( level.var_b447b86d9f2c6586.profileenabled ) )
    {
        level thread function_52126d875f245349();
        level.var_b447b86d9f2c6586.var_e89c1ce0df45b5c7 = { #varianttag:"ambient" };
    }
    
    utility::registersharedfunc( #"hash_e8e361e25979d82d", #"spawn_entity", &activity_spawn_entity );
    utility::registersharedfunc( #"hash_e8e361e25979d82d", #"hash_201def010528b7af", &activity_spawn_vehicle );
}

// Namespace ob_resource_manager
// Params 0
// Checksum 0xbb731e11, Offset: 0x44e
// Size: 0x13, Type: bool
function function_516cca136bef547f()
{
    return getdvarint( @"rm_enabled", 1 ) != 0;
}

// Namespace ob_resource_manager
// Params 0, eflags: 0x4
// Checksum 0x6b93ef00, Offset: 0x46a
// Size: 0x98
function private function_8f8b736001dcdbb5()
{
    var_d7afb3729d610012 = [];
    
    foreach ( resource in [ "entities", "scriptables", "vehicles" ] )
    {
        var_d7afb3729d610012[ resource ] = 0;
    }
    
    return var_d7afb3729d610012;
}

// Namespace ob_resource_manager
// Params 0, eflags: 0x4
// Checksum 0x97aa96b8, Offset: 0x50b
// Size: 0x2
function private ob_spawn_entity()
{
    
}

// Namespace ob_resource_manager
// Params 0, eflags: 0x4
// Checksum 0x9e702bc1, Offset: 0x515
// Size: 0x2
function private ob_spawn_scriptable()
{
    
}

// Namespace ob_resource_manager
// Params 0, eflags: 0x4
// Checksum 0x454658aa, Offset: 0x51f
// Size: 0x2
function private ob_spawn_vehicle()
{
    
}

// Namespace ob_resource_manager
// Params 0
// Checksum 0xd4fa410b, Offset: 0x529
// Size: 0x98
function function_33913e883ed9bb61()
{
    container = [];
    
    foreach ( resource in [ "entities", "scriptables", "vehicles" ] )
    {
        container[ resource ] = [];
    }
    
    return container;
}

// Namespace ob_resource_manager
// Params 0, eflags: 0x4
// Checksum 0xbda7ac, Offset: 0x5ca
// Size: 0xa3
function private function_379bfa96ac471769()
{
    container = [];
    var_198a30d4bf7f5853 = activity_definition_utils::function_e9cffc15e34b2ea3( self );
    container[ "entities" ] = var_198a30d4bf7f5853.var_622af9ed9146813f.activityresources.var_565837295b09914e ?? 0;
    container[ "scriptables" ] = var_198a30d4bf7f5853.var_622af9ed9146813f.activityresources.var_70b4e90213acebe3 ?? 0;
    container[ "vehicles" ] = var_198a30d4bf7f5853.var_622af9ed9146813f.activityresources.var_9b8d447f054a4d70 ?? 0;
    return container;
}

// Namespace ob_resource_manager
// Params 0, eflags: 0x4
// Checksum 0x4ade3c3c, Offset: 0x676
// Size: 0x18b
function private function_6b9b0a698b7b6527()
{
    assert( !isdefined( level.var_b447b86d9f2c6586.counts ) );
    classes = ob_activity_manager::function_13745445d5f57d2a();
    
    foreach ( class in classes )
    {
        level.var_b447b86d9f2c6586.counts[ class ] = function_8f8b736001dcdbb5();
    }
    
    level.var_b447b86d9f2c6586.counts[ "ambient" ] = function_8f8b736001dcdbb5();
    assert( level.var_b447b86d9f2c6586.var_134b19f98368bff0.size == 0 );
    level.var_b447b86d9f2c6586.var_134b19f98368bff0[ "entities" ] = int( max( getdvarint( @"hash_4dc99f3054df38f1", 500 ), 0 ) );
    level.var_b447b86d9f2c6586.var_134b19f98368bff0[ "scriptables" ] = int( max( getdvarint( @"hash_5d026b677a8c5410", 1300 ), 0 ) );
    level.var_b447b86d9f2c6586.var_134b19f98368bff0[ "vehicles" ] = int( max( getdvarint( @"hash_8145cf83bbc69bd7", 80 ), 0 ) );
}

// Namespace ob_resource_manager
// Params 6, eflags: 0x4
// Checksum 0x2a4a7b22, Offset: 0x809
// Size: 0x125
function private function_5bce7b1656341629( resourcetype, var_a98d07f7a054ff29, activitytype, activityname, amount, var_e46ce3bdb7e7f4af )
{
    if ( !isdefined( amount ) || amount <= 0 )
    {
        return 1;
    }
    
    var_cc940e55034069c0 = level.var_b447b86d9f2c6586.var_4d31ff9ee6ed3974[ resourcetype ];
    var_9ba55644dfb96131 = level.var_b447b86d9f2c6586.var_134b19f98368bff0[ resourcetype ];
    canafford = var_cc940e55034069c0 + amount <= var_9ba55644dfb96131;
    
    if ( var_e46ce3bdb7e7f4af && !canafford )
    {
        if ( !isdefined( var_e46ce3bdb7e7f4af.var_ebc56c8eb6ccfb37 ) )
        {
            var_e46ce3bdb7e7f4af.var_ebc56c8eb6ccfb37 = [];
        }
        
        var_e46ce3bdb7e7f4af.var_ebc56c8eb6ccfb37[ resourcetype ] = var_cc940e55034069c0 + amount - var_9ba55644dfb96131;
    }
    
    if ( resourcetype == "vehicles" )
    {
        var_aed18290476b25c = vehicle_tracking::can_spawn_vehicle( amount );
        
        if ( var_e46ce3bdb7e7f4af && canafford && !var_aed18290476b25c )
        {
            var_e46ce3bdb7e7f4af.var_ebc56c8eb6ccfb37[ resourcetype ] = amount;
        }
        
        return ( canafford && var_aed18290476b25c );
    }
    
    return canafford;
}

// Namespace ob_resource_manager
// Params 5
// Checksum 0x3357fc7c, Offset: 0x937
// Size: 0x132
function function_343895fa5dadad10( var_a98d07f7a054ff29, activitytype, activityname, resourcebundle, var_6120b5ea34b5a382 )
{
    if ( !isdefined( resourcebundle ) )
    {
        return 1;
    }
    
    var_471303dcf2cce24a = level.var_b447b86d9f2c6586.limits[ var_a98d07f7a054ff29 ];
    
    if ( isdefined( var_471303dcf2cce24a ) )
    {
    }
    
    if ( var_6120b5ea34b5a382 )
    {
        if ( !isdefined( var_6120b5ea34b5a382.var_ebc56c8eb6ccfb37 ) )
        {
            var_6120b5ea34b5a382.var_ebc56c8eb6ccfb37 = [];
        }
        
        var_6120b5ea34b5a382.var_ebc56c8eb6ccfb37[ "entities" ] = 0;
        var_6120b5ea34b5a382.var_ebc56c8eb6ccfb37[ "scriptables" ] = 0;
        var_6120b5ea34b5a382.var_ebc56c8eb6ccfb37[ "vehicles" ] = 0;
    }
    
    result = 1;
    
    if ( !function_5bce7b1656341629( "entities", var_a98d07f7a054ff29, activitytype, activityname, resourcebundle.var_565837295b09914e, var_6120b5ea34b5a382 ) )
    {
        result = 0;
    }
    
    if ( !function_5bce7b1656341629( "scriptables", var_a98d07f7a054ff29, activitytype, activityname, resourcebundle.var_70b4e90213acebe3, var_6120b5ea34b5a382 ) )
    {
        result = 0;
    }
    
    if ( !function_5bce7b1656341629( "vehicles", var_a98d07f7a054ff29, activitytype, activityname, resourcebundle.var_9b8d447f054a4d70, var_6120b5ea34b5a382 ) )
    {
        result = 0;
    }
    
    return result;
}

// Namespace ob_resource_manager
// Params 5
// Checksum 0x45e2eac7, Offset: 0xa72
// Size: 0x278
function function_ecad2cf1cfb8379e( var_a98d07f7a054ff29, activitytype, activityname, resourcebundle, cleanupsummary )
{
    if ( cleanupsummary )
    {
        cleanupsummary.var_d7be4c9e0ea581ee = [];
        cleanupsummary.var_e43253eb66526600 = 0;
        cleanupsummary.var_aea72c7f42d1b235 = " Activity Instances Cleaned up: ";
    }
    
    profilestart();
    
    foreach ( activityinstance in level.activities.instances )
    {
        activitystate = activityinstance.state;
        
        if ( activitystate != "Idle" )
        {
            continue;
        }
        
        var_6120b5ea34b5a382 = {};
        canafford = function_343895fa5dadad10( var_a98d07f7a054ff29, activitytype, activityname, resourcebundle, var_6120b5ea34b5a382 );
        
        if ( cleanupsummary )
        {
            if ( !isdefined( cleanupsummary.var_107ec35884b5f30 ) )
            {
                cleanupsummary.var_107ec35884b5f30 = var_6120b5ea34b5a382;
            }
        }
        
        if ( canafford )
        {
            profilestop();
            return 1;
        }
        
        var_8ce2777d39cf9bc8 = 0;
        
        if ( var_6120b5ea34b5a382.var_ebc56c8eb6ccfb37[ "entities" ] > 0 && activityinstance.var_d3254054df6fc17a[ "entities" ] > 0 )
        {
            var_8ce2777d39cf9bc8 = 1;
        }
        else if ( var_6120b5ea34b5a382.var_ebc56c8eb6ccfb37[ "scriptables" ] > 0 && activityinstance.var_d3254054df6fc17a[ "scriptables" ] > 0 )
        {
            var_8ce2777d39cf9bc8 = 1;
        }
        else if ( var_6120b5ea34b5a382.var_ebc56c8eb6ccfb37[ "vehicles" ] > 0 && activityinstance.var_d3254054df6fc17a[ "vehicles" ] > 0 )
        {
            var_8ce2777d39cf9bc8 = 1;
        }
        
        if ( var_8ce2777d39cf9bc8 )
        {
            if ( cleanupsummary )
            {
                cleanupsummary.var_e43253eb66526600++;
                cleanupsummary.var_aea72c7f42d1b235 = cleanupsummary.var_aea72c7f42d1b235 + "[" + activityinstance.varianttag + "] ";
            }
            
            activity_instance_common::function_9aeeabe50fc9cc3e( activityinstance );
            continue;
        }
    }
    
    var_6120b5ea34b5a382 = {};
    canafford = function_343895fa5dadad10( var_a98d07f7a054ff29, activitytype, activityname, resourcebundle, var_6120b5ea34b5a382 );
    
    if ( cleanupsummary )
    {
        if ( !isdefined( cleanupsummary.var_107ec35884b5f30 ) )
        {
            cleanupsummary.var_107ec35884b5f30 = var_6120b5ea34b5a382;
        }
    }
    
    profilestop();
    return canafford;
}

// Namespace ob_resource_manager
// Params 5, eflags: 0x4
// Checksum 0x1296c6c1, Offset: 0xcf4
// Size: 0xa4
function private function_d30353d0d33cd44( resourcetype, var_a98d07f7a054ff29, activitytype, activityname, amount )
{
    if ( !isdefined( amount ) || amount <= 0 )
    {
        return;
    }
    
    level.var_b447b86d9f2c6586.counts[ var_a98d07f7a054ff29 ][ resourcetype ] += amount;
    level.var_b447b86d9f2c6586.var_4d31ff9ee6ed3974[ resourcetype ] += amount;
}

// Namespace ob_resource_manager
// Params 5, eflags: 0x4
// Checksum 0x94e57527, Offset: 0xda0
// Size: 0x11b
function private function_2df2e72d750cf03d( resourcetype, var_a98d07f7a054ff29, activitytype, activityname, var_bc1a896f3fee5ad8 )
{
    level endon( #"game_ended" );
    
    if ( istrue( level.var_b447b86d9f2c6586.profileenabled ) )
    {
        level.var_b447b86d9f2c6586.var_586b30d2c3c0f071[ resourcetype ][ activityname ] = arraycombine( level.var_b447b86d9f2c6586.var_586b30d2c3c0f071[ resourcetype ][ activityname ], var_bc1a896f3fee5ad8 );
    }
    
    for ( totalamount = var_bc1a896f3fee5ad8.size; totalamount > 0 ; totalamount = var_bc1a896f3fee5ad8.size )
    {
        utility::waittill_any_ents_array( var_bc1a896f3fee5ad8, "entitydeleted" );
        var_bc1a896f3fee5ad8 = function_5713d46873b29625( var_bc1a896f3fee5ad8 );
        
        if ( istrue( level.var_b447b86d9f2c6586.profileenabled ) )
        {
            level.var_b447b86d9f2c6586.var_586b30d2c3c0f071[ resourcetype ][ activityname ] = function_5713d46873b29625( level.var_b447b86d9f2c6586.var_586b30d2c3c0f071[ resourcetype ][ activityname ] );
        }
        
        function_c059c82404107b02( resourcetype, var_a98d07f7a054ff29, activitytype, activityname, totalamount - var_bc1a896f3fee5ad8.size );
    }
}

// Namespace ob_resource_manager
// Params 6, eflags: 0x4
// Checksum 0x9162f586, Offset: 0xec3
// Size: 0x161
function private function_c059c82404107b02( resourcetype, var_a98d07f7a054ff29, activitytype, activityname, amount, var_bc1a896f3fee5ad8 = undefined )
{
    if ( !isdefined( amount ) || amount <= 0 )
    {
        return;
    }
    
    freeamount = amount;
    
    if ( isdefined( var_bc1a896f3fee5ad8 ) )
    {
        var_bc1a896f3fee5ad8 = function_5713d46873b29625( var_bc1a896f3fee5ad8 );
        
        if ( var_bc1a896f3fee5ad8.size > 0 )
        {
            freeamount = max( 0, amount - var_bc1a896f3fee5ad8.size );
            assert( amount >= var_bc1a896f3fee5ad8.size, "<dev string:x53>" + var_bc1a896f3fee5ad8.size + "<dev string:x7d>" + amount + "<dev string:x85>" + activityname );
            level thread function_2df2e72d750cf03d( resourcetype, var_a98d07f7a054ff29, activitytype, activityname, var_bc1a896f3fee5ad8 );
        }
    }
    
    level.var_b447b86d9f2c6586.counts[ var_a98d07f7a054ff29 ][ resourcetype ] -= freeamount;
    level.var_b447b86d9f2c6586.var_4d31ff9ee6ed3974[ resourcetype ] -= freeamount;
    assert( level.var_b447b86d9f2c6586.counts[ var_a98d07f7a054ff29 ][ resourcetype ] >= 0 );
    assert( level.var_b447b86d9f2c6586.var_4d31ff9ee6ed3974[ resourcetype ] >= 0 );
}

// Namespace ob_resource_manager
// Params 0
// Checksum 0xf211fc29, Offset: 0x102c
// Size: 0xeb
function function_4fe4605f81a69697()
{
    activityinstance = self;
    var_a98d07f7a054ff29 = activityinstance.category;
    activitytype = activityinstance.type;
    activityname = activityinstance.varianttag;
    var_9ba55644dfb96131 = activityinstance.var_d3254054df6fc17a;
    
    if ( !isdefined( self.var_41964d9110b1cf5 ) )
    {
        self.var_41964d9110b1cf5 = [];
    }
    
    function_c059c82404107b02( "entities", var_a98d07f7a054ff29, activitytype, activityname, var_9ba55644dfb96131[ "entities" ], self.var_41964d9110b1cf5[ "entities" ] );
    function_c059c82404107b02( "scriptables", var_a98d07f7a054ff29, activitytype, activityname, var_9ba55644dfb96131[ "scriptables" ], self.var_41964d9110b1cf5[ "scriptables" ] );
    function_c059c82404107b02( "vehicles", var_a98d07f7a054ff29, activitytype, activityname, var_9ba55644dfb96131[ "vehicles" ], self.var_41964d9110b1cf5[ "vehicles" ] );
}

// Namespace ob_resource_manager
// Params 0
// Checksum 0x248abf44, Offset: 0x111f
// Size: 0x10c
function function_2fdf4c6f6ce33a2a()
{
    activityinstance = self;
    var_a98d07f7a054ff29 = activityinstance.category;
    activitytype = activityinstance.type;
    activityname = activityinstance.varianttag;
    activityinstance.var_d3254054df6fc17a = function_379bfa96ac471769();
    var_b74c4a1c5249c873 = activityinstance.var_d3254054df6fc17a;
    additionalspawndata = activity_instance_common::function_a45920af4495e9f( activityinstance );
    var_e206e40c465fa7bd = additionalspawndata.parent && additionalspawndata.var_e206e40c465fa7bd;
    
    if ( var_e206e40c465fa7bd )
    {
        function_5d7f4ceba0aeeb46( additionalspawndata.parent, activityinstance );
        return;
    }
    
    function_d30353d0d33cd44( "entities", var_a98d07f7a054ff29, activitytype, activityname, var_b74c4a1c5249c873[ "entities" ] );
    function_d30353d0d33cd44( "scriptables", var_a98d07f7a054ff29, activitytype, activityname, var_b74c4a1c5249c873[ "scriptables" ] );
    function_d30353d0d33cd44( "vehicles", var_a98d07f7a054ff29, activitytype, activityname, var_b74c4a1c5249c873[ "vehicles" ] );
}

// Namespace ob_resource_manager
// Params 2, eflags: 0x4
// Checksum 0xdfc42b3, Offset: 0x1233
// Size: 0xfe
function private function_9bc70e4cf10315c( resource, resourcetype )
{
    if ( !isdefined( self.var_41964d9110b1cf5 ) )
    {
        self.var_41964d9110b1cf5 = function_33913e883ed9bb61();
    }
    
    if ( !isdefined( self.var_41964d9110b1cf5[ resourcetype ] ) )
    {
        self.var_41964d9110b1cf5[ resourcetype ] = [];
    }
    
    self.var_41964d9110b1cf5[ resourcetype ][ self.var_41964d9110b1cf5[ resourcetype ].size ] = resource;
    
    if ( self.varianttag == "ambient" )
    {
        return;
    }
    
    if ( self.var_41964d9110b1cf5[ resourcetype ].size > self.var_d3254054df6fc17a[ resourcetype ] )
    {
        assertmsg( "<dev string:x90>" + self.var_d3254054df6fc17a[ resourcetype ] + "<dev string:xb6>" + resourcetype + "<dev string:xb7>" + self.varianttag + "<dev string:xc3>" + ( resource.classname ?? "<dev string:xb6>" ) + "<dev string:xd0>" + resource.origin + "<dev string:xda>" );
    }
}

// Namespace ob_resource_manager
// Params 2, eflags: 0x4
// Checksum 0xf70e21fd, Offset: 0x1339
// Size: 0x113
function private function_177432dbc690cbad( resource, resourcetype )
{
    if ( !isdefined( self.var_41964d9110b1cf5 ) )
    {
        assertmsg( "<dev string:x121>" + ( self.varianttag ?? self.type ) + "<dev string:x134>" + resourcetype + "<dev string:x161>" + ( resource.classname ?? "<dev string:x166>" ) + "<dev string:x170>" + ( resource.origin ?? "<dev string:x166>" ) );
        return;
    }
    
    assert( arraycontains( self.var_41964d9110b1cf5[ resourcetype ], resource ), "<dev string:x175>" + resourcetype + "<dev string:x161>" + ( resource.classname ?? "<dev string:x166>" ) + "<dev string:x170>" + ( resource.origin ?? "<dev string:x166>" ) + "<dev string:x187>" + ( self.varianttag ?? self.type ) );
    self.var_41964d9110b1cf5[ resourcetype ] = arrayremove( self.var_41964d9110b1cf5[ resourcetype ], resource );
}

// Namespace ob_resource_manager
// Params 5
// Checksum 0x8e9f9283, Offset: 0x1454
// Size: 0x76
function activity_spawn_entity( classname, origin, spawnflags, var_7d2a90fa4ff676a2, var_3085cda132eb754 )
{
    assert( activity_instance_common::isactivityinstance( self ) );
    ent = spawn( classname, origin, spawnflags, var_7d2a90fa4ff676a2, var_3085cda132eb754 );
    
    if ( function_516cca136bef547f() && isdefined( ent ) )
    {
        function_9bc70e4cf10315c( ent, "entities" );
    }
    
    return ent;
}

// Namespace ob_resource_manager
// Params 1
// Checksum 0xec263d8f, Offset: 0x14d3
// Size: 0x96
function function_fc3309a378736988( count = 1 )
{
    if ( !function_516cca136bef547f() )
    {
        return 1;
    }
    
    assert( activity_instance_common::isactivityinstance( self ) );
    
    if ( self.varianttag == "ambient" )
    {
        return function_5bce7b1656341629( "entities", "ambient", undefined, undefined, count );
    }
    
    if ( !isdefined( self.var_41964d9110b1cf5 ) )
    {
        self.var_41964d9110b1cf5 = function_33913e883ed9bb61();
    }
    
    return self.var_41964d9110b1cf5[ "entities" ].size + count <= self.var_d3254054df6fc17a[ "entities" ];
}

// Namespace ob_resource_manager
// Params 3
// Checksum 0x943de6de, Offset: 0x1572
// Size: 0x88
function activity_spawn_vehicle( vehicleref, spawndata, faildata )
{
    assert( activity_instance_common::isactivityinstance( self ) );
    vehicle = vehicle::spawn( vehicleref, spawndata, faildata );
    
    if ( function_516cca136bef547f() && isdefined( vehicle ) )
    {
        function_9bc70e4cf10315c( vehicle, "vehicles" );
        function_9bc70e4cf10315c( vehicle, "entities" );
        vehicle callback::add( #"vehicle_husk_spawn", &on_vehicle_husk_spawn );
    }
    
    return vehicle;
}

// Namespace ob_resource_manager
// Params 3
// Checksum 0x28fc1743, Offset: 0x1603
// Size: 0x73
function function_5833e4ba6b50b615( vehicleref, spawndata, faildata )
{
    if ( !function_516cca136bef547f() )
    {
        return vehicle::spawn( vehicleref, spawndata, faildata );
    }
    
    if ( !function_5bce7b1656341629( "vehicles", "ambient", undefined, undefined, 1 ) )
    {
        return;
    }
    
    vehicle = vehicle::spawn( vehicleref, spawndata, faildata );
    
    if ( isdefined( vehicle ) )
    {
        function_ae795d845f3e495f( vehicle );
    }
    
    return vehicle;
}

// Namespace ob_resource_manager
// Params 1, eflags: 0x4
// Checksum 0x3cac082b, Offset: 0x167f
// Size: 0x9c
function private function_ae795d845f3e495f( vehicle )
{
    function_d30353d0d33cd44( "vehicles", "ambient", undefined, undefined, 1 );
    function_d30353d0d33cd44( "entities", "ambient", undefined, undefined, 1 );
    vehicle callback::add( #"vehicle_delete", &on_ambient_vehicle_deleted );
    vehicle callback::add( #"vehicle_husk_spawn", &on_ambient_vehicle_husk_spawn );
    
    if ( istrue( level.var_b447b86d9f2c6586.profileenabled ) )
    {
        level.var_b447b86d9f2c6586.var_e89c1ce0df45b5c7 function_9bc70e4cf10315c( vehicle, "vehicles" );
    }
}

// Namespace ob_resource_manager
// Params 1, eflags: 0x4
// Checksum 0xe475b9f, Offset: 0x1723
// Size: 0x99
function private on_ambient_vehicle_deleted( unused_param )
{
    function_c059c82404107b02( "vehicles", "ambient", undefined, undefined, 1 );
    function_c059c82404107b02( "entities", "ambient", undefined, undefined, 1 );
    
    if ( istrue( level.var_b447b86d9f2c6586.profileenabled ) )
    {
        level.var_b447b86d9f2c6586.var_e89c1ce0df45b5c7.var_41964d9110b1cf5[ "vehicles" ] = arrayremove( level.var_b447b86d9f2c6586.var_e89c1ce0df45b5c7.var_41964d9110b1cf5[ "vehicles" ], self );
    }
}

// Namespace ob_resource_manager
// Params 1, eflags: 0x4
// Checksum 0x68107a6f, Offset: 0x17c4
// Size: 0x1e
function private on_ambient_vehicle_husk_spawn( params )
{
    on_ambient_vehicle_deleted( params );
    on_vehicle_husk_spawn( params );
}

// Namespace ob_resource_manager
// Params 1, eflags: 0x4
// Checksum 0xc1067d6, Offset: 0x17ea
// Size: 0x35
function private on_vehicle_husk_spawn( params )
{
    husk = params.husk;
    
    if ( isent( husk ) )
    {
        function_ae795d845f3e495f( husk );
    }
}

// Namespace ob_resource_manager
// Params 1
// Checksum 0x307a0bae, Offset: 0x1827
// Size: 0x50
function function_4d956586279ad989( ent )
{
    if ( !function_516cca136bef547f() )
    {
        return;
    }
    
    assert( isent( ent ) );
    assert( isdefined( self.var_41964d9110b1cf5 ) || activity_instance_common::isactivityinstance( self ) );
    function_9bc70e4cf10315c( ent, "entities" );
}

// Namespace ob_resource_manager
// Params 1
// Checksum 0xced20538, Offset: 0x187f
// Size: 0x50
function function_360d7e0860217cf4( ent )
{
    if ( !function_516cca136bef547f() )
    {
        return;
    }
    
    assert( isent( ent ) );
    assert( isdefined( self.var_41964d9110b1cf5 ) || activity_instance_common::isactivityinstance( self ) );
    function_177432dbc690cbad( ent, "entities" );
}

// Namespace ob_resource_manager
// Params 1
// Checksum 0xe637d339, Offset: 0x18d7
// Size: 0x70
function activity_register_vehicle( veh )
{
    if ( !function_516cca136bef547f() )
    {
        return;
    }
    
    assert( isdefined( veh ) && veh vehicle::is_vehicle() );
    assert( activity_instance_common::isactivityinstance( self ) );
    function_9bc70e4cf10315c( veh, "vehicles" );
    function_9bc70e4cf10315c( veh, "entities" );
    veh callback::add( #"vehicle_husk_spawn", &on_vehicle_husk_spawn );
}

// Namespace ob_resource_manager
// Params 3
// Checksum 0x90666c3b, Offset: 0x194f
// Size: 0x16e
function function_2948ca4364d60860( vehiclecount, var_13de8a19948f49e8, scriptablecount )
{
    if ( !function_516cca136bef547f() )
    {
        return;
    }
    
    activityinstance = self;
    var_a98d07f7a054ff29 = activityinstance.category;
    ActivityTypeName = activityinstance.type;
    var_5383457952d414cf = activityinstance.varianttag;
    
    if ( vehiclecount )
    {
        assert( self.var_d3254054df6fc17a[ "<dev string:x1aa>" ] >= vehiclecount );
        self.var_d3254054df6fc17a[ "vehicles" ] = self.var_d3254054df6fc17a[ "vehicles" ] - vehiclecount;
        function_c059c82404107b02( "vehicles", var_a98d07f7a054ff29, ActivityTypeName, var_5383457952d414cf, vehiclecount );
    }
    
    if ( var_13de8a19948f49e8 )
    {
        assert( self.var_d3254054df6fc17a[ "<dev string:x1b3>" ] >= var_13de8a19948f49e8 );
        self.var_d3254054df6fc17a[ "entities" ] = self.var_d3254054df6fc17a[ "entities" ] - var_13de8a19948f49e8;
        function_c059c82404107b02( "entities", var_a98d07f7a054ff29, ActivityTypeName, var_5383457952d414cf, var_13de8a19948f49e8 );
    }
    
    if ( scriptablecount )
    {
        assert( self.var_d3254054df6fc17a[ "<dev string:x1bc>" ] >= scriptablecount );
        self.var_d3254054df6fc17a[ "scriptables" ] = self.var_d3254054df6fc17a[ "scriptables" ] - scriptablecount;
        function_c059c82404107b02( "scriptables", var_a98d07f7a054ff29, ActivityTypeName, var_5383457952d414cf, scriptablecount );
    }
}

// Namespace ob_resource_manager
// Params 2
// Checksum 0xc3890478, Offset: 0x1ac5
// Size: 0xea
function function_7e6ceb9ece0c87e7( resourcetype, amount )
{
    activityinstance = self;
    
    if ( !function_516cca136bef547f() )
    {
        return;
    }
    
    var_cc940e55034069c0 = level.var_b447b86d9f2c6586.var_4d31ff9ee6ed3974[ resourcetype ];
    var_9ba55644dfb96131 = level.var_b447b86d9f2c6586.var_134b19f98368bff0[ resourcetype ];
    amount = min( var_9ba55644dfb96131 - var_cc940e55034069c0, amount );
    
    if ( amount > 0 )
    {
        var_a98d07f7a054ff29 = activityinstance.category;
        ActivityTypeName = activityinstance.type;
        var_5383457952d414cf = activityinstance.varianttag;
        self.var_d3254054df6fc17a[ resourcetype ] += amount;
        function_d30353d0d33cd44( resourcetype, var_a98d07f7a054ff29, ActivityTypeName, var_5383457952d414cf, amount );
    }
    
    return amount;
}

// Namespace ob_resource_manager
// Params 2, eflags: 0x4
// Checksum 0x3fd3c0d5, Offset: 0x1bb8
// Size: 0x104
function private function_5d7f4ceba0aeeb46( srcinstance, destinstance )
{
    if ( !function_516cca136bef547f() )
    {
        return;
    }
    
    vehiclecount = destinstance.var_d3254054df6fc17a[ "vehicles" ];
    var_13de8a19948f49e8 = destinstance.var_d3254054df6fc17a[ "entities" ];
    scriptablecount = destinstance.var_d3254054df6fc17a[ "scriptables" ];
    srcinstance function_2948ca4364d60860( vehiclecount, var_13de8a19948f49e8, scriptablecount );
    var_d7cdbfc2868c8ecd = destinstance.category;
    var_955d4e8d65b9a348 = destinstance.type;
    var_4461dc53e879a8b = destinstance.varianttag;
    
    if ( vehiclecount )
    {
        function_d30353d0d33cd44( "vehicles", var_d7cdbfc2868c8ecd, var_955d4e8d65b9a348, var_4461dc53e879a8b, vehiclecount );
    }
    
    if ( var_13de8a19948f49e8 )
    {
        function_d30353d0d33cd44( "entities", var_d7cdbfc2868c8ecd, var_955d4e8d65b9a348, var_4461dc53e879a8b, var_13de8a19948f49e8 );
    }
    
    if ( scriptablecount )
    {
        function_d30353d0d33cd44( "scriptables", var_d7cdbfc2868c8ecd, var_955d4e8d65b9a348, var_4461dc53e879a8b, scriptablecount );
    }
}

// Namespace ob_resource_manager
// Params 0, eflags: 0x4
// Checksum 0xacd760e9, Offset: 0x1cc4
// Size: 0x614
function private function_52126d875f245349()
{
    while ( true )
    {
        wait 1;
        
        if ( getdvarint( @"hash_18f2ea3d7c6ff542", 0 ) == 0 )
        {
            continue;
        }
        
        shoulddump = getdvarint( @"rm_dump", 0 );
        
        if ( shoulddump )
        {
            setdvar( @"rm_dump", 0 );
            logstring( "[RM] Dump Begin =====================================" );
            var_2c8295f0b1c8c4f9 = [];
            
            foreach ( activityinstance in level.activities.instances )
            {
                text = activityinstance.varianttag;
                instance_state = activityinstance.state;
                logstring( "[RM] activity instance:" + text + " | State:" + instance_state );
                
                foreach ( resourcetype, limit in activityinstance.var_d3254054df6fc17a )
                {
                    used = activityinstance.var_41964d9110b1cf5[ resourcetype ].size ?? 0;
                    
                    if ( !used && !limit )
                    {
                        continue;
                    }
                    
                    text = resourcetype + " " + used + " / " + limit;
                    logstring( "[RM]     " + text );
                    
                    if ( !isdefined( var_2c8295f0b1c8c4f9[ resourcetype ] ) )
                    {
                        var_2c8295f0b1c8c4f9[ resourcetype ] = { #var_b7c765711f3f79eb:0, #current:0 };
                    }
                    
                    var_2c8295f0b1c8c4f9[ resourcetype ].current += used;
                    var_2c8295f0b1c8c4f9[ resourcetype ].var_b7c765711f3f79eb += limit;
                }
            }
            
            if ( isdefined( level.var_b447b86d9f2c6586.var_e89c1ce0df45b5c7.var_41964d9110b1cf5 ) )
            {
                logstring( "[RM] Ambient Resources" );
                
                foreach ( resourcetype, resources in level.var_b447b86d9f2c6586.var_e89c1ce0df45b5c7.var_41964d9110b1cf5 )
                {
                    if ( resources.size == 0 )
                    {
                        continue;
                    }
                    
                    text = resourcetype + " " + resources.size;
                    logstring( "[RM] " + text );
                    
                    if ( !isdefined( var_2c8295f0b1c8c4f9[ resourcetype ] ) )
                    {
                        var_2c8295f0b1c8c4f9[ resourcetype ] = 0;
                    }
                    
                    var_2c8295f0b1c8c4f9[ resourcetype ].current += resources.size;
                }
            }
            
            logstring( "[RM] Dump Spawn Counts ==============================" );
            
            foreach ( resourcetype, count in var_2c8295f0b1c8c4f9 )
            {
                var_9ba55644dfb96131 = level.var_b447b86d9f2c6586.var_134b19f98368bff0[ resourcetype ];
                text = resourcetype + " spawn:" + count.current + " alloc:" + count.var_b7c765711f3f79eb + " limit:" + var_9ba55644dfb96131;
                logstring( "[RM] " + text );
            }
        }
        
        foreach ( resourcetype, count in level.var_b447b86d9f2c6586.var_4d31ff9ee6ed3974 )
        {
            var_9ba55644dfb96131 = level.var_b447b86d9f2c6586.var_134b19f98368bff0[ resourcetype ];
            
            if ( count >= var_9ba55644dfb96131 * 0.85 || shoulddump )
            {
                logstring( "[RM] High resource usage:" + resourcetype + " " + count + " / " + var_9ba55644dfb96131 );
                
                if ( resourcetype == "scriptables" )
                {
                    var_ebc7a908c778aece = function_7bcc0dcd4d7ee24f();
                    logstring( "[RM] Free scriptables:" + var_ebc7a908c778aece );
                }
            }
        }
        
        foreach ( resourcetype, activities in level.var_b447b86d9f2c6586.var_586b30d2c3c0f071 )
        {
            if ( resourcetype == "scriptables" )
            {
                continue;
            }
            
            if ( activities.size == 0 )
            {
                continue;
            }
            
            count = 0;
            
            foreach ( activityname, resources in activities )
            {
                count += resources.size;
                
                if ( shoulddump && resources.size > 0 )
                {
                    logstring( "[RM] Dump Unreleased resources:" + resourcetype + " count:" + resources.size + " activity:" + activityname );
                }
            }
            
            if ( count > 0 )
            {
                logstring( "[RM] Unreleased resources:" + resourcetype + " count:" + count );
            }
        }
    }
}

