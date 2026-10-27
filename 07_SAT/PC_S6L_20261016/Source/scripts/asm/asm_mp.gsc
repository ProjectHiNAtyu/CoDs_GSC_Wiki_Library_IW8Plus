// scripts\asm\asm_mp.gsc  (hash_547b73ef8f00503b.gscc) (size: 5015 Bytes / 0x1397 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x73a45d4b (1940151627)
// size ...... 5015 (0x1397)
// includes .. 7   (offset: 0x128f)
// strings ... 13  (offset: 0x12c7)
// dev strs .. 3   (offset: 0x1373)
// exports ... 17  (offset: 0x9c3)
// cseg ...... 0x128 + 0x89b (0x9c3)
// imports ... 54  (offset: 0xc6b)
// animtree1 . 0   (offset: 0x1397)
// animtree2 . 0   (offset: 0x1397)
#using scripts\anim\notetracks_mp;
#using scripts\anim\shared;
#using scripts\asm\asm;
#using scripts\asm\asm_bb;
#using scripts\asm\shared\utility;
#using scripts\common\scriptable_door;
#using scripts\common\utility;

#namespace asm_mp;

// Namespace asm_mp
// Params 2
// Checksum 0x384cb43c, Offset: 0x146
// Size: 0x13f
function asm_init( baseasmname, archetypename )
{
    self.asmname = baseasmname;
    first_init = 0;
    
    if ( !isdefined( self.asm ) )
    {
        first_init = 1;
        self.asm = spawnstruct();
        self.asm.animoverrides = [];
    }
    
    if ( isdefined( archetypename ) )
    {
        if ( !first_init )
        {
            self setanimset( archetypename );
        }
    }
    
    self.fnasm_init = &asm_init;
    self.fnasm_setorientmode = &asm_settransitionorientmode_transition;
    self.fnasm_handlenotetrack = &notetracks_mp::handlenotetrack;
    self.fnasm_playadditiveanimloopstate = &asm_playadditiveanimloopstate_mp;
    self.fnasm_playfacialanim = &asm_playfacialanim_mp;
    self.fnplaceweaponon = &shared::placeweaponon;
    self.fndooropen = &scriptable_door::scriptabledoor_open;
    self.fndoorclose = &scriptable_door::scriptabledoor_close;
    self.fndoorneedstoclose = &asm::function_85622bf0cacb63d6;
    self.fngetdoorcenter = &asm::function_a4a0d4a33b623013;
    self.fndooralreadyopen = &scriptable_door::function_ebc4f081a7104b46;
    self.var_56ec7a82956dbf18 = &function_b6181cc2f48930a0;
    self settryopendoor( &utility::tryopendoor );
    hack_setup_a_struct();
    asm::asm_init_common( self.asmname );
}

// Namespace asm_mp
// Params 2
// Checksum 0xcdc92634, Offset: 0x28d
// Size: 0x1c
function function_b6181cc2f48930a0( pos, radius )
{
    return function_6cf720856f2ecd74( pos, radius );
}

// Namespace asm_mp
// Params 0
// Checksum 0xd5cbac5b, Offset: 0x2b2
// Size: 0xe7
function hack_setup_a_struct()
{
    if ( isdefined( self.a ) )
    {
        return;
    }
    
    self.a = spawnstruct();
    self.currentpose = "stand";
    self.a.movement = "stop";
    self.a.lastenemytime = gettime();
    self.allowlongdeath = 1;
    self.a.paintime = 0;
    self.a.lastshoottime = 0;
    self.reacttobulletchance = 0.8;
    self.misstime = 0;
    self.a.nodeath = 0;
    self.misstimedebounce = 0;
    self.a.disablepain = 0;
    self.laserenabled = 0;
}

// Namespace asm_mp
// Params 0
// Checksum 0x6173a5b, Offset: 0x3a1
// Size: 0x2c
function function_f7a8bcd86dc6ead3()
{
    level.fnanimatedprop_setup = &animatedprop_setup;
    level.fnanimatedprop_startanim = &animatedprop_setanim;
    level.fnanimatedprop_setanim = &animatedprop_setanim;
}

// Namespace asm_mp
// Params 4
// Checksum 0x85fb1ef2, Offset: 0x3d5
// Size: 0x91
function animatedprop_setup( modelname, var, origin, angles )
{
    assert( isdefined( level.scr_model ) );
    assert( isdefined( level.scr_model[ modelname ] ) );
    prop = spawn( "script_model", origin );
    prop.angles = angles;
    prop setmodel( level.scr_model[ modelname ] );
    self.animated_prop = prop;
}

// Namespace asm_mp
// Params 2
// Checksum 0x520cc75d, Offset: 0x46e
// Size: 0x66
function animatedprop_setanim( propname, param )
{
    assert( isdefined( self.animated_prop ) );
    assert( isdefined( level.scr_anim[ propname ] ) );
    propanim = level.scr_anim[ propname ][ param ];
    self.animated_prop scriptmodelplayanimdeltamotion( propanim );
}

// Namespace asm_mp
// Params 4
// Checksum 0x4f4c03d9, Offset: 0x4dc
// Size: 0x39
function asm_handlenotetracks( note, animstate, animindex, animtime )
{
    asm::asm_fireevent( self.asmname, note );
}

