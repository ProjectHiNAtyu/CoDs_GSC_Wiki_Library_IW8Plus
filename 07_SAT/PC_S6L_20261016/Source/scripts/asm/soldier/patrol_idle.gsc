// scripts\asm\soldier\patrol_idle.gsc  (hash_48be9a3e6e3cb250.gscc) (size: 11362 Bytes / 0x2c62 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xcdd7b69f (3453466271)
// size ...... 11362 (0x2c62)
// includes .. 6   (offset: 0x294e)
// strings ... 38  (offset: 0x297e)
// dev strs .. 9   (offset: 0x2bca)
// exports ... 43  (offset: 0x19a6)
// cseg ...... 0x299 + 0x170d (0x19a6)
// imports ... 68  (offset: 0x205e)
// animtree1 . 0   (offset: 0x2c62)
// animtree2 . 0   (offset: 0x2c62)
#using scripts\asm\asm;
#using scripts\asm\soldier\death;
#using scripts\asm\soldier\patrol;
#using scripts\common\anim;
#using scripts\common\string;
#using scripts\common\utility;

#namespace patrol_idle;

// Namespace patrol_idle
// Params 0
// Checksum 0x8131258a, Offset: 0x2b7
// Size: 0x39
function patrol_idle_getcellphone()
{
    modelname = "offhand_wm_smartphone_on";
    
    if ( isdefined( level.scr_model[ "idle_cellphone" ] ) )
    {
        modelname = level.scr_model[ "idle_cellphone" ];
    }
    
    return modelname;
}

// Namespace patrol_idle
// Params 3
// Checksum 0x368eba16, Offset: 0x2f9
// Size: 0x2f
function patrol_idle_init( asmname, statename, params )
{
    self.newenemyreactiondistsq = 0;
    thread patrol_prop_waitfordelete();
}

