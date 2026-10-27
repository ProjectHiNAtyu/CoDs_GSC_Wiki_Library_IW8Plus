// scripts\mp\ob\systems\ob_resource_manager_debug.gsc  (hash_5cc4a9ffe5bb8433.gscc) (size: 3658 Bytes / 0xe4a / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x16e85766 (384325478)
// size ...... 3658 (0xe4a)
// includes .. 1   (offset: 0xcb2)
// strings ... 0   (offset: 0xcba)
// dev strs .. 30  (offset: 0xcba)
// exports ... 3   (offset: 0xa9a)
// cseg ...... 0x58 + 0xa42 (0xa9a)
// imports ... 10  (offset: 0xb12)
// animtree1 . 0   (offset: 0xe4a)
// animtree2 . 0   (offset: 0xe4a)
#using scripts\common\devgui;

#namespace ob_resource_manager_debug;

/#

    // Namespace ob_resource_manager_debug
    // Params 0
    // Checksum 0x12c1c3e5, Offset: 0x76
    // Size: 0x75, Type: dev
    function ob_resource_manager_debug_init()
    {
        devgui::function_9082edeb5db93280( "<dev string:x24>" );
        devgui::add_devgui_command( "<dev string:x44>", "<dev string:x50>" );
        devgui::add_devgui_command( "<dev string:x64>", "<dev string:x6f>" );
        devgui::add_devgui_command( "<dev string:x83>", "<dev string:x99>" );
        devgui::add_devgui_command( "<dev string:xad>", "<dev string:xc2>" );
        devgui::add_devgui_command( "<dev string:xe0>", "<dev string:xeb>" );
        devgui::function_77df7fe7dd273e10();
        level thread ob_resource_manager_debug_draw();
    }

    // Namespace ob_resource_manager_debug
    // Params 0
    // Checksum 0xe44d4d98, Offset: 0xf3
    // Size: 0x9a7, Type: dev
    function ob_resource_manager_debug_draw()
    {
        level endon( #"game_ended" );
        var_f646066634df681c = ( 0.43, 0.63, 0.84 );
        color_map = [];
        color_map[ "<dev string:xf9>" ] = ( 0.71, 0.43, 0.83 );
        color_map[ "<dev string:x102>" ] = ( 0.81, 0.63, 0.25 );
        color_map[ "<dev string:x10b>" ] = ( 1, 1, 1 );
        setdvarifuninitialized( @"hash_f146b9c2cd2cb32d", "<dev string:x117>" );
        
        while ( true )
        {
            var_3b73b9804bfbfff2 = getdvarint( @"rm_debug_draw", 0 );
            filteredactivity = getdvar( @"hash_f146b9c2cd2cb32d" );
            
            if ( var_3b73b9804bfbfff2 > 0 )
            {
                posx = getdvarint( @"hash_766610262af4d734", 2050 );
                posy = getdvarint( @"hash_766611262af4d967", 50 );
                linespacing = 20;
                scale = 1.4;
                var_4d44f1616544beba = 0.8;
                printtoscreen2d( posx, posy, "<dev string:x11c>", var_f646066634df681c, scale );
                posy += linespacing;
                printtoscreen2d( posx, posy, "<dev string:x134>", var_f646066634df681c, scale );
                posy += linespacing;
                var_ebc7a908c778aece = function_7bcc0dcd4d7ee24f();
                
                foreach ( resourcetype, count in level.var_b447b86d9f2c6586.var_4d31ff9ee6ed3974 )
                {
                    var_9ba55644dfb96131 = level.var_b447b86d9f2c6586.var_134b19f98368bff0[ resourcetype ];
                    text = resourcetype + "<dev string:x144>" + count + "<dev string:x14c>" + var_9ba55644dfb96131;
                    
                    if ( resourcetype == "<dev string:x10b>" )
                    {
                        var_ebc7a908c778aece = function_7bcc0dcd4d7ee24f();
                        text += "<dev string:x154>" + var_ebc7a908c778aece;
                    }
                    else if ( resourcetype == "<dev string:x102>" )
                    {
                        text += "<dev string:x154>" + level.maxvehiclecount - level.vehiclecount;
                    }
                    
                    if ( count >= var_9ba55644dfb96131 * var_4d44f1616544beba )
                    {
                        printtoscreen2d( posx, posy, text, ( 1, 0, 0 ), scale );
                    }
                    else
                    {
                        printtoscreen2d( posx, posy, text, color_map[ resourcetype ], scale );
                    }
                    
                    posy += linespacing;
                }
                
                printtoscreen2d( posx, posy, "<dev string:x15b>", var_f646066634df681c, scale );
                posy += linespacing;
                var_2c8295f0b1c8c4f9 = [];
                
                foreach ( activityinstance in level.activities.instances )
                {
                    if ( isdefined( activityinstance.var_41964d9110b1cf5 ) )
                    {
                        foreach ( resourcetype, resources in activityinstance.var_41964d9110b1cf5 )
                        {
                            if ( resourcetype == "<dev string:x10b>" )
                            {
                                continue;
                            }
                            
                            if ( !isdefined( var_2c8295f0b1c8c4f9[ resourcetype ] ) )
                            {
                                var_2c8295f0b1c8c4f9[ resourcetype ] = 0;
                            }
                            
                            var_2c8295f0b1c8c4f9[ resourcetype ] += resources.size;
                        }
                    }
                }
                
                foreach ( resourcetype, count in var_2c8295f0b1c8c4f9 )
                {
                    var_9ba55644dfb96131 = level.var_b447b86d9f2c6586.var_134b19f98368bff0[ resourcetype ];
                    text = resourcetype + "<dev string:x16f>" + count + "<dev string:x14c>" + var_9ba55644dfb96131;
                    
                    if ( count >= var_9ba55644dfb96131 * var_4d44f1616544beba )
                    {
                        printtoscreen2d( posx, posy, text, ( 1, 0, 0 ), scale );
                    }
                    else
                    {
                        printtoscreen2d( posx, posy, text, color_map[ resourcetype ], scale );
                    }
                    
                    posy += linespacing;
                }
                
                if ( isdefined( level.var_b447b86d9f2c6586.counts[ "<dev string:x177>" ] ) )
                {
                    printtoscreen2d( posx, posy, "<dev string:x17f>", var_f646066634df681c, scale );
                }
                
                posy += linespacing;
                
                foreach ( resourcetype, count in level.var_b447b86d9f2c6586.counts[ "<dev string:x177>" ] )
                {
                    if ( count == 0 )
                    {
                        continue;
                    }
                    
                    text = resourcetype + "<dev string:x16f>" + count;
                    printtoscreen2d( posx, posy, text, color_map[ resourcetype ], scale );
                    posy += linespacing;
                }
                
                if ( istrue( level.var_b447b86d9f2c6586.profileenabled ) )
                {
                    printtoscreen2d( posx, posy, "<dev string:x192>", ( 0.8, 0.8, 0 ), scale );
                    posy += linespacing;
                    
                    foreach ( resourcetype, activities in level.var_b447b86d9f2c6586.var_586b30d2c3c0f071 )
                    {
                        if ( resourcetype == "<dev string:x10b>" )
                        {
                            continue;
                        }
                        
                        text = resourcetype;
                        printtoscreen2d( posx, posy, text, color_map[ resourcetype ], scale );
                        posy += linespacing;
                        
                        foreach ( var_416ff904fb92f911, resources in activities )
                        {
                            if ( resources.size == 0 )
                            {
                                continue;
                            }
                            
                            text = var_416ff904fb92f911 + "<dev string:x1a1>" + resources.size;
                            printtoscreen2d( posx, posy, text, ( 1, 1, 1 ), scale );
                            posy += linespacing;
                        }
                    }
                }
                
                if ( var_3b73b9804bfbfff2 == 2 )
                {
                    printtoscreen2d( posx, posy, "<dev string:x1a4>", var_f646066634df681c, scale );
                    posy += linespacing;
                    
                    foreach ( activityinstance in level.activities.instances )
                    {
                        if ( isdefined( activityinstance.var_41964d9110b1cf5 ) )
                        {
                            if ( filteredactivity != "<dev string:x117>" && filteredactivity != activityinstance.type )
                            {
                                continue;
                            }
                            
                            text = activityinstance.varianttag;
                            printtoscreen2d( posx, posy, text, ( 1, 1, 1 ), scale );
                            posy += linespacing;
                            
                            foreach ( resourcetype, resources in activityinstance.var_41964d9110b1cf5 )
                            {
                                if ( resources.size == 0 )
                                {
                                    continue;
                                }
                                
                                color = color_map[ resourcetype ];
                                
                                if ( resources.size > activityinstance.var_d3254054df6fc17a[ resourcetype ] )
                                {
                                    color = ( 1, 0, 0 );
                                }
                                
                                text = resourcetype + "<dev string:x1c8>" + resources.size + "<dev string:x1ca>" + activityinstance.var_d3254054df6fc17a[ resourcetype ];
                                printtoscreen2d( posx, posy, text, color, scale );
                                posy += linespacing;
                            }
                        }
                    }
                }
                
                printtoscreen2d( posx, posy, "<dev string:x1ce>", var_f646066634df681c, scale );
                posy += linespacing;
                
                foreach ( activityclassname, activitycounts in level.var_b447b86d9f2c6586.counts )
                {
                    text = activityclassname;
                    printtoscreen2d( posx, posy, text, ( 1, 1, 1 ), scale );
                    posy += linespacing;
                    
                    foreach ( resourcetype, count in activitycounts )
                    {
                        if ( count == 0 )
                        {
                            continue;
                        }
                        
                        text = resourcetype + "<dev string:x144>" + count;
                        printtoscreen2d( posx, posy, text, color_map[ resourcetype ], scale );
                        posy += linespacing;
                    }
                }
            }
            
            waitframe();
        }
    }

#/