/#

    // Namespace asm_mp
    // Params 2
    // Checksum 0xc7cc31af, Offset: 0x51d
    // Size: 0x2b, Type: dev
    function asm_shoulddeathtransition( asmname, currentstate )
    {
        assertmsg( "<dev string:x24>" + asmname + "<dev string:x37>" );
    }

#/

// Namespace asm_mp
// Params 1
// Checksum 0x27bae5a5, Offset: 0x550
// Size: 0x125
function asm_settransitionorientmode_transition( orient_mode )
{
    switch ( orient_mode )
    {
        case #"hash_96a6a25bd7beed30":
            var_bea7fb00cbc6d91e = 1024;
            
            if ( utility::actor_is3d() )
            {
                orient_angles = self.angles;
                
                if ( isdefined( self.node ) && distancesquared( self.origin, self.node.origin ) < var_bea7fb00cbc6d91e )
                {
                    orient_angles = self function_dabf98356d840a64( self.node );
                }
                
                self orientmode( "face angle 3d", orient_angles );
            }
            else
            {
                yaw = self.angles[ 1 ];
                
                if ( isdefined( self.node ) && distancesquared( self.origin, self.node.origin ) < var_bea7fb00cbc6d91e )
                {
                    yaw = utility::getnodeforwardyaw( self.node );
                }
                
                self orientmode( "face angle", yaw );
            }
            
            break;
        default:
            self orientmode( orient_mode );
            break;
    }
}

// Namespace asm_mp
// Params 1
// Checksum 0x7d2fa20a, Offset: 0x67d
// Size: 0x165
function asm_settransitionorientmode_legacy( orient_mode )
{
    switch ( orient_mode )
    {
        case #"hash_a6238b3102248f7f":
            pathgoal = self.pathgoalpos;
            
            if ( isdefined( pathgoal ) )
            {
                delta = pathgoal - self.origin;
                dir = vectornormalize( delta );
                face_angles = vectortoangles( dir );
                self orientmode( "face angle", face_angles[ 1 ] );
                break;
            }
        case #"hash_579a1f64b8b40d31":
            self orientmode( "face current" );
            break;
        case #"hash_87fdfc09c0f3853e":
        case #"hash_f51882822bb936c8":
            self orientmode( orient_mode );
            break;
        case #"hash_96a6a25bd7beed30":
            yaw = self.angles[ 1 ];
            var_bea7fb00cbc6d91e = 1024;
            
            if ( isdefined( self.node ) && distancesquared( self.origin, self.node.origin ) < var_bea7fb00cbc6d91e )
            {
                yaw = utility::getnodeforwardyaw( self.node );
            }
            
            self orientmode( "face angle", yaw );
            break;
        default:
            assert( 0, "<dev string:x67>" );
            break;
    }
}

// Namespace asm_mp
// Params 3
// Checksum 0xfc050988, Offset: 0x7ea
// Size: 0x27
function asm_getanimindex( asmname, statename, params )
{
    return self asmgetanim( asmname, statename, params );
}

// Namespace asm_mp
// Params 3
// Checksum 0x1e53a103, Offset: 0x81a
// Size: 0x1e
function asm_playadditiveanimloopstate_mp( asmname, statename, params )
{
    
}

// Namespace asm_mp
// Params 1
// Checksum 0xd3b70731, Offset: 0x840
// Size: 0x23
function asm_animhasfacialoverridemp( a_anim )
{
    if ( !animisleaf( a_anim ) )
    {
        return 0;
    }
    
    return animhasnotetrack( a_anim, "facial_override" );
}

// Namespace asm_mp
// Params 3
// Checksum 0xd1710a73, Offset: 0x86c
// Size: 0x54
function asm_playfacialanim_mp( asmname, statename, animname )
{
    if ( archetypehasstate( asmname, statename ) )
    {
        animid = animname;
        
        if ( isstring( animname ) )
        {
            animid = asm::asm_lookupanimfromaliasifexists( statename, animname );
        }
        
        self setfacialindexfromasm( asmname, statename, animid );
    }
}

// Namespace asm_mp
// Params 2
// Checksum 0xd42037b8, Offset: 0x8c8
// Size: 0xa7
function asm_playfacialaniminternalmp( a_anim, a_state )
{
    if ( !utility::isfacialstateallowed( "asm" ) )
    {
        return;
    }
    
    if ( isdefined( a_anim ) && asm_animhasfacialoverridemp( a_anim ) )
    {
        return;
    }
    
    headknob = asm::asm_lookupanimfromaliasifexists( "knobs", "head" );
    
    if ( !isdefined( headknob ) )
    {
        return;
    }
    
    if ( !isdefined( self.asm.facial_state ) )
    {
        self.asm.facial_state = "";
    }
    
    utility::setfacialstate( "asm" );
    
    if ( isai( self ) )
    {
        self setfacialindex( a_state );
    }
}

// Namespace asm_mp
// Params 0
// Checksum 0xf09109f, Offset: 0x977
// Size: 0x4c
function asm_setanimscripted()
{
    self animmode( "noclip" );
    self orientmode( "face angle", self.angles[ 1 ] );
    asm::asm_clearfacialanim();
    asm_bb::bb_setanimscripted();
    self asmsetstate( self.asmname, "animscripted" );
    self scriptedanimstarted();
}

