// scripts\anim\notetracks_mp.gsc  (hash_4f57e90811aa8900.gscc) (size: 3130 Bytes / 0xc3a / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xdbfa777f (3690624895)
// size ...... 3130 (0xc3a)
// includes .. 4   (offset: 0xb16)
// strings ... 18  (offset: 0xb36)
// dev strs .. 3   (offset: 0xc16)
// exports ... 12  (offset: 0x622)
// cseg ...... 0x156 + 0x4cc (0x622)
// imports ... 27  (offset: 0x802)
// animtree1 . 0   (offset: 0xc3a)
// animtree2 . 0   (offset: 0xc3a)
#using scripts\anim\notetracks;
#using scripts\anim\utility_common;
#using scripts\asm\asm_bb;
#using scripts\common\debug;

#namespace notetracks_mp;

// Namespace notetracks_mp
// Params 0
// Checksum 0xf7e4503c, Offset: 0x174
// Size: 0x21
function registernotetracksifnot()
{
    if ( isdefined( anim.notetracks ) )
    {
        return;
    }
    
    anim.notetracks = [];
    registernotetracks();
}

// Namespace notetracks_mp
// Params 0
// Checksum 0xd78484a1, Offset: 0x19d
// Size: 0xa3
function registernotetracks()
{
    level._defaultnotetrackhandler = &handlenotetrack;
    level.fnnotetrackprefixhandler = &notetrack_prefix_handler_cp_mp;
    notetracks::registernotetracks();
    anim.notetracks[ "anim_pose = stand" ] = &notetrackposestand;
    anim.notetracks[ "anim_pose = crouch" ] = &notetrackposecrouch;
    anim.notetracks[ "anim_pose = prone" ] = &notetrackposeprone;
    anim.notetracks[ "anim_pose = crawl" ] = &notetrackposecrawl;
    anim.notetracks[ "gun drop" ] = &notetrackgundrop;
    anim.notetracks[ "dropgun" ] = &notetrackgundrop;
}

// Namespace notetracks_mp
// Params 4
// Checksum 0x540df2be, Offset: 0x248
// Size: 0xc8
function handlenotetrack( note, flagname, customfunction, customparams )
{
    if ( notetracks::hascustomnotetrackhandler( note ) )
    {
        return notetracks::handlecustomnotetrackhandler( note, flagname, customfunction, customparams );
    }
    
    retval = notetracks::handlecommonnotetrack( note, flagname, customfunction, customparams );
    
    if ( retval == "__unhandled" )
    {
        retval = undefined;
        
        switch ( note )
        {
            case #"hash_88cce8d6571fe7e1":
                if ( weaponclass( self.weapon ) == "rocketlauncher" )
                {
                    notetrackrocketlauncherammoattach();
                }
                
                break;
            default:
                if ( isdefined( customfunction ) )
                {
                    if ( isdefined( customparams ) )
                    {
                        return [[ customfunction ]]( note, customparams );
                    }
                    else
                    {
                        return [[ customfunction ]]( note );
                    }
                }
                
                break;
        }
    }
    
    return retval;
}

// Namespace notetracks_mp
// Params 1
// Checksum 0x34323015, Offset: 0x319
// Size: 0x155
function notetrack_prefix_handler_cp_mp( notetrack )
{
    prefix = getsubstr( notetrack, 0, 3 );
    
    if ( prefix == "as_" )
    {
        alias = getsubstr( notetrack, 3 );
        
        if ( isdefined( self.anim_playsound_func ) )
        {
            self thread [[ self.anim_playsound_func ]]( alias );
        }
        
        return 1;
    }
    
    if ( prefix == "vm_" )
    {
        animation = getsubstr( notetrack, 3 );
        
        if ( isdefined( self.anim_playvm_func ) )
        {
            self thread [[ self.anim_playvm_func ]]( animation );
        }
        
        return 1;
    }
    
    if ( prefix == "ws_" )
    {
        state = getsubstr( notetrack, 3 );
        
        if ( isdefined( self.weapon_state_func ) )
        {
            self thread [[ self.weapon_state_func ]]( state );
        }
        
        return 1;
    }
    
    if ( prefix == "cm_" )
    {
        cmtype = getsubstr( notetrack, 3 );
        
        if ( isdefined( self.cinematic_motion_override ) )
        {
            self thread [[ self.cinematic_motion_override ]]( cmtype );
        }
        
        return 1;
    }
    
    if ( prefix == "df_" )
    {
        doftype = getsubstr( notetrack, 3 );
        
        if ( isdefined( self.dof_func ) )
        {
            self thread [[ self.dof_func ]]( doftype );
        }
        
        return 1;
    }
    
    return notetracks::notetrack_prefix_handler_common( notetrack );
}

// Namespace notetracks_mp
// Params 0
// Checksum 0x1afff089, Offset: 0x477
// Size: 0x39
function notetrackrocketlauncherammoattach()
{
    assert( isdefined( self ) );
    
    if ( !isalive( self ) )
    {
        return;
    }
    
    if ( !utility_common::usingrocketlauncher() )
    {
        return;
    }
    
    if ( self tagexists( "tag_rocket" ) )
    {
        self showpart( "tag_rocket" );
    }
}

// Namespace notetracks_mp
// Params 2
// Checksum 0x3f4c2a4e, Offset: 0x4b8
// Size: 0x5d
function notetrackgundrop( note, flagname )
{
    if ( !isai( self ) )
    {
        println( "<dev string:x24>" + debug::function_4496bef4cfc0d07( self ) + "<dev string:x36>" + note + "<dev string:x49>" );
        return;
    }
    
    if ( isdefined( self.fndropweapon ) )
    {
        self [[ self.fndropweapon ]]();
    }
}

// Namespace notetracks_mp
// Params 1
// Checksum 0x59ffd9b0, Offset: 0x51d
// Size: 0x2b
function setpose( pose )
{
    self.currentpose = pose;
    asm_bb::bb_requeststance( pose );
    self notify( "entered_pose" + pose );
}

// Namespace notetracks_mp
// Params 2
// Checksum 0x6d068f95, Offset: 0x550
// Size: 0x3c
function notetrackposestand( note, flagname )
{
    if ( isdefined( self.notetrackposestandfunc ) )
    {
        self [[ self.notetrackposestandfunc ]]();
        return;
    }
    
    setpose( "stand" );
}

// Namespace notetracks_mp
// Params 2
// Checksum 0xe91aba0c, Offset: 0x594
// Size: 0x21
function notetrackposecrouch( note, flagname )
{
    setpose( "crouch" );
}

// Namespace notetracks_mp
// Params 2
// Checksum 0x6d068f89, Offset: 0x5bd
// Size: 0x21
function notetrackposeprone( note, flagname )
{
    setpose( "prone" );
}

// Namespace notetracks_mp
// Params 2
// Checksum 0xa2045e71, Offset: 0x5e6
// Size: 0x3c
function notetrackposecrawl( note, flagname )
{
    if ( isdefined( self.notetrackposecrawlfunc ) )
    {
        self [[ self.notetrackposecrawlfunc ]]();
        return;
    }
    
    setpose( "prone" );
}

