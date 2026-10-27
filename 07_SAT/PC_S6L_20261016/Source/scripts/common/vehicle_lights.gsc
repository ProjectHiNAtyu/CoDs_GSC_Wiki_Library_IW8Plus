// scripts\common\vehicle_lights.gsc  (hash_1dafaebc95981b6e.gscc) (size: 3438 Bytes / 0xd6e / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x31f8c92 (52399250)
// size ...... 3438 (0xd6e)
// includes .. 2   (offset: 0xcc6)
// strings ... 8   (offset: 0xcd6)
// dev strs .. 4   (offset: 0xd3e)
// exports ... 8   (offset: 0x916)
// cseg ...... 0x9d + 0x879 (0x916)
// imports ... 21  (offset: 0xa56)
// animtree1 . 0   (offset: 0xd6e)
// animtree2 . 0   (offset: 0xd6e)
#using scripts\common\utility;
#using scripts\common\vehicle;

#namespace vehicle_lights;

// Namespace vehicle_lights
// Params 2
// Checksum 0xa4b20ece, Offset: 0xbb
// Size: 0x3c
function lights_on( group, classname )
{
    groups = strtok( group, " " );
    utility::array_levelthread( groups, &lights_on_internal, classname );
}

// Namespace vehicle_lights
// Params 3
// Checksum 0x5cef6448, Offset: 0xff
// Size: 0x1c4
function group_light( model, name, group )
{
    if ( !isdefined( level.vehicle.templates.vehicle_lights_group ) )
    {
        level.vehicle.templates.vehicle_lights_group = [];
    }
    
    if ( !isdefined( level.vehicle.templates.vehicle_lights_group[ model ] ) )
    {
        level.vehicle.templates.vehicle_lights_group[ model ] = [];
    }
    
    if ( !isdefined( level.vehicle.templates.vehicle_lights_group[ model ][ group ] ) )
    {
        level.vehicle.templates.vehicle_lights_group[ model ][ group ] = [];
    }
    
    foreach ( lightgroup_name in level.vehicle.templates.vehicle_lights_group[ model ][ group ] )
    {
        if ( name == lightgroup_name )
        {
            return;
        }
    }
    
    level.vehicle.templates.vehicle_lights_group[ model ][ group ][ level.vehicle.templates.vehicle_lights_group[ model ][ group ].size ] = name;
}

