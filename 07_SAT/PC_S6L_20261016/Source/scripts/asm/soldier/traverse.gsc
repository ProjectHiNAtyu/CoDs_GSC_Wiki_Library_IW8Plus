// scripts\asm\soldier\traverse.gsc  (hash_55c37f8d19cc80e7.gscc) (size: 27947 Bytes / 0x6d2b / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xbae1b8 (12247480)
// size ...... 27947 (0x6d2b)
// includes .. 7   (offset: 0x6837)
// strings ... 56  (offset: 0x686f)
// dev strs .. 21  (offset: 0x6c2f)
// exports ... 74  (offset: 0x48c7)
// cseg ...... 0x37c + 0x454b (0x48c7)
// imports ... 131 (offset: 0x5457)
// animtree1 . 0   (offset: 0x6d2b)
// animtree2 . 0   (offset: 0x6d2b)
#using scripts\anim\utility;
#using scripts\asm\asm;
#using scripts\asm\shared\utility;
#using scripts\asm\soldier\arrival;
#using scripts\asm\soldier\cover;
#using scripts\asm\traverse;
#using scripts\common\utility;

#namespace traverse;

// Namespace traverse
// Params 3
// Checksum 0xdf2f957f, Offset: 0x39a
// Size: 0x1cb
function playtraverseanim_deprecated( asmname, statename, params )
{
    self endon( #"death" );
    self endon( #"terminate_ai_threads" );
    checktraverse( statename );
    traverseanim = asm::asm_getanim( asmname, statename );
    traversexanim = asm::asm_getxanim( statename, traverseanim );
    self.desired_anim_pose = "crouch";
    utility::updateanimpose();
    self endon( #"killanimscript" );
    self animmode( "noclip" );
    startnode = self getnegotiationstartnode();
    assert( isdefined( startnode ) );
    self orientmode( "face angle", startnode.angles[ 1 ] );
    startnode.traverse_height = startnode.origin[ 2 ] + startnode.traverse_height_delta;
    realheight = startnode.traverse_height - startnode.origin[ 2 ];
    thread teleportthread( realheight - params );
    self aisetanim( statename, traverseanim );
    var_ec4cc57f6551d469 = 0.2;
    thread traverse_donotetracks( asmname, statename );
    
    if ( !animhasnotetrack( traversexanim, "gravity on" ) )
    {
        var_84fe9fbc135daaa3 = 1.23;
        wait var_84fe9fbc135daaa3 - var_ec4cc57f6551d469;
        self animmode( "gravity" );
        wait var_ec4cc57f6551d469;
    }
    else
    {
        self waittillmatch( #"traverse", #"gravity on" );
        self animmode( "gravity" );
        
        if ( !animhasnotetrack( traversexanim, "blend" ) )
        {
            wait var_ec4cc57f6551d469;
        }
        else
        {
            self waittillmatch( #"traverse", #"blend" );
        }
    }
    
    terminatetraverse( asmname, statename );
}

// Namespace traverse
// Params 3
// Checksum 0x4a7fa31, Offset: 0x56d
// Size: 0x97
function playtraverseanim( asmname, statename, params )
{
    traverseanim = asm::asm_getanim( asmname, statename );
    checktraverse( statename );
    self animmode( "noclip" );
    startnode = self getnegotiationstartnode();
    assert( isdefined( startnode ) );
    self orientmode( "face angle", startnode.angles[ 1 ] );
    self aisetanim( statename, traverseanim );
    asm::asm_donotetracks( asmname, statename );
    terminatetraverse( asmname, statename );
}

// Namespace traverse
// Params 3
// Checksum 0xac201a8e, Offset: 0x60c
// Size: 0x31c
function playtraverseanim_doublejump( asmname, statename, params )
{
    self endon( #"death" );
    self endon( #"terminate_ai_threads" );
    self endon( statename + "_finished" );
    var_be123853ca3ed6d4 = getdvarint( @"hash_db3bdaface7c82ec", 0 );
    
    if ( var_be123853ca3ed6d4 != 3 && var_be123853ca3ed6d4 != 4 )
    {
        checktraverse( statename );
    }
    
    self.ragdoll_immediate = 1;
    start_node = self getnegotiationstartnode();
    end_node_pos = self getnegotiationendpos();
    start_node.traverse_height = start_node.origin[ 2 ] + start_node.traverse_height_delta - 44;
    move_to_locs = [];
    
    if ( start_node.traverse_height > end_node_pos[ 2 ] )
    {
        halfway_x = ( start_node.origin[ 0 ] + end_node_pos[ 0 ] ) * 0.5;
        halfway_y = ( start_node.origin[ 1 ] + end_node_pos[ 1 ] ) * 0.5;
        move_to_locs[ move_to_locs.size ] = ( halfway_x, halfway_y, start_node.traverse_height );
        
        /#
            if ( var_be123853ca3ed6d4 != 0 )
            {
                jump_over_position = move_to_locs[ 0 ];
                function_aa6e36543a3f1a24( self.origin, jump_over_position, ( 128, 0, 255 ), 100 );
                function_aa6e36543a3f1a24( self.origin, end_node_pos, ( 128, 0, 255 ), 100 );
            }
        #/
    }
    
    move_to_locs[ move_to_locs.size ] = end_node_pos;
    var_4b54d63627c6ccbb = spawn( "script_model", start_node.origin );
    var_4b54d63627c6ccbb setmodel( "tag_origin" );
    var_4b54d63627c6ccbb.angles = start_node.angles;
    thread utility::delete_on_death( var_4b54d63627c6ccbb );
    self orientmode( "face angle", start_node.angles[ 1 ] );
    max_time = 1.63;
    
    /#
        if ( var_be123853ca3ed6d4 == 3 )
        {
            max_time = 0.9;
        }
    #/
    
    self linkto( var_4b54d63627c6ccbb );
    jumpanim = asm::asm_getanim( asmname, statename );
    asm::asm_playfacialanim( asmname, statename, asm::asm_getxanim( jumpanim ) );
    self aisetanim( statename, jumpanim );
    thread traverse_donotetracks( asmname, statename );
    
    foreach ( org in move_to_locs )
    {
        move_time = max_time / move_to_locs.size;
        var_4b54d63627c6ccbb moveto( org, move_time );
        var_4b54d63627c6ccbb waittill( #"movedone" );
    }
    
    self notify( #"double_jumped" );
    self unlink();
    self.ragdoll_immediate = undefined;
    var_4b54d63627c6ccbb delete();
    thread terminatetraverse( asmname, statename );
}

// Namespace traverse
// Params 3
// Checksum 0xa6ca1b10, Offset: 0x930
// Size: 0x2e
function traverse_doublejump_cleanup( asmname, statename, params )
{
    self unlink();
    self.ragdoll_immediate = undefined;
}

// Namespace traverse
// Params 2
// Checksum 0xfce9a493, Offset: 0x966
// Size: 0x4e
function traverse_donotetracks( asmname, statename )
{
    self endon( #"death" );
    self endon( #"terminate_ai_threads" );
    self endon( statename + "_finished" );
    self endon( #"double_jumped" );
    asm::asm_donotetracks( asmname, statename );
}

// Namespace traverse
// Params 1
// Checksum 0x22b84f38, Offset: 0x9bc
// Size: 0x67
function getexternaltraverseinfo( traversename )
{
    assert( isdefined( level.scr_traverse ), "<dev string:x24>" );
    assert( isdefined( level.scr_traverse[ traversename ] ), "<dev string:x66>" + traversename + "<dev string:x7b>" );
    
    if ( isdefined( level.scr_traverse[ traversename ] ) )
    {
        return level.scr_traverse[ traversename ];
    }
    
    return;
}

// Namespace traverse
// Params 2
// Checksum 0x4e20925b, Offset: 0xa2b
// Size: 0x23
function function_a6072a7a16075b70( name, func )
{
    self.var_d52d7abeb60cc682[ name ] = func;
}

// Namespace traverse
// Params 1
// Checksum 0x842ceb3d, Offset: 0xa56
// Size: 0x19, Type: bool
function function_dc255caada8dc05e( name )
{
    return isdefined( self.var_d52d7abeb60cc682[ name ] );
}

// Namespace traverse
// Params 4
// Checksum 0x44fb59e2, Offset: 0xa78
// Size: 0x4a
function function_a9aa1e1721af633( name, asmname, statename, params )
{
    if ( isdefined( self.var_d52d7abeb60cc682[ name ] ) )
    {
        return [[ self.var_d52d7abeb60cc682[ name ] ]]( asmname, statename, params );
    }
}

// Namespace traverse
// Params 3
// Checksum 0x9b49995f, Offset: 0xaca
// Size: 0x75
function playtraverseanim_external( asmname, statename, params )
{
    if ( function_dc255caada8dc05e( "PlayTraverseAnim_External" ) )
    {
        return function_a9aa1e1721af633( "PlayTraverseAnim_External", asmname, statename, params );
    }
    
    assert( utility::issp(), "<dev string:x91>" + asmname + "<dev string:xb2>" + statename + "<dev string:xbd>" + self.origin );
    playtraverseanim_scaled( asmname, statename );
}

// Namespace traverse
// Params 3
// Checksum 0x798d7fda, Offset: 0xb47
// Size: 0xcc
function choosetraverseanim_external( asmname, statename, params )
{
    if ( function_dc255caada8dc05e( "ChooseTraverseAnim_External" ) )
    {
        return function_a9aa1e1721af633( "ChooseTraverseAnim_External", asmname, statename, params );
    }
    
    startnode = self getnegotiationstartnode();
    assert( isdefined( startnode ) );
    traversename = startnode.animscript;
    
    if ( isdefined( level.var_346636cddf2fe55a[ traversename ] ) )
    {
        xanim = [[ level.var_346636cddf2fe55a[ traversename ] ]]( asmname, statename, params );
        assert( isanimation( xanim ) );
        return xanim;
    }
    
    animinfo = getexternaltraverseinfo( traversename );
    assert( isanimation( animinfo ) );
    return animinfo;
}

// Namespace traverse
// Params 3
// Checksum 0x2b848496, Offset: 0xc1c
// Size: 0xa6
function playdoublejumpfinishanim( asmname, statename, params )
{
    self endon( statename + "_finished" );
    self animmode( "noclip" );
    self orientmode( "face angle", self.angles[ 1 ] );
    self.useanimgoalweight = 1;
    animid = asm::asm_getanim( asmname, statename );
    self aisetanim( statename, animid );
    xanim = asm::asm_getxanim( statename, animid );
    asm::asm_playfacialanim( asmname, statename, xanim );
    asm::asm_donotetracks( asmname, statename );
    thread terminatetraverse( asmname, statename );
}

// Namespace traverse
// Params 5
// Checksum 0xd27be065, Offset: 0xcca
// Size: 0xc3
function getdoublejumpoffsetposition( asmname, var_9e81b2c9573f34cd, endpos, endangles, notetrackname )
{
    animid = asm::asm_chooseanim( asmname, var_9e81b2c9573f34cd );
    assert( isdefined( animid ) );
    xanim = asm::asm_getxanim( var_9e81b2c9573f34cd, animid );
    aligntime = getnotetracktimes( xanim, notetrackname );
    assert( aligntime.size > 0 );
    time = aligntime[ 0 ];
    animdelta = getmovedelta( xanim, 0, time );
    animangledelta = getangledelta( xanim, 0, time );
    return cover::calcanimstartpos( endpos, endangles[ 1 ], animdelta, animangledelta );
}

// Namespace traverse
// Params 4
// Checksum 0x6349583, Offset: 0xd96
// Size: 0x1a3, Type: bool
function doublejumpneedsfinishanim( asmname, nextstatename, startnode, endpos )
{
    assert( isdefined( startnode ) );
    assert( isdefined( endpos ) );
    
    /#
        if ( getdvarint( @"hash_db3bdaface7c82ec", 0 ) == 3 )
        {
            return false;
        }
    #/
    
    deltaz = endpos[ 2 ] - startnode.origin[ 2 ];
    
    if ( deltaz < 0 )
    {
        return false;
    }
    
    if ( isdefined( startnode.jump_over_offset ) && getdvarint( @"hash_db3bdaface7c82ec", 0 ) != 2 )
    {
        jump_over_offset = startnode.jump_over_offset;
        angleoffset = startnode.angles - startnode.startnodeoriginalangles;
        
        if ( angleoffset != ( 0, 0, 0 ) )
        {
            jump_over_offset = rotatevector( jump_over_offset, angleoffset );
        }
        
        jump_over_position = startnode.origin + jump_over_offset;
        var_4c6afa3f92091794 = jump_over_position[ 2 ];
        var_4c6afa3f92091794 -= 44;
        
        if ( endpos[ 2 ] < var_4c6afa3f92091794 )
        {
            return false;
        }
    }
    
    delta = endpos - startnode.origin;
    delta = ( delta[ 0 ], delta[ 1 ], 0 );
    desiredangles = vectortoangles( delta );
    offsetpos = getdoublejumpoffsetposition( asmname, nextstatename, endpos, desiredangles, "footstep_left_small" );
    newdelta = offsetpos - startnode.origin;
    
    if ( vectordot( newdelta, delta ) < 0 )
    {
        return false;
    }
    
    return true;
}

// Namespace traverse
// Params 4
// Checksum 0x73d92fec, Offset: 0xf42
// Size: 0x8c, Type: bool
function checkdoublejumpfinish( asmname, statename, tostatename, params )
{
    startnode = gettraversalstartnode();
    
    if ( !isdefined( startnode ) )
    {
        thread terminatetraverse( asmname, "double_jump" );
        return false;
    }
    
    endpos = self getnegotiationendpos();
    assert( isdefined( endpos ) );
    
    if ( !doublejumpneedsfinishanim( asmname, tostatename, startnode, endpos ) )
    {
        thread terminatetraverse( asmname, "double_jump" );
        return false;
    }
    
    return true;
}

// Namespace traverse
// Params 0
// Checksum 0x4bc86aa7, Offset: 0xfd7
// Size: 0x25
function gettraversalstartnode()
{
    var_7237854e3be197ca = self.traversal_start_node;
    
    if ( isdefined( var_7237854e3be197ca ) )
    {
        return var_7237854e3be197ca;
    }
    
    return self getnegotiationstartnode();
}

// Namespace traverse
// Params 3
// Checksum 0xe33c68c6, Offset: 0x1005
// Size: 0x114
function playdoublejumpmantleorvault( asmname, statename, zoffset )
{
    self endon( statename + "_finished" );
    startnode = gettraversalstartnode();
    assert( isdefined( startnode.doublejumpmantlepos ) );
    assert( isdefined( startnode ) );
    endpos = startnode.doublejumpmantlepos;
    
    /#
    #/
    
    delta = endpos - startnode.origin;
    delta = ( delta[ 0 ], delta[ 1 ], 0 );
    desiredangles = vectortoangles( delta );
    jumpanim = asm::asm_getanim( asmname, statename );
    assert( isdefined( jumpanim ) );
    nextstatename = statename + "_finish";
    mantlestartpos = getdoublejumpoffsetposition( asmname, nextstatename, endpos, desiredangles, "mantle_align" );
    mantlestartpos = ( mantlestartpos[ 0 ], mantlestartpos[ 1 ], mantlestartpos[ 2 ] + zoffset );
    playscaledjump( asmname, statename, jumpanim, mantlestartpos, desiredangles, 1, 0, 1 );
}

// Namespace traverse
// Params 3
// Checksum 0x9e936e00, Offset: 0x1121
// Size: 0x2a
function playdoublejumpmantle( asmname, statename, params )
{
    playdoublejumpmantleorvault( asmname, statename, -8 );
}

// Namespace traverse
// Params 3
// Checksum 0x7606ed02, Offset: 0x1153
// Size: 0x2a
function playdoublejumpvault( asmname, statename, params )
{
    playdoublejumpmantleorvault( asmname, statename, -42 );
}

// Namespace traverse
// Params 3
// Checksum 0x5104cc3f, Offset: 0x1185
// Size: 0x3c
function doublejumpterminate( asmname, statename, params )
{
    self.useanimgoalweight = 0;
    self.jump_over_position = undefined;
    self.traversal_start_node = undefined;
}

// Namespace traverse
// Params 3
// Checksum 0x69ce1547, Offset: 0x11c9
// Size: 0x3a
function doublejumpearlyterminate( asmname, statename, params )
{
    if ( !asm::asm_eventfired( asmname, "end" ) )
    {
        doublejumpterminate( asmname, statename, params );
    }
}

// Namespace traverse
// Params 4
// Checksum 0x137eee5d, Offset: 0x120b
// Size: 0x4d
function isdoublejumpanimdone( asmname, statename, tostatename, params )
{
    /#
        if ( getdvarint( @"hash_db3bdaface7c82ec", 0 ) == 3 )
        {
            return 0;
        }
    #/
    
    return asm::asm_eventfired( asmname, "end" );
}

// Namespace traverse
// Params 3
// Checksum 0xf997c997, Offset: 0x1261
// Size: 0x3a6
function playdoublejumptraversal( asmname, statename, params )
{
    self endon( statename + "_finished" );
    
    /#
        if ( getdvarint( @"hash_db3bdaface7c82ec", 0 ) == 4 )
        {
            playtraverseanim_doublejump( asmname, "<dev string:xf0>", params );
            return;
        }
        
        if ( getdvarint( @"hash_db3bdaface7c82ec", 0 ) == 3 )
        {
            playtraverseanim_doublejump( asmname, statename, params );
            return;
        }
    #/
    
    startnode = gettraversalstartnode();
    endpos = self getnegotiationendpos();
    assert( isdefined( startnode ) );
    assert( isdefined( endpos ) );
    
    if ( !isdefined( startnode.startnodeoriginalangles ) )
    {
        startnode.startnodeoriginalangles = startnode.angles;
    }
    
    angleoffset = startnode.angles - startnode.startnodeoriginalangles;
    
    if ( angleoffset != ( 0, 0, 0 ) )
    {
        endpos = rotatevector( endpos, angleoffset );
    }
    
    jump_over_position = undefined;
    var_be123853ca3ed6d4 = getdvarint( @"hash_db3bdaface7c82ec", 0 );
    
    if ( var_be123853ca3ed6d4 != 2 )
    {
        if ( isdefined( startnode.jump_over_offset ) )
        {
            jump_over_offset = startnode.jump_over_offset;
            
            if ( angleoffset != ( 0, 0, 0 ) )
            {
                jump_over_offset = rotatevector( jump_over_offset, angleoffset );
            }
            
            jump_over_position = startnode.origin + jump_over_offset;
            var_4c6afa3f92091794 = jump_over_position[ 2 ];
            var_4c6afa3f92091794 -= 44;
            
            if ( var_4c6afa3f92091794 > endpos[ 2 ] )
            {
                halfway_x = ( startnode.origin[ 0 ] + endpos[ 0 ] ) * 0.5;
                halfway_y = ( startnode.origin[ 1 ] + endpos[ 1 ] ) * 0.5;
                jump_over_position = ( halfway_x, halfway_y, jump_over_position[ 2 ] );
            }
            else
            {
                jump_over_position = undefined;
            }
        }
    }
    
    jumpanim = asm::asm_getanim( asmname, statename );
    assert( isdefined( jumpanim ) );
    self.jump_over_position = jump_over_position;
    
    /#
        if ( getdvarint( @"hash_db3bdaface7c82ec", 0 ) != 0 )
        {
            if ( isdefined( jump_over_position ) )
            {
                function_aa6e36543a3f1a24( self.origin, jump_over_position, ( 128, 0, 255 ), 100 );
                function_aa6e36543a3f1a24( self.origin, endpos, ( 128, 0, 255 ), 100 );
            }
            else
            {
                function_aa6e36543a3f1a24( self.origin, endpos, ( 128, 255, 0 ), 100 );
            }
        }
    #/
    
    nextstatename = statename + "_finish";
    
    if ( doublejumpneedsfinishanim( asmname, nextstatename, startnode, endpos ) )
    {
        delta = endpos - startnode.origin;
        delta = ( delta[ 0 ], delta[ 1 ], 0 );
        desiredangles = vectortoangles( delta );
        nextstatename = statename + "_finish";
        offsetpos = getdoublejumpoffsetposition( asmname, nextstatename, endpos, desiredangles, "footstep_left_small" );
        endpos = offsetpos;
    }
    
    delta = endpos - startnode.origin;
    var_3e35a4edb5f479f0 = 0;
    animendtime = 1;
    
    if ( delta[ 2 ] < 0 )
    {
        var_3e35a4edb5f479f0 = 1;
        touchgroundtime = getnotetracktimes( asm::asm_getxanim( statename, jumpanim ), "gravity on" );
        
        if ( touchgroundtime.size > 0 )
        {
            animendtime = touchgroundtime[ 0 ];
        }
    }
    
    delta = ( delta[ 0 ], delta[ 1 ], 0 );
    desiredangles = vectortoangles( delta );
    playscaledjump( asmname, statename, jumpanim, endpos, desiredangles, animendtime, var_3e35a4edb5f479f0, 1 );
}

// Namespace traverse
// Params 3
// Checksum 0x97e9a661, Offset: 0x160f
// Size: 0xed
function choosedoublejumpanim( asmname, statename, params )
{
    endpos = self getnegotiationendpos();
    assert( isdefined( endpos ) );
    alias = "double_jump_up";
    
    if ( isdefined( params ) )
    {
        assert( params == "<dev string:x101>" || params == "<dev string:x104>" );
        alias = "double_jump_" + params;
    }
    else if ( endpos[ 2 ] < self.origin[ 2 ] )
    {
        alias = "double_jump_down";
    }
    
    if ( self.asm.footsteps.foot == "right" )
    {
        prefix = "right_";
    }
    else
    {
        prefix = "left_";
    }
    
    alias = prefix + alias;
    animname = asm::asm_lookupanimfromalias( statename, alias );
    return animname;
}

// Namespace traverse
// Params 2
// Checksum 0xa5c0ab, Offset: 0x1705
// Size: 0x129
function getwallnodeposition( startnode, index )
{
    assert( index >= 0 );
    assert( isdefined( startnode ) );
    assert( isdefined( startnode.wall_info ) );
    assert( isdefined( startnode.wall_info.nodeoffsets ) );
    assert( startnode.wall_info.nodeoffsets.size > index );
    angleoffset = startnode.angles - startnode.wall_info.startnodeoriginalangles;
    
    if ( angleoffset != ( 0, 0, 0 ) )
    {
        worlddelta = rotatevector( startnode.wall_info.nodeoffsets[ index ], angleoffset );
        nodeposition = startnode.origin + worlddelta;
    }
    else
    {
        nodeposition = startnode.origin + startnode.wall_info.nodeoffsets[ index ];
    }
    
    return nodeposition;
}

// Namespace traverse
// Params 4
// Checksum 0xf1d8cc16, Offset: 0x1837
// Size: 0x15e, Type: bool
function shouldwallrunshoot( asmname, statename, tostatename, params )
{
    if ( !isdefined( self.enemy ) )
    {
        return false;
    }
    
    enemypos = self.enemy.origin;
    startnode = self.traversal_start_node;
    assert( isdefined( startnode ) );
    assert( isdefined( startnode.wall_info ) );
    assert( isdefined( self.wall_run_current_node_index ) );
    assert( startnode.wall_info.nodeoffsets.size > self.wall_run_current_node_index + 1 );
    wallstartpos = getwallnodeposition( startnode, self.wall_run_current_node_index );
    wallendpos = getwallnodeposition( startnode, self.wall_run_current_node_index + 1 );
    wallendpos = ( wallendpos[ 0 ], wallendpos[ 1 ], wallstartpos[ 2 ] );
    enemypos = ( enemypos[ 0 ], enemypos[ 1 ], wallstartpos[ 2 ] );
    walldir = vectornormalize( wallendpos - wallstartpos );
    enemydir = vectornormalize( enemypos - wallstartpos );
    dot = vectordot( walldir, enemydir );
    
    if ( dot < 0.2588 )
    {
        return false;
    }
    
    return true;
}

// Namespace traverse
// Params 3
// Checksum 0x177e72b6, Offset: 0x199e
// Size: 0x4f
function choosewallrunanim( asmname, statename, params )
{
    assert( isdefined( self.wall_run_direction ) );
    jumpanim = asm::asm_lookupanimfromalias( statename, self.wall_run_direction );
    return jumpanim;
}

// Namespace traverse
// Params 1
// Checksum 0x1bad558b, Offset: 0x19f6
// Size: 0x47
function getsmoothstep( delta )
{
    /#
        if ( getdvarint( @"hash_dd616d5851bec943", 1 ) == 2 )
        {
            return ( delta * delta * delta * ( delta * ( delta * 6 - 15 ) + 10 ) );
        }
    #/
    
    return delta * delta * ( 3 - 2 * delta );
}

// Namespace traverse
// Params 6
// Checksum 0x66aba67f, Offset: 0x1a46
// Size: 0x173
function teleportdeltaovernumframes( statename, waittime, delta, numframes, animname, playbackrate )
{
    self endon( statename + "_finished" );
    
    if ( waittime > 0 )
    {
        wait waittime;
    }
    
    framedelta = delta / numframes;
    startpos = self.origin[ 2 ];
    endpos = startpos + delta[ 2 ];
    lastz = self.origin[ 2 ];
    self setanimrate( animname, playbackrate );
    
    for ( i = 0; i < numframes ; i++ )
    {
        var_eb05fb595e8fff69 = 1;
        
        /#
            if ( getdvarint( @"hash_dd616d5851bec943", 1 ) == 0 )
            {
                var_eb05fb595e8fff69 = 0;
            }
        #/
        
        if ( var_eb05fb595e8fff69 )
        {
            pct = i / ( numframes - 1 );
            smoothstep = getsmoothstep( pct );
            newz = endpos * smoothstep + startpos * ( 1 - smoothstep );
            newdeltaz = newz - lastz;
            framedelta = ( framedelta[ 0 ], framedelta[ 1 ], newdeltaz );
            lastz = newz;
        }
        
        neworigin = self.origin + framedelta;
        self forceteleport( neworigin );
        
        if ( i + 1 < numframes )
        {
            waitframe();
        }
    }
    
    self setanimrate( animname, 1 );
}

/#

    // Namespace traverse
    // Params 2
    // Checksum 0xc8200768, Offset: 0x1bc1
    // Size: 0x61, Type: dev
    function debugdest( dest, statename )
    {
        self notify( #"hash_acc0fe7aa3900d01" );
        self endon( #"hash_acc0fe7aa3900d01" );
        self endon( statename + "<dev string:x109>" );
        
        while ( true )
        {
            line( self.origin, dest, ( 0, 255, 0 ) );
            waitframe();
        }
    }

#/

// Namespace traverse
// Params 2
// Checksum 0x20f77ca9, Offset: 0x1c2a
// Size: 0x42
function wallrunnotehandler( note, params )
{
    if ( note == "start_jump" )
    {
        thread handlejumpteleports( params );
        return;
    }
    
    if ( note == "end_mantle" )
    {
        self animmode( "gravity" );
    }
}

// Namespace traverse
// Params 3
// Checksum 0x91c82939, Offset: 0x1c74
// Size: 0x351
function handlejumpteleports( params, animtime, playbackrate )
{
    assert( isarray( params ) );
    assert( params.size == 7 );
    statename = params[ 0 ];
    animname = params[ 1 ];
    desiredendpos = params[ 2 ];
    starttime = params[ 3 ];
    var_b469749df561f1d1 = params[ 4 ];
    var_43451d2d68e7deb8 = params[ 6 ];
    self endon( statename + "_finished" );
    animlength = getanimlength( animname );
    
    if ( !isdefined( animtime ) )
    {
        animtime = ( gettime() - starttime ) * 0.001;
    }
    
    animtimepct = animtime / animlength;
    endjumptime = getnotetracktimes( animname, "end_jump" );
    var_8175c36cc5c4c6cb = getnotetracktimes( animname, "end_double_jump" );
    
    if ( var_8175c36cc5c4c6cb.size > 0 )
    {
        self.wall_run_double_jumping = 1;
        endjumptime = var_8175c36cc5c4c6cb;
    }
    else
    {
        self.wall_run_double_jumping = 0;
    }
    
    assert( endjumptime.size > 0 );
    
    if ( isdefined( self.jump_over_position ) )
    {
        var_b469749df561f1d1 = ( endjumptime[ 0 ] - animtimepct ) / 2 + animtimepct;
        endjumptime[ 0 ] = var_b469749df561f1d1;
        desiredendpos = self.jump_over_position;
    }
    
    movedelta = getmovedelta( animname, animtimepct, var_b469749df561f1d1 );
    animendpos = self localtoworldcoords( movedelta );
    
    /#
        if ( getdvarint( @"ai_debugwallrun", 0 ) != 0 && isdefined( self.traversal_start_node ) )
        {
            disttoanimend = distance( self.origin, animendpos );
            disttodesiredpos = distance( self.origin, desiredendpos );
            var_5339d95f01c746d6 = disttodesiredpos / disttoanimend;
            
            if ( var_5339d95f01c746d6 < 0.8 || var_5339d95f01c746d6 > 1.2 )
            {
                println( "<dev string:x113>" + self.traversal_start_node.origin + "<dev string:x13c>" + animname + "<dev string:x151>" + var_5339d95f01c746d6 );
                println( "<dev string:x156>" + disttoanimend + "<dev string:x164>" + disttodesiredpos );
            }
        }
    #/
    
    if ( !isdefined( playbackrate ) )
    {
        playbackrate = 1;
    }
    
    if ( var_43451d2d68e7deb8 )
    {
        disttoanimend = distance( self.origin, animendpos );
        disttodesiredpos = distance( self.origin, desiredendpos );
        playbackrate = disttoanimend / disttodesiredpos;
        
        if ( playbackrate < 0.7 )
        {
            playbackrate = 0.7;
        }
        else if ( playbackrate > 1.3 )
        {
            playbackrate = 1.3;
        }
    }
    
    scaledelta = desiredendpos - animendpos;
    var_ff920d9eeede7d06 = endjumptime[ 0 ] * animlength;
    jumpduration = var_ff920d9eeede7d06 - animtimepct * animlength;
    jumpduration *= 1 / playbackrate;
    numframes = jumpduration * 20;
    numframes = ceil( numframes );
    teleportstarttime = gettime();
    teleportdeltaovernumframes( statename, 0, scaledelta, numframes, animname, playbackrate );
    
    if ( isdefined( self.jump_over_position ) )
    {
        animtimedelta = ( gettime() - teleportstarttime ) * playbackrate;
        realanimtime = animtime + animtimedelta * 0.001;
        self.jump_over_position = undefined;
        params[ 6 ] = 0;
        handlejumpteleports( params, realanimtime, playbackrate );
    }
}

// Namespace traverse
// Params 1
// Checksum 0x931b3e46, Offset: 0x1fcd
// Size: 0x75
function getwallrunyawfromstartnode( startnode )
{
    assert( isdefined( startnode.wall_info ) );
    assert( startnode.wall_info.nodeoffsets.size >= 2 );
    delta = getwallnodeposition( startnode, 1 ) - getwallnodeposition( startnode, 0 );
    desiredangles = vectortoangles( delta );
    return desiredangles[ 1 ];
}

// Namespace traverse
// Params 1
// Checksum 0x7a68a601, Offset: 0x204b
// Size: 0xf9
function getwallrundirectionfromstartnode( startnode )
{
    assert( isdefined( startnode ) );
    assert( isdefined( startnode.wall_info ) );
    assert( startnode.wall_info.nodeoffsets.size >= 2 );
    self.wall_run_current_node_index = 0;
    delta = getwallnodeposition( startnode, 1 ) - getwallnodeposition( startnode, 0 );
    desiredangles = vectortoangles( delta );
    self.wall_run_yaw = desiredangles[ 1 ];
    startposition = getwallnodeposition( startnode, self.wall_run_current_node_index );
    right = anglestoright( desiredangles );
    dir = startposition - startnode.origin;
    dot = vectordot( right, dir );
    
    if ( dot > 0 )
    {
        return "right";
    }
    
    return "left";
}

// Namespace traverse
// Params 0
// Checksum 0xf14580ea, Offset: 0x214d
// Size: 0x62
function setupwallrunifneeded()
{
    if ( isdefined( self.wall_run_direction ) )
    {
        return;
    }
    
    if ( !isdefined( self.traversal_start_node ) )
    {
        self.traversal_start_node = self getnegotiationstartnode();
    }
    
    assert( isdefined( self.traversal_start_node ) );
    startnode = self.traversal_start_node;
    self.wall_run_direction = getwallrundirectionfromstartnode( startnode );
}

// Namespace traverse
// Params 0
// Checksum 0xf27d94b5, Offset: 0x21b7
// Size: 0x12
function getwallrundirection()
{
    setupwallrunifneeded();
    return self.wall_run_direction;
}

// Namespace traverse
// Params 3
// Checksum 0x7d032607, Offset: 0x21d2
// Size: 0x74
function wallrunterminate( asmname, statename, params )
{
    self.wall_run_current_node_index = undefined;
    self.wall_run_direction = undefined;
    self.wall_run_double_jumping = undefined;
    self.wall_run_yaw = undefined;
    self.wall_run_attach_anim = undefined;
    self setdefaultaimlimits();
    self.useanimgoalweight = 0;
    self.jump_over_position = undefined;
    self.traversal_start_node = undefined;
}

// Namespace traverse
// Params 3
// Checksum 0x538adf43, Offset: 0x224e
// Size: 0x55
function traversalorientearlyterminate( asmname, statename, params )
{
    if ( !asm::asm_eventfired( asmname, "end" ) && !asm::asm_eventfired( asmname, "code_move" ) )
    {
        self.traversal_start_node = undefined;
        self.wall_run_direction = undefined;
    }
}

// Namespace traverse
// Params 3
// Checksum 0x6dfbdd42, Offset: 0x22ab
// Size: 0x12d
function playwallrunattach( asmname, statename, params )
{
    self animmode( "noclip" );
    self orientmode( "face angle", self.angles[ 1 ] );
    self.useanimgoalweight = 1;
    
    if ( params == "shoot" )
    {
        setupwallrunaimlimits();
    }
    
    animid = asm::asm_getanim( asmname, statename );
    xanim = asm::asm_getxanim( statename, animid );
    var_b7df5af73e289377 = getnotetracktimes( xanim, "wall_contact" );
    assert( var_b7df5af73e289377.size > 0 );
    time = var_b7df5af73e289377[ 0 ];
    angledelta = getangledelta( xanim, 0, time );
    faceyaw = self.wall_run_yaw - angledelta;
    forceangles = ( 0, faceyaw, 0 );
    self forceteleport( self.origin, forceangles );
    self aisetanim( statename, animid );
    asm::asm_playfacialanim( asmname, statename, xanim );
    endnote = asm::asm_donotetracks( asmname, statename, asm::asm_getnotehandler( asmname, statename ) );
}

// Namespace traverse
// Params 1
// Checksum 0x37011d33, Offset: 0x23e0
// Size: 0xa7
function getwallattachoffsetposition( asmname )
{
    animname = choosewallattachanim( asmname, "wall_run_attach" );
    assert( isdefined( animname ) );
    var_b7df5af73e289377 = getnotetracktimes( animname, "wall_contact" );
    assert( var_b7df5af73e289377.size > 0 );
    time = var_b7df5af73e289377[ 0 ];
    animdelta = getmovedelta( animname, 0, time );
    animangledelta = getangledelta( animname, 0, time );
    return cover::calcanimstartpos( getwallnodeposition( self.traversal_start_node, 0 ), self.wall_run_yaw, animdelta, animangledelta );
}

// Namespace traverse
// Params 3
// Checksum 0x57e2c1ab, Offset: 0x2490
// Size: 0x1a6
function playwallrunenter( asmname, statename, params )
{
    self endon( statename + "_finished" );
    animid = asm::asm_getanim( asmname, statename );
    xanim = asm::asm_getxanim( statename, animid );
    startnode = self.traversal_start_node;
    assert( isdefined( startnode ) );
    assert( isdefined( startnode.wall_info ) );
    assert( startnode.wall_info.nodeoffsets.size >= 2 );
    self.wall_run_current_node_index = 0;
    wallnodepos = getwallnodeposition( startnode, 0 );
    delta = wallnodepos - self.origin;
    delta = ( delta[ 0 ], delta[ 1 ], 0 );
    desiredangles = vectortoangles( delta );
    jumpdestination = getwallattachoffsetposition();
    self orientmode( "face angle", desiredangles[ 1 ] );
    assert( isdefined( self.wall_run_direction ) );
    
    /#
        if ( getdvarint( @"ai_debugwallrun", 0 ) != 0 )
        {
            function_aa6e36543a3f1a24( self.origin, jumpdestination, ( 128, 0, 255 ), 100 );
        }
    #/
    
    animendtime = 1;
    codemovetime = getnotetracktimes( xanim, "code_move" );
    
    if ( codemovetime.size > 0 )
    {
        animendtime = codemovetime[ 0 ];
    }
    
    playscaledjump( asmname, statename, animid, jumpdestination, desiredangles, animendtime, 0, 1 );
    self forceteleport( jumpdestination, desiredangles );
}

// Namespace traverse
// Params 8
// Checksum 0x31358b36, Offset: 0x263e
// Size: 0x116
function playscaledjump( asmname, statename, animid, desiredposition, desiredangles, var_b469749df561f1d1, var_3e35a4edb5f479f0, var_43451d2d68e7deb8 )
{
    self endon( statename + "_finished" );
    
    if ( !isdefined( var_b469749df561f1d1 ) )
    {
        var_b469749df561f1d1 = 1;
    }
    
    if ( !isdefined( var_3e35a4edb5f479f0 ) )
    {
        var_3e35a4edb5f479f0 = 0;
    }
    
    if ( !isdefined( var_43451d2d68e7deb8 ) )
    {
        var_43451d2d68e7deb8 = 0;
    }
    
    self forceteleport( self.origin, desiredangles );
    self animmode( "noclip" );
    self orientmode( "face angle", desiredangles[ 1 ] );
    xanim = asm::asm_getxanim( statename, animid );
    self.useanimgoalweight = 1;
    self aisetanim( statename, animid );
    asm::asm_playfacialanim( asmname, statename, xanim );
    notetrackparams = [ statename, xanim, desiredposition, gettime(), var_b469749df561f1d1, var_3e35a4edb5f479f0, var_43451d2d68e7deb8 ];
    asm::asm_donotetracks( asmname, statename, &wallrunnotehandler, notetrackparams );
}

// Namespace traverse
// Params 3
// Checksum 0x76d82489, Offset: 0x275c
// Size: 0xc3
function choosewallattachanim( asmname, statename, params )
{
    var_7237854e3be197ca = self.wall_run_attach_anim;
    
    if ( isdefined( var_7237854e3be197ca ) )
    {
        return var_7237854e3be197ca;
    }
    
    aliasname = self.wall_run_direction;
    yawdelta = angleclamp180( self.wall_run_yaw - self.angles[ 1 ] );
    yawdelta = abs( yawdelta );
    
    if ( yawdelta >= 22.5 )
    {
        if ( yawdelta > 67.5 )
        {
            aliasname += "_90";
        }
        else
        {
            aliasname += "_45";
        }
    }
    
    self.wall_run_attach_anim = asm::asm_lookupanimfromalias( statename, aliasname );
    return self.wall_run_attach_anim;
}

// Namespace traverse
// Params 3
// Checksum 0x4cd41f36, Offset: 0x2828
// Size: 0x1a8
function choosewallrunenteranim( asmname, statename, params )
{
    setupwallrunifneeded();
    assert( isdefined( self.wall_run_direction ) );
    assert( isdefined( self.traversal_start_node ) );
    alias = self.wall_run_direction;
    startnode = self.traversal_start_node;
    assert( isdefined( startnode ) );
    assert( isdefined( startnode.wall_info ) );
    assert( startnode.wall_info.nodeoffsets.size >= 2 );
    jumptopos = getwallnodeposition( startnode, 0 );
    zdelta = jumptopos[ 2 ] - self.origin[ 2 ];
    bdoublejump = 0;
    
    if ( zdelta >= 0 )
    {
        if ( zdelta > 120 )
        {
            bdoublejump = 1;
        }
    }
    else if ( 0 - zdelta > 240 )
    {
        bdoublejump = 1;
    }
    
    if ( bdoublejump == 0 )
    {
        distsq = distancesquared( self.origin, jumptopos );
        
        if ( distsq > 40000 )
        {
            bdoublejump = 1;
        }
    }
    
    prefix = "left_";
    
    if ( self.asm.footsteps.foot == "right" )
    {
        prefix = "right_";
    }
    
    if ( bdoublejump )
    {
        alias = prefix + "double_jump";
    }
    else
    {
        alias = prefix + "single_jump";
    }
    
    jumpanim = asm::asm_lookupanimfromalias( statename, alias );
    return jumpanim;
}

// Namespace traverse
// Params 5
// Checksum 0x4cad3fd9, Offset: 0x29d9
// Size: 0x52
function senddelayedevent( asmname, statename, time, event, var_8b75ef26f1c5c28d )
{
    self endon( statename + "_finished" );
    wait time;
    asm::asm_fireevent( asmname, event );
    
    if ( var_8b75ef26f1c5c28d )
    {
        self notify( event );
    }
}

// Namespace traverse
// Params 4
// Checksum 0xe193edbc, Offset: 0x2a33
// Size: 0xc3, Type: bool
function hasanotherwallrun( asmname, statename, tostatename, params )
{
    if ( !isdefined( self.wall_run_current_node_index ) )
    {
        return false;
    }
    
    startnode = self.traversal_start_node;
    
    if ( !isdefined( startnode ) )
    {
        return false;
    }
    
    assert( isdefined( startnode.wall_info ) );
    var_be268e3b9569fa71 = self.wall_run_current_node_index + 2;
    
    if ( startnode.wall_info.nodeoffsets.size <= var_be268e3b9569fa71 )
    {
        return false;
    }
    
    assert( startnode.wall_info.nodeoffsets.size > var_be268e3b9569fa71 + 1 );
    return true;
}

// Namespace traverse
// Params 3
// Checksum 0xd015133, Offset: 0x2aff
// Size: 0x10f
function playwallruncontinue( asmname, statename, params )
{
    self endon( statename + "_finished" );
    startnode = self.traversal_start_node;
    self function_ff32ea59b2119107();
    assert( isdefined( startnode ) );
    self.wall_run_current_node_index += 2;
    assert( startnode.wall_info.nodeoffsets.size > self.wall_run_current_node_index + 1 );
    endpos = getwallnodeposition( startnode, self.wall_run_current_node_index );
    desiredangles = self.angles;
    
    if ( self.wall_run_direction == "left" )
    {
        self.wall_run_direction = "right";
    }
    else
    {
        self.wall_run_direction = "left";
    }
    
    animid = asm::asm_getanim( asmname, statename );
    playscaledjump( asmname, statename, animid, endpos, desiredangles );
}

// Namespace traverse
// Params 1
// Checksum 0x7d395e43, Offset: 0x2c16
// Size: 0xde
function getwallrunmantleposition( startnode )
{
    assert( isdefined( startnode ) );
    assert( isdefined( startnode.wall_info ) );
    assert( isdefined( startnode.wall_info.mantleoffset ) );
    angleoffset = startnode.angles - startnode.wall_info.startnodeoriginalangles;
    
    if ( angleoffset == ( 0, 0, 0 ) )
    {
        return ( startnode.origin + startnode.wall_info.mantleoffset );
    }
    
    worlddelta = rotatevector( startnode.wall_info.mantleoffset, angleoffset );
    return startnode.origin + worlddelta;
}

// Namespace traverse
// Params 1
// Checksum 0xd2c77c38, Offset: 0x2cfd
// Size: 0xb8
function getwallrunmantleangles( startnode )
{
    assert( isdefined( startnode ) );
    assert( isdefined( startnode.wall_info ) );
    
    if ( !isdefined( startnode.wall_info.mantleangles ) )
    {
        return;
    }
    
    angleoffset = startnode.angles[ 1 ] - startnode.wall_info.startnodeoriginalangles[ 1 ];
    
    if ( angleoffset == 0 )
    {
        return startnode.wall_info.mantleangles;
    }
    
    return ( 0, angleclamp180( startnode.wall_info.mantleangles[ 1 ] + angleoffset ), 0 );
}

// Namespace traverse
// Params 0
// Checksum 0x9dd9fedf, Offset: 0x2dbe
// Size: 0x73
function getwallruntomantletype()
{
    startnode = self.traversal_start_node;
    assert( isdefined( startnode ) );
    
    if ( !isdefined( startnode.wall_info.mantleoffset ) )
    {
        return "none";
    }
    
    mantlepos = getwallrunmantleposition( startnode );
    
    if ( mantlepos[ 2 ] >= self.origin[ 2 ] )
    {
        return "high";
    }
    
    return "low";
}

// Namespace traverse
// Params 4
// Checksum 0xcf3012b4, Offset: 0x2e3a
// Size: 0x78
function shouldwallruntovault( asmname, statename, tostatename, params )
{
    startnode = self.traversal_start_node;
    assert( isdefined( startnode ) );
    
    if ( !isdefined( startnode.wall_info.bvaultover ) )
    {
        return 0;
    }
    
    return startnode.wall_info.bvaultover;
}

// Namespace traverse
// Params 3
// Checksum 0xef0dd8a9, Offset: 0x2ebb
// Size: 0x297
function playwallrunloop( asmname, statename, params )
{
    self endon( statename + "_finished" );
    startnode = self.traversal_start_node;
    assert( isdefined( startnode ) );
    assert( isdefined( startnode.wall_info ) );
    setupwallrunaimlimits();
    loopanim = asm::asm_getanim( asmname, statename );
    assert( isdefined( loopanim ) );
    loopxanim = asm::asm_getxanim( statename, loopanim );
    movedelta = getmovedelta( loopxanim );
    animmovedist = length2d( movedelta );
    assert( animmovedist > 0 );
    
    if ( !isdefined( startnode.wall_info.mantleoffset ) && self.wall_run_current_node_index == startnode.wall_info.nodeoffsets.size - 2 )
    {
        exitanim = asm::asm_getanim( asmname, "wall_run_exit" );
        assert( isdefined( exitanim ) );
        exitxanim = asm::asm_getxanim( "wall_run_exit", exitanim );
        var_f75545153ec4db10 = getnotetracktimes( exitxanim, "start_jump" );
        assert( var_f75545153ec4db10.size > 0 );
        exitanimlength = getanimlength( exitxanim );
        exitmovedelta = getmovedelta( exitxanim, 0, var_f75545153ec4db10[ 0 ] );
        exitmovedist = length2d( exitmovedelta );
    }
    else
    {
        exitmovedist = 0;
    }
    
    assert( startnode.wall_info.nodeoffsets.size > self.wall_run_current_node_index + 1 );
    delta = getwallnodeposition( startnode, self.wall_run_current_node_index + 1 ) - self.origin;
    desiredmovedist = length( delta );
    desiredmovedist -= exitmovedist;
    
    if ( desiredmovedist < 0 )
    {
        desiredmovedist = 0;
    }
    
    var_4ff398c3be9658a4 = desiredmovedist / animmovedist;
    animlength = getanimlength( loopxanim );
    animtimeneeded = animlength * var_4ff398c3be9658a4;
    thread senddelayedevent( asmname, statename, animtimeneeded, "wall_run_loop_done", 1 );
    desiredmovedir = vectornormalize( delta );
    self orientmode( "face direction", desiredmovedir );
    thread playwallrunendsound( statename );
    self animmode( "noclip" );
    self aisetanim( statename, loopanim );
    asm::asm_playfacialanim( asmname, statename, loopxanim );
    asm::asm_donotetracks( asmname, statename );
}

// Namespace traverse
// Params 1
// Checksum 0x581d77fd, Offset: 0x315a
// Size: 0x3c
function playwallrunendsound( statename )
{
    self endon( #"death" );
    
    if ( soundexists( "wallrun_end_npc" ) )
    {
        self waittill( #"wall_run_loop_done" );
        self playsound( "wallrun_end_npc" );
    }
}

// Namespace traverse
// Params 3
// Checksum 0x735f4689, Offset: 0x319e
// Size: 0x1d7
function choosewallrunexitanim( asmname, statename, params )
{
    alias = self.wall_run_direction;
    endpos = self getnegotiationendpos();
    zdelta = endpos[ 2 ] - self.origin[ 2 ];
    bdoublejump = 0;
    
    if ( zdelta >= 0 )
    {
        if ( zdelta > 120 )
        {
            bdoublejump = 1;
        }
    }
    else if ( 0 - zdelta > 240 )
    {
        bdoublejump = 1;
    }
    
    if ( bdoublejump == 0 )
    {
        distsq = distancesquared( self.origin, endpos );
        
        if ( distsq > 46225 )
        {
            bdoublejump = 1;
        }
    }
    
    if ( bdoublejump )
    {
        alias += "_double";
    }
    
    endpos = self getnegotiationendpos();
    startnode = self.traversal_start_node;
    assert( isdefined( startnode.wall_info.nodeoffsets[ startnode.wall_info.nodeoffsets.size - 1 ] ) );
    dir = self getnegotiationendpos() - getwallnodeposition( startnode, startnode.wall_info.nodeoffsets.size - 1 );
    dir = ( dir[ 0 ], dir[ 1 ], 0 );
    dir = vectornormalize( dir );
    desiredangles = vectortoangles( dir );
    yawdelta = angleclamp180( desiredangles[ 1 ] - self.angles[ 1 ] );
    yawdelta = abs( yawdelta );
    
    if ( yawdelta >= 22.5 )
    {
        if ( yawdelta > 67.5 )
        {
            alias += "_90";
        }
        else
        {
            alias += "_45";
        }
    }
    
    jumpanim = asm::asm_lookupanimfromalias( statename, alias );
    return jumpanim;
}

// Namespace traverse
// Params 3
// Checksum 0x92d658ab, Offset: 0x337e
// Size: 0x152
function playwallrunexit( asmname, statename, params )
{
    self endon( statename + "_finished" );
    startnode = self.traversal_start_node;
    endpos = self getnegotiationendpos();
    assert( isdefined( startnode ) );
    assert( isdefined( endpos ) );
    assert( isdefined( startnode.wall_info ) );
    desiredangles = self.angles;
    var_b469749df561f1d1 = 1;
    animname = asm::asm_getanim( asmname, statename );
    groundtime = getnotetracktimes( animname, "ground" );
    self function_ff32ea59b2119107();
    
    if ( groundtime.size > 0 )
    {
        var_b469749df561f1d1 = groundtime[ 0 ];
    }
    else
    {
        var_8175c36cc5c4c6cb = getnotetracktimes( animname, "end_double_jump" );
        
        if ( var_8175c36cc5c4c6cb.size > 0 )
        {
            var_b469749df561f1d1 = var_8175c36cc5c4c6cb[ 0 ];
        }
        else
        {
            endjumptime = getnotetracktimes( animname, "end_jump" );
            
            if ( endjumptime.size > 0 )
            {
                var_b469749df561f1d1 = endjumptime[ 0 ];
            }
        }
    }
    
    if ( soundexists( "wallrun_end_npc" ) )
    {
        self playsound( "wallrun_end_npc" );
    }
    
    playscaledjump( asmname, statename, animname, endpos, desiredangles, var_b469749df561f1d1, 1, 1 );
    thread terminatewallruntraverse( asmname, statename );
}

// Namespace traverse
// Params 4
// Checksum 0x3cb3f5b7, Offset: 0x34d8
// Size: 0xbe, Type: bool
function isnotdoingwallruntransition( asmname, statename, tostatename, params )
{
    if ( isdefined( self.traversal_start_node ) )
    {
        return false;
    }
    
    /#
        if ( getdvarint( @"ai_debugwallrun", 0 ) != 0 )
        {
            if ( self setuptraversaltransitioncheck( 120 ) )
            {
                thread draworigin();
                thread drawdebugline( self.traversal_start_node.origin, ( 0, 0, 1 ), ( 1, 0, 0 ) );
                thread debugwallrun( statename, self.traversal_start_node, self getnegotiationendpos() );
                self.traversal_start_node = undefined;
                self.wall_run_direction = undefined;
            }
        }
    #/
    
    return true;
}

// Namespace traverse
// Params 2
// Checksum 0x46751d6c, Offset: 0x359f
// Size: 0x57
function terminatewallruntraverse( asmname, statename )
{
    self.wall_run_current_node_index = undefined;
    self.wall_run_direction = undefined;
    self.wall_run_double_jumping = undefined;
    self.wall_run_yaw = undefined;
    self.wall_run_attach_anim = undefined;
    self setdefaultaimlimits();
    terminatetraverse( asmname, statename );
}

// Namespace traverse
// Params 3
// Checksum 0xc15e40d5, Offset: 0x35fe
// Size: 0x233
function playwallruntomantle( asmname, statename, params )
{
    self endon( statename + "_finished" );
    startnode = self.traversal_start_node;
    endnodepos = self getnegotiationendpos();
    assert( isdefined( startnode ) );
    assert( isdefined( endnodepos ) );
    mantleendpos = getwallrunmantleposition( startnode );
    
    if ( isdefined( startnode.wall_info.bvaultover ) || getwallruntomantletype() == "high" )
    {
        mantleangles = getwallrunmantleangles( startnode );
        
        if ( !isdefined( mantleangles ) )
        {
            delta = endnodepos - mantleendpos;
            delta = ( delta[ 0 ], delta[ 1 ], 0 );
            mantleangles = vectortoangles( delta );
        }
    }
    else
    {
        delta = mantleendpos - self.origin;
        delta = ( delta[ 0 ], delta[ 1 ], 0 );
        mantleangles = vectortoangles( delta );
    }
    
    mantleanim = asm::asm_getanim( asmname, statename );
    assert( isdefined( mantleanim ) );
    animlength = getanimlength( mantleanim );
    var_96d83300f605ab71 = getnotetracktimes( mantleanim, "start_mantle" );
    assert( var_96d83300f605ab71.size > 0 );
    var_98db0d8357fadaf6 = var_96d83300f605ab71[ 0 ];
    var_24fd49697c0a1116 = getnotetracktimes( mantleanim, "end_mantle" );
    assert( var_24fd49697c0a1116.size > 0 );
    var_2599982e8ad6f693 = var_24fd49697c0a1116[ 0 ];
    var_2f8f63555da7786f = getmovedelta( mantleanim, var_98db0d8357fadaf6, var_2599982e8ad6f693 );
    self forceteleport( self.origin, mantleangles );
    var_a4ce86bc61ef0f58 = self localtoworldcoords( var_2f8f63555da7786f );
    actualdelta = var_a4ce86bc61ef0f58 - self.origin;
    mantlestartpos = mantleendpos - actualdelta;
    
    /#
        if ( getdvarint( @"ai_debugwallrun", 0 ) != 0 )
        {
            function_aa6e36543a3f1a24( self.origin, mantlestartpos, ( 255, 0, 0 ), 100 );
        }
    #/
    
    playscaledjump( asmname, statename, mantleanim, mantlestartpos, mantleangles, var_98db0d8357fadaf6, 0, 1 );
    thread terminatewallruntraverse( asmname, statename );
}

// Namespace traverse
// Params 3
// Checksum 0x323432db, Offset: 0x3839
// Size: 0x2d8
function playtraversaltransition( asmname, statename, params )
{
    self endon( statename + "_finished" );
    animid = asm::asm_getanim( asmname, statename );
    
    if ( !isdefined( animid ) )
    {
        asm::asm_fireevent( asmname, "code_move" );
        return;
    }
    
    xanim = asm::asm_getxanim( statename, animid );
    animendtime = 1;
    notetracktimes = undefined;
    
    if ( getdvarint( @"hash_f13997d88562c7b5", 1 ) == 1 )
    {
        notetracktimes = getnotetracktimes( xanim, "align" );
    }
    
    if ( !isdefined( notetracktimes ) || notetracktimes.size == 0 )
    {
        notetracktimes = getnotetracktimes( xanim, "code_move" );
    }
    
    if ( notetracktimes.size > 0 )
    {
        animendtime = notetracktimes[ 0 ];
    }
    
    stopdelta = getmovedelta( xanim, 0, animendtime );
    stopangledelta = getangledelta( xanim, 0, animendtime );
    negotiationnode = self.traversal_start_node;
    assert( isdefined( negotiationnode ) );
    
    /#
        if ( getdvarint( @"ai_debugwallrun", 0 ) != 0 && self.traversal_start_node.animscript == "<dev string:x173>" )
        {
            thread draworigin();
            thread drawdebugline( negotiationnode.origin, ( 0, 0, 1 ), ( 1, 0, 0 ) );
            thread debugwallrun( statename, self.traversal_start_node, self getnegotiationendpos() );
        }
    #/
    
    anim_length = getanimlength( xanim ) * animendtime;
    var_4cc37e313efd7202 = int( ceil( anim_length * 20 ) );
    
    if ( self.traversal_start_node.animscript == "wall_run" )
    {
        var_80324eb4a62f1365 = getwallnodeposition( self.traversal_start_node, 0 ) - self.origin;
        var_9c35d3d8dd79b8c4 = vectortoangles( var_80324eb4a62f1365 );
        desiredyaw = var_9c35d3d8dd79b8c4[ 1 ];
    }
    else
    {
        desireddelta = self getnegotiationendpos() - self.traversal_start_node.origin;
        desireddelta = ( desireddelta[ 0 ], desireddelta[ 1 ], 0 );
        desiredangles = vectortoangles( desireddelta );
        desiredyaw = desiredangles[ 1 ];
    }
    
    stopstartpos = cover::calcanimstartpos( negotiationnode.origin, desiredyaw, stopdelta, stopangledelta );
    arrivalyaw = desiredyaw - stopangledelta;
    self.a.arrivalasmstatename = statename;
    self.useanimgoalweight = 1;
    self startcoverarrival();
    self aisetanim( statename, animid );
    asm::asm_playfacialanim( asmname, statename, xanim );
    asm::asm_donotetracks( asmname, statename, asm::asm_getnotehandler( asmname, statename ) );
}

// Namespace traverse
// Params 3
// Checksum 0xfe363069, Offset: 0x3b19
// Size: 0x120
function choosetraversaltransition( asmname, statename, params )
{
    approachdir = anglestoforward( self.angles );
    approachangles = vectortoangles( approachdir );
    
    if ( self.traversal_start_node.animscript == "wall_run" )
    {
        desiredangles = vectortoangles( getwallnodeposition( self.traversal_start_node, 0 ) - self.origin );
    }
    else
    {
        desireddelta = self getnegotiationendpos() - self.traversal_start_node.origin;
        desireddelta = ( desireddelta[ 0 ], desireddelta[ 1 ], 0 );
        desiredangles = vectortoangles( desireddelta );
    }
    
    desiredyaw = desiredangles[ 1 ];
    anglediff = angleclamp180( desiredyaw - approachangles[ 1 ] );
    angleindex = getangleindex( anglediff, 22.5 );
    stopanims = arrival::getstopanims( asmname, statename, undefined, 1 );
    
    if ( !isdefined( stopanims[ angleindex ] ) )
    {
        return;
    }
    
    return stopanims[ angleindex ];
}

// Namespace traverse
// Params 4
// Checksum 0xe68f9388, Offset: 0x3c42
// Size: 0x5d, Type: bool
function shouldabortwallrunattach( asmname, statename, tostatename, params )
{
    distsq = distance2dsquared( self.origin, getwallnodeposition( self.traversal_start_node, 1 ) );
    
    if ( distsq < 144 )
    {
        return true;
    }
    
    return false;
}

// Namespace traverse
// Params 4
// Checksum 0x40db0c60, Offset: 0x3ca8
// Size: 0x44, Type: bool
function shouldtraversetransitionto( asmname, statename, tostatename, params )
{
    if ( tostatename == self.traversal_start_node.animscript )
    {
        return true;
    }
    
    return false;
}

// Namespace traverse
// Params 1
// Checksum 0xeec4951, Offset: 0x3cf5
// Size: 0x56, Type: bool
function istraversaltransitionsupported( animscript )
{
    switch ( animscript )
    {
        case #"hash_3083e73248cdb399":
        case #"hash_5f054fa72e77b8dd":
        case #"hash_6fc6878fd3fd1e7a":
        case #"hash_8f681d217a32aef7":
        case #"hash_d14662a6eb371af5":
            return true;
    }
    
    return false;
}

// Namespace traverse
// Params 4
// Checksum 0xab164ddc, Offset: 0x3d54
// Size: 0x2f4, Type: bool
function shoulddotraversaltransition( asmname, statename, tostatename, params )
{
    if ( !isdefined( self.traversal_start_node ) )
    {
        return false;
    }
    
    if ( !istraversaltransitionsupported( self.traversal_start_node.animscript ) )
    {
        return false;
    }
    
    if ( !self.facemotion )
    {
        return false;
    }
    
    traversal_direction = undefined;
    
    if ( self.traversal_start_node.animscript == "wall_run" )
    {
        traversal_direction = getwallrundirectionfromstartnode( self.traversal_start_node );
        desireddelta = getwallnodeposition( self.traversal_start_node, 0 ) - self.origin;
        desiredangles = vectortoangles( desireddelta );
    }
    else
    {
        desireddelta = self getnegotiationendpos() - self.traversal_start_node.origin;
        desireddelta = ( desireddelta[ 0 ], desireddelta[ 1 ], 0 );
        traversal_direction = vectornormalize( desireddelta );
        desiredangles = vectortoangles( traversal_direction );
    }
    
    traversalyaw = desiredangles[ 1 ];
    approachdir = anglestoforward( self.angles );
    approachangles = vectortoangles( approachdir );
    anglediff = angleclamp180( traversalyaw - approachangles[ 1 ] );
    angleindex = getangleindex( anglediff, 22.5 );
    stopanims = arrival::getstopanims( asmname, tostatename, undefined, 1 );
    stopanim = stopanims[ angleindex ];
    
    if ( !isdefined( stopanim ) )
    {
        return false;
    }
    
    animendtime = 1;
    notetracktimes = undefined;
    
    if ( getdvarint( @"hash_f13997d88562c7b5", 1 ) == 1 )
    {
        notetracktimes = getnotetracktimes( stopanim, "align" );
    }
    
    if ( !isdefined( notetracktimes ) || notetracktimes.size == 0 )
    {
        notetracktimes = getnotetracktimes( stopanim, "code_move" );
    }
    
    if ( notetracktimes.size > 0 )
    {
        animendtime = notetracktimes[ 0 ];
    }
    
    stopdelta = getmovedelta( stopanim, 0, animendtime );
    stopangledelta = getangledelta( stopanim, 0, animendtime );
    disttonode = distance2d( self.origin, self.traversal_start_node.origin );
    animstopdist = length( stopdelta );
    delta = disttonode - animstopdist;
    
    if ( delta < 0 )
    {
        traversedir = anglestoforward( desiredangles );
        dot = vectordot( approachdir, traversedir );
        
        if ( dot > 0.707 )
        {
            if ( abs( delta ) > 10 )
            {
                return false;
            }
        }
        else if ( abs( delta ) > 64 )
        {
            return false;
        }
    }
    else if ( delta > 10 )
    {
        return false;
    }
    
    if ( self.traversal_start_node.animscript == "wall_run" )
    {
        self.wall_run_direction = traversal_direction;
    }
    
    return true;
}

// Namespace traverse
// Params 1
// Checksum 0x4efe7251, Offset: 0x4051
// Size: 0x2e
function handlewallrunattachnotetrack( note )
{
    if ( note == "wall_contact" )
    {
        if ( soundexists( "wallrun_start_npc" ) )
        {
            self playsound( "wallrun_start_npc" );
        }
    }
}

// Namespace traverse
// Params 0
// Checksum 0xe79f785e, Offset: 0x4087
// Size: 0x2e
function setupwallrunaimlimits()
{
    self.upaimlimit = -89;
    self.downaimlimit = 45;
    self.rightaimlimit = -90;
    self.leftaimlimit = 90;
}

/#

    // Namespace traverse
    // Params 3
    // Checksum 0xc7f46205, Offset: 0x40bd
    // Size: 0x8d, Type: dev
    function drawdebugline( pos, normal, color )
    {
        self notify( #"hash_1defabdfde6b7dd6" );
        level endon( #"game_ended" );
        self endon( #"death" );
        level endon( #"enddebugmode" );
        self endon( #"hash_1defabdfde6b7dd6" );
        lineend = pos + normal * 100;
        
        while ( true )
        {
            line( pos, lineend, color, 1, 1, 1 );
            wait 0.05;
        }
    }

    // Namespace traverse
    // Params 4
    // Checksum 0x5acfbea5, Offset: 0x4152
    // Size: 0x42, Type: dev
    function function_aa6e36543a3f1a24( from, to, color, duration )
    {
        if ( !isdefined( duration ) )
        {
            duration = 5;
        }
        
        line( from, to, color, 1, 1, duration );
    }

    // Namespace traverse
    // Params 0
    // Checksum 0xf6a78ba3, Offset: 0x419c
    // Size: 0xb2, Type: dev
    function draworigin()
    {
        self notify( #"hash_672446f622edb735" );
        level endon( #"game_ended" );
        self endon( #"death" );
        level endon( #"enddebugmode" );
        self endon( #"hash_672446f622edb735" );
        color = ( 0, 0, 1 );
        normal = ( 0, 0, 1 );
        
        while ( true )
        {
            pos = self.origin;
            lineend = pos + normal * 100;
            line( pos, lineend, color, 1, 1, 1 );
            wait 0.05;
        }
    }

    // Namespace traverse
    // Params 3
    // Checksum 0xccb3653b, Offset: 0x4256
    // Size: 0x135, Type: dev
    function debugwallrun( statename, startnode, endpos )
    {
        color1 = ( 0, 1, 0 );
        color2 = ( 0, 0, 1 );
        color = color1;
        line( startnode.origin, getwallnodeposition( startnode, 0 ), color, 1, 1, 300 );
        currentpos = startnode.origin;
        
        for ( i = 0; i < startnode.wall_info.nodeoffsets.size - 1 ; i++ )
        {
            if ( i % 2 == 0 )
            {
                color = color2;
            }
            else
            {
                color = color1;
            }
            
            currentpos = getwallnodeposition( startnode, i );
            line( currentpos, getwallnodeposition( startnode, i + 1 ), color, 1, 1, 300 );
            currentpos = getwallnodeposition( startnode, i + 1 );
            
            if ( i % 2 == 0 )
            {
                color = color1;
                continue;
            }
            
            color = color2;
        }
        
        line( currentpos, endpos, color, 1, 1, 300 );
    }

#/

// Namespace traverse
// Params 3
// Checksum 0xea74d911, Offset: 0x4393
// Size: 0x432
function playtraverseanim_ladder( asmname, statename, params )
{
    self endon( statename + "_finished" );
    self aisetisonladder( 1 );
    startnode = self getnegotiationstartnode();
    endpos = self getnegotiationendpos();
    
    if ( isdefined( startnode ) && !isdefined( startnode.traverse_height ) )
    {
        asm::function_83faa08e56039deb( startnode );
    }
    
    assert( isdefined( startnode ) );
    self animmode( "noclip" );
    self orientmode( "face angle", startnode.targetangles[ 1 ] );
    starttoend = endpos - startnode.origin;
    demeanor = asm::asm_getdemeanor();
    climbanim = undefined;
    mountanim = undefined;
    dismountanim = undefined;
    dropdownanim = 0;
    
    if ( starttoend[ 2 ] > 0 )
    {
        offalias = "off_" + demeanor;
        dismountanim = asm::asm_lookupanimfromaliasifexists( statename, offalias );
        
        if ( !isdefined( dismountanim ) )
        {
            if ( !isdefined( startnode.traverse_drop_height_delta ) || startnode.traverse_drop_height_delta < 6 )
            {
                dismountanim = asm::asm_lookupanimfromalias( statename, "off" );
            }
            else if ( startnode.traverse_drop_height_delta < 36 )
            {
                dismountanim = asm::asm_lookupanimfromalias( statename, "off_low" );
                dropdownanim = 1;
            }
            else if ( startnode.traverse_drop_height_delta < 60 )
            {
                dismountanim = asm::asm_lookupanimfromalias( statename, "off_mid" );
                dropdownanim = 1;
            }
            else
            {
                dismountanim = asm::asm_lookupanimfromalias( statename, "off_high" );
                dropdownanim = 1;
            }
        }
        
        climbanim = asm::asm_lookupanimfromalias( statename, "up" );
    }
    else
    {
        onalias = "on_" + demeanor;
        dismountanim = asm::asm_lookupanimfromaliasifexists( statename, onalias );
        
        if ( !isdefined( dismountanim ) )
        {
            mountanim = asm::asm_lookupanimfromalias( statename, "on" );
        }
        
        climbanim = asm::asm_lookupanimfromalias( statename, "down" );
    }
    
    rate = 1;
    
    if ( isdefined( self.moveplaybackrate ) )
    {
        rate = self.moveplaybackrate;
    }
    
    if ( isdefined( mountanim ) )
    {
        self aisetanim( statename, mountanim, rate );
        asm::asm_donotetracks( asmname, statename );
    }
    
    loopendpos = endpos;
    
    if ( isdefined( dismountanim ) )
    {
        dismountxanim = asm::asm_getxanim( statename, dismountanim );
        dismounttranslation = getmovedelta( dismountxanim );
        
        if ( dropdownanim )
        {
            loopendpos = startnode.traverse_height - ( 0, 0, 48 );
        }
        else
        {
            loopendpos = endpos - dismounttranslation + ( 0, 0, 1 );
        }
    }
    
    assert( isdefined( climbanim ) );
    var_603ea32134dba9bc = loopendpos - self.origin;
    
    if ( var_603ea32134dba9bc[ 2 ] * starttoend[ 2 ] > 0 )
    {
        climbxanim = asm::asm_getxanim( statename, climbanim );
        climbanimtranslation = getmovedelta( climbxanim );
        var_aca3f7c7fe6e9cc3 = climbanimtranslation[ 2 ] * rate / getanimlength( climbxanim );
        climbtime = var_603ea32134dba9bc[ 2 ] / var_aca3f7c7fe6e9cc3;
        assert( climbtime > 0 );
        
        if ( !( isdefined( climbxanim ) && isdefined( climbanimtranslation ) && isdefined( var_aca3f7c7fe6e9cc3 ) && isdefined( climbtime ) ) )
        {
            arcname = utility::function_18bf04f16702b9b2();
            basearcname = self.basearchetype;
            println( "<dev string:x17c>" + climbanim + "<dev string:x1a0>" + arcname + "<dev string:x1b1>" + statename + "<dev string:x1bc>" + basearcname + "<dev string:x1dc>" );
        }
        
        self aisetanim( statename, climbanim, rate );
        asm::asm_donotetracksfortime( asmname, statename, climbtime );
    }
    
    if ( isdefined( dismountanim ) )
    {
        self aisetanim( statename, dismountanim, rate );
        waitframe();
        notetrackhandle = &handletraversewarpnotetracks;
        self.traversestartnode = startnode;
        self.traverseendnode = self getnegotiationendnode();
        self.var_b5ddf4fb051b5e5 = endpos;
        self.traversexanim = asm::asm_getxanim( statename, dismountanim );
        asm::asm_donotetracks( asmname, statename, notetrackhandle );
        self.var_b5ddf4fb051b5e5 = undefined;
    }
    
    terminatetraverse( asmname, statename );
}

// Namespace traverse
// Params 3
// Checksum 0x73f3ef7d, Offset: 0x47cd
// Size: 0x5b
function terminate_ladder( asmname, statename, params )
{
    bisdead = !isalive( self );
    self.nogravityragdoll = bisdead;
    self aisetisonladder( 0 );
    self.var_b5ddf4fb051b5e5 = undefined;
    
    if ( bisdead )
    {
        self.forceragdollimmediate = 0;
    }
}

// Namespace traverse
// Params 3
// Checksum 0x70d4b9c3, Offset: 0x4830
// Size: 0x97
function traverse_basic( asmname, statename, params )
{
    self endon( statename + "_finished" );
    traverseanim = asm::asm_getanim( asmname, statename );
    self animmode( "noclip" );
    startnode = self getnegotiationstartnode();
    self orientmode( "face angle", startnode.angles[ 1 ] );
    self aisetanim( statename, traverseanim );
    asm::asm_donotetracks( asmname, statename, asm::asm_getnotehandler( asmname, statename ) );
    terminatetraverse( asmname, statename );
}

