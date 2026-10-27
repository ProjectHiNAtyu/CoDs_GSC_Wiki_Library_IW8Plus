// scripts\anim\notetracks.gsc  (hash_357b9a54dfedbd4a.gscc) (size: 30845 Bytes / 0x787d / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xe76d94fb (3882718459)
// size ...... 30845 (0x787d)
// includes .. 6   (offset: 0x6efd)
// strings ... 139 (offset: 0x6f2d)
// dev strs .. 32  (offset: 0x7695)
// exports ... 85  (offset: 0x48b9)
// cseg ...... 0x9c6 + 0x3ef3 (0x48b9)
// imports ... 194 (offset: 0x5601)
// animtree1 . 0   (offset: 0x787d)
// animtree2 . 0   (offset: 0x787d)
#using scripts\anim\utility_common;
#using scripts\anim\weaponlist;
#using scripts\asm\shared\utility;
#using scripts\common\debug;
#using scripts\common\notetrack;
#using scripts\common\utility;

#namespace notetracks;

/#

    // Namespace notetracks
    // Params 1
    // Checksum 0xee9d1620, Offset: 0x9e4
    // Size: 0x1b0, Type: dev
    function shownotetrack( note )
    {
        if ( !isdefined( self ) || getdvarint( @"hash_a19781010239d2e6" ) != 1 && getdvarint( @"hash_a19781010239d2e6" ) != self getentitynumber() )
        {
            return;
        }
        
        self endon( #"death" );
        anim.shownotetrackspeed = 30;
        anim.shownotetrackduration = 20;
        duration = anim.shownotetrackduration + int( 20 / anim.shownotetrackspeed );
        color = ( 0.5, 0.75, 1 );
        
        if ( note == "<dev string:x24>" || note == "<dev string:x28>" )
        {
            color = ( 0.25, 0.4, 0.5 );
        }
        else if ( note == "<dev string:x2f>" )
        {
            color = ( 1, 0.5, 0.5 );
        }
        
        for ( i = 0; i < duration ; i++ )
        {
            if ( duration - i <= anim.shownotetrackduration )
            {
                amnt = 1 * ( i - duration - anim.shownotetrackduration ) / anim.shownotetrackduration;
            }
            else
            {
                amnt = 0;
            }
            
            time = 1 * i / 20;
            alpha = 1 - amnt * amnt;
            
            if ( isai( self ) )
            {
                pos = self geteye() + ( 0, 0, 20 + anim.shownotetrackspeed * time );
            }
            else
            {
                pos = self.origin;
            }
            
            print3d( pos, note, color, alpha, 0.5 );
            waitframe();
        }
    }

#/

// Namespace notetracks
// Params 0
// Checksum 0x10f4e11d, Offset: 0xb9c
// Size: 0x516
function registernotetracks()
{
    thread function_8d66def2db6aadea();
    anim.notetracks[ "anim_movement = \"stop\"" ] = &notetrackmovementstop;
    anim.notetracks[ "anim_movement = \"walk\"" ] = &notetrackmovementwalk;
    anim.notetracks[ "anim_movement = \"run\"" ] = &notetrackmovementrun;
    anim.notetracks[ "anim_movement = stop" ] = &notetrackmovementstop;
    anim.notetracks[ "anim_movement = walk" ] = &notetrackmovementwalk;
    anim.notetracks[ "anim_movement = run" ] = &notetrackmovementrun;
    anim.notetracks[ "anim_movement_gun_pose_override = run_gun_down" ] = &notetrackmovementgunposeoverride;
    anim.notetracks[ "anim_coverpose = cover_left" ] = &notetrackcoverposerequest;
    anim.notetracks[ "anim_coverpose = cover_right" ] = &notetrackcoverposerequest;
    anim.notetracks[ "anim_coverpose = cover_crouch" ] = &notetrackcoverposerequest;
    anim.notetracks[ "anim_coverpose = cover_stand" ] = &notetrackcoverposerequest;
    anim.notetracks[ "anim_coverpose = cover_left_crouch" ] = &notetrackcoverposerequest;
    anim.notetracks[ "anim_coverpose = cover_right_crouch" ] = &notetrackcoverposerequest;
    anim.notetracks[ "anim_coverpose = exposed" ] = &notetrackcoverposerequest;
    anim.notetracks[ "anim_coverpose = exposed_crouch" ] = &notetrackcoverposerequest;
    anim.notetracks[ "anim_coverpose = prone" ] = &notetrackcoverposerequest;
    anim.notetracks[ "anim_aiming = 1" ] = &notetrackalertnessaiming;
    anim.notetracks[ "anim_aiming = 0" ] = &notetrackalertnessalert;
    anim.notetracks[ "anim_alertness = causal" ] = &notetrackalertnesscasual;
    anim.notetracks[ "anim_alertness = alert" ] = &notetrackalertnessalert;
    anim.notetracks[ "anim_alertness = aiming" ] = &notetrackalertnessaiming;
    anim.notetracks[ "gravity on" ] = &notetrackgravity;
    anim.notetracks[ "gravity off" ] = &notetrackgravity;
    anim.notetracks[ "bodyfall large" ] = &notetrackbodyfall;
    anim.notetracks[ "bodyfall small" ] = &notetrackbodyfall;
    anim.notetracks[ "code_move" ] = &notetrackcodemove;
    anim.notetracks[ "face_enemy" ] = &notetrackfaceenemy;
    anim.notetracks[ "pistol_rechamber" ] = &notetrackpistolrechamber;
    anim.notetracks[ "load_shell" ] = &notetrackloadshell;
    anim.notetracks[ "fire_if_loaded" ] = &function_2e97e17b2cc19283;
    anim.notetracks[ "fire" ] = &notetrackfire;
    anim.notetracks[ "fire_spray" ] = &notetrackfirespray;
    anim.notetracks[ "gun_2_chest" ] = &notetrackguntochest;
    anim.notetracks[ "gun_2_back" ] = &notetrackguntoback;
    anim.notetracks[ "gun_2_right" ] = &notetrackguntoright;
    anim.notetracks[ "gun_2_hand" ] = &function_4c4b60b6d26e6b8d;
    anim.notetracks[ "secondary_pickup" ] = &function_ce774dc44fc1dd11;
    anim.notetracks[ "secondary_putaway" ] = &function_380f7059bea9f4a0;
    anim.notetracks[ "pistol_pickup" ] = &notetrackpistolpickup;
    anim.notetracks[ "pistol_putaway" ] = &notetrackpistolputaway;
    anim.notetracks[ "refill ammo" ] = &notetrackrefillclip;
    anim.notetracks[ "refill clip" ] = &notetrackrefillclip;
    anim.notetracks[ "reload done" ] = &notetrackrefillclip;
    anim.notetracks[ "ht_on" ] = &notetrackhton0;
    anim.notetracks[ "ht_on_0" ] = &notetrackhton0;
    anim.notetracks[ "ht_on_1" ] = &notetrackhton1;
    anim.notetracks[ "ht_off" ] = &notetrackhtoff;
    anim.notetracks[ "hp_on" ] = &function_a0b102acdae4fcea;
    anim.notetracks[ "hp_on_pos" ] = &function_66322e480aecee00;
    anim.notetracks[ "hp_off" ] = &function_4a227e256571435c;
    anim.notetracks[ "notify" ] = &notetracknotify;
    anim.notetracks[ "viewunlinkmodel" ] = &function_b164d5c10b8930f4;
    anim.notetracks[ "charge_abort" ] = &function_61c434cdbeeb63b5;
    anim.notetracks[ "melee_swipe" ] = &function_1d5758f4056c4b5b;
    
    if ( isdefined( level._notetrackfx ) )
    {
        keys = getarraykeys( level._notetrackfx );
        
        foreach ( key in keys )
        {
            anim.notetracks[ key ] = &customnotetrackfx;
        }
    }
}

// Namespace notetracks
// Params 2
// Checksum 0xf4259135, Offset: 0x10ba
// Size: 0x15
function notetrackstopanim( note, flagname )
{
    
}

// Namespace notetracks
// Params 2
// Checksum 0xc9f0874a, Offset: 0x10d7
// Size: 0xdf
function notetrackcoverposerequest( note, flagname )
{
    assert( issubstr( note, "<dev string:x39>" ) );
    coverpose = strtok( note, " = " )[ 1 ];
    
    switch ( coverpose )
    {
        case #"hash_175771022bc5e75d":
        case #"hash_4ddb655e251e06c8":
        case #"hash_9d76c99eddd14433":
        case #"hash_c475427a998ee26c":
        case #"hash_d165cddb82d41e6a":
        case #"hash_d44cb989edc40ab3":
        case #"hash_d91940431ed7c605":
        case #"hash_e7aface284179b3b":
        case #"hash_f1676baca0ae608b":
            self.coverposerequest = coverpose;
            break;
        default:
            assertmsg( "<dev string:x4b>" );
            break;
    }
}

// Namespace notetracks
// Params 2
// Checksum 0x6fc4e162, Offset: 0x11be
// Size: 0x2e
function notetrackmovementstop( note, flagname )
{
    self.a.movement = "stop";
}

// Namespace notetracks
// Params 2
// Checksum 0x6fc4e162, Offset: 0x11f4
// Size: 0x2e
function notetrackmovementwalk( note, flagname )
{
    self.a.movement = "walk";
}

// Namespace notetracks
// Params 2
// Checksum 0xfde8547e, Offset: 0x122a
// Size: 0x2e
function notetrackmovementrun( note, flagname )
{
    self.a.movement = "run";
}

// Namespace notetracks
// Params 2
// Checksum 0x102d0585, Offset: 0x1260
// Size: 0x2e
function notetrackmovementgunposeoverride( note, flagname )
{
    self.asm.movementgunposeoverride = "run_gun_down";
}

// Namespace notetracks
// Params 2
// Checksum 0x109007c5, Offset: 0x1296
// Size: 0x15
function notetrackalertnessaiming( note, flagname )
{
    
}

// Namespace notetracks
// Params 2
// Checksum 0xd89852f0, Offset: 0x12b3
// Size: 0x15
function notetrackalertnesscasual( note, flagname )
{
    
}

// Namespace notetracks
// Params 2
// Checksum 0xbbd072d8, Offset: 0x12d0
// Size: 0x15
function notetrackalertnessalert( note, flagname )
{
    
}

/#

    // Namespace notetracks
    // Params 2
    // Checksum 0xc6203f08, Offset: 0x12ed
    // Size: 0x6f, Type: dev
    function function_890184f0f7e2ce45( note, flagname )
    {
        setdvarifuninitialized( @"hash_d54f2997c58912ce", "<dev string:x6b>" );
        
        if ( getdvarint( @"hash_d54f2997c58912ce" ) < 1 )
        {
            return;
        }
        
        if ( !isdefined( flagname ) )
        {
            flagname = "<dev string:x6d>";
        }
        
        if ( issubstr( note, "<dev string:x6f>" ) )
        {
            println( "<dev string:x71>" + note + "<dev string:xa1>" + flagname );
        }
    }

#/

// Namespace notetracks
// Params 2
// Checksum 0x41266ca8, Offset: 0x1364
// Size: 0x15
function notetrackloadshell( note, flagname )
{
    
}

// Namespace notetracks
// Params 2
// Checksum 0x1ea2a6dd, Offset: 0x1381
// Size: 0x15
function notetrackpistolrechamber( note, flagname )
{
    
}

// Namespace notetracks
// Params 2
// Checksum 0xed420ad5, Offset: 0x139e
// Size: 0x4a
function notetrackgravity( note, flagname )
{
    if ( issubstr( note, "on" ) )
    {
        self animmode( "gravity" );
        return;
    }
    
    if ( issubstr( note, "off" ) )
    {
        self animmode( "nogravity" );
    }
}

// Namespace notetracks
// Params 2
// Checksum 0xe0a7165b, Offset: 0x13f0
// Size: 0x147
function customnotetrackfx( note, flagname )
{
    assert( isdefined( level._notetrackfx[ note ] ) );
    
    if ( isdefined( self.groundtype ) )
    {
        groundtype = self.groundtype;
    }
    else
    {
        groundtype = "dirt";
    }
    
    struct = undefined;
    
    if ( isdefined( level._notetrackfx[ note ][ groundtype ] ) )
    {
        struct = level._notetrackfx[ note ][ groundtype ];
    }
    else if ( isdefined( level._notetrackfx[ note ][ "all" ] ) )
    {
        struct = level._notetrackfx[ note ][ "all" ];
    }
    
    if ( !isdefined( struct ) )
    {
        return;
    }
    
    if ( isai( self ) && isdefined( struct.fx ) )
    {
        playfxontag( struct.fx, self, struct.tag );
    }
    
    if ( !isdefined( struct.sound_prefix ) && !isdefined( struct.sound_suffix ) )
    {
        return;
    }
    
    alias = string( struct.sound_prefix ) + groundtype + struct.sound_suffix;
    
    if ( soundexists( alias ) )
    {
        self playsound( alias );
    }
}

// Namespace notetracks
// Params 2
// Checksum 0x7ec08ed7, Offset: 0x153f
// Size: 0x1a
function notetrackcodemove( note, flagname )
{
    return "code_move";
}

// Namespace notetracks
// Params 2
// Checksum 0xa2a2ea29, Offset: 0x1562
// Size: 0x20
function notetrackfaceenemy( note, flagname )
{
    self orientmode( "face enemy" );
}

// Namespace notetracks
// Params 2
// Checksum 0x4a1503, Offset: 0x158a
// Size: 0x8d
function notetrackbodyfall( note, flagname )
{
    suffix = "_small";
    
    if ( issubstr( note, "large" ) )
    {
        suffix = "_large";
    }
    
    if ( isdefined( self.groundtype ) )
    {
        groundtype = self.groundtype;
    }
    else
    {
        groundtype = "dirt";
    }
    
    if ( suffix == "_large" )
    {
        self playsurfacesound( "bodyfall_torso", groundtype );
        return;
    }
    
    self playsurfacesound( "bodyfall_limb_small", groundtype );
}

// Namespace notetracks
// Params 3
// Checksum 0x401d4a31, Offset: 0x161f
// Size: 0xe5
function donotetracks( flagname, customfunction, debugidentifier )
{
    for ( ;; )
    {
        self waittill( flagname, notes );
        
        if ( !isdefined( notes ) )
        {
            notes = [ "undefined" ];
        }
        
        if ( !isarray( notes ) )
        {
            notes = [ notes ];
        }
        
        notetrack::validatenotetracks( flagname, notes );
        
        foreach ( note in notes )
        {
            var_7237854e3be197ca = handlenotetrack( note, flagname, customfunction );
            
            if ( isdefined( var_7237854e3be197ca ) )
            {
                return var_7237854e3be197ca;
            }
        }
    }
}

// Namespace notetracks
// Params 4
// Checksum 0x5eaf358c, Offset: 0x170c
// Size: 0x7e
function handlenotetrack( note, flagname, customfunction, customparams )
{
    if ( isdefined( self.fnasm_handlenotetrack ) )
    {
        return [[ self.fnasm_handlenotetrack ]]( note, flagname, customfunction, customparams );
    }
    
    if ( isdefined( level._defaultnotetrackhandler ) )
    {
        return [[ level._defaultnotetrackhandler ]]( note, flagname, customfunction, customparams );
    }
    
    assertmsg( "<dev string:xa9>" + self getentitynumber() );
}

// Namespace notetracks
// Params 1
// Checksum 0xcece8360, Offset: 0x1792
// Size: 0x3e, Type: bool
function hascustomnotetrackhandler( note )
{
    notetrackfunc = anim.notetracks[ note ];
    
    if ( isdefined( notetrackfunc ) )
    {
        return true;
    }
    
    if ( isdefined( self.customnotetrackhandler ) )
    {
        return true;
    }
    
    return false;
}

// Namespace notetracks
// Params 4
// Checksum 0x689fe3e4, Offset: 0x17d9
// Size: 0xa4
function handlecustomnotetrackhandler( note, flagname, customfunction, customparams )
{
    assert( hascustomnotetrackhandler( note ) );
    notetrackfunc = anim.notetracks[ note ];
    
    /#
        function_890184f0f7e2ce45( note, flagname );
    #/
    
    if ( isdefined( notetrackfunc ) )
    {
        return [[ notetrackfunc ]]( note, flagname );
    }
    
    if ( isdefined( self.customnotetrackhandler ) )
    {
        if ( isdefined( customparams ) )
        {
            return [[ self.customnotetrackhandler ]]( note, flagname, customfunction, customparams );
        }
        
        return [[ self.customnotetrackhandler ]]( note, flagname, customfunction );
    }
}

// Namespace notetracks
// Params 4
// Checksum 0xfb981397, Offset: 0x1885
// Size: 0x283
function handlecommonnotetrack( note, flagname, customfunction, customparams )
{
    /#
        thread shownotetrack( note );
    #/
    
    switch ( note )
    {
        case #"hash_b61583709daf623":
        case #"hash_247cc07ab83949f2":
        case #"hash_2a91eda16e3944d1":
        case #"hash_ed49946bfff8e78a":
            return note;
        case #"hash_1962676868099dfd":
            if ( isdefined( self.enemy ) )
            {
                return note;
            }
            
            break;
        case #"hash_49af0c46b8bd5fb2":
            thread utility::play_sound_in_space( "melee_swing_small", self gettagorigin( "TAG_WEAPON_RIGHT" ) );
            break;
        case #"hash_466ca7b853d8962e":
            thread utility::play_sound_in_space( "melee_swing_large", self gettagorigin( "TAG_WEAPON_RIGHT" ) );
            break;
        case #"hash_e01205bce6c9351c":
            self.a.nodeath = 1;
            break;
        case #"hash_96585dbff62202c2":
            self.allowpain = 0;
            break;
        case #"hash_fc9342b5a91869ea":
            self.allowpain = 1;
            break;
        case #"hash_39305061b0d59e1e":
        case #"hash_83ed1371a36bf0b6":
            self.a.meleestate = "right";
            break;
        case #"hash_d97e6d5be66b4c5":
        case #"hash_31521d11dde26e47":
            self.a.meleestate = "left";
            break;
        case #"hash_7701f1d5cbc5085d":
            if ( isdefined( self.hatmodel ) )
            {
                if ( isdefined( self.helmetsidemodel ) )
                {
                    self detach( self.helmetsidemodel, "TAG_HELMETSIDE" );
                    self.helmetsidemodel = undefined;
                }
                
                self detach( self.hatmodel, "" );
                self attach( self.hatmodel, "TAG_WEAPON_LEFT" );
                self.hatmodel = undefined;
            }
            
            break;
        case #"hash_6f55d0ff4f5a774":
            level notify( #"glass_break", self );
            break;
        case #"hash_275f5641f230746b":
            level notify( #"glass_break", self );
            break;
        case #"hash_ff2ad0514dabb22b":
            if ( !self.fixednode )
            {
                self animmode( "physics_drift" );
            }
            
            break;
        default:
            return "__unhandled";
    }
}

// Namespace notetracks
// Params 3
// Checksum 0x5aa2a956, Offset: 0x1b10
// Size: 0x106
function donotetracksintercept( flagname, interceptfunction, debugidentifier )
{
    assert( isdefined( interceptfunction ) );
    
    for ( ;; )
    {
        self waittill( flagname, notes );
        
        if ( !isdefined( notes ) )
        {
            notes = [ "undefined" ];
        }
        
        if ( !isarray( notes ) )
        {
            notes = [ notes ];
        }
        
        notetrack::validatenotetracks( flagname, notes );
        intercepted = [[ interceptfunction ]]( notes );
        
        if ( intercepted )
        {
            continue;
        }
        
        foreach ( note in notes )
        {
            var_7237854e3be197ca = handlenotetrack( note, flagname );
            
            if ( isdefined( var_7237854e3be197ca ) )
            {
                return var_7237854e3be197ca;
            }
        }
    }
}

// Namespace notetracks
// Params 2
// Checksum 0xc1663710, Offset: 0x1c1e
// Size: 0x110
function donotetrackspostcallback( flagname, postfunction )
{
    assert( isdefined( postfunction ) );
    
    for ( ;; )
    {
        self waittill( flagname, notes );
        
        if ( !isdefined( notes ) )
        {
            notes = [ "undefined" ];
        }
        
        if ( !isarray( notes ) )
        {
            notes = [ notes ];
        }
        
        notetrack::validatenotetracks( flagname, notes );
        defined_val = undefined;
        
        foreach ( note in notes )
        {
            val = handlenotetrack( note, flagname );
            
            if ( isdefined( val ) )
            {
                defined_val = val;
                break;
            }
        }
        
        [[ postfunction ]]( notes );
        var_7237854e3be197ca = defined_val;
        
        if ( isdefined( var_7237854e3be197ca ) )
        {
            return var_7237854e3be197ca;
        }
    }
}

// Namespace notetracks
// Params 4
// Checksum 0x5089fa24, Offset: 0x1d36
// Size: 0x32
function donotetracksfortimeout( flagname, killstring, customfunction, debugidentifier )
{
    donotetracks( flagname, customfunction, debugidentifier );
}

// Namespace notetracks
// Params 4
// Checksum 0x44ec460e, Offset: 0x1d70
// Size: 0x39
function donotetracksforever( flagname, killstring, customfunction, debugidentifier )
{
    donotetracksforeverproc( &donotetracks, flagname, killstring, customfunction, debugidentifier );
}

// Namespace notetracks
// Params 4
// Checksum 0xb75799a8, Offset: 0x1db1
// Size: 0x39
function donotetracksforeverintercept( flagname, killstring, interceptfunction, debugidentifier )
{
    donotetracksforeverproc( &donotetracksintercept, flagname, killstring, interceptfunction, debugidentifier );
}

// Namespace notetracks
// Params 5
// Checksum 0x2d9f1cd5, Offset: 0x1df2
// Size: 0xee
function donotetracksforeverproc( notetracksfunc, flagname, killstring, customfunction, debugidentifier )
{
    if ( isdefined( killstring ) )
    {
        self endon( killstring );
    }
    
    self endon( #"killanimscript" );
    
    if ( !isdefined( debugidentifier ) )
    {
        debugidentifier = "undefined";
    }
    
    for ( ;; )
    {
        time = gettime();
        returnednote = [[ notetracksfunc ]]( flagname, customfunction, debugidentifier );
        timetaken = gettime() - time;
        
        if ( timetaken < 0.05 )
        {
            time = gettime();
            returnednote = [[ notetracksfunc ]]( flagname, customfunction, debugidentifier );
            timetaken = gettime() - time;
            
            if ( timetaken < 0.05 )
            {
                println( gettime() + "<dev string:xc8>" + debugidentifier + "<dev string:xca>" + flagname + "<dev string:x123>" + returnednote + "<dev string:x12f>" );
                wait 0.05 - timetaken;
            }
        }
    }
}

// Namespace notetracks
// Params 4
// Checksum 0xb616fa31, Offset: 0x1ee8
// Size: 0x53
function donotetrackswithtimeout( flagname, time, customfunction, debugidentifier )
{
    ent = spawnstruct();
    ent thread donotetracksfortimeendnotify( time );
    donotetracksfortimeproc( &donotetracksfortimeout, flagname, customfunction, debugidentifier, ent );
}

// Namespace notetracks
// Params 4
// Checksum 0x5ebed6b7, Offset: 0x1f43
// Size: 0x53
function donotetracksfortime( time, flagname, customfunction, debugidentifier )
{
    ent = spawnstruct();
    ent thread donotetracksfortimeendnotify( time );
    donotetracksfortimeproc( &donotetracksforever, flagname, customfunction, debugidentifier, ent );
}

// Namespace notetracks
// Params 4
// Checksum 0x4154d189, Offset: 0x1f9e
// Size: 0x53
function donotetracksfortimeintercept( time, flagname, interceptfunction, debugidentifier )
{
    ent = spawnstruct();
    ent thread donotetracksfortimeendnotify( time );
    donotetracksfortimeproc( &donotetracksforeverintercept, flagname, interceptfunction, debugidentifier, ent );
}

// Namespace notetracks
// Params 5
// Checksum 0x128891c0, Offset: 0x1ff9
// Size: 0x47
function donotetracksfortimeproc( donotetracksforeverfunc, flagname, customfunction, debugidentifier, ent )
{
    ent endon( #"stop_notetracks" );
    [[ donotetracksforeverfunc ]]( flagname, undefined, customfunction, debugidentifier );
}

// Namespace notetracks
// Params 1
// Checksum 0x1ee5ecb2, Offset: 0x2048
// Size: 0x1b
function donotetracksfortimeendnotify( time )
{
    wait time;
    self notify( #"stop_notetracks" );
}

// Namespace notetracks
// Params 1
// Checksum 0x212935f6, Offset: 0x206b
// Size: 0x2b
function notetrack_prefix_handler( notetrack )
{
    assert( isdefined( level.fnnotetrackprefixhandler ) );
    return [[ level.fnnotetrackprefixhandler ]]( notetrack );
}

// Namespace notetracks
// Params 2
// Checksum 0x860c86e6, Offset: 0x209f
// Size: 0x1e
function function_98ec98c1d61cf08e( guy, notetrack )
{
    function_781f681362634fd0( notetrack );
}

// Namespace notetracks
// Params 0
// Checksum 0x48842ac3, Offset: 0x20c5
// Size: 0x98
function function_69b9e02867aa85e5()
{
    if ( utility::ismp() )
    {
        linked_children = self getlinkedchildren();
        
        foreach ( ent in linked_children )
        {
            if ( isplayer( ent ) )
            {
                return ent;
            }
        }
    }
    
    return level.player;
}

// Namespace notetracks
// Params 1
// Checksum 0xad63d848, Offset: 0x2166
// Size: 0xb60
function notetrack_prefix_handler_common( notetrack )
{
    prefix3 = getsubstr( notetrack, 0, 3 );
    
    if ( prefix3 == "sm_" )
    {
        model = cleanup_string( getsubstr( notetrack, 3 ) );
        self setmodel( model );
    }
    else if ( prefix3 == "fb_" )
    {
        player = function_69b9e02867aa85e5();
        assert( isdefined( player ), "<dev string:x131>" + notetrack );
        fade_data = strtok( notetrack, "_" );
        fade_action = tolower( fade_data[ 1 ] );
        var_adc62138933601b1 = undefined;
        var_ae42b04fcf01a851 = undefined;
        var_60db31b83c84d1a6 = undefined;
        
        if ( fade_action == "to" )
        {
            var_adc62138933601b1 = float( fade_data[ 2 ] );
        }
        else if ( fade_action == "from" )
        {
            var_60db31b83c84d1a6 = float( fade_data[ 2 ] );
        }
        else if ( fade_action == "tofrom" )
        {
            var_adc62138933601b1 = float( fade_data[ 2 ] );
            var_ae42b04fcf01a851 = float( fade_data[ 3 ] );
            var_60db31b83c84d1a6 = float( fade_data[ 4 ] );
        }
        
        player thread function_9e31ae7a5e7d20c( var_adc62138933601b1, var_ae42b04fcf01a851, var_60db31b83c84d1a6 );
        return 1;
    }
    else if ( prefix3 == "rm_" )
    {
        player = function_69b9e02867aa85e5();
        assert( isdefined( player ), "<dev string:x131>" + notetrack );
        rumble = getsubstr( notetrack, 3 );
        player playrumbleonentity( rumble );
        return 1;
    }
    else if ( prefix3 == "at_" )
    {
        attachto = self.player ?? self;
        attachto function_9e6002c6e61dadeb( getsubstr( notetrack, 3 ) );
        return 1;
    }
    else if ( prefix3 == "dt_" )
    {
        params = getsubstr( notetrack, 3 );
        detachfrom = self.player ?? self;
        
        if ( params == "all" )
        {
            detachfrom function_97c6caa36e65db54();
        }
        else
        {
            detachfrom function_dd7954588a5da1f5( params );
        }
        
        return 1;
    }
    else if ( prefix3 == "ds_" )
    {
        function_801167dc009f7115( getsubstr( notetrack, 3 ) );
        return 1;
    }
    else if ( prefix3 == "as_" )
    {
        function_5359be77d2818b1f( getsubstr( notetrack, 3 ) );
        return 1;
    }
    else if ( prefix3 == "fs_" )
    {
        utility::flag_set( getsubstr( notetrack, 3 ) );
        return 1;
    }
    else if ( prefix3 == "fc_" )
    {
        utility::flag_clear( getsubstr( notetrack, 3 ) );
        return 1;
    }
    
    prefix4 = getsubstr( notetrack, 0, 4 );
    
    if ( prefix4 == "fsf_" )
    {
        player = function_69b9e02867aa85e5();
        assert( isdefined( player ), "<dev string:x131>" + notetrack );
        var_2f1f1185367b7c67 = strtok( notetrack, "_" );
        var_703f67c7438f27b4 = float( var_2f1f1185367b7c67[ 1 ] );
        var_30a7cf22a24b9d82 = float( var_2f1f1185367b7c67[ 2 ] );
        player lerpfovscalefactor( var_703f67c7438f27b4, var_30a7cf22a24b9d82 );
        return 1;
    }
    else if ( prefix4 == "rms_" )
    {
        rumble = function_b166dea5984e5210( notetrack, prefix4 );
        
        if ( rumble == "all" )
        {
            stopallrumbles();
        }
        else
        {
            player = function_69b9e02867aa85e5();
            assert( isdefined( player ), "<dev string:x131>" + notetrack );
            player stoprumble( rumble );
        }
        
        return 1;
    }
    else if ( prefix4 == "rml_" )
    {
        player = function_69b9e02867aa85e5();
        assert( isdefined( player ), "<dev string:x131>" + notetrack );
        rumble = function_b166dea5984e5210( notetrack, prefix4 );
        player playrumblelooponentity( rumble );
        return 1;
    }
    else if ( prefix4 == "fov_" )
    {
        player = function_69b9e02867aa85e5();
        assert( isdefined( player ), "<dev string:x131>" + notetrack );
        
        if ( !isdefined( player ) )
        {
            return 1;
        }
        
        fov_data = strtok( notetrack, "_" );
        fov_action = tolower( fov_data[ 1 ] );
        fov_value = undefined;
        fov_time = undefined;
        var_eb59ff215af085f5 = undefined;
        var_57832f999646903c = undefined;
        ease_param_offset = undefined;
        
        if ( fov_action == "start" )
        {
            fov_value = float( fov_data[ 2 ] );
            
            if ( isdefined( fov_data[ 3 ] ) )
            {
                fov_time = float( fov_data[ 3 ] );
            }
            
            ease_param_offset = 4;
        }
        else
        {
            fov_value = 65;
            
            if ( isdefined( fov_data[ 2 ] ) )
            {
                fov_time = float( fov_data[ 2 ] );
            }
            
            ease_param_offset = 3;
        }
        
        var_784d2d90701325ab = fov_data[ ease_param_offset ];
        
        if ( isdefined( var_784d2d90701325ab ) )
        {
            if ( var_784d2d90701325ab == "easein" )
            {
                var_eb59ff215af085f5 = float( fov_data[ ease_param_offset + 1 ] );
                var_b7a4141e8c9b33aa = fov_data[ ease_param_offset + 2 ];
                
                if ( var_b7a4141e8c9b33aa == "easeout" )
                {
                    var_57832f999646903c = float( fov_data[ ease_param_offset + 3 ] );
                }
            }
            else if ( var_784d2d90701325ab == "easeout" )
            {
                var_57832f999646903c = float( fov_data[ ease_param_offset + 1 ] );
            }
        }
        
        player modifybasefov( fov_value, fov_time, var_eb59ff215af085f5, var_57832f999646903c );
        return 1;
    }
    else if ( prefix4 == "dof_" )
    {
        player = function_69b9e02867aa85e5();
        assert( isdefined( player ), "<dev string:x131>" + notetrack );
        dof_tokens = strtok( notetrack, "," );
        dof_action = tolower( dof_tokens[ 0 ] );
        
        if ( dof_action == "dof_auto" )
        {
            if ( !isdefined( dof_tokens[ 1 ] ) )
            {
                assertmsg( "<dev string:x151>" + notetrack + "<dev string:x15f>" + debug::function_4496bef4cfc0d07( self ) + "<dev string:x165>" );
                return;
            }
            
            fstop = float( dof_tokens[ 1 ] );
            var_c84557dfdf0580a2 = function_270aa7df372b1353( dof_tokens[ 2 ] );
            var_22561e8ea277ff8c = function_270aa7df372b1353( dof_tokens[ 3 ] );
            player utility::dof_enable_autofocus( fstop, undefined, var_c84557dfdf0580a2, var_22561e8ea277ff8c );
        }
        else if ( dof_action == "dof_ent" || dof_action == "dof_ent1" )
        {
            if ( !isdefined( dof_tokens[ 1 ] ) )
            {
                assertmsg( "<dev string:x151>" + notetrack + "<dev string:x15f>" + debug::function_4496bef4cfc0d07( self ) + "<dev string:x165>" );
                return;
            }
            
            fstop = float( dof_tokens[ 1 ] );
            var_c84557dfdf0580a2 = function_270aa7df372b1353( dof_tokens[ 2 ] );
            var_22561e8ea277ff8c = function_270aa7df372b1353( dof_tokens[ 3 ] );
            override_bone = undefined;
            
            if ( isdefined( dof_tokens[ 4 ] ) )
            {
                override_bone = cleanup_string( dof_tokens[ 4 ] );
                
                if ( isdefined( override_bone ) && !self tagexists( override_bone ) )
                {
                    assertmsg( "<dev string:x151>" + notetrack + "<dev string:x15f>" + debug::function_4496bef4cfc0d07( self ) + "<dev string:x18b>" );
                    return;
                }
            }
            
            var_6f739fb4e85e04bd = function_47aa4a1ab3a51c3c( dof_tokens[ 5 ] );
            focus_ent = self;
            
            if ( dof_action == "dof_ent" )
            {
                player utility::dof_enable_autofocus( fstop, focus_ent, var_c84557dfdf0580a2, var_22561e8ea277ff8c, undefined, override_bone, undefined, var_6f739fb4e85e04bd, 1 );
            }
            else
            {
                focus_distance = distance( player geteye(), focus_ent.origin );
                player utility::dof_enable( fstop, focus_distance, undefined, var_c84557dfdf0580a2, var_22561e8ea277ff8c, undefined, override_bone );
            }
        }
        else if ( dof_action == "dof_distance" || dof_action == "dof_distance1" )
        {
            if ( !isdefined( dof_tokens[ 1 ] ) )
            {
                assertmsg( "<dev string:x151>" + notetrack + "<dev string:x15f>" + debug::function_4496bef4cfc0d07( self ) + "<dev string:x1d9>" );
                return;
            }
            
            focus_distance = float( dof_tokens[ 1 ] );
            
            if ( !isdefined( dof_tokens[ 2 ] ) )
            {
                assertmsg( "<dev string:x151>" + notetrack + "<dev string:x15f>" + debug::function_4496bef4cfc0d07( self ) + "<dev string:x165>" );
                return;
            }
            
            fstop = float( dof_tokens[ 2 ] );
            var_c84557dfdf0580a2 = function_270aa7df372b1353( dof_tokens[ 3 ] );
            var_22561e8ea277ff8c = function_270aa7df372b1353( dof_tokens[ 4 ] );
            
            if ( dof_action == "dof_distance" )
            {
                player utility::dof_enable_autofocus( fstop, undefined, var_c84557dfdf0580a2, var_22561e8ea277ff8c, undefined, focus_distance, undefined, 1 );
            }
            else
            {
                player utility::dof_enable( fstop, focus_distance, undefined, var_c84557dfdf0580a2, var_22561e8ea277ff8c );
            }
        }
        else if ( dof_action == "dof_pos" || dof_action == "dof_pos1" )
        {
            focus_pos = function_c85976dbfa005f70( dof_tokens[ 1 ], dof_tokens[ 2 ], dof_tokens[ 3 ] );
            
            if ( !isdefined( focus_pos ) )
            {
                assertmsg( "<dev string:x208>" + notetrack + "<dev string:x15f>" + debug::function_4496bef4cfc0d07( self ) + "<dev string:x214>" );
                return;
            }
            
            if ( !isdefined( dof_tokens[ 4 ] ) )
            {
                assertmsg( "<dev string:x151>" + notetrack + "<dev string:x15f>" + debug::function_4496bef4cfc0d07( self ) + "<dev string:x165>" );
                return;
            }
            
            fstop = float( dof_tokens[ 4 ] );
            var_c84557dfdf0580a2 = function_270aa7df372b1353( dof_tokens[ 5 ] );
            var_22561e8ea277ff8c = function_270aa7df372b1353( dof_tokens[ 6 ] );
            
            if ( dof_action == "dof_pos" )
            {
                player utility::dof_enable_autofocus( fstop, undefined, var_c84557dfdf0580a2, var_22561e8ea277ff8c, undefined, focus_pos, undefined, 1 );
            }
            else
            {
                focus_distance = distance( player geteye(), focus_pos );
                player utility::dof_enable( fstop, focus_distance, undefined, var_c84557dfdf0580a2, var_22561e8ea277ff8c, focus_pos );
            }
        }
        else if ( dof_action == "dof_stop" )
        {
            player utility::dof_disable_autofocus();
        }
        else
        {
            assertmsg( "<dev string:x151>" + notetrack + "<dev string:x287>" + debug::function_4496bef4cfc0d07( self ) + "<dev string:x28e>" );
        }
        
        return 1;
    }
    else if ( prefix4 == "bar_" )
    {
        split = strtok( notetrack, "_" );
        
        if ( split.size < 2 || split.size > 4 )
        {
            assertmsg( "<dev string:x31a>" + notetrack + "<dev string:x326>" );
            return 1;
        }
        
        player = self.player ?? self;
        
        switch ( split[ 1 ] )
        {
            case #"hash_7ebb454a971d80d":
                hidecinematicletterboxing( float( split[ 2 ] ?? 0 ), float( split[ 3 ] ?? 0 ), player );
                break;
            case #"hash_ca51c18a00a0a89c":
                showcinematicletterboxing( float( split[ 2 ] ?? 0 ), float( split[ 3 ] ?? 0 ), player );
                break;
            default:
                assertmsg( "<dev string:x31a>" + notetrack + "<dev string:x344>" );
                break;
        }
        
        return 1;
    }
    
    if ( isstartstr( notetrack, "linkmodel" ) )
    {
        params = getsubstr( notetrack, 10 );
        function_370e3c53376acf8a( params );
        return 1;
    }
    else if ( isstartstr( notetrack, "unlinkmodel" ) )
    {
        params = getsubstr( notetrack, 12 );
        
        if ( params == "all" )
        {
            function_2c2fa803a0d2b3a4();
        }
        else
        {
            function_6392e37a20403625( params );
        }
        
        return 1;
    }
    else if ( isstartstr( notetrack, "hide" ) )
    {
        params = getsubstr( notetrack, 5 );
        hide_part_data = strtok( params, "," );
        tag = hide_part_data[ 0 ];
        
        if ( isdefined( tag ) )
        {
            if ( utility::issp() )
            {
                if ( isdefined( hide_part_data[ 1 ] ) )
                {
                    self hidepart( tag, hide_part_data[ 1 ] );
                }
                else
                {
                    self hidepart( tag );
                }
            }
        }
        else
        {
            self hide();
        }
        
        return 1;
    }
    else if ( isstartstr( notetrack, "show" ) )
    {
        params = getsubstr( notetrack, 5 );
        hide_part_data = strtok( params, "," );
        tag = hide_part_data[ 0 ];
        
        if ( isdefined( tag ) )
        {
            if ( utility::issp() )
            {
                params = getsubstr( notetrack, 5 );
                var_c0613d27d49a66ca = strtok( params, "," );
                
                if ( isdefined( var_c0613d27d49a66ca[ 1 ] ) )
                {
                    self showpart( tag, var_c0613d27d49a66ca[ 1 ] );
                }
                else
                {
                    self showpart( tag );
                }
            }
        }
        else
        {
            self show();
        }
        
        return 1;
    }
    
    return 0;
}

// Namespace notetracks
// Params 0
// Checksum 0xab97cdee, Offset: 0x2ccf
// Size: 0x96
function shootnotetrack()
{
    waittillframeend();
    
    if ( isalive( self ) && gettime() > self._blackboard.shootparams_lastshoottime )
    {
        if ( self._blackboard.shootparams_valid )
        {
            var_3194eba7c1afe666 = self._blackboard.shootparams_shotsperburst == 1;
        }
        else
        {
            var_3194eba7c1afe666 = 1;
        }
        
        utility_common::shootenemywrapper( var_3194eba7c1afe666 );
        utility::decrementbulletsinclip();
        
        if ( weaponclass( self.weapon ) == "rocketlauncher" )
        {
            self.rocketammo--;
        }
    }
}

// Namespace notetracks
// Params 2
// Checksum 0x6487aee1, Offset: 0x2d6d
// Size: 0x2b
function function_2e97e17b2cc19283( note, flagname )
{
    if ( self.bulletsinclip )
    {
        notetrackfire( note, flagname );
    }
}

// Namespace notetracks
// Params 2
// Checksum 0xbf0f2c33, Offset: 0x2da0
// Size: 0xad
function notetrackfire( note, flagname )
{
    if ( self.weapon && ( self.weapon.classname == "fist" || self.weapon.classname == "none" ) )
    {
        return;
    }
    
    if ( self.var_fb3e3c7ffba25a13 )
    {
        return;
    }
    
    if ( isdefined( self.script ) && isdefined( anim.fire_notetrack_functions[ self.script ] ) )
    {
        thread [[ anim.fire_notetrack_functions[ self.script ] ]]();
        return;
    }
    
    thread shootnotetrack();
}

// Namespace notetracks
// Params 2
// Checksum 0x53bc0b6e, Offset: 0x2e55
// Size: 0x237
function notetrackfirespray( note, flagname )
{
    if ( self.weapon && ( self.weapon.classname == "fist" || self.weapon.classname == "none" ) )
    {
        return;
    }
    
    if ( self.var_fb3e3c7ffba25a13 )
    {
        return;
    }
    
    if ( !isalive( self ) && self isbadguy() )
    {
        if ( isdefined( self.changed_team ) )
        {
            return;
        }
        
        self.changed_team = 1;
        teams[ "axis" ] = "team3";
        teams[ "team3" ] = "axis";
        assert( isdefined( teams[ self.team ] ), "<dev string:x35d>" + self.team );
        self.team = teams[ self.team ];
    }
    
    if ( !issentient( self ) )
    {
        self notify( #"fire" );
        return;
    }
    
    if ( isundefinedweapon( self.a.weaponpos[ "right" ] ) )
    {
        return;
    }
    
    weaporig = self getmuzzlepos();
    dir = anglestoforward( self getmuzzleangle() );
    ang = 10;
    
    if ( isdefined( self.isrambo ) )
    {
        ang = 20;
    }
    
    hitenemy = 0;
    
    if ( isalive( self.enemy ) && issentient( self.enemy ) && self canshootenemy() )
    {
        enemydir = vectornormalize( self.enemy geteye() - weaporig );
        
        if ( vectordot( dir, enemydir ) > cos( ang ) )
        {
            hitenemy = 1;
        }
    }
    
    if ( hitenemy )
    {
        utility_common::shootenemywrapper();
    }
    else
    {
        dir += ( ( randomfloat( 2 ) - 1 ) * 0.1, ( randomfloat( 2 ) - 1 ) * 0.1, ( randomfloat( 2 ) - 1 ) * 0.1 );
        pos = weaporig + dir * 1000;
        self [[ anim.shootposwrapper_func ]]( pos );
    }
    
    utility::decrementbulletsinclip();
}

// Namespace notetracks
// Params 2
// Checksum 0x5a798655, Offset: 0x3094
// Size: 0x1c
function notetrackrefillclip( note, flagname )
{
    weaponlist::refillclip();
}

// Namespace notetracks
// Params 3
// Checksum 0x8a1c50e0, Offset: 0x30b8
// Size: 0x4f
function notetracknotify( note, flagname, customparams )
{
    player = level.players[ customparams[ 0 ] ];
    
    if ( customparams.size == 3 && isdefined( player ) )
    {
        player notify( customparams[ 2 ] );
    }
}

// Namespace notetracks
// Params 3
// Checksum 0x901ffbc4, Offset: 0x310f
// Size: 0x7c
function function_b164d5c10b8930f4( note, flagname, customparams )
{
    if ( customparams.size == 3 )
    {
        params = strtok( customparams[ 2 ], "," );
        
        if ( params.size >= 1 )
        {
            entitytargetname = params[ 0 ];
            var_b880bacfb5a2268b = getent( entitytargetname, #targetname );
            
            if ( isdefined( var_b880bacfb5a2268b ) )
            {
                var_b880bacfb5a2268b delete();
            }
        }
    }
}

// Namespace notetracks
// Params 0
// Checksum 0x55d0e337, Offset: 0x3193
// Size: 0x6a
function getpreferredweapon()
{
    if ( self._blackboard.weaponrequest == weaponclass( self.primaryweapon ) )
    {
        return self.primaryweapon;
    }
    else if ( self._blackboard.weaponrequest == weaponclass( self.secondaryweapon ) )
    {
        return self.secondaryweapon;
    }
    
    return self.primaryweapon;
}

// Namespace notetracks
// Params 2
// Checksum 0xbea9745b, Offset: 0x3206
// Size: 0x3d
function notetrackguntochest( note, flagname )
{
    if ( isdefined( self.fnplaceweaponon ) )
    {
        self [[ self.fnplaceweaponon ]]( self.weapon, "chest" );
    }
}

// Namespace notetracks
// Params 2
// Checksum 0xe75fbd75, Offset: 0x324b
// Size: 0x62
function notetrackguntoback( note, flagname )
{
    if ( isdefined( self.fnplaceweaponon ) )
    {
        self [[ self.fnplaceweaponon ]]( self.weapon, "back" );
    }
    
    self.weapon = getpreferredweapon();
    self.bulletsinclip = weaponclipsize( self.weapon );
}

// Namespace notetracks
// Params 2
// Checksum 0x9e7f2541, Offset: 0x32b5
// Size: 0x10d
function notetrackpistolpickup( note, flagname )
{
    pistolposition = "right";
    
    if ( !isdefined( self.sidearm ) || isnullweapon( self.sidearm ) || self.weapon == self.sidearm && isdefined( self.a.weaponpos[ pistolposition ] ) && self.a.weaponpos[ pistolposition ] == self.weapon )
    {
        return;
    }
    
    if ( isdefined( self.fnplaceweaponon ) )
    {
        self [[ self.fnplaceweaponon ]]( self.sidearm, pistolposition );
    }
    
    if ( isdefined( self.stowsidearmposition ) )
    {
        self.a.weaponpos[ self.stowsidearmposition ] = undefined;
    }
    
    self.bulletsinclip = weaponclipsize( self.weapon );
    self notify( #"weapon_switch_done" );
}

// Namespace notetracks
// Params 2
// Checksum 0x4f21d012, Offset: 0x33ca
// Size: 0x91
function notetrackpistolputaway( note, flagname )
{
    if ( isdefined( self.fnplaceweaponon ) )
    {
        if ( isdefined( self.stowsidearmposition ) )
        {
            self [[ self.fnplaceweaponon ]]( self.sidearm, self.stowsidearmposition );
        }
        else
        {
            self [[ self.fnplaceweaponon ]]( self.sidearm, "none" );
        }
    }
    
    self.weapon = getpreferredweapon();
    self.bulletsinclip = weaponclipsize( self.weapon );
}

// Namespace notetracks
// Params 2
// Checksum 0xd2d13a0c, Offset: 0x3463
// Size: 0xf5
function function_ce774dc44fc1dd11( note, flagname )
{
    pistolposition = "right";
    assert( isdefined( self.secondaryweapon ) );
    
    if ( !isdefined( self.secondaryweapon ) || isnullweapon( self.secondaryweapon ) || self.weapon == self.secondaryweapon && isdefined( self.a.weaponpos[ pistolposition ] ) && self.a.weaponpos[ pistolposition ] == self.secondaryweapon )
    {
        return;
    }
    
    if ( isdefined( self.fnplaceweaponon ) )
    {
        self [[ self.fnplaceweaponon ]]( self.secondaryweapon, pistolposition );
    }
    
    self.bulletsinclip = weaponclipsize( self.weapon );
    self notify( #"weapon_switch_done" );
}

// Namespace notetracks
// Params 2
// Checksum 0xe882565e, Offset: 0x3560
// Size: 0x91
function function_380f7059bea9f4a0( note, flagname )
{
    if ( isdefined( self.fnplaceweaponon ) )
    {
        if ( isdefined( self.var_8963cb25470d8d58 ) )
        {
            self [[ self.fnplaceweaponon ]]( self.secondaryweapon, self.var_8963cb25470d8d58 );
        }
        else
        {
            self [[ self.fnplaceweaponon ]]( self.secondaryweapon, "none" );
        }
    }
    
    self.weapon = getpreferredweapon();
    self.bulletsinclip = weaponclipsize( self.weapon );
}

// Namespace notetracks
// Params 2
// Checksum 0x9089fef1, Offset: 0x35f9
// Size: 0x53
function notetrackguntoright( note, flagname )
{
    if ( isdefined( self.fnplaceweaponon ) )
    {
        self [[ self.fnplaceweaponon ]]( self.weapon, "right" );
    }
    
    self.bulletsinclip = weaponclipsize( self.weapon );
}

// Namespace notetracks
// Params 2
// Checksum 0xda3396ca, Offset: 0x3654
// Size: 0x53
function function_4c4b60b6d26e6b8d( note, flagname )
{
    if ( isdefined( self.fnplaceweaponon ) )
    {
        self [[ self.fnplaceweaponon ]]( self.weapon, "inhand" );
    }
    
    self.bulletsinclip = weaponclipsize( self.weapon );
}

// Namespace notetracks
// Params 2
// Checksum 0xe6bbbe86, Offset: 0x36af
// Size: 0x1f
function notetrackhton0( note, flagname )
{
    if ( !isai( self ) )
    {
        return;
    }
}

// Namespace notetracks
// Params 2
// Checksum 0x91bc8e10, Offset: 0x36d6
// Size: 0x1f
function notetrackhton1( note, flagname )
{
    if ( !isai( self ) )
    {
        return;
    }
}

// Namespace notetracks
// Params 2
// Checksum 0xac6ac04f, Offset: 0x36fd
// Size: 0x1f
function notetrackhtoff( note, flagname )
{
    if ( !isai( self ) )
    {
        return;
    }
}

// Namespace notetracks
// Params 2
// Checksum 0xb85cb1b0, Offset: 0x3724
// Size: 0x40
function function_a0b102acdae4fcea( note, flagname )
{
    if ( isai( self ) )
    {
        self setlookatstate( "request" );
        
        if ( utility::issp() )
        {
            self setlookatplayer( level.player );
        }
    }
}

// Namespace notetracks
// Params 2
// Checksum 0x82c1a2df, Offset: 0x376c
// Size: 0x2e
function function_66322e480aecee00( note, flagname )
{
    if ( isai( self ) )
    {
        self setlookatstate( "request" );
        self setlookatpos();
    }
}

// Namespace notetracks
// Params 2
// Checksum 0x445ae60b, Offset: 0x37a2
// Size: 0x2e
function function_4a227e256571435c( note, flagname )
{
    if ( isai( self ) )
    {
        self setlookatstate( "prohibit" );
        self setlookatentity();
    }
}

// Namespace notetracks
// Params 2
// Checksum 0x84eff0f9, Offset: 0x37d8
// Size: 0x2e
function function_61c434cdbeeb63b5( note, flagname )
{
    if ( isai( self ) )
    {
        self asmfireevent( self.asmname, note );
    }
}

// Namespace notetracks
// Params 2
// Checksum 0x9d69b171, Offset: 0x380e
// Size: 0x31
function function_1d5758f4056c4b5b( note, flagname )
{
    if ( isdefined( self.var_4a70d72021f92db9 ) )
    {
        return [[ self.var_4a70d72021f92db9 ]]( note, flagname );
    }
}

// Namespace notetracks
// Params 1
// Checksum 0x19ba0cd2, Offset: 0x3847
// Size: 0x1ea
function function_a5174414568d2a6c( var_69d0e4bf53b1112a )
{
    info = strtok( var_69d0e4bf53b1112a, ",", 1 );
    model = info[ 0 ];
    tag = info[ 1 ];
    boolstring = info[ 2 ];
    offs_pos_x = info[ 3 ];
    offs_pos_y = info[ 4 ];
    offs_pos_z = info[ 5 ];
    offs_ang_pitch = info[ 6 ];
    offs_ang_yaw = info[ 7 ];
    offs_ang_roll = info[ 8 ];
    
    if ( !isdefined( model ) )
    {
        return [ undefined, undefined, undefined, undefined, undefined ];
    }
    
    if ( isdefined( level.fnnotetrackmodeltranslate ) )
    {
        model = [[ level.fnnotetrackmodeltranslate ]]( model );
    }
    
    if ( isdefined( model ) )
    {
        model = cleanup_string( model );
    }
    
    if ( isdefined( tag ) )
    {
        tag = cleanup_string( tag );
    }
    
    var_aec74715ebe5b196 = function_47aa4a1ab3a51c3c( boolstring );
    offs_pos = function_c85976dbfa005f70( offs_pos_x, offs_pos_y, offs_pos_z );
    offs_ang = function_c85976dbfa005f70( offs_ang_pitch, offs_ang_yaw, offs_ang_roll );
    
    if ( !isdefined( tag ) || tag == "" )
    {
        tag = "";
    }
    else if ( isent( self ) && !self tagexists( tag ) )
    {
        assertmsg( "<dev string:x151>" + var_69d0e4bf53b1112a + "<dev string:x15f>" + debug::function_4496bef4cfc0d07( self ) + "<dev string:x36a>" + tag + "<dev string:x380>" );
        return;
    }
    
    if ( !isdefined( model ) )
    {
        assertmsg( "<dev string:x151>" + var_69d0e4bf53b1112a + "<dev string:x15f>" + debug::function_4496bef4cfc0d07( self ) + "<dev string:x3bc>" );
        return;
    }
    
    return [ model, tag, var_aec74715ebe5b196, offs_pos, offs_ang ];
}

// Namespace notetracks
// Params 1
// Checksum 0x16866c6c, Offset: 0x3a3a
// Size: 0xa1
function function_9e6002c6e61dadeb( attachinfo )
{
    [ model, tag, var_aec74715ebe5b196 ] = function_a5174414568d2a6c( attachinfo );
    
    if ( isdefined( self.notetrackattach[ tag ] ) )
    {
        function_f6f6fe4d0444f6bc( tag );
    }
    
    if ( model != "none" && model != "" )
    {
        self attach( model, tag, 1 );
        self.notetrackattach[ tag ] = model;
        self.var_352ae0cb7fbe7c7b[ tag ] = var_aec74715ebe5b196;
    }
}

// Namespace notetracks
// Params 1
// Checksum 0x18af1bae, Offset: 0x3ae3
// Size: 0x150
function function_370e3c53376acf8a( attachinfo )
{
    [ model, tag, var_aec74715ebe5b196, offs_org, offs_ang ] = function_a5174414568d2a6c( attachinfo );
    
    if ( isdefined( self.var_8569d22e33f70cdc[ tag ] ) )
    {
        function_1c73580556d172b9( tag );
    }
    
    spawned = undefined;
    
    if ( model != "none" && model != "" )
    {
        spawned = spawn( "script_model", self.origin );
        spawned setmodel( model );
        
        if ( !isdefined( offs_org ) )
        {
            offs_org = ( 0, 0, 0 );
        }
        
        if ( !isdefined( offs_ang ) )
        {
            offs_ang = ( 0, 0, 0 );
        }
        
        tagactual = tag;
        
        if ( tagactual == "" )
        {
            tagactual = spawned function_cb497b712374573a( 0 );
            
            if ( !self tagexists( tagactual ) )
            {
                tagactual = self function_cb497b712374573a( 0 );
            }
        }
        
        spawned linkto( self, tagactual, offs_org, offs_ang );
        self.var_8569d22e33f70cdc[ tag ] = spawned;
        self.var_2b91df7b8de12e6b[ tag ] = var_aec74715ebe5b196;
        utility::script_func( "notetrack_linkmodel_callback", spawned );
    }
    
    return spawned;
}

// Namespace notetracks
// Params 1
// Checksum 0x5c7217d8, Offset: 0x3c3c
// Size: 0x61
function function_dd7954588a5da1f5( attachinfo )
{
    [ model, tag ] = function_a5174414568d2a6c( attachinfo );
    
    if ( isdefined( self.notetrackattach[ tag ] ) )
    {
        function_f6f6fe4d0444f6bc( tag );
        return;
    }
    
    self detach( model, tag );
}

// Namespace notetracks
// Params 1, eflags: 0x4
// Checksum 0x3be43482, Offset: 0x3ca5
// Size: 0x37
function private function_f6f6fe4d0444f6bc( tag )
{
    self detach( self.notetrackattach[ tag ], tag );
    self.notetrackattach[ tag ] = undefined;
    self.var_352ae0cb7fbe7c7b[ tag ] = undefined;
}

// Namespace notetracks
// Params 1
// Checksum 0xeb6d26f6, Offset: 0x3ce4
// Size: 0xe6
function function_6392e37a20403625( attachinfo )
{
    [ model, tag ] = function_a5174414568d2a6c( attachinfo );
    
    if ( isdefined( self.var_8569d22e33f70cdc[ tag ] ) )
    {
        function_1c73580556d172b9( tag );
        return;
    }
    
    children = self getlinkedchildren();
    
    foreach ( child in children )
    {
        if ( child.model == model )
        {
            child delete();
        }
    }
}

// Namespace notetracks
// Params 1, eflags: 0x4
// Checksum 0x38da75cb, Offset: 0x3dd2
// Size: 0x35
function private function_1c73580556d172b9( tag )
{
    self.var_8569d22e33f70cdc[ tag ] delete();
    self.var_8569d22e33f70cdc[ tag ] = undefined;
    self.var_2b91df7b8de12e6b[ tag ] = undefined;
}

// Namespace notetracks
// Params 1
// Checksum 0x68111acf, Offset: 0x3e0f
// Size: 0xa7
function function_801167dc009f7115( attachinfo )
{
    [ modelname, tag ] = function_a5174414568d2a6c( attachinfo );
    model = spawn( "script_model", self gettagorigin( tag ) );
    model.angles = self gettagangles( tag );
    model setmodel( modelname );
    
    if ( !isdefined( self.var_b9b5a26dc286378f ) )
    {
        self.var_b9b5a26dc286378f = [];
    }
    
    self.var_b9b5a26dc286378f[ self.var_b9b5a26dc286378f.size ] = model;
    function_dd7954588a5da1f5( attachinfo );
}

// Namespace notetracks
// Params 1
// Checksum 0xd4c315e0, Offset: 0x3ebe
// Size: 0x95
function function_5359be77d2818b1f( info )
{
    info = strtok( info, "," );
    tag = info[ 0 ];
    index = self.var_b9b5a26dc286378f.size - 1;
    ent = self.var_b9b5a26dc286378f[ index ];
    self.var_b9b5a26dc286378f[ index ] = undefined;
    self attach( ent.model, tag, 1 );
    self.notetrackattach[ tag ] = ent.model;
    ent delete();
}

// Namespace notetracks
// Params 1
// Checksum 0x4a8d419, Offset: 0x3f5b
// Size: 0xdb
function function_97c6caa36e65db54( var_f92701bf8b8e8650 )
{
    if ( isdefined( self.notetrackattach ) )
    {
        tags = getarraykeys( self.notetrackattach );
        
        foreach ( tag in tags )
        {
            if ( !var_f92701bf8b8e8650 || self.var_352ae0cb7fbe7c7b[ tag ] )
            {
                function_f6f6fe4d0444f6bc( tag );
            }
        }
        
        if ( self.notetrackattach.size == 0 )
        {
            self.notetrackattach = undefined;
            self.var_352ae0cb7fbe7c7b = undefined;
        }
    }
}

// Namespace notetracks
// Params 1
// Checksum 0x14d5c7be, Offset: 0x403e
// Size: 0xdb
function function_2c2fa803a0d2b3a4( var_f92701bf8b8e8650 )
{
    if ( isdefined( self.var_8569d22e33f70cdc ) )
    {
        tags = getarraykeys( self.var_8569d22e33f70cdc );
        
        foreach ( tag in tags )
        {
            if ( !var_f92701bf8b8e8650 || self.var_2b91df7b8de12e6b[ tag ] )
            {
                function_1c73580556d172b9( tag );
            }
        }
        
        if ( self.var_8569d22e33f70cdc.size == 0 )
        {
            self.var_8569d22e33f70cdc = undefined;
            self.var_2b91df7b8de12e6b = undefined;
        }
    }
}

// Namespace notetracks
// Params 1
// Checksum 0x3da10628, Offset: 0x4121
// Size: 0x1e
function function_781f681362634fd0( note )
{
    function_97c6caa36e65db54( 1 );
    function_2c2fa803a0d2b3a4( 1 );
}

// Namespace notetracks
// Params 3
// Checksum 0x632a6c24, Offset: 0x4147
// Size: 0x45
function function_9e31ae7a5e7d20c( var_adc62138933601b1, var_ae42b04fcf01a851, var_60db31b83c84d1a6 )
{
    if ( isdefined( var_adc62138933601b1 ) )
    {
        fadetoblack( var_adc62138933601b1 );
    }
    
    if ( isdefined( var_ae42b04fcf01a851 ) )
    {
        wait var_ae42b04fcf01a851;
    }
    
    if ( isdefined( var_60db31b83c84d1a6 ) )
    {
        fadefromblack( var_60db31b83c84d1a6 );
    }
}

// Namespace notetracks
// Params 1
// Checksum 0x8a37f1b9, Offset: 0x4194
// Size: 0x10f
function fadetoblack( fadetime )
{
    self notify( #"hash_fcaf6ee3c14c1f14" );
    self notify( #"do_fade_to_black" );
    self endon( #"do_fade_to_black" );
    
    if ( !isdefined( self.var_34f8e5e9b4be971e ) )
    {
        self.var_34f8e5e9b4be971e = newclienthudelem( self );
        self.var_34f8e5e9b4be971e setshader( "black", 640, 480 );
        self.var_34f8e5e9b4be971e.sort = 1;
        self.var_34f8e5e9b4be971e.horzalign = "fullscreen";
        self.var_34f8e5e9b4be971e.vertalign = "fullscreen";
        self.var_34f8e5e9b4be971e.foreground = 1;
    }
    
    if ( fadetime > 0 )
    {
        self.var_34f8e5e9b4be971e.alpha = 0;
        self.var_34f8e5e9b4be971e fadeovertime( fadetime );
    }
    
    self.var_34f8e5e9b4be971e.alpha = 1;
    wait fadetime;
}

// Namespace notetracks
// Params 1
// Checksum 0x50d398b5, Offset: 0x42ab
// Size: 0x11d
function fadefromblack( fadetime )
{
    self notify( #"hash_fcaf6ee3c14c1f14" );
    self notify( #"do_fade_to_black" );
    self endon( #"hash_fcaf6ee3c14c1f14" );
    
    if ( !isdefined( self.var_34f8e5e9b4be971e ) )
    {
        self.var_34f8e5e9b4be971e = newclienthudelem( self );
        self.var_34f8e5e9b4be971e setshader( "black", 640, 480 );
        self.var_34f8e5e9b4be971e.sort = 1;
        self.var_34f8e5e9b4be971e.horzalign = "fullscreen";
        self.var_34f8e5e9b4be971e.vertalign = "fullscreen";
        self.var_34f8e5e9b4be971e.foreground = 1;
    }
    
    if ( fadetime > 0 )
    {
        self.var_34f8e5e9b4be971e.alpha = 1;
        self.var_34f8e5e9b4be971e fadeovertime( fadetime );
    }
    
    self.var_34f8e5e9b4be971e.alpha = 0;
    wait fadetime;
    self.var_34f8e5e9b4be971e destroy();
}

// Namespace notetracks
// Params 1
// Checksum 0x31d2f7ee, Offset: 0x43d0
// Size: 0x52
function function_270aa7df372b1353( numberstring )
{
    if ( isdefined( numberstring ) )
    {
        numberstring = cleanup_string( numberstring );
        
        if ( isstartstr( numberstring, "undef" ) )
        {
            return;
        }
        
        time = float( numberstring );
        magic_time = utility::function_4aa72f5b1badf161( time );
        return magic_time;
    }
}

// Namespace notetracks
// Params 1
// Checksum 0xeb9f9d90, Offset: 0x442b
// Size: 0x3e
function function_47aa4a1ab3a51c3c( boolstring )
{
    if ( isdefined( boolstring ) )
    {
        boolstring = tolower( boolstring );
        
        if ( issubstr( boolstring, "f" ) )
        {
            return 0;
        }
        
        if ( issubstr( boolstring, "t" ) )
        {
            return 1;
        }
    }
}

// Namespace notetracks
// Params 3
// Checksum 0x8b8009a2, Offset: 0x4472
// Size: 0x52
function function_c85976dbfa005f70( stringx, stringy, stringz )
{
    if ( isdefined( stringx ) && isdefined( stringy ) && isdefined( stringz ) )
    {
        vector = ( float( stringx ), float( stringy ), float( stringz ) );
        return vector;
    }
}

// Namespace notetracks
// Params 1
// Checksum 0x6cddba0e, Offset: 0x44cd
// Size: 0x5c
function cleanup_string( string )
{
    string = tolower( string );
    len = string.size;
    
    if ( isstartstr( string, " " ) || isendstr( string, " " ) )
    {
        [ string ] = strtok( string, " " );
    }
    
    return string;
}

// Namespace notetracks
// Params 2
// Checksum 0xf00945c9, Offset: 0x4532
// Size: 0x1e
function function_b166dea5984e5210( notetrack, note_prefix )
{
    return getsubstr( notetrack, note_prefix.size );
}

// Namespace notetracks
// Params 0
// Checksum 0x2fbf05e7, Offset: 0x4559
// Size: 0x360
function function_8d66def2db6aadea()
{
    if ( !utility::issp() )
    {
        return;
    }
    
    waittillframeend();
    
    if ( !isdefined( level.scr_anim ) )
    {
        return;
    }
    
    var_e4a8e2247a8147c3[ 0 ] = "at_";
    var_e4a8e2247a8147c3[ 1 ] = "linkmodel_";
    var_e4a8e2247a8147c3[ 2 ] = "sm_";
    var_e4a8e2247a8147c3[ 3 ] = "dt_";
    var_e4a8e2247a8147c3[ 4 ] = "unlinkmodel_";
    var_26996206c839bf70[ 0 ] = "rm_";
    var_26996206c839bf70[ 1 ] = "rml_";
    var_26996206c839bf70[ 2 ] = "rms_";
    prefix_array = arraycombine( var_e4a8e2247a8147c3, var_26996206c839bf70 );
    
    foreach ( var_f8bb86d466b8b36e in level.scr_anim )
    {
        foreach ( var_5b2473d5fd041de1 in var_f8bb86d466b8b36e )
        {
            if ( !isarray( var_5b2473d5fd041de1 ) )
            {
                var_5b2473d5fd041de1 = [ var_5b2473d5fd041de1 ];
            }
            
            foreach ( animation in var_5b2473d5fd041de1 )
            {
                foreach ( note_prefix in prefix_array )
                {
                    if ( !isanimation( animation ) )
                    {
                        continue;
                    }
                    
                    searchresults = getnotetracks( animation, note_prefix, 1 );
                    
                    foreach ( result in searchresults )
                    {
                        if ( isstartstr( note_prefix, "rm" ) )
                        {
                            rumble = function_b166dea5984e5210( result[ "name" ], note_prefix );
                            
                            if ( isdefined( rumble ) )
                            {
                                precacherumble( rumble );
                            }
                            
                            continue;
                        }
                        
                        notetrack_substring = getsubstr( result[ "name" ], note_prefix.size );
                        [ model, tag ] = function_a5174414568d2a6c( notetrack_substring );
                        
                        if ( isdefined( model ) )
                        {
                            if ( model != "all" )
                            {
                                precachemodel( model );
                            }
                        }
                    }
                }
            }
        }
    }
}