// Namespace vehicle_lights
// Params 0
// Checksum 0xceef8c8f, Offset: 0x2cb
// Size: 0x7a
function lights_delayfxforframe()
{
    level notify( #"new_lights_delayfxforframe" );
    level endon( #"new_lights_delayfxforframe" );
    
    if ( !isdefined( level.fxdelay ) )
    {
        level.fxdelay = 0;
    }
    
    level.fxdelay += randomfloatrange( 0.2, 0.4 );
    
    if ( level.fxdelay > 2 )
    {
        level.fxdelay = 0;
    }
    
    wait 0.05;
    level.fxdelay = undefined;
}

// Namespace vehicle_lights
// Params 3
// Checksum 0xd704b194, Offset: 0x34d
// Size: 0x254
function lights_off_internal( group, model, classname )
{
    self notify( #"lights_off" );
    
    if ( isdefined( classname ) )
    {
        model = classname;
    }
    else if ( !isdefined( model ) )
    {
        model = self.classname_mp ?? self.classname;
    }
    
    if ( !isdefined( group ) )
    {
        group = "all";
    }
    
    if ( !isdefined( self.lights ) )
    {
        return;
    }
    
    if ( !isdefined( level.vehicle.templates.vehicle_lights_group[ model ][ group ] ) )
    {
        /#
            println( "<dev string:x24>" + self.vehicletype );
            println( "<dev string:x32>" + self.classname );
            println( "<dev string:x3e>" + group );
        #/
        
        assertmsg( "<dev string:x4c>" );
        return;
    }
    
    lights = level.vehicle.templates.vehicle_lights_group[ model ][ group ];
    count = 0;
    maxlightstopsperframe = 2;
    
    if ( isdefined( self.maxlightstopsperframe ) )
    {
        maxlightstopsperframe = self.maxlightstopsperframe;
    }
    
    foreach ( light in lights )
    {
        template = level.vehicle.templates.vehicle_lights[ model ][ light ];
        
        if ( template.isscriptable )
        {
            utility::function_7c10ea82c1e305b8( template.part, "off" );
        }
        else if ( utility::hastag( self.model, template.tag ) )
        {
            stopfxontag( template.effect, self, template.tag );
            count++;
            
            if ( count >= maxlightstopsperframe )
            {
                count = 0;
                wait 0.05;
            }
        }
        
        if ( !isdefined( self ) )
        {
            return;
        }
        
        self.lights[ light ] = undefined;
    }
}

// Namespace vehicle_lights
// Params 2
// Checksum 0xd34a2001, Offset: 0x5a9
// Size: 0x2e2
function lights_on_internal( group, model )
{
    level.lastlighttime = gettime();
    self endon( #"lights_off" );
    self endon( #"death" );
    
    if ( !isdefined( group ) )
    {
        group = "all";
    }
    
    if ( !isdefined( model ) )
    {
        model = self.classname_mp ?? self.classname;
    }
    
    if ( !isdefined( level.vehicle.templates.vehicle_lights_group ) )
    {
        return;
    }
    
    if ( !isdefined( level.vehicle.templates.vehicle_lights_group[ model ][ group ] ) )
    {
        return;
    }
    
    thread lights_delayfxforframe();
    
    if ( !isdefined( self.lights ) )
    {
        self.lights = [];
    }
    
    lights = level.vehicle.templates.vehicle_lights_group[ model ][ group ];
    var_6004cbf2423b4969 = [];
    
    foreach ( light in lights )
    {
        if ( isdefined( self.lights[ light ] ) )
        {
            continue;
        }
        
        template = level.vehicle.templates.vehicle_lights[ model ][ light ];
        
        if ( isdefined( template.delay ) )
        {
            delay = template.delay;
        }
        else
        {
            delay = 0;
        }
        
        delay += level.fxdelay;
        
        while ( isdefined( var_6004cbf2423b4969[ string( delay ) ] ) )
        {
            delay += 0.05;
        }
        
        var_6004cbf2423b4969[ string( delay ) ] = 1;
        
        if ( template.isscriptable )
        {
            if ( vehicle::function_dfa3d2eee203d2d3( template.part ) )
            {
                if ( group == "brakelights" )
                {
                    utility::delaythread( delay, &utility::function_7c10ea82c1e305b8, template.part, "brake" );
                }
                else if ( group == "daylights" )
                {
                    utility::delaythread( delay, &utility::function_7c10ea82c1e305b8, template.part, "day" );
                }
                else
                {
                    utility::delaythread( delay, &utility::function_7c10ea82c1e305b8, template.part, "on" );
                }
            }
        }
        else
        {
            childthread function_ef6384b76b1f62c6( delay, template.effect, self, template.tag );
        }
        
        self.lights[ light ] = 1;
        
        if ( !isdefined( self ) )
        {
            break;
        }
    }
    
    level.fxdelay = 0;
}

// Namespace vehicle_lights
// Params 4, eflags: 0x4
// Checksum 0xee85f02a, Offset: 0x893
// Size: 0x33
function private function_ef6384b76b1f62c6( timer, effect, entity, tag )
{
    wait timer;
    playfxontag( effect, entity, tag );
}

// Namespace vehicle_lights
// Params 3
// Checksum 0xefc74f63, Offset: 0x8ce
// Size: 0x48
function lights_off( group, model, classname )
{
    groups = strtok( group, " ", model );
    utility::array_levelthread( groups, &lights_off_internal, model, classname );
}