// Namespace patrol_idle
// Params 3
// Checksum 0x7cac3ec1, Offset: 0x330
// Size: 0x63
function patrol_idle_cleanup( asmname, statename, params )
{
    self.newenemyreactiondistsq = 262144;
    self function_49d3154c50a04d58();
    
    if ( isdefined( self.idle_prop ) )
    {
        self.idle_prop delete();
        self.idle_prop = undefined;
    }
    
    self notify( #"patrol_idle_complete" );
}

// Namespace patrol_idle
// Params 4
// Checksum 0x80977a52, Offset: 0x39b
// Size: 0x7f, Type: bool
function patrol_idle_istype( asmname, statename, tostatename, params )
{
    assert( isdefined( params ) );
    assert( self._blackboard.idlenodeisvalid );
    assert( isdefined( self._blackboard.var_80620d148c237af1 ) );
    return self._blackboard.var_80620d148c237af1 == params;
}

// Namespace patrol_idle
// Params 2
// Checksum 0x9e7cb40c, Offset: 0x423
// Size: 0x34
function patrol_getcustomfunc( scenename, funcname )
{
    if ( isdefined( level.idle_funcs[ scenename ] ) )
    {
        return level.idle_funcs[ scenename ][ funcname ];
    }
}

// Namespace patrol_idle
// Params 3
// Checksum 0x266ddd97, Offset: 0x460
// Size: 0x74
function patrol_idle_getnotehandler( asmname, statename, params )
{
    if ( isdefined( self._blackboard.customidlenode ) )
    {
        var_7237854e3be197ca = patrol_getcustomfunc( self._blackboard.customidlenode, params + "_note" );
        
        if ( isdefined( var_7237854e3be197ca ) )
        {
            return var_7237854e3be197ca;
        }
    }
    
    return asm::asm_getnotehandler( asmname, statename );
}

// Namespace patrol_idle
// Params 5
// Checksum 0x58274c0c, Offset: 0x4dd
// Size: 0xd2
function patrol_playanim( asmname, statename, params, notehandler, animrate )
{
    self endon( statename + "_finished" );
    patrolanim = asm::asm_getanim( asmname, statename );
    patrolxanim = asm::asm_getxanim( statename, patrolanim );
    
    if ( isnumber( patrolanim ) )
    {
        self aisetanim( statename, patrolanim, animrate );
    }
    else
    {
        assert( utility::issp(), "<dev string:x24>" );
        blankindex = asm::asm_lookupanimfromalias( statename, "blank" );
        self aisetanim( statename, blankindex, animrate );
        self setflaggedanimrestart( statename, patrolanim, 1, animrate );
    }
    
    asm::asm_playfacialanim( asmname, statename, patrolxanim );
    asm::asm_donotetracks( asmname, statename, notehandler, statename );
}

// Namespace patrol_idle
// Params 3
// Checksum 0xa0077f26, Offset: 0x5b7
// Size: 0xc0
function patrol_playidleintro( asmname, statename, params )
{
    self animmode( "zonly_physics" );
    desiredangle = self.angles[ 1 ];
    
    if ( self._blackboard.idlenodeisvalid )
    {
        if ( isdefined( self._blackboard.idlenodeangles ) )
        {
            desiredangle = self._blackboard.idlenodeangles[ 1 ];
        }
        else
        {
            desiredangle = 0;
        }
    }
    
    self orientmode( "face angle", desiredangle );
    notehandler = patrol_idle_getnotehandler( asmname, statename, "intro" );
    patrol_playanim( asmname, statename, params, notehandler, 1 );
}

// Namespace patrol_idle
// Params 3
// Checksum 0xe6114bed, Offset: 0x67f
// Size: 0x103
function patrol_playidleloop( asmname, statename, params )
{
    self endon( statename + "_finished" );
    bodyknob = asm::asm_getbodyknob();
    prevanim = bodyknob;
    notehandler = patrol_idle_getnotehandler( asmname, statename, "loop" );
    
    while ( true )
    {
        loopanim = asm::asm_getanim( asmname, statename );
        
        if ( isnumber( loopanim ) )
        {
            self aisetanim( statename, loopanim );
        }
        else
        {
            assert( utility::issp(), "<dev string:x4f>" );
            blankindex = asm::asm_lookupanimfromalias( statename, "blank" );
            self aisetanim( statename, blankindex );
            self setflaggedanimrestart( statename, loopanim, 1, 0.2, 1 );
        }
        
        loopxanim = asm::asm_getxanim( statename, loopanim );
        asm::asm_playfacialanim( asmname, statename, loopxanim );
        prevanim = loopanim;
        asm::asm_donotetracks( asmname, statename, notehandler, statename );
    }
}

// Namespace patrol_idle
// Params 3
// Checksum 0x1e7bb7f4, Offset: 0x78a
// Size: 0x63
function patrol_chooseidlereact( asmname, statename, params )
{
    reactyaw = 0;
    alias = patrol::function_9c7d080daecb05ab();
    
    if ( isint( alias ) )
    {
        alias = string::to_string( alias );
    }
    
    reactanim = asm::asm_lookupanimfromalias( statename, alias );
    return reactanim;
}

// Namespace patrol_idle
// Params 3
// Checksum 0xac21bdd0, Offset: 0x7f6
// Size: 0x150
function patrol_playidlereact( asmname, statename, params )
{
    self endon( statename + "_finished" );
    self function_49d3154c50a04d58();
    patrolanim = asm::asm_getanim( asmname, statename );
    notehandler = patrol_idle_getnotehandler( asmname, statename, "react" );
    patrolxanim = asm::asm_getxanim( statename, patrolanim );
    animrate = 1;
    
    if ( isdefined( self.stealthreactendtime ) )
    {
        animlength = getanimlength( patrolxanim );
        desiredlength = ( self.stealthreactendtime - gettime() ) / 2000;
        
        if ( desiredlength < animlength )
        {
            if ( desiredlength < 0.3 )
            {
                desiredlength = 0.3;
            }
            
            animrate = animlength / desiredlength;
        }
    }
    
    if ( isnumber( patrolanim ) )
    {
        self aisetanim( statename, patrolanim, animrate );
    }
    else
    {
        assert( utility::issp(), "<dev string:x7a>" );
        blankindex = asm::asm_lookupanimfromalias( statename, "blank" );
        self aisetanim( statename, blankindex, animrate );
        self setflaggedanimrestart( statename, patrolanim, 1, 0.2, animrate );
    }
    
    asm::asm_playfacialanim( asmname, statename, patrolxanim );
    self function_a03c28c47bbe8db6( patrolanim, statename );
    asm::asm_donotetracks( asmname, statename, notehandler, statename );
}

// Namespace patrol_idle
// Params 3
// Checksum 0xb9f85330, Offset: 0x94e
// Size: 0x53
function patrol_playidleend( asmname, statename, params )
{
    notehandler = patrol_idle_getnotehandler( asmname, statename, "end" );
    self notify( #"smoking_end" );
    patrol_playanim( asmname, statename, params, notehandler, 1 );
}

// Namespace patrol_idle
// Params 2
// Checksum 0xb8693a33, Offset: 0x9a9
// Size: 0x154
function patrol_notehandler_smoking( note, statename )
{
    note = getsubstr( note, 10 );
    
    if ( isstartstr( note, "attach" ) )
    {
        self.idle_fx = level.g_effect[ "cigarette_unlit" ];
        playfxontag( self.idle_fx, self, "tag_accessory_right" );
        return;
    }
    
    if ( isstartstr( note, "light" ) )
    {
        self.idle_fx = level.g_effect[ "cigarette_lit" ];
        playfxontag( self.idle_fx, self, "tag_accessory_right" );
        stopfxontag( level.g_effect[ "cigarette_unlit" ], self, "tag_accessory_right" );
        playfx( level.g_effect[ "lighter_glow" ], self gettagorigin( "tag_accessory_right" ) );
        thread patrol_smoking_blowsmoke( statename );
        return;
    }
    
    if ( isstartstr( note, "detach" ) )
    {
        stopfxontag( level.g_effect[ "cigarette_lit" ], self, "tag_accessory_right" );
        self.idle_fx = undefined;
        playfx( level.g_effect[ "cigarette_lit_toss" ], self gettagorigin( "tag_accessory_right" ), anglestoforward( self gettagangles( "tag_accessory_right" ) ) );
        return;
    }
    
    if ( isstartstr( note, "face_goal" ) )
    {
        patrol::handlefacegoalnotetrack( statename, note, undefined );
    }
}

// Namespace patrol_idle
// Params 1
// Checksum 0x9af8016e, Offset: 0xb05
// Size: 0x9b
function patrol_smoking_blowsmoke( statename )
{
    self endon( #"smoking_end" );
    self endon( #"death" );
    
    while ( true )
    {
        self.smoke_fx_ent = playfxontag( level.g_effect[ "cigarette_smoke" ], self, "tag_eye" );
        thread utility::playsoundontag( "fly_t10_ai_smoking_exhale_01", "j_head" );
        waittime = randomintrange( 5, 8 );
        wait waittime;
        
        if ( isdefined( self.smoke_fx_ent ) )
        {
            self.smoke_fx_ent delete();
            self.smoke_fx_ent = undefined;
        }
    }
}

// Namespace patrol_idle
// Params 3
// Checksum 0xe46532a0, Offset: 0xba8
// Size: 0x85
function patrol_smoking_cleanup( asmname, statename, params )
{
    self notify( #"smoking_end" );
    
    if ( isdefined( self.idle_fx ) )
    {
        stopfxontag( self.idle_fx, self, "tag_accessory_right" );
        self.idle_fx = undefined;
    }
    
    if ( isdefined( self.smoke_fx_ent ) )
    {
        self.smoke_fx_ent delete();
        self.smoke_fx_ent = undefined;
    }
    
    patrol_idle_cleanup( asmname, statename, params );
}

// Namespace patrol_idle
// Params 2
// Checksum 0xe628e6ff, Offset: 0xc35
// Size: 0xd3
function patrol_notehandler_cellphone( note, statename )
{
    self endon( statename + "_finished" );
    
    switch ( note )
    {
        case #"hash_2d1403e602f082a4":
            self.idle_prop = animation::anim_link_tag_model( patrol_idle_getcellphone(), "tag_accessory_right" );
            wait 2;
            
            if ( isdefined( self.idle_prop ) )
            {
                playfxontag( level.g_effect[ "cellphone_glow" ], self.idle_prop, "tag_origin" );
            }
            
            break;
        case #"hash_682ec8b49fe7aa12":
            if ( isdefined( self.idle_prop ) )
            {
                self.idle_prop delete();
                self.idle_prop = undefined;
            }
            
            break;
        case #"hash_2c250facc201a952":
            patrol::handlefacegoalnotetrack( statename, note, undefined );
            break;
    }
}

// Namespace patrol_idle
// Params 3
// Checksum 0x4d79afbc, Offset: 0xd10
// Size: 0x10e
function patrol_prop_cleanup( asmname, statename, params )
{
    if ( isdefined( self.idle_prop ) )
    {
        if ( ![[ self.fnisinstealthidle ]]() || !isalive( self ) )
        {
            launchforce = anglestoforward( self.angles );
            launchforce *= randomfloatrange( 30, 45 );
            forcex = launchforce[ 0 ];
            forcey = launchforce[ 1 ];
            forcez = randomfloatrange( 80, 90 );
            self.idle_prop unlink();
            self.idle_prop physicslaunchserver( self.idle_prop.origin, ( forcex, forcey, forcez ) );
            self.idle_prop thread patrol_prop_delete();
            self.idle_prop = undefined;
            return;
        }
        
        if ( [[ self.fnstealthisidlecurious ]]() )
        {
            self.idle_prop delete();
            self.idle_prop = undefined;
        }
    }
}

// Namespace patrol_idle
// Params 0
// Checksum 0x52acb22, Offset: 0xe26
// Size: 0x4b
function patrol_prop_delete()
{
    wait 5;
    
    while ( isalive( level.player ) && distance2dsquared( level.player.origin, self.origin ) < 160000 )
    {
        wait 1;
    }
    
    self delete();
}

// Namespace patrol_idle
// Params 2
// Checksum 0x27e488fe, Offset: 0xe79
// Size: 0x95
function patrol_notehandler_drinking( note, statename )
{
    switch ( note )
    {
        case #"hash_2d1403e602f082a4":
            self.idle_prop = animation::anim_link_tag_model( "p7_bottle_plastic_16oz_water", "tag_accessory_right" );
            break;
        case #"hash_682ec8b49fe7aa12":
            if ( isdefined( self.idle_prop ) )
            {
                self.idle_prop delete();
                self.idle_prop = undefined;
            }
            
            break;
        case #"hash_2c250facc201a952":
            patrol::handlefacegoalnotetrack( statename, note, undefined );
            break;
    }
}

// Namespace patrol_idle
// Params 3
// Checksum 0x6ac924bd, Offset: 0xf16
// Size: 0x16d
function patrol_playidlesittingloop( asmname, statename, params )
{
    self endon( statename + "_finished" );
    self animmode( "noclip" );
    groundpos = utility::drop_to_ground( self._blackboard.idlenodeorigin, 8, -128 );
    
    if ( isdefined( params ) )
    {
        assert( self._blackboard.idlenodeisvalid );
        assert( isdefined( level.fnanimatedprop_setup ) );
        [[ level.fnanimatedprop_setup ]]( "idle_chair", params, groundpos, self._blackboard.idlenodeangles );
    }
    
    var_7bb16cb7ca52fecf = 1;
    bodyknob = asm::asm_getbodyknob();
    prevanim = bodyknob;
    
    while ( true )
    {
        loopanim = asm::asm_getanim( asmname, statename );
        loopxanim = asm::asm_getxanim( statename, loopanim );
        self aisetanim( statename, loopanim );
        asm::asm_playfacialanim( asmname, statename, loopxanim );
        prevanim = loopanim;
        
        if ( var_7bb16cb7ca52fecf )
        {
            assert( self._blackboard.idlenodeisvalid );
            self startcoverarrival();
            thread patrol_idlesitting_checkforcoverarrivalcomplete( statename, groundpos );
            var_7bb16cb7ca52fecf = 0;
        }
        
        asm::asm_donotetracks( asmname, statename, asm::asm_getnotehandler( asmname, statename ), statename );
    }
}

// Namespace patrol_idle
// Params 2
// Checksum 0xbca505b8, Offset: 0x108b
// Size: 0x47
function patrol_idlesitting_checkforcoverarrivalcomplete( statename, endpos )
{
    self endon( statename + "_finished" );
    
    while ( true )
    {
        if ( distance2dsquared( self.origin, endpos ) < 4 )
        {
            self finishcoverarrival();
            break;
        }
        
        waitframe();
    }
}

// Namespace patrol_idle
// Params 3
// Checksum 0x9d08f9b, Offset: 0x10da
// Size: 0x24
function patrol_playidlesittingloop_cleanup( asmname, statename, params )
{
    self finishcoverarrival();
}

// Namespace patrol_idle
// Params 3
// Checksum 0x74c1abd3, Offset: 0x1106
// Size: 0x34
function patrol_playidlesittingloop_prop_cleanup( asmname, statename, params )
{
    patrol_prop_cleanup( asmname, statename, params );
    patrol_playidlesittingloop_cleanup( asmname, statename, params );
}

// Namespace patrol_idle
// Params 3
// Checksum 0x7cce612b, Offset: 0x1142
// Size: 0x29
function patrol_playidlesittingloop_sleeping( asmname, statename, params )
{
    patrol_playidlesittingloop( asmname, statename, params );
}

// Namespace patrol_idle
// Params 3
// Checksum 0x47536bcb, Offset: 0x1173
// Size: 0x29
function patrol_playidlesittingloop_sleeping_cleanup( asmname, statename, params )
{
    patrol_playidlesittingloop_cleanup( asmname, statename, params );
}

// Namespace patrol_idle
// Params 3
// Checksum 0xe399286f, Offset: 0x11a4
// Size: 0x65
function patrol_playidlesittingloop_cellphone( asmname, statename, params )
{
    self.idle_prop = animation::anim_link_tag_model( patrol_idle_getcellphone(), "tag_accessory_right" );
    playfxontag( level.g_effect[ "cellphone_glow" ], self.idle_prop, "tag_origin" );
    patrol_playidlesittingloop( asmname, statename, params );
}

// Namespace patrol_idle
// Params 3
// Checksum 0x27e6df8e, Offset: 0x1211
// Size: 0x29
function patrol_playidlesittingloop_laptop( asmname, statename, params )
{
    patrol_playidlesittingloop( asmname, statename, params );
}

// Namespace patrol_idle
// Params 3
// Checksum 0x28c2e93e, Offset: 0x1242
// Size: 0x42
function patrol_playidlesittingloop_pistolclean( asmname, statename, params )
{
    self.idle_prop = animation::anim_link_tag_model( "weapon_wm_pi_mike1911_phys", "tag_accessory_right" );
    patrol_playidlesittingloop( asmname, statename, params );
}

// Namespace patrol_idle
// Params 3
// Checksum 0x11976db8, Offset: 0x128c
// Size: 0x5b
function patrol_playdeathanim_sitting( asmname, statename, params )
{
    if ( isdefined( self.animated_prop ) )
    {
        assert( isdefined( level.fnanimatedprop_startanim ) );
        self [[ level.fnanimatedprop_startanim ]]( "idle_chair", params );
    }
    
    death::playdeathanim( asmname, statename );
}

// Namespace patrol_idle
// Params 3
// Checksum 0x21f7503, Offset: 0x12ef
// Size: 0x4d
function patrol_playidlesittingreact( asmname, statename, params )
{
    self animmode( "noclip" );
    
    if ( isdefined( params ) )
    {
        self [[ level.fnanimatedprop_setanim ]]( "idle_chair", params );
    }
    
    asm::asm_playanimstate( asmname, statename );
}

// Namespace patrol_idle
// Params 4
// Checksum 0xc0d95519, Offset: 0x1344
// Size: 0x95, Type: bool
function patrol_hascustomanim( asmname, statename, tostatename, params )
{
    if ( isdefined( self._blackboard.customidlenode ) )
    {
        scenename = self._blackboard.customidlenode;
    }
    else
    {
        scenename = self._blackboard.var_80620d148c237af1;
    }
    
    assert( isdefined( scenename ) );
    return isdefined( level.scr_anim[ "patrol_idle" ][ scenename ][ params ] );
}

// Namespace patrol_idle
// Params 4
// Checksum 0xe50e3435, Offset: 0x13e2
// Size: 0xb5
function patrol_iscustomanimdefaultvalue( asmname, statename, tostatename, params )
{
    if ( isdefined( self._blackboard.customidlenode ) )
    {
        scenename = self._blackboard.customidlenode;
    }
    else
    {
        scenename = self._blackboard.var_80620d148c237af1;
    }
    
    assert( isdefined( scenename ) );
    assert( isdefined( level.scr_anim[ "<dev string:xa9>" ][ scenename ][ params ] ) );
    return isnumber( level.scr_anim[ "patrol_idle" ][ scenename ][ params ] );
}

// Namespace patrol_idle
// Params 3
// Checksum 0xf6ebfb79, Offset: 0x14a0
// Size: 0x211
function patrol_chooseanim_custom( asmname, statename, params )
{
    assert( isdefined( self._blackboard.customidlenode ) );
    scenename = self._blackboard.customidlenode;
    state = params;
    assert( isdefined( scenename ) );
    assert( isdefined( level.scr_anim ) );
    assert( isdefined( level.scr_anim[ "<dev string:xa9>" ] ), "<dev string:xb5>" + scenename + "<dev string:xe0>" + "<dev string:xa9>" + "<dev string:xf5>" );
    assert( isdefined( level.scr_anim[ "<dev string:xa9>" ][ scenename ] ), "<dev string:xb5>" + scenename + "<dev string:xe0>" + "<dev string:xa9>" + "<dev string:xf5>" );
    assert( isdefined( level.scr_anim[ "<dev string:xa9>" ][ scenename ][ state ] ), "<dev string:xff>" + state + "<dev string:xe0>" + "<dev string:xa9>" + "<dev string:x11f>" + scenename + "<dev string:xf5>" );
    
    if ( isarray( level.scr_anim[ "patrol_idle" ][ scenename ][ state ] ) )
    {
        numanims = level.scr_anim[ "patrol_idle" ][ scenename ][ state ].size;
        assert( numanims > 0 );
        
        if ( numanims > 1 )
        {
            if ( isdefined( self.fnisinstealthinvestigate ) && [[ self.fnisinstealthinvestigate ]]() )
            {
                if ( isdefined( self.var_e6969704da389ed1 ) )
                {
                    if ( self.var_5f2e4dbdcea0a9b0 == "investigate" )
                    {
                        return level.scr_anim[ "patrol_idle" ][ scenename ][ state ][ 0 ];
                    }
                }
            }
            
            return level.scr_anim[ "patrol_idle" ][ scenename ][ state ][ 1 ];
        }
        else
        {
            return level.scr_anim[ "patrol_idle" ][ scenename ][ 0 ];
        }
        
        return;
    }
    
    return level.scr_anim[ "patrol_idle" ][ scenename ][ state ];
}

// Namespace patrol_idle
// Params 3
// Checksum 0x334d62f7, Offset: 0x16b9
// Size: 0x87
function patrol_idle_custom_init( asmname, statename, params )
{
    assert( self._blackboard.idlenodeisvalid );
    assert( isdefined( self._blackboard.var_80620d148c237af1 ) );
    self._blackboard.customidlenode = self._blackboard.var_80620d148c237af1;
    patrol_idle_init( asmname, statename, params );
}

// Namespace patrol_idle
// Params 3
// Checksum 0xb3e93696, Offset: 0x1748
// Size: 0x50
function patrol_idle_custom_cleanup( asmname, statename, params )
{
    patrol_idle_cleanup( asmname, statename, params );
    patrol_idle_callcustomcallback( "cleanup" );
    
    if ( isalive( self ) )
    {
        self._blackboard.customidlenode = undefined;
    }
}

// Namespace patrol_idle
// Params 1
// Checksum 0x15a26856, Offset: 0x17a0
// Size: 0x78
function patrol_idle_callcustomcallback( funcname )
{
    if ( isdefined( level.idle_funcs ) )
    {
        assert( isdefined( self._blackboard.customidlenode ) );
        scenename = self._blackboard.customidlenode;
        
        if ( isdefined( level.idle_funcs[ scenename ][ funcname ] ) )
        {
            self thread [[ level.idle_funcs[ scenename ][ funcname ] ]]();
        }
    }
}

// Namespace patrol_idle
// Params 3
// Checksum 0xa05badc5, Offset: 0x1820
// Size: 0x35
function patrol_playidleintro_custom( asmname, statename, params )
{
    patrol_idle_callcustomcallback( "intro_begin" );
    patrol_playidleintro( asmname, statename, params );
}

// Namespace patrol_idle
// Params 3
// Checksum 0xce55489b, Offset: 0x185d
// Size: 0x35
function patrol_playidleloop_custom( asmname, statename, params )
{
    patrol_idle_callcustomcallback( "loop_begin" );
    patrol_playidleloop( asmname, statename, params );
}

// Namespace patrol_idle
// Params 3
// Checksum 0xe0d5bea2, Offset: 0x189a
// Size: 0x35
function patrol_playidlereact_custom( asmname, statename, params )
{
    patrol_idle_callcustomcallback( "react_begin" );
    patrol_playidlereact( asmname, statename, params );
}

// Namespace patrol_idle
// Params 3
// Checksum 0x5b76f38c, Offset: 0x18d7
// Size: 0x35
function patrol_playidleend_custom( asmname, statename, params )
{
    patrol_idle_callcustomcallback( "exit_begin" );
    patrol_playidleend( asmname, statename, params );
}

// Namespace patrol_idle
// Params 3
// Checksum 0x5b515fa, Offset: 0x1914
// Size: 0x54
function patrol_playidle_custom_terminate( asmname, statename, params )
{
    assert( isdefined( self._blackboard.customidlenode ) );
    assert( isdefined( params ) );
    patrol_idle_callcustomcallback( params + "_end" );
}

// Namespace patrol_idle
// Params 0
// Checksum 0x2d717029, Offset: 0x1970
// Size: 0x36
function patrol_prop_waitfordelete()
{
    self endon( #"patrol_idle_complete" );
    self waittill( #"entitydeleted" );
    
    if ( isdefined( self.idle_prop ) )
    {
        self.idle_prop delete();
    }
}

