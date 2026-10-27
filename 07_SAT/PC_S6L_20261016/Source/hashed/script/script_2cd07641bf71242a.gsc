// script_2cd07641bf71242a  (hash_2cd07641bf71242a.gscc) (size: 23930 Bytes / 0x5d7a / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x56de70f5 (1457418485)
// size ...... 23930 (0x5d7a)
// includes .. 9   (offset: 0x58d2)
// strings ... 32  (offset: 0x591a)
// dev strs .. 34  (offset: 0x5ba6)
// exports ... 38  (offset: 0x42be)
// cseg ...... 0x26b + 0x4053 (0x42be)
// imports ... 115 (offset: 0x48ae)
// animtree1 . 0   (offset: 0x5d7a)
// animtree2 . 0   (offset: 0x5d7a)
#using scripts\asm\asm;
#using scripts\asm\traverse;
#using scripts\common\ai;
#using scripts\common\callbacks;
#using scripts\common\math;
#using scripts\common\trace;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\common\vortex;

#namespace zombie_traverse_asm;

// Namespace zombie_traverse_asm
// Params 0
// Checksum 0xd614227f, Offset: 0x289
// Size: 0x1e
function init_zombie_traverse_asm()
{
    self.handletraversewarpnotetracksfn = &function_52bac7cd13f9f6d7;
    self.var_5e505729e7585103 = &traverse::function_b1f841aaaec3f50b;
}

// Namespace zombie_traverse_asm
// Params 3
// Checksum 0x3fe8fe51, Offset: 0x2af
// Size: 0x2db
function function_589bb49260cf5997( asmname, statename, params )
{
    self endon( #"death" );
    self endon( #"terminate_ai_threads" );
    self endon( statename + "_finished" );
    startnode = undefined;
    
    if ( self.var_15c6e27c1acff47e == "node_based" )
    {
        startnode = self getnegotiationstartnode();
        
        if ( !isdefined( startnode ) )
        {
            startnode = self.traversal_start_node;
        }
        
        assert( isdefined( startnode ) );
    }
    
    startpos = undefined;
    endpos = undefined;
    
    if ( self.var_15c6e27c1acff47e == "nodeless" || self.var_15c6e27c1acff47e == "linkless" )
    {
        if ( self.var_15c6e27c1acff47e == "linkless" && self.var_ef53ce9913fe1a35 == "fence" )
        {
            var_bfbd522a221be6d9 = &traverse::function_e51c2dd7b73c2c61;
        }
        else if ( self.var_15c6e27c1acff47e == "nodeless" )
        {
            var_bfbd522a221be6d9 = &traverse::function_b4671daaf4716143;
        }
        
        assert( isdefined( var_bfbd522a221be6d9 ), "<dev string:x24>" );
        self.var_9d40c8bd8f7a879 = self [[ var_bfbd522a221be6d9 ]]();
        startpos = self.var_9d40c8bd8f7a879.origin;
        endpos = self.var_9d40c8bd8f7a879.endpos;
    }
    else if ( self.var_15c6e27c1acff47e == "node_based" )
    {
        startpos = startnode.origin;
        endpos = self getnegotiationendpos();
        
        if ( !isdefined( endpos ) )
        {
            endnode = self getnegotiationendnode();
            
            if ( !isdefined( endnode ) && isdefined( self.traversal_end_node ) )
            {
                endpos = self.traversal_end_node.origin;
            }
        }
    }
    
    if ( isdefined( endpos ) )
    {
        if ( ai::is_floating() )
        {
            startpos += ( 0, 0, self.var_ed3c19fec55b26cc );
            endpos += ( 0, 0, max( self.var_69623111d7e6b9a4 - self.var_87edd2358c253b2c, 0 ) );
        }
        
        self forceteleport( endpos, self.angles );
        
        /#
            animscript = "<dev string:x72>";
            var_97678767b299ec07 = "<dev string:x72>";
            
            if ( isdefined( startnode ) && isdefined( startnode.animscript ) )
            {
                animscript = "<dev string:x73>" + startnode.animscript + "<dev string:x80>";
                var_97678767b299ec07 = "<dev string:x84>" + ( startnode.traverse_data_calculated ? "<dev string:x91>" : "<dev string:x96>" );
            }
            
            println( "<dev string:x9c>" + startpos + "<dev string:x80>" + animscript + var_97678767b299ec07 );
            record3dtext( "<dev string:xee>" + animscript + var_97678767b299ec07, self.origin + ( 0, 0, 70 ), ( 1, 0, 1 ) );
        #/
    }
    
    traverse::terminatetraverse( asmname, statename );
}

// Namespace zombie_traverse_asm
// Params 3
// Checksum 0x3b65ca17, Offset: 0x592
// Size: 0x5f
function function_ca53ae0c0b57bfdd( asmname, statename, params )
{
    /#
        if ( self.var_15c6e27c1acff47e == "<dev string:x10e>" )
        {
            assert( isdefined( self.var_fa685a7668b11923 ), "<dev string:x117>" + self.origin );
        }
    #/
    
    traverse::calctraversetype( asmname, statename, params );
}

// Namespace zombie_traverse_asm
// Params 1, eflags: 0x4
// Checksum 0x2bebbf67, Offset: 0x5f9
// Size: 0x14c
function private function_52bac7cd13f9f6d7( note )
{
    if ( note == "warp_arrival_start" )
    {
        if ( self.var_15c6e27c1acff47e == "nodeless" || self.var_15c6e27c1acff47e == "linkless" )
        {
            if ( !isdefined( self.var_9d40c8bd8f7a879 ) )
            {
                println( "<dev string:x14b>" + self.var_15c6e27c1acff47e + "<dev string:x185>" );
                return;
            }
            
            targetangles = self.var_9d40c8bd8f7a879.angles;
        }
        else
        {
            if ( !isdefined( self.traversestartnode ) )
            {
                println( "<dev string:x1b4>" + self.var_15c6e27c1acff47e + "<dev string:x1e8>" );
                return;
            }
            
            targetangles = self.traversestartnode.angles;
        }
        
        if ( isdefined( targetangles ) )
        {
            yaw_diff = absangleclamp180( targetangles[ 1 ] - self.angles[ 1 ] );
            yaw_diff_threshold = 45;
            
            if ( yaw_diff > yaw_diff_threshold )
            {
                thread function_3fd9989e66a850a( targetangles[ 1 ] );
                
                /#
                    print3d( self.origin + ( 10, 0, 0 ), "<dev string:x216>" + yaw_diff, ( 1, 1, 0.9 ), 0.8, 0.5 );
                #/
            }
        }
    }
}

// Namespace zombie_traverse_asm
// Params 1, eflags: 0x4
// Checksum 0x5649d514, Offset: 0x74d
// Size: 0x165
function private function_3fd9989e66a850a( target_yaw )
{
    rotation_speed_const = 200;
    var_a4b1870fcefddc6f = 360;
    self endon( #"death" );
    yaw = self.angles[ 1 ];
    var_fbae2ab9067926e3 = 0;
    
    while ( yaw != target_yaw && self.var_a4d7ad445f64c817 )
    {
        yaw = self.angles[ 1 ];
        var_c464a2d2aa68df50 = level.framedurationseconds * rotation_speed_const;
        diff = angleclamp180( target_yaw - yaw );
        new_yaw = undefined;
        
        if ( abs( diff ) < var_c464a2d2aa68df50 )
        {
            new_yaw = target_yaw;
        }
        else
        {
            if ( abs( diff ) > 90 || var_fbae2ab9067926e3 )
            {
                var_c464a2d2aa68df50 = level.framedurationseconds * var_a4b1870fcefddc6f;
                var_fbae2ab9067926e3 = 1;
            }
            
            new_yaw = yaw + utility::sign( diff ) * var_c464a2d2aa68df50;
        }
        
        new_angles = ( self.angles[ 0 ], new_yaw, self.angles[ 2 ] );
        self.angles = new_angles;
        yaw = new_yaw;
        
        /#
            print3d( self.origin + ( 10, 0, 0 ), "<dev string:x244>" + new_yaw, ( 1, 1, 0.9 ), 0.8, 0.5 );
        #/
        
        waitframe();
    }
}

// Namespace zombie_traverse_asm
// Params 3
// Checksum 0x5ca0b6c2, Offset: 0x8ba
// Size: 0x7c0
function function_952391a84bcf8748( asmname, statename, params )
{
    self.var_28343eb233cd40f = self getpath();
    
    if ( !callback::exists( "on_zombie_ai_killed", &function_26a0baf6e09439b7 ) )
    {
        callback::add( "on_zombie_ai_killed", &function_26a0baf6e09439b7 );
    }
    
    self.var_7069b475f40888c3 = self.var_ebd26f6520cc1e89;
    self.var_ebd26f6520cc1e89 = 0;
    self.var_a6a05cdb7d779829 = self.turnrate;
    self.turnrate = 0.8;
    self.var_507d3f5433b78f74 = 0;
    self.traversal_start_node = function_8805543e0ba78b2c();
    
    if ( !isdefined( self.traversal_start_node ) )
    {
        getendnode = self getnegotiationendnode();
        
        if ( isdefined( getendnode ) )
        {
            self forceteleport( getendnode.origin, getendnode.angles );
        }
        else
        {
            var_da0a72fcf51810 = self getpath();
            
            if ( var_da0a72fcf51810.size > 0 )
            {
                self forceteleport( var_da0a72fcf51810[ var_da0a72fcf51810.size - 1 ], self.angles );
            }
            else
            {
                self kill();
            }
        }
        
        function_8aed51f0a595a877( asmname, statename );
        asm::asm_fireevent( asmname, "wall_crawl_interrupt" );
        return;
    }
    
    if ( isdefined( self.traversal_start_node ) && !self.traversal_start_node.traverse_data_calculated )
    {
        asm::function_83faa08e56039deb( self.traversal_start_node );
    }
    
    if ( self.traversal_start_node.var_9e6ad2387360eba9 && self.var_720018aa0a425283 )
    {
        self._blackboard.var_697a504d7c395146 = 1;
    }
    
    if ( self.traversal_start_node.var_f4e44cfbed574505 )
    {
        self.forceannihilate = 1;
    }
    
    assert( isdefined( self.traversal_start_node ), "<dev string:x272>" );
    
    if ( self.traversal_start_node.var_b7f89eae9e2e5c8c )
    {
        self._blackboard.var_a6db4b2fd6e741cc = 1;
    }
    
    getendnode = self getnegotiationendnode();
    
    if ( isdefined( getendnode ) )
    {
        self.traversal_end_node = getendnode;
    }
    
    self.var_566c37085d619bf1 = self getnegotiationendpos();
    
    if ( !( isdefined( self.traversal_start_node.wall_nodes ) && isdefined( self.traversal_start_node.wall_angles ) ) || self.traversal_start_node.wall_nodes.size < 2 || self.traversal_start_node.wall_nodes.size != self.traversal_start_node.wall_angles.size || !isdefined( self.var_566c37085d619bf1 ) )
    {
        self forceteleport( self.traversal_end_node.origin, self.traversal_end_node.angles );
        function_8aed51f0a595a877( asmname, statename );
        asm::asm_fireevent( asmname, "wall_crawl_interrupt" );
        return;
    }
    
    assert( isdefined( self.traversal_end_node ), "<dev string:x294>" );
    assert( self.traversal_start_node.wall_nodes.size >= 2 && self.traversal_start_node.wall_angles.size >= 2 && self.traversal_start_node.wall_nodes.size == self.traversal_start_node.wall_angles.size, "<dev string:x2b4>" );
    assert( isdefined( self.var_566c37085d619bf1 ), "<dev string:x2d5>" );
    var_6dbd2b4ddc5ae349 = self.traversal_start_node.origin - self.traversal_start_node.wall_nodes[ 0 ];
    var_ca741af9725130a0 = anglestoup( self.traversal_start_node.wall_angles[ 0 ] );
    var_8f3e6605a09ba74d = anglestoup( self.traversal_start_node.wall_angles[ 1 ] );
    self._blackboard.var_a9547fcd63ee1bfa = vectordot( var_ca741af9725130a0, var_8f3e6605a09ba74d ) < 0.98 && self.traversal_start_node.wall_nodes[ 0 ][ 2 ] > self.traversal_start_node.origin[ 2 ] && self.traversal_start_node.wall_nodes[ 0 ][ 2 ] > self.traversal_start_node.wall_nodes[ 1 ][ 2 ];
    var_30cd5be92c80b68d = vectordot( var_ca741af9725130a0, var_6dbd2b4ddc5ae349 ) < 0 && !self._blackboard.var_a9547fcd63ee1bfa;
    
    if ( var_30cd5be92c80b68d )
    {
        self.var_914cc10272d9f32c = 1;
        asm::asm_fireevent( asmname, "wall_transition_end" );
        return;
    }
    
    traversalattributes = spawnstruct();
    traversalattributes.startpos = self.traversal_start_node.origin;
    traversalattributes.endpos = self.traversal_start_node.wall_nodes[ 0 ];
    
    if ( self._blackboard.var_a9547fcd63ee1bfa )
    {
        var_28d0cf2b96f94962 = anglestoforward( self.traversal_start_node.wall_angles[ 0 ] );
        var_8af34bfde34d6147 = vectorcross( var_28d0cf2b96f94962, var_ca741af9725130a0 );
        var_6429ef0f73aa3b6a = axistoangles( var_28d0cf2b96f94962, var_8af34bfde34d6147, var_ca741af9725130a0 );
        traversalattributes.angles = var_6429ef0f73aa3b6a;
    }
    else
    {
        var_5b037cba2a135d6 = self.traversal_start_node.wall_nodes[ 1 ] - self.traversal_start_node.wall_nodes[ 0 ];
        var_28c901cd02a09fc3 = vectornormalize( var_5b037cba2a135d6 );
        
        if ( var_5b037cba2a135d6[ 0 ] != 0 || var_5b037cba2a135d6[ 1 ] != 0 )
        {
            var_8af34bfde34d6147 = vectorcross( var_28c901cd02a09fc3, var_ca741af9725130a0 );
            var_6429ef0f73aa3b6a = axistoangles( var_28c901cd02a09fc3, var_8af34bfde34d6147, var_ca741af9725130a0 );
            traversalattributes.angles = var_6429ef0f73aa3b6a;
        }
        else
        {
            var_e3b44ee56789bdf1 = vectortoyaw( -1 * var_ca741af9725130a0 );
            traversalattributes.angles = ( vectortopitch( var_28c901cd02a09fc3 ), var_e3b44ee56789bdf1, self.angles[ 2 ] );
        }
    }
    
    self settraversalattributes( traversalattributes.startpos, traversalattributes.endpos, traversalattributes.angles, traversalattributes.endpos );
    animid = asm::asm_getanim( asmname, statename );
    assert( isdefined( animid ), "<dev string:x2fb>" );
    
    if ( !isdefined( animid ) )
    {
        self forceteleport( self.traversal_end_node.origin, self.traversal_end_node.angles );
        function_8aed51f0a595a877( asmname, statename );
        asm::asm_fireevent( asmname, "wall_crawl_interrupt" );
        return;
    }
    
    animalias = self function_30c9365bb7f9ea96( statename, animid );
    assert( isdefined( animalias ), "<dev string:x31c>" );
    
    if ( !isdefined( animalias ) )
    {
        self forceteleport( self.traversal_end_node.origin, self.traversal_end_node.angles );
        function_8aed51f0a595a877( asmname, statename );
        asm::asm_fireevent( asmname, "wall_crawl_interrupt" );
        return;
    }
    
    if ( animalias == "right" || animalias == "left" )
    {
        self orientmode( "face angle 3d", self.traversal_start_node.angles );
        thread function_9c2d6bc3f5fa55ea( asmname, statename, animid, 0, 1 );
        return;
    }
    
    thread function_986acd9354c7aed6( asmname, statename, animid, traversalattributes.angles, 0, 1 );
}

// Namespace zombie_traverse_asm
// Params 3
// Checksum 0x9758ac2d, Offset: 0x1082
// Size: 0x28
function function_b1ff6bb4c80d22b1( asmname, statename, params )
{
    thread function_7747e3c6de6f0749( asmname, statename );
}

// Namespace zombie_traverse_asm
// Params 2
// Checksum 0x6190a318, Offset: 0x10b2
// Size: 0x9a0
function function_7747e3c6de6f0749( asmname, statename )
{
    self endon( #"death" );
    self endon( #"terminate_ai_threads" );
    self endon( statename + "_finished" );
    var_8c7aa5fe4e38c178 = 200;
    function_9bc26f59839423be( asmname, statename );
    debugframes = getdvarint( @"hash_507099c93f31940f", 0 );
    lastpos = self.origin;
    
    if ( !isdefined( self.var_5a803392d461261e ) )
    {
        function_f36b84ed92576116();
        
        if ( self._blackboard.var_697a504d7c395146 )
        {
            self._blackboard.var_f8f294eaa70c3a52 = gettime();
            
            if ( self._blackboard.var_1d29076b12111692 > 0 )
            {
                self._blackboard.var_f8f294eaa70c3a52 += randomfloatrange( 0, self._blackboard.var_1d29076b12111692 );
            }
        }
    }
    
    for ( var_b40975095284c393 = self.var_5a803392d461261e.var_b40975095284c393; var_b40975095284c393 < self.traversal_start_node.wall_nodes.size - 1 ; var_b40975095284c393++ )
    {
        if ( !self._blackboard.var_ba73f2df320d70cd )
        {
            if ( self.var_edd82a39e229c72d )
            {
                self.var_5a803392d461261e.var_b5d4104aea3e2010 = self.var_5bdb50b5148e8241[ 2 ];
            }
            else
            {
                self.var_5a803392d461261e.var_b5d4104aea3e2010 = self.traversal_start_node.wall_nodes[ var_b40975095284c393 ];
            }
            
            self.var_5a803392d461261e.var_ad83db4ee270db1b = self.traversal_start_node.wall_nodes[ var_b40975095284c393 + 1 ];
            self.var_5a803392d461261e.var_beb263276c2708a2 = self.var_5a803392d461261e.var_ad83db4ee270db1b - self.var_5a803392d461261e.var_b5d4104aea3e2010;
            self.var_5a803392d461261e.var_a36f9e1f2b81b2c9 = vectornormalize( self.var_5a803392d461261e.var_beb263276c2708a2 );
            function_d718c49c2ab97359( var_b40975095284c393 );
            self.var_5a803392d461261e.var_f146412f6345a2c7 = length( self.var_5a803392d461261e.var_beb263276c2708a2 );
            
            /#
                if ( debugframes > 0 )
                {
                    line( self.var_5a803392d461261e.var_b5d4104aea3e2010, self.var_5a803392d461261e.var_ad83db4ee270db1b, ( 1, 0, 0 ), 1, 0, debugframes );
                }
            #/
            
            self.var_5a803392d461261e.var_77a0f38841f51b2a = ( 0, 0, 0 );
            function_388038a98ac0e47c( var_b40975095284c393 );
            
            if ( self.traversal_start_node.var_62d0d61e122d910[ var_b40975095284c393 ] == -1 )
            {
                var_e154fb7c68162084 = 10;
                self.var_5a803392d461261e.var_fced88a013f1b524 = var_e154fb7c68162084;
            }
            else
            {
                self.var_5a803392d461261e.var_fced88a013f1b524 = self.traversal_start_node.var_62d0d61e122d910[ var_b40975095284c393 ];
            }
            
            self.var_5a803392d461261e.var_2554c51c9e7c75fb = 360;
            
            if ( self.var_5a803392d461261e.var_fced88a013f1b524 == 0 )
            {
                var_35f6b453a4e88fd0 = vectorcross( self.var_5a803392d461261e.var_a36f9e1f2b81b2c9, self.var_5a803392d461261e.var_77a0f38841f51b2a );
                targetangles = axistoangles( self.var_5a803392d461261e.var_a36f9e1f2b81b2c9, var_35f6b453a4e88fd0, self.var_5a803392d461261e.var_77a0f38841f51b2a );
                self orientmode( "face angle 3d", targetangles );
            }
            else
            {
                self.var_5a803392d461261e.var_2554c51c9e7c75fb = 360 * floor( self.var_5a803392d461261e.var_f146412f6345a2c7 / var_8c7aa5fe4e38c178 );
                
                if ( self.var_5a803392d461261e.var_2554c51c9e7c75fb == 0 )
                {
                    self.var_5a803392d461261e.var_2554c51c9e7c75fb = 360;
                }
            }
            
            self.var_5a803392d461261e.var_b40975095284c393 = var_b40975095284c393;
        }
        else
        {
            self._blackboard.var_ba73f2df320d70cd = 0;
        }
        
        assert( isdefined( self.var_5a803392d461261e ), "<dev string:x33e>" );
        assert( isdefined( self.var_5a803392d461261e.var_b40975095284c393 ) );
        assert( isdefined( self.var_5a803392d461261e.var_b5d4104aea3e2010 ) );
        assert( isdefined( self.var_5a803392d461261e.var_ad83db4ee270db1b ) );
        assert( isdefined( self.var_5a803392d461261e.var_beb263276c2708a2 ) );
        assert( isdefined( self.var_5a803392d461261e.var_a36f9e1f2b81b2c9 ) );
        assert( isdefined( self.var_5a803392d461261e.var_77a0f38841f51b2a ) );
        assert( isdefined( self.var_5a803392d461261e.var_f146412f6345a2c7 ) );
        assert( isdefined( self.var_5a803392d461261e.var_fced88a013f1b524 ) );
        assert( isdefined( self.var_5a803392d461261e.var_2554c51c9e7c75fb ) );
        assert( isdefined( self.var_5a803392d461261e.var_2d6c72e58535776b ) );
        assert( isdefined( self.var_5a803392d461261e.var_1a5b1bdbc70e8d4f ) );
        assert( isdefined( self.var_5a803392d461261e.var_3605db50fce2f765 ) );
        assert( isdefined( self.var_5a803392d461261e.var_dcd076d27b063b0e ) );
        
        while ( isdefined( self.var_5a803392d461261e.var_b5d4104aea3e2010 ) )
        {
            /#
                if ( getdvarint( @"hash_a91939dfe6134589", 0 ) > 0 )
                {
                    sphere( self.origin, 5, ( 0, 1, 0 ), 0, 5000 );
                }
            #/
            
            if ( self._blackboard.var_6591d5e2d095a6c4 )
            {
                asm::asm_fireevent( asmname, "drop_off_wall" );
                return;
            }
            
            if ( self.var_5a803392d461261e.var_fced88a013f1b524 > 0 )
            {
                var_d95fdf7e9c80998c = self.origin - self.var_5a803392d461261e.var_b5d4104aea3e2010;
                var_f1863a2d0222612f = vectordot( var_d95fdf7e9c80998c, self.var_5a803392d461261e.var_a36f9e1f2b81b2c9 );
                var_4860c6e042607dd3 = var_f1863a2d0222612f / self.var_5a803392d461261e.var_f146412f6345a2c7;
                var_7d890754476904f7 = self.var_5a803392d461261e.var_fced88a013f1b524 * sin( self.var_5a803392d461261e.var_2554c51c9e7c75fb * ( var_4860c6e042607dd3 + self.var_5a803392d461261e.var_2d6c72e58535776b ) );
                var_2b9fbcaa95c53580 = rotatepointaroundvector( self.var_5a803392d461261e.var_77a0f38841f51b2a, self.var_5a803392d461261e.var_a36f9e1f2b81b2c9, var_7d890754476904f7 );
                var_92065909937edf49 = vectorcross( var_2b9fbcaa95c53580, self.var_5a803392d461261e.var_77a0f38841f51b2a );
                var_3352dba904f9afc1 = axistoangles( var_2b9fbcaa95c53580, var_92065909937edf49, self.var_5a803392d461261e.var_77a0f38841f51b2a );
                
                if ( !vortex::is_pulled() )
                {
                    self orientmode( "face angle 3d", var_3352dba904f9afc1 );
                }
            }
            
            var_a51491cd2d180918 = self.var_5a803392d461261e.var_ad83db4ee270db1b - self.origin;
            
            if ( vectordot( self.var_5a803392d461261e.var_beb263276c2708a2, var_a51491cd2d180918 ) < 0 )
            {
                break;
            }
            
            /#
                if ( debugframes > 0 )
                {
                    line( lastpos, self.origin, ( 0, 1, 0 ), 1, 0, debugframes );
                    lastpos = self.origin;
                }
            #/
            
            waitframe();
        }
        
        if ( self.var_5a803392d461261e.var_1a5b1bdbc70e8d4f && var_b40975095284c393 < self.traversal_start_node.wall_nodes.size - 2 )
        {
            if ( self.var_64f7b5f645fc3f32 )
            {
                thread function_c62800356907b9bd();
            }
            
            for ( var_1337b9f5f54d8a24 = 0; var_1337b9f5f54d8a24 < self.var_5a803392d461261e.var_3605db50fce2f765.size ; var_1337b9f5f54d8a24++ )
            {
                self forceteleport( self.var_5a803392d461261e.var_3605db50fce2f765[ var_1337b9f5f54d8a24 ], self.var_5a803392d461261e.var_dcd076d27b063b0e[ var_1337b9f5f54d8a24 ] );
                waitframe();
            }
            
            self.var_edd82a39e229c72d = 1;
            continue;
        }
        
        self.var_edd82a39e229c72d = 0;
    }
    
    if ( self._blackboard.var_a9547fcd63ee1bfa )
    {
        self orientmode( "face angle 3d", self.traversal_start_node.wall_angles[ self.traversal_start_node.wall_angles.size - 1 ] );
    }
    
    asm::asm_fireevent( asmname, "wall_crawl_end" );
}

// Namespace zombie_traverse_asm
// Params 0, eflags: 0x4
// Checksum 0xc194468e, Offset: 0x1a5a
// Size: 0x80
function private function_c62800356907b9bd()
{
    self endon( #"death" );
    self endon( #"terminate_ai_threads" );
    self._blackboard.var_697a504d7c395146 = 0;
    
    while ( self getaiblackboarddynamic( "transitioning_to_or_from_wall" ) || self.var_914cc10272d9f32c || self.var_edd82a39e229c72d || self.var_5bb8825b761bc2a )
    {
        waitframe();
    }
    
    wait 1;
    self._blackboard.var_697a504d7c395146 = 1;
}

// Namespace zombie_traverse_asm
// Params 2, eflags: 0x4
// Checksum 0x7e7afd3a, Offset: 0x1ae2
// Size: 0xc8
function private function_9bc26f59839423be( asmname, statename )
{
    assert( isdefined( self.traversal_start_node ) && isdefined( self.traversal_start_node.wall_nodes ) );
    animid = asm::asm_getanim( asmname, statename );
    assert( isdefined( animid ), "<dev string:x2fb>" );
    
    if ( !isdefined( animid ) )
    {
        self forceteleport( self.traversal_end_node.origin, self.traversal_end_node.angles );
        function_8aed51f0a595a877( asmname, statename );
        return;
    }
    
    self aisetanim( statename, animid );
    asm::asm_playfacialanim( asmname, statename, asm::asm_getxanim( statename, animid ) );
    self animmode( "noclip" );
}

// Namespace zombie_traverse_asm
// Params 0, eflags: 0x4
// Checksum 0x8afe72a8, Offset: 0x1bb2
// Size: 0x197
function private function_f36b84ed92576116()
{
    var_e154fb7c68162084 = 10;
    self.var_5a803392d461261e = spawnstruct();
    self.var_5a803392d461261e.var_b40975095284c393 = 0;
    self.var_5a803392d461261e.var_2d6c72e58535776b = randomfloat( 1 );
    self.var_edd82a39e229c72d = 0;
    self.var_5bdb50b5148e8241 = [];
    self.var_5a803392d461261e.var_fced88a013f1b524 = var_e154fb7c68162084;
    
    if ( self._blackboard.var_697a504d7c395146 )
    {
        self.var_64f7b5f645fc3f32 = 1;
    }
    
    if ( self.var_914cc10272d9f32c )
    {
        if ( self.var_64f7b5f645fc3f32 )
        {
            thread function_c62800356907b9bd();
        }
        
        self.var_5a803392d461261e.var_beb263276c2708a2 = self.traversal_start_node.wall_nodes[ 0 ] - self.traversal_start_node.origin;
        self orientmode( "face angle", vectortoyaw( self.var_5a803392d461261e.var_beb263276c2708a2 ) );
        
        while ( true )
        {
            var_a51491cd2d180918 = self.traversal_start_node.wall_nodes[ 0 ] - self.origin;
            
            if ( vectordot( self.var_5a803392d461261e.var_beb263276c2708a2, var_a51491cd2d180918 ) < 0 )
            {
                break;
            }
            
            waitframe();
        }
        
        self.var_914cc10272d9f32c = undefined;
        self._blackboard.var_397bfb4ed7256a7a = 1;
        val::reset_all( "wall_transition" );
    }
}

// Namespace zombie_traverse_asm
// Params 1, eflags: 0x4
// Checksum 0xfb853053, Offset: 0x1d51
// Size: 0x54a
function private function_d718c49c2ab97359( var_b40975095284c393 )
{
    self.var_5a803392d461261e.var_1a5b1bdbc70e8d4f = 0;
    self.var_5a803392d461261e.var_3605db50fce2f765 = [];
    self.var_5a803392d461261e.var_dcd076d27b063b0e = [];
    
    if ( var_b40975095284c393 < self.traversal_start_node.wall_nodes.size - 2 )
    {
        var_ca50b2ffd21848b5 = -0.05;
        var_cadd6ff4538897d0 = anglestoup( self.traversal_start_node.wall_angles[ var_b40975095284c393 + 1 ] );
        var_a1740113f3272907 = vectordot( anglestoup( self.angles ), var_cadd6ff4538897d0 ) >= 0.9;
        self.var_5a803392d461261e.var_1a5b1bdbc70e8d4f = vectordot( self.var_5a803392d461261e.var_a36f9e1f2b81b2c9, var_cadd6ff4538897d0 ) <= var_ca50b2ffd21848b5 && !var_a1740113f3272907;
        
        if ( self.var_5a803392d461261e.var_1a5b1bdbc70e8d4f )
        {
            var_3c324c72ba69e056 = 10;
            var_59177b013b5f0cba = 50;
            var_6c1bdd36ee205d65 = 0.8;
            
            for ( var_34bc13605f7e2191 = 0; var_34bc13605f7e2191 < var_3c324c72ba69e056 ; var_34bc13605f7e2191++ )
            {
                self.var_5bdb50b5148e8241[ 0 ] = self.var_5a803392d461261e.var_b5d4104aea3e2010 + self.var_5a803392d461261e.var_beb263276c2708a2 * var_6c1bdd36ee205d65;
                var_78a9bbaea0e11692 = vectordot( self.var_5bdb50b5148e8241[ 0 ] - self.traversal_start_node.wall_nodes[ var_b40975095284c393 + 1 ], var_cadd6ff4538897d0 );
                
                if ( var_78a9bbaea0e11692 > var_59177b013b5f0cba )
                {
                    break;
                }
                
                var_6c1bdd36ee205d65 -= 0.05;
            }
            
            self.var_5bdb50b5148e8241[ 1 ] = self.var_5bdb50b5148e8241[ 0 ] + self.var_5a803392d461261e.var_a36f9e1f2b81b2c9 * var_78a9bbaea0e11692;
            var_a4c558ed942c14f8 = vectornormalize( self.traversal_start_node.wall_nodes[ var_b40975095284c393 + 2 ] - self.var_5bdb50b5148e8241[ 1 ] );
            self.var_5bdb50b5148e8241[ 2 ] = self.var_5bdb50b5148e8241[ 1 ] + var_a4c558ed942c14f8 * var_78a9bbaea0e11692;
            
            /#
                if ( getdvarint( @"hash_a91939dfe6134589", 0 ) > 0 )
                {
                    sphere( self.var_5bdb50b5148e8241[ 0 ], 10, ( 1, 0, 0 ), 0, 5000 );
                    sphere( self.var_5bdb50b5148e8241[ 1 ], 10, ( 1, 0, 0 ), 0, 5000 );
                    sphere( self.var_5bdb50b5148e8241[ 2 ], 10, ( 1, 0, 0 ), 0, 5000 );
                }
            #/
            
            var_703c2bbf56dd1f6b = self.var_5bdb50b5148e8241[ 0 ] - self.var_5bdb50b5148e8241[ 1 ];
            var_e39eb39187ea07c1 = self.var_5bdb50b5148e8241[ 2 ] - self.var_5bdb50b5148e8241[ 1 ];
            
            if ( lengthsquared( var_703c2bbf56dd1f6b ) == 0 || lengthsquared( var_e39eb39187ea07c1 ) == 0 )
            {
                return;
            }
            
            var_aaa59201332399e6 = math::anglebetweenvectors( var_703c2bbf56dd1f6b, var_e39eb39187ea07c1 );
            var_84fefdf8551da873 = [ 1, 180 ];
            var_a1247e56e8ee44f0 = [ 0.07, 0.2 ];
            var_a84bae471b7aa520 = 90;
            var_deaf577567829847 = 0.1;
            slope = ( var_a1247e56e8ee44f0[ 0 ] - var_a1247e56e8ee44f0[ 1 ] ) / ( var_84fefdf8551da873[ 1 ] - var_84fefdf8551da873[ 0 ] );
            var_7aa4ce327e0ba2fb = slope * ( var_aaa59201332399e6 - var_a84bae471b7aa520 ) + var_deaf577567829847;
            lerpfraction = 0;
            var_3605db50fce2f765 = [];
            var_dcd076d27b063b0e = [];
            
            while ( lerpfraction < 1 )
            {
                var_304b3e92cbd31c96 = math::lerp( self.var_5bdb50b5148e8241[ 0 ], self.var_5bdb50b5148e8241[ 1 ], lerpfraction );
                var_304b3d92cbd31a63 = math::lerp( self.var_5bdb50b5148e8241[ 1 ], self.var_5bdb50b5148e8241[ 2 ], lerpfraction );
                var_3605db50fce2f765[ var_3605db50fce2f765.size ] = math::lerp( var_304b3e92cbd31c96, var_304b3d92cbd31a63, lerpfraction );
                var_dcd076d27b063b0e[ var_dcd076d27b063b0e.size ] = math::angle_lerp( self.traversal_start_node.wall_angles[ var_b40975095284c393 ], self.traversal_start_node.wall_angles[ var_b40975095284c393 + 1 ], lerpfraction );
                
                /#
                    if ( getdvarint( @"hash_a91939dfe6134589", 0 ) > 0 )
                    {
                        sphere( var_3605db50fce2f765[ var_3605db50fce2f765.size - 1 ], 5, ( 1, 1, 0 ), 0, 5000 );
                    }
                #/
                
                lerpfraction += var_7aa4ce327e0ba2fb;
            }
            
            self.var_5a803392d461261e.var_3605db50fce2f765 = var_3605db50fce2f765;
            self.var_5a803392d461261e.var_dcd076d27b063b0e = var_dcd076d27b063b0e;
            self.var_5a803392d461261e.var_ad83db4ee270db1b = self.var_5bdb50b5148e8241[ 0 ];
            self.var_5a803392d461261e.var_beb263276c2708a2 = self.var_5a803392d461261e.var_ad83db4ee270db1b - self.var_5a803392d461261e.var_b5d4104aea3e2010;
        }
    }
}

// Namespace zombie_traverse_asm
// Params 1, eflags: 0x4
// Checksum 0x65ef34c0, Offset: 0x22a3
// Size: 0x293
function private function_388038a98ac0e47c( var_b40975095284c393 )
{
    if ( self._blackboard.var_a9547fcd63ee1bfa && var_b40975095284c393 == 0 )
    {
        self.var_5a803392d461261e.var_77a0f38841f51b2a = anglestoup( self.traversal_start_node.wall_angles[ var_b40975095284c393 + 1 ] );
        self._blackboard.var_a9547fcd63ee1bfa = 0;
        return;
    }
    
    if ( !self._blackboard.var_a9547fcd63ee1bfa && var_b40975095284c393 == self.traversal_start_node.wall_nodes.size - 2 )
    {
        var_c2a6541762acd146 = 10;
        var_c4c5c84004ae6ab7 = anglestoup( self.traversal_start_node.wall_angles[ var_b40975095284c393 ] );
        var_99bda75ac72afc1d = anglestoup( self.traversal_start_node.wall_angles[ var_b40975095284c393 + 1 ] );
        self._blackboard.var_a9547fcd63ee1bfa = vectordot( var_c4c5c84004ae6ab7, var_99bda75ac72afc1d ) < 0.98 && self.traversal_start_node.wall_nodes[ var_b40975095284c393 + 1 ][ 2 ] > self.traversal_start_node.wall_nodes[ var_b40975095284c393 ][ 2 ] && self.traversal_start_node.wall_nodes[ var_b40975095284c393 + 1 ][ 2 ] - self.var_566c37085d619bf1[ 2 ] > var_c2a6541762acd146;
        
        if ( !self._blackboard.var_a9547fcd63ee1bfa )
        {
            var_668a7913ebbc3799 = -12;
            self.var_5a803392d461261e.var_ad83db4ee270db1b = self.traversal_start_node.wall_nodes[ var_b40975095284c393 + 1 ] + var_668a7913ebbc3799 * self.var_5a803392d461261e.var_a36f9e1f2b81b2c9;
            self.var_5a803392d461261e.var_beb263276c2708a2 = self.var_5a803392d461261e.var_ad83db4ee270db1b - self.var_5a803392d461261e.var_b5d4104aea3e2010;
        }
        
        self.var_5a803392d461261e.var_77a0f38841f51b2a = anglestoup( self.traversal_start_node.wall_angles[ var_b40975095284c393 ] );
        return;
    }
    
    self.var_5a803392d461261e.var_77a0f38841f51b2a = anglestoup( self.traversal_start_node.wall_angles[ var_b40975095284c393 ] );
}

// Namespace zombie_traverse_asm
// Params 3
// Checksum 0x1215d91, Offset: 0x253e
// Size: 0x513
function function_9f0005804f9e932d( asmname, statename, params )
{
    assert( isdefined( self.var_566c37085d619bf1 ), "<dev string:x2d5>" );
    assert( isdefined( self.traversal_end_node ), "<dev string:x294>" );
    assert( self.traversal_start_node.wall_nodes.size >= 2, "<dev string:x2b4>" );
    
    if ( self.traversal_start_node.var_f4e44cfbed574505 )
    {
        self.forceannihilate = 0;
    }
    
    if ( !( isdefined( self.var_566c37085d619bf1 ) && isdefined( self.traversal_start_node.wall_nodes ) ) || self.traversal_start_node.wall_nodes.size < 2 )
    {
        if ( isdefined( self.traversal_end_node ) )
        {
            self forceteleport( self.traversal_end_node.origin, self.traversal_end_node.angles );
        }
        
        function_8aed51f0a595a877( asmname, statename );
        return;
    }
    
    var_fb315494eddc714f = 25;
    var_d37320bce5b947d1 = self.traversal_start_node.wall_nodes[ self.traversal_start_node.wall_nodes.size - 2 ];
    var_1f982dec67274878 = self.traversal_start_node.wall_nodes[ self.traversal_start_node.wall_nodes.size - 1 ];
    starttoenddir = self.var_566c37085d619bf1 - var_1f982dec67274878;
    var_30cd5be92c80b68d = vectordot( starttoenddir, anglestoup( self.angles ) ) <= 0 && !self._blackboard.var_a9547fcd63ee1bfa;
    
    if ( var_30cd5be92c80b68d )
    {
        self.var_5bb8825b761bc2a = 1;
        thread function_ea25133e3ebd7856( asmname, statename, var_d37320bce5b947d1, var_1f982dec67274878, self.var_566c37085d619bf1, vectortoangles( self.var_566c37085d619bf1 - var_1f982dec67274878 ) );
        return;
    }
    
    traversalattributes = spawnstruct();
    traversalattributes.startpos = var_1f982dec67274878;
    var_228d9f18a9e6b9ca = ( 0, 0, var_fb315494eddc714f );
    var_228d9f18a9e6b9ca = self.var_566c37085d619bf1 + var_228d9f18a9e6b9ca;
    var_1565544a8551d039 = ( 0, 0, -1 * var_fb315494eddc714f );
    var_1565544a8551d039 = self.var_566c37085d619bf1 + var_1565544a8551d039;
    self.var_566c37085d619bf1 = physicstrace( var_228d9f18a9e6b9ca, var_1565544a8551d039 );
    traversalattributes.endpos = self.var_566c37085d619bf1;
    
    if ( isdefined( self.var_28343eb233cd40f ) && isdefined( self.enemy ) && self.var_28343eb233cd40f.size == 3 )
    {
        var_b4586d9021628fa6 = vectortoangles( self.enemy.origin - self.var_566c37085d619bf1 );
        traversalattributes.angles = ( 0, var_b4586d9021628fa6[ 1 ], 0 );
    }
    else if ( self.var_28343eb233cd40f.size > 3 )
    {
        var_b4586d9021628fa6 = vectortoangles( self.var_28343eb233cd40f[ 2 ] - self.var_566c37085d619bf1 );
        traversalattributes.angles = ( 0, var_b4586d9021628fa6[ 1 ], 0 );
    }
    else
    {
        var_b4586d9021628fa6 = vectortoangles( self.var_566c37085d619bf1 - self.origin );
        traversalattributes.angles = ( 0, var_b4586d9021628fa6[ 1 ], 0 );
    }
    
    self settraversalattributes( traversalattributes.startpos, traversalattributes.endpos, traversalattributes.angles, traversalattributes.endpos );
    animid = asm::asm_getanim( asmname, statename );
    assert( isdefined( animid ), "<dev string:x2fb>" );
    
    if ( !isdefined( animid ) )
    {
        self forceteleport( self.traversal_end_node.origin, self.traversal_end_node.angles );
        function_8aed51f0a595a877( asmname, statename );
        return;
    }
    
    animalias = self function_30c9365bb7f9ea96( statename, animid );
    assert( isdefined( animalias ), "<dev string:x31c>" );
    
    if ( !isdefined( animalias ) )
    {
        self forceteleport( self.traversal_end_node.origin, self.traversal_end_node.angles );
        function_8aed51f0a595a877( asmname, statename );
        return;
    }
    
    self.var_5a803392d461261e = undefined;
    self.var_dc7b3db86f0c80be = getsubstr( animalias, 0, 7 ) == "ceiling";
    
    if ( animalias == "right" || animalias == "left" || self.var_dc7b3db86f0c80be )
    {
        self settraversalattributes( traversalattributes.startpos, traversalattributes.endpos, self.traversal_end_node.angles, traversalattributes.endpos );
        thread function_9c2d6bc3f5fa55ea( asmname, statename, animid, self.var_dc7b3db86f0c80be, 0 );
        return;
    }
    
    thread function_986acd9354c7aed6( asmname, statename, animid, traversalattributes.angles, 0, 0 );
}

// Namespace zombie_traverse_asm
// Params 3
// Checksum 0xda4acaa6, Offset: 0x2a59
// Size: 0x2bf
function function_417d43e82b2ea8aa( asmname, statename, params )
{
    if ( self.traversal_start_node.var_f4e44cfbed574505 )
    {
        self.forceannihilate = 0;
    }
    
    traversalattributes = spawnstruct();
    traversalattributes.startpos = self.origin;
    traversalattributes.endpos = self._blackboard.var_b116aea4bce2b017;
    
    if ( isdefined( self.var_28343eb233cd40f ) && isdefined( self.enemy ) && self.var_28343eb233cd40f.size == 3 )
    {
        var_ada576ce7667da30 = vectortoyaw( self.enemy.origin - self._blackboard.var_b116aea4bce2b017 );
        traversalattributes.angles = ( 0, var_ada576ce7667da30, 0 );
    }
    else if ( self.var_28343eb233cd40f.size > 3 )
    {
        var_ada576ce7667da30 = vectortoyaw( self.var_28343eb233cd40f[ 2 ] - self._blackboard.var_b116aea4bce2b017 );
        traversalattributes.angles = ( 0, var_ada576ce7667da30, 0 );
    }
    else
    {
        var_ada576ce7667da30 = vectortoyaw( self._blackboard.var_b116aea4bce2b017 - self.origin );
        traversalattributes.angles = ( 0, var_ada576ce7667da30, 0 );
    }
    
    self settraversalattributes( traversalattributes.startpos, traversalattributes.endpos, traversalattributes.angles, traversalattributes.endpos );
    animid = asm::asm_getanim( asmname, statename );
    assert( isdefined( animid ), "<dev string:x2fb>" );
    
    if ( !isdefined( animid ) )
    {
        self forceteleport( self.traversal_end_node.origin, self.traversal_end_node.angles );
        function_8aed51f0a595a877( asmname, statename );
        return;
    }
    
    animalias = self function_30c9365bb7f9ea96( statename, animid );
    assert( isdefined( animalias ), "<dev string:x31c>" );
    
    if ( !isdefined( animalias ) )
    {
        self forceteleport( self.traversal_end_node.origin, self.traversal_end_node.angles );
        function_8aed51f0a595a877( asmname, statename );
        return;
    }
    
    self.var_5a803392d461261e = undefined;
    self.var_dc7b3db86f0c80be = getsubstr( animalias, 0, 7 ) == "ceiling";
    
    if ( self.var_dc7b3db86f0c80be )
    {
        thread function_9c2d6bc3f5fa55ea( asmname, statename, animid, 1, 0 );
        return;
    }
    
    thread function_986acd9354c7aed6( asmname, statename, animid, traversalattributes.angles, 1, 0 );
}

// Namespace zombie_traverse_asm
// Params 3
// Checksum 0xbe51d218, Offset: 0x2d20
// Size: 0xd7
function function_a26a6d35e551d9ed( asmname, statename, params )
{
    featurearray = [];
    
    if ( self._blackboard.var_6591d5e2d095a6c4 )
    {
        featurearray[ "drop_height" ] = self.origin[ 2 ] - self._blackboard.var_b116aea4bce2b017[ 2 ];
    }
    else
    {
        featurearray[ "drop_height" ] = self.origin[ 2 ] - self.var_566c37085d619bf1[ 2 ];
    }
    
    alias = self function_805ca5e408d630c0( self.animsetname, statename, featurearray );
    assert( asm::asm_hasalias( statename, alias ), "<dev string:x366>" + statename + "<dev string:x371>" + alias );
    return asm::asm_chooseanim( asmname, statename, alias );
}

// Namespace zombie_traverse_asm
// Params 2
// Checksum 0x264d4ecc, Offset: 0x2e00
// Size: 0x20a
function function_8aed51f0a595a877( asmname, statename )
{
    if ( callback::exists( "on_zombie_ai_killed", &function_26a0baf6e09439b7 ) )
    {
        callback::remove( "on_zombie_ai_killed", &function_26a0baf6e09439b7 );
    }
    
    if ( self._blackboard.var_397bfb4ed7256a7a && !vortex::is_pulled() && ( self._blackboard.var_32718cfc9c01dd9b || self._blackboard.var_65f32caa86b87a2 ) )
    {
        self._blackboard.var_ba73f2df320d70cd = 1;
        self animmode( "noclip" );
        return;
    }
    
    if ( self._blackboard.var_397bfb4ed7256a7a && vortex::is_pulled() )
    {
        self animmode( "noclip" );
        self.var_507d3f5433b78f74 = 1;
    }
    else
    {
        self animmode( "normal" );
        
        if ( isdefined( self.var_7069b475f40888c3 ) )
        {
            self.var_ebd26f6520cc1e89 = self.var_7069b475f40888c3;
        }
    }
    
    if ( isdefined( self.var_a6a05cdb7d779829 ) )
    {
        self.turnrate = self.var_a6a05cdb7d779829;
    }
    
    self function_786bb6aa1b76c7ee( "transitioning_to_or_from_wall", 0 );
    self.var_e59e24fbb46d7d5e = 0;
    self._blackboard.var_397bfb4ed7256a7a = 0;
    self._blackboard.var_6591d5e2d095a6c4 = 0;
    self._blackboard.var_a6db4b2fd6e741cc = 0;
    self._blackboard.var_a9547fcd63ee1bfa = 0;
    self._blackboard.var_697a504d7c395146 = 0;
    self._blackboard.var_ba73f2df320d70cd = 0;
    self.var_5a803392d461261e = undefined;
    self.var_914cc10272d9f32c = undefined;
    self.var_5bb8825b761bc2a = undefined;
    self.var_edd82a39e229c72d = undefined;
    self.var_64f7b5f645fc3f32 = undefined;
    val::reset_all( "wall_transition" );
    traverse::terminatetraverse( asmname, statename );
}

// Namespace zombie_traverse_asm
// Params 1, eflags: 0x4
// Checksum 0xe0c5a343, Offset: 0x3012
// Size: 0x67
function private function_26a0baf6e09439b7( params )
{
    if ( ( self.noragdoll || self.script_noragdoll ) && !self.forceannihilate )
    {
        self.forceannihilate = 1;
        return;
    }
    
    if ( !self.forceragdollimmediate )
    {
        self.forceragdollimmediate = 1;
        self.ragdoll_damagelocation_none = "torso_upper";
    }
}

// Namespace zombie_traverse_asm
// Params 6, eflags: 0x4
// Checksum 0xd9ce0564, Offset: 0x3081
// Size: 0x209
function private function_986acd9354c7aed6( asmname, statename, animid, var_1d8f9951cad1673b, var_f36f5a480a39dc40, var_397bfb4ed7256a7a )
{
    self endon( #"death" );
    self endon( #"terminate_ai_threads" );
    self endon( statename + "_finished" );
    val::set_array( "wall_transition", [ "postpone_stun", "disallow_knockdown" ], 1 );
    self animmode( "noclip" );
    self function_786bb6aa1b76c7ee( "transitioning_to_or_from_wall", 1 );
    
    if ( self.var_64f7b5f645fc3f32 )
    {
        thread function_c62800356907b9bd();
    }
    
    asm::asm_playfacialanim( asmname, statename, asm::asm_getxanim( statename, animid ) );
    self aisetanim( statename, animid );
    
    if ( var_f36f5a480a39dc40 )
    {
        var_8125f9f1ff3f5bbb = vectortopitch( self._blackboard.var_b116aea4bce2b017 - self.origin );
        self.turnrate = self.var_a6a05cdb7d779829;
        self orientmode( "face angle 3d", ( var_8125f9f1ff3f5bbb, self.angles[ 1 ], self.angles[ 2 ] ) );
    }
    
    self waittill( #"start_orienting" );
    self.var_e59e24fbb46d7d5e = 1;
    
    if ( var_f36f5a480a39dc40 )
    {
        self.turnrate = 0.3;
    }
    else
    {
        asm::function_d82cb83c9c260d49( 0.5 );
    }
    
    self orientmode( "face angle 3d", var_1d8f9951cad1673b );
    self waittill( #"end_anim" );
    self.var_e59e24fbb46d7d5e = 0;
    
    if ( var_f36f5a480a39dc40 )
    {
        self._blackboard.var_6591d5e2d095a6c4 = 0;
    }
    else
    {
        var_46c52fe4b84fc183 = self.var_e105f3af9b5e5e9b ?? 1;
        asm::function_d82cb83c9c260d49( var_46c52fe4b84fc183 );
    }
    
    self._blackboard.var_397bfb4ed7256a7a = var_397bfb4ed7256a7a;
    self function_786bb6aa1b76c7ee( "transitioning_to_or_from_wall", 0 );
    val::reset_all( "wall_transition" );
    asm::asm_fireevent( asmname, "wall_transition_end" );
}

// Namespace zombie_traverse_asm
// Params 5, eflags: 0x4
// Checksum 0x7d7a23c6, Offset: 0x3292
// Size: 0x239
function private function_9c2d6bc3f5fa55ea( asmname, statename, animid, var_dc7b3db86f0c80be, var_397bfb4ed7256a7a )
{
    self endon( #"death" );
    self endon( #"terminate_ai_threads" );
    self endon( statename + "_finished" );
    val::set_array( "wall_transition", [ "postpone_stun", "disallow_knockdown" ], 1 );
    self animmode( "noclip" );
    self function_786bb6aa1b76c7ee( "transitioning_to_or_from_wall", 1 );
    
    if ( self.var_64f7b5f645fc3f32 )
    {
        thread function_c62800356907b9bd();
    }
    
    if ( !var_dc7b3db86f0c80be )
    {
        self.var_e59e24fbb46d7d5e = 1;
    }
    
    if ( isdefined( self.var_8276841ec402381f ) && isdefined( self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb ) && isdefined( self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.var_c1e63c59484bf25c ) )
    {
        foreach ( animplaybackrate in self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.var_c1e63c59484bf25c )
        {
            if ( animplaybackrate.movetype == self.var_8276841ec402381f )
            {
                asm::function_d82cb83c9c260d49( animplaybackrate.playbackrate );
                break;
            }
        }
    }
    
    asm::asm_playfacialanim( asmname, statename, asm::asm_getxanim( statename, animid ) );
    self aisetanim( statename, animid );
    self waittill( #"end_anim" );
    self.var_e59e24fbb46d7d5e = 0;
    var_46c52fe4b84fc183 = self.var_e105f3af9b5e5e9b ?? 1;
    asm::function_d82cb83c9c260d49( var_46c52fe4b84fc183 );
    self._blackboard.var_397bfb4ed7256a7a = var_397bfb4ed7256a7a;
    self function_786bb6aa1b76c7ee( "transitioning_to_or_from_wall", 0 );
    val::reset_all( "wall_transition" );
    asm::asm_fireevent( asmname, "wall_transition_end" );
}

// Namespace zombie_traverse_asm
// Params 6, eflags: 0x4
// Checksum 0x28ad3f81, Offset: 0x34d3
// Size: 0x217
function private function_ea25133e3ebd7856( asmname, statename, var_6474852d79a5c20c, var_3b191a8a0b2001f7, endpos, endangles )
{
    self endon( #"death" );
    self endon( #"terminate_ai_threads" );
    self endon( statename + "_finished" );
    assert( self.traversal_start_node.wall_nodes.size >= 2, "<dev string:x2b4>" );
    
    if ( self.traversal_start_node.wall_nodes.size < 2 )
    {
        self forceteleport( self.traversal_end_node.origin, self.traversal_end_node.angles );
        function_8aed51f0a595a877( asmname, statename );
        return;
    }
    
    if ( self.var_64f7b5f645fc3f32 )
    {
        thread function_c62800356907b9bd();
    }
    
    offsetvalue = 20;
    
    if ( distancesquared( var_3b191a8a0b2001f7, var_6474852d79a5c20c ) < squared( offsetvalue ) )
    {
        offsetvalue = 0;
    }
    
    var_2a1e48e07a1cfa3f = offsetvalue * -1 * anglestoforward( self.angles );
    var_72953e2416d1a2a4 = var_3b191a8a0b2001f7 + var_2a1e48e07a1cfa3f;
    var_beb263276c2708a2 = var_72953e2416d1a2a4 - var_6474852d79a5c20c;
    
    while ( true )
    {
        var_a51491cd2d180918 = var_72953e2416d1a2a4 - self.origin;
        
        if ( vectordot( var_beb263276c2708a2, var_a51491cd2d180918 ) < 0 )
        {
            break;
        }
        
        waitframe();
    }
    
    var_beb263276c2708a2 = endpos - self.origin;
    var_a36f9e1f2b81b2c9 = vectornormalize( var_beb263276c2708a2 );
    var_77a0f38841f51b2a = anglestoup( endangles );
    var_3ea3f7b578eb45aa = vectorcross( var_a36f9e1f2b81b2c9, var_77a0f38841f51b2a );
    targetangles = axistoangles( var_a36f9e1f2b81b2c9, var_3ea3f7b578eb45aa, var_77a0f38841f51b2a );
    self orientmode( "face angle 3d", targetangles );
    
    while ( true )
    {
        var_a51491cd2d180918 = endpos - self.origin;
        
        if ( vectordot( var_beb263276c2708a2, var_a51491cd2d180918 ) < 0 )
        {
            break;
        }
        
        waitframe();
    }
    
    self._blackboard.var_397bfb4ed7256a7a = 0;
    asm::asm_fireevent( asmname, "wall_transition_end" );
}

// Namespace zombie_traverse_asm
// Params 0, eflags: 0x4
// Checksum 0xf75571a1, Offset: 0x36f2
// Size: 0x11f
function private function_8805543e0ba78b2c()
{
    startnode = undefined;
    
    if ( !ai::is_doing_traversal( self ) )
    {
        if ( !self setuptraversaltransitioncheck( 120 ) )
        {
            return;
        }
    }
    
    if ( self.var_15c6e27c1acff47e == "node_based" )
    {
        startnode = self getnegotiationstartnode();
        
        if ( !isdefined( startnode ) )
        {
            self starttraversearrival( 120 );
            startnode = self getnegotiationstartnode();
        }
        
        assert( isdefined( startnode ) );
    }
    else if ( self.var_15c6e27c1acff47e == "linkless" || self.var_15c6e27c1acff47e == "nodeless" )
    {
        assertmsg( "<dev string:x394>" + self.var_15c6e27c1acff47e + "<dev string:x39c>" + ( isdefined( self.traverse_traversetype ) ? "<dev string:x3ad>" + self.traverse_traversetype : "<dev string:x72>" ) + "<dev string:x3b7>" + ( isdefined( self.var_fa685a7668b11923 ) ? "<dev string:x3cb>" + self.var_fa685a7668b11923 : "<dev string:x72>" ) + ( isdefined( self.var_d87cab901a66356c ) ? "<dev string:x3d4>" + self.var_d87cab901a66356c : "<dev string:x72>" ) );
    }
    
    return startnode;
}

// Namespace zombie_traverse_asm
// Params 0
// Checksum 0x65aa042d, Offset: 0x381a
// Size: 0x2e
function force_drop_off_wall()
{
    if ( self._blackboard.var_397bfb4ed7256a7a )
    {
        self._blackboard.var_6591d5e2d095a6c4 = 1;
    }
}

// Namespace zombie_traverse_asm
// Params 0
// Checksum 0xfd1b1702, Offset: 0x3850
// Size: 0x2f
function function_cb2386722e58be36()
{
    if ( !self._blackboard.var_697a504d7c395146 )
    {
        self._blackboard.var_697a504d7c395146 = 1;
    }
}

// Namespace zombie_traverse_asm
// Params 0
// Checksum 0xa2909c31, Offset: 0x3887
// Size: 0x2d
function function_85b354b1fada24eb()
{
    if ( self._blackboard.var_697a504d7c395146 )
    {
        self._blackboard.var_697a504d7c395146 = 0;
    }
}

// Namespace zombie_traverse_asm
// Params 1
// Checksum 0x8d49bfb8, Offset: 0x38bc
// Size: 0x27
function function_f767340ef0691f12( var_4a695cd95df69f8d )
{
    if ( isdefined( self getaiblackboarddynamic( "wallCrawlRangedAttackRange" ) ) )
    {
        self function_786bb6aa1b76c7ee( "wallCrawlRangedAttackRange", var_4a695cd95df69f8d );
    }
}

// Namespace zombie_traverse_asm
// Params 1
// Checksum 0x86213c0c, Offset: 0x38eb
// Size: 0x3f
function function_fba2da16d6f649b9( var_7d74a013d285ad96 )
{
    if ( isdefined( self._blackboard.var_1d29076b12111692 ) )
    {
        self._blackboard.var_1d29076b12111692 = utility::function_4b74c15943231980( var_7d74a013d285ad96 );
    }
}

// Namespace zombie_traverse_asm
// Params 3
// Checksum 0xb81c202, Offset: 0x3932
// Size: 0xb3
function function_37b96bf99b46c0a8( asmname, statename, params )
{
    walk_nodes = function_3fb677c834a8ba20();
    
    if ( !isdefined( walk_nodes ) )
    {
        traverse::terminatetraverse( asmname, statename );
        return;
    }
    
    animid = asm::asm_getanim( asmname, statename );
    assert( isdefined( animid ), "<dev string:x3db>" );
    
    if ( walk_nodes.size < 2 || !isdefined( animid ) )
    {
        traverse::terminatetraverse( asmname, statename );
        return;
    }
    
    self aisetanim( statename, animid );
    asm::asm_playfacialanim( asmname, statename, asm::asm_getxanim( statename, animid ) );
    self animmode( "gravity_off_nav" );
    thread function_673d463f0cbe9d06( asmname, statename, walk_nodes );
}

// Namespace zombie_traverse_asm
// Params 3
// Checksum 0xa6ef88a8, Offset: 0x39ed
// Size: 0x10d
function function_673d463f0cbe9d06( asmname, statename, walk_nodes )
{
    self endon( #"death" );
    self endon( #"terminate_ai_threads" );
    self endon( statename + "_finished" );
    var_ebd26f6520cc1e89 = self.var_ebd26f6520cc1e89;
    self.var_ebd26f6520cc1e89 = 0;
    
    for ( i = 0; i < walk_nodes.size - 1 ; i++ )
    {
        startpos = walk_nodes[ i ];
        endpos = walk_nodes[ i + 1 ];
        var_e16f272d8e313f8a = endpos - startpos;
        yaw = vectortoyaw( var_e16f272d8e313f8a );
        self orientmode( "face angle", yaw );
        
        while ( true )
        {
            var_1f4c5666d756234c = endpos - self.origin;
            
            if ( vectordot( var_e16f272d8e313f8a, var_1f4c5666d756234c ) < 0 )
            {
                break;
            }
            
            waitframe();
        }
    }
    
    self.var_ebd26f6520cc1e89 = var_ebd26f6520cc1e89;
    asm::asm_fireevent( asmname, "end" );
}

// Namespace zombie_traverse_asm
// Params 0, eflags: 0x4
// Checksum 0x5cd1608f, Offset: 0x3b02
// Size: 0x176
function private function_3fb677c834a8ba20()
{
    walk_nodes = [];
    
    if ( !ai::is_doing_traversal( self ) )
    {
        if ( !self setuptraversaltransitioncheck( 120 ) )
        {
            return;
        }
    }
    
    if ( self.var_15c6e27c1acff47e == "linkless" )
    {
        startpos = self getnegotiationstartpos();
        
        if ( !isdefined( startpos ) )
        {
            self starttraversearrival( 120, self.var_4249813a2840cfc8, self.var_9d40c8bd8f7a879.origin, self.var_9d40c8bd8f7a879.endpos );
            startpos = self getnegotiationstartpos();
        }
        
        assert( isdefined( startpos ) );
        endpos = self getnegotiationendpos();
        walk_nodes[ walk_nodes.size ] = startpos;
        walk_nodes[ walk_nodes.size ] = endpos;
    }
    else if ( self.var_15c6e27c1acff47e == "nodeless" )
    {
        startpos = self getnegotiationstartpos();
        
        if ( !isdefined( startpos ) )
        {
            self starttraversearrival( 120, self.var_4249813a2840cfc8 );
            startpos = self getnegotiationstartpos();
        }
        
        assert( isdefined( startpos ) );
        endpos = self getnegotiationendpos();
        walk_nodes[ walk_nodes.size ] = startpos;
        walk_nodes[ walk_nodes.size ] = endpos;
    }
    else if ( self.var_15c6e27c1acff47e == "node_based" )
    {
        startnode = self getnegotiationstartnode();
        
        if ( !isdefined( startnode ) )
        {
            self starttraversearrival( 120 );
            startnode = self getnegotiationstartnode();
        }
        
        assert( isdefined( startnode ) );
        walk_nodes = startnode.walk_nodes;
    }
    else
    {
        assertmsg( "<dev string:x3ff>" );
    }
    
    return walk_nodes;
}

// Namespace zombie_traverse_asm
// Params 3
// Checksum 0xfbee4e74, Offset: 0x3c81
// Size: 0x41
function function_ef949d50b586efe1( asmname, statename, params )
{
    chosen_anim = traverse::traversechooseanim( asmname, statename, params );
    self.var_726ebaeeb07b6bd9 = chosen_anim;
    return chosen_anim;
}

// Namespace zombie_traverse_asm
// Params 3
// Checksum 0x7848fd63, Offset: 0x3ccb
// Size: 0x42
function function_32a3c0cd4f6177c4( asmname, statename, params )
{
    if ( self.var_726ebaeeb07b6bd9 )
    {
        return self.var_726ebaeeb07b6bd9;
    }
    
    return traverse::traversechooseanim( asmname, statename, params );
}

// Namespace zombie_traverse_asm
// Params 1
// Checksum 0x38f908ac, Offset: 0x3d15
// Size: 0xaf
function function_f91a43bc37888ed3( params )
{
    if ( self.var_b8a25dd1082321c8 > 0 && isdefined( params.featurearray ) )
    {
        if ( params.featurearray[ "drop_height" ] > self.var_b8a25dd1082321c8 || params.featurearray[ "height" ] > self.var_b8a25dd1082321c8 || params.featurearray[ "length" ] > self.var_b8a25dd1082321c8 )
        {
            self function_786bb6aa1b76c7ee( "traverse_teleport_state", 1 );
            return "traverse_teleport_intro";
        }
    }
    
    self function_f2df0257c63f229( "traverse_teleport_state" );
    return params.traversetype;
}

// Namespace zombie_traverse_asm
// Params 3
// Checksum 0x48950ae7, Offset: 0x3dcd
// Size: 0xea
function function_ef22669f1b555e89( asmname, statename, params )
{
    blackboard_value = self getaiblackboarddynamic( "traverse_teleport_state" );
    
    if ( blackboard_value == 2 || blackboard_value == 3 )
    {
        return;
    }
    
    self function_786bb6aa1b76c7ee( "traverse_teleport_state", 2 );
    self endon( #"death" );
    mover = utility::spawn_model( "tag_origin", self.origin + ( 0, 0, 20 ), self.angles );
    callback::callback( #"hash_87f46f8c460bcb41", { #mover:mover } );
    function_cfe6960bdb390a66( asmname, statename, mover );
    self function_786bb6aa1b76c7ee( "traverse_teleport_state", 3 );
    utility::delaythread( 0.5, &clearblackboard, "traverse_teleport_state" );
    
    if ( mover )
    {
        mover delete();
    }
}

// Namespace zombie_traverse_asm
// Params 1, eflags: 0x4
// Checksum 0x709f2637, Offset: 0x3ebf
// Size: 0x1c
function private clearblackboard( key )
{
    if ( isalive( self ) )
    {
        self function_f2df0257c63f229( key );
    }
}

// Namespace zombie_traverse_asm
// Params 3, eflags: 0x4
// Checksum 0xa2d8c876, Offset: 0x3ee3
// Size: 0x375
function private function_cfe6960bdb390a66( asmname, statename, mover )
{
    self endon( #"death" );
    self endon( #"terminate_ai_threads" );
    self endon( statename + "_finished" );
    startnode = undefined;
    
    if ( self.var_15c6e27c1acff47e == "node_based" )
    {
        startnode = self getnegotiationstartnode();
        
        if ( !isdefined( startnode ) )
        {
            startnode = self.traversal_start_node;
        }
        
        assert( isdefined( startnode ) );
    }
    
    startpos = undefined;
    endpos = undefined;
    apexpos = undefined;
    
    if ( self.var_15c6e27c1acff47e == "nodeless" || self.var_15c6e27c1acff47e == "linkless" )
    {
        if ( self.var_15c6e27c1acff47e == "linkless" && self.var_ef53ce9913fe1a35 == "fence" )
        {
            var_bfbd522a221be6d9 = &traverse::function_e51c2dd7b73c2c61;
        }
        else if ( self.var_15c6e27c1acff47e == "nodeless" )
        {
            var_bfbd522a221be6d9 = &traverse::function_b4671daaf4716143;
        }
        
        assert( isdefined( var_bfbd522a221be6d9 ), "<dev string:x24>" );
        self.var_9d40c8bd8f7a879 = self [[ var_bfbd522a221be6d9 ]]();
        startpos = self.var_9d40c8bd8f7a879.origin;
        endpos = self.var_9d40c8bd8f7a879.endpos;
        
        if ( isdefined( self.var_9d40c8bd8f7a879.apex_delta ) )
        {
            apexpos = startpos + self.var_9d40c8bd8f7a879.apex_delta;
        }
    }
    else if ( self.var_15c6e27c1acff47e == "node_based" )
    {
        startpos = startnode.origin;
        endpos = self getnegotiationendpos();
        
        if ( isdefined( startnode.apex_delta ) )
        {
            apexpos = startpos + startnode.apex_delta;
        }
        
        if ( !isdefined( endpos ) )
        {
            endnode = self getnegotiationendnode();
            
            if ( !isdefined( endnode ) && isdefined( self.traversal_end_node ) )
            {
                endpos = self.traversal_end_node.origin;
            }
        }
    }
    
    if ( isdefined( endpos ) )
    {
        if ( ai::is_floating() )
        {
            startpos += ( 0, 0, self.var_ed3c19fec55b26cc );
            endpos += ( 0, 0, max( self.var_69623111d7e6b9a4 - self.var_87edd2358c253b2c, 0 ) );
        }
        
        startpos += ( 0, 0, 20 );
        endpos += ( 0, 0, 20 );
        
        if ( trace::ray_trace_passed( mover.origin, endpos, self, trace::create_world_contents() ) )
        {
            movetopos( endpos, mover );
        }
        else
        {
            path_array = [];
            path_array[ path_array.size ] = mover.origin;
            path_array[ path_array.size ] = startpos;
            dist = distance( mover.origin, startpos );
            
            if ( isdefined( apexpos ) )
            {
                apexpos += ( 0, 0, 20 );
                path_array[ path_array.size ] = apexpos;
                dist += distance( startpos, apexpos );
                dist += distance( apexpos, endpos );
            }
            else
            {
                dist += distance( startpos, endpos );
            }
            
            path_array[ path_array.size ] = endpos;
            move_time = dist / 500;
            mover utility::function_2159dd4196ff4b81( path_array, move_time, 1, 0, 1 );
        }
        
        ground_pos = utility::groundpos( endpos ) ?? endpos;
        self.origin = ground_pos;
    }
}

// Namespace zombie_traverse_asm
// Params 2, eflags: 0x4
// Checksum 0xdb552f67, Offset: 0x4260
// Size: 0x5e
function private movetopos( pos, mover )
{
    dist = distance( pos, mover.origin );
    move_time = dist / 500;
    mover moveto( pos, move_time, move_time * 0.75, move_time * 0.25 );
    wait move_time;
}

