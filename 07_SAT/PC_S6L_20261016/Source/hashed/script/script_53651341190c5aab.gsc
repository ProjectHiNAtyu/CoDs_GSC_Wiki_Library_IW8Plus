// script_53651341190c5aab  (hash_53651341190c5aab.gscc) (size: 24767 Bytes / 0x60bf / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xa01ec4d0 (2686371024)
// size ...... 24767 (0x60bf)
// includes .. 4   (offset: 0x5d83)
// strings ... 43  (offset: 0x5da3)
// dev strs .. 11  (offset: 0x602f)
// exports ... 83  (offset: 0x3d53)
// cseg ...... 0x58e + 0x37c5 (0x3d53)
// imports ... 161 (offset: 0x4a4b)
// animtree1 . 0   (offset: 0x60bf)
// animtree2 . 0   (offset: 0x60bf)
#using scripts\asm\asm;
#using scripts\asm\cap;
#using scripts\common\cap;
#using scripts\common\utility;

#namespace interaction_common;

// Namespace interaction_common
// Params 1
// Checksum 0xb677c74f, Offset: 0x5ac
// Size: 0x21
function function_b4c8cc8d02ad0b95( interactionid )
{
    function_74c1da714488705c();
    thread function_61857cad428ddd0f();
    thread function_91053ba261a3aefc();
}

// Namespace interaction_common
// Params 1
// Checksum 0x5b2277f0, Offset: 0x5d5
// Size: 0x75
function function_dabb6663ba0a5177( interactionid )
{
    if ( isai( self ) )
    {
        self._blackboard.idlenode = undefined;
        self._blackboard.var_8acd86e75a05d61a = undefined;
        self.var_e0bc276499c18875 = undefined;
        
        if ( isalive( self ) )
        {
            if ( self.var_74e6943ef6ad6db1 )
            {
                self enabletraversals( 1 );
            }
            
            self notify( #"exited_skit" );
            function_b39f50639201758( interactionid );
        }
    }
}

// Namespace interaction_common
// Params 1
// Checksum 0x331dd23, Offset: 0x652
// Size: 0x1f2
function function_b39f50639201758( interactionid )
{
    skitvars = self.skitvars[ self.var_47b8cd06c0de3934 ].var_89e39ca8d7769234;
    
    if ( skitvars.size > 0 )
    {
        for ( i = 0; i < skitvars.size ; i++ )
        {
            command = skitvars[ i ];
            
            switch ( command )
            {
                case #"hash_29a13629e68e33fd":
                    skitname = skitvars[ i + 1 ] ?? "noparams";
                    
                    if ( skitname == "noparams" )
                    {
                        println( "<dev string:x24>" );
                        break;
                    }
                    
                    thread function_db31d7c8e2a192e1( skitname );
                    break;
                case #"hash_74f8589eca6d8b6a":
                    thread function_81357cba41e3a886( interactionid );
                    break;
                case #"hash_bd8646875225b68d":
                    skitstep = skitvars[ i + 1 ] ?? "noparams";
                    
                    if ( skitstep == "noparams" )
                    {
                        println( "<dev string:x24>" );
                        break;
                    }
                    
                    thread function_2f6ac664c6d76a89( skitstep );
                    break;
                case #"hash_161f451ea8f87f72":
                    skitname = skitvars[ i + 1 ] ?? "noparams";
                    
                    if ( skitname == "noparams" )
                    {
                        println( "<dev string:x24>" );
                        break;
                    }
                    
                    thread function_3ab78ff54084fa1e( skitname );
                    break;
                case #"hash_aabf6c4e0d8752ff":
                    skitname = skitvars[ i + 1 ] ?? "noparams";
                    
                    if ( skitname == "noparams" )
                    {
                        println( "<dev string:x24>" );
                        break;
                    }
                    
                    thread function_57780e4dc66759bb( skitname );
                    break;
                case #"hash_edd254f3ef01705b":
                    planname = skitvars[ i + 1 ] ?? "noparams";
                    
                    if ( planname == "noparams" )
                    {
                        println( "<dev string:x55>" );
                        break;
                    }
                    
                    thread function_634eb2b5c9b9484f( planname );
                    break;
            }
        }
    }
}

// Namespace interaction_common
// Params 1
// Checksum 0xafc7a4d1, Offset: 0x84c
// Size: 0x28a
function function_d4be89b1cf3d4993( funcid )
{
    switch ( funcid )
    {
        case #"hash_4d7ca12cb5ce1028":
            return &startcap;
        case #"hash_68f0ff432f6351ef":
            return &function_8d857b0f49d5bc35;
        case #"hash_c8fcdf8b63cc465a":
            return &function_d7ce78b577ce3552;
        case #"hash_303d74db152a39b9":
            return &function_ac09dd92b7250c46;
        case #"hash_996b6e15533d90f1":
            return &withindisttogoal;
        case #"hash_b541f16499b1633d":
            return &processevent;
        case #"hash_c0639b15cea67610":
            return &function_b4c8cc8d02ad0b95;
        case #"hash_96053be986d24f88":
            return &function_dabb6663ba0a5177;
        case #"hash_6e88d76179a2a0c0":
            return &function_ac130d84a0eb32ff;
        case #"hash_cb33d1efb4e52f0c":
            return &function_36e116420f58ccb3;
        case #"hash_8cd577f687228a56":
            return &function_1ac2b621b44f294f;
        case #"hash_c2342f9a0757f30":
            return &function_35b47a28ed5af7f5;
        case #"hash_af8904470869cfc3":
            return &function_320f55574f0726f4;
        case #"hash_a56eca06864aaf61":
            return &inplace;
        case #"hash_8cc77e3e31358f72":
            return &function_a6d48b868d228471;
        case #"hash_fd9154ff75bc4e6b":
            return &function_4bb4e69fc697b378;
        case #"hash_da98e33c69929347":
            return &function_245a8ceff5a9a894;
        case #"hash_1e571ef374ec6101":
            return &cleanupscriptmodel;
        case #"hash_694e601f9cb204ca":
            return &setupscriptmodel;
        case #"hash_ec1950a022e6c185":
            return &setupscriptable;
        case #"hash_d218d98026b6b9d7":
            return &function_f9cec32b76c81972;
        case #"hash_747eeb8dcda02e2c":
            return &cleanupscriptable;
        case #"hash_e5196ef5ace8ec0c":
            return &updatecollision;
        case #"hash_c7f66c13ac37bc15":
            return &stealthisenabled;
        case #"hash_159e471acd245f61":
            return &function_3d3f02fd7a5fbeab;
        case #"hash_8014355657c4e7f0":
            return &function_ff3fb91b3d4e6197;
        case #"hash_2c7ce84b74bbddbd":
            return &debugstate;
        case #"hash_c4f809fb5412dbef":
            return &skit_setvalue;
        case #"hash_72fe79d9600dc71c":
            return &function_fc05e3b2b222ba78;
        case #"hash_ad1e6887af9da37":
            return &skit_checkvalue;
        case #"hash_cb84953e6b3ddf1b":
            return &function_57c3c5e6f61d75f7;
        case #"hash_90495590d80b79e1":
            return &function_2eb2e8ff2163a2b2;
        case #"hash_993e77427cb9de08":
            return &function_5484f7281cb2458f;
        case #"hash_c4171f62477d5da7":
            return &function_43373ea24524297a;
    }
    
    assertmsg( "<dev string:x8b>" + funcid );
}

// Namespace interaction_common
// Params 2
// Checksum 0xe32fcd13, Offset: 0xade
// Size: 0x22, Type: bool
function function_2eb2e8ff2163a2b2( statename, params )
{
    return self.var_80c39a64c7a0542f ?? 0;
}

// Namespace interaction_common
// Params 2
// Checksum 0x68aa7cfc, Offset: 0xb09
// Size: 0xaa
function function_5484f7281cb2458f( statename, params )
{
    skitname = params[ 0 ];
    pos = self.origin;
    angles = ( 0, 0, 0 );
    
    if ( params[ 1 ] )
    {
        var_281697180aa2ebc2 = spawninteraction( skitname, pos, angles );
        
        if ( params.size > 1 )
        {
            for ( i = 1; i < params.size ; i++ )
            {
                interactionaddtagtotaglist( var_281697180aa2ebc2, "information_tag", params[ i ] );
            }
        }
        
        return;
    }
    
    println( "<dev string:xa9>" );
}

// Namespace interaction_common
// Params 2
// Checksum 0x4b01b432, Offset: 0xbbb
// Size: 0xac
function function_43373ea24524297a( statename, params )
{
    skitname = params[ 0 ];
    pos = params[ 1 ];
    angles = ( 0, 0, 0 );
    
    if ( params[ 0 ] && params[ 1 ] )
    {
        var_281697180aa2ebc2 = spawninteraction( skitname, pos, angles );
        
        if ( params.size > 2 )
        {
            for ( i = 2; i < params.size ; i++ )
            {
                interactionaddtagtotaglist( var_281697180aa2ebc2, "information_tag", params[ i ] );
            }
        }
        
        return;
    }
    
    println( "<dev string:xf9>" );
}

// Namespace interaction_common
// Params 2
// Checksum 0x7eb8977d, Offset: 0xc6f
// Size: 0x14e, Type: bool
function function_57c3c5e6f61d75f7( statename, params )
{
    if ( function_2eb2e8ff2163a2b2() == 0 )
    {
        return false;
    }
    
    if ( !isarray( params ) )
    {
        params = [ params ];
    }
    
    skitid = self.var_47b8cd06c0de3934;
    
    for ( i = 0; i < self.skitvars.size ; i++ )
    {
        if ( self.skitvars[ i ].var_e6f77a8052580740 && self.skitvars[ i ].var_e6f77a8052580740 == skitid )
        {
            for ( j = 0; j < params.size ; j++ )
            {
                var = params[ j ];
                
                foreach ( storedvar in self.skitvars[ i ].var_89e39ca8d7769234 )
                {
                    if ( var == storedvar )
                    {
                        return true;
                    }
                }
            }
        }
    }
    
    return false;
}

// Namespace interaction_common
// Params 2
// Checksum 0x974f2162, Offset: 0xdc6
// Size: 0x1c
function function_8d857b0f49d5bc35( statename, params )
{
    function_38f8b447cf8ea7cc();
}

// Namespace interaction_common
// Params 2
// Checksum 0x6401a9c, Offset: 0xdea
// Size: 0x15
function function_c0d7bc8e31affd7f( statename, params )
{
    
}

// Namespace interaction_common
// Params 2
// Checksum 0x96d8ea11, Offset: 0xe07
// Size: 0x1c
function function_d7ce78b577ce3552( statename, params )
{
    function_88c7216b32d58113();
}

// Namespace interaction_common
// Params 2
// Checksum 0xa0988b15, Offset: 0xe2b
// Size: 0x3a
function debugstate( statename, params )
{
    println( "<dev string:x143>" + gettime() + "<dev string:x14a>" + statename + "<dev string:x154>" + params[ 0 ] );
}

// Namespace interaction_common
// Params 2
// Checksum 0x43ddc674, Offset: 0xe6d
// Size: 0x90
function updatecollision( statename, params )
{
    if ( isarray( params ) )
    {
        setting = params[ 0 ];
    }
    else
    {
        setting = params;
    }
    
    switch ( setting )
    {
        case #"hash_c1c88ef798270243":
            self animmode( "noclip" );
            break;
        case #"hash_6caf06e2c9e6872e":
            self animmode( "zonly_physics" );
            break;
        case #"hash_7038dec66d8275be":
            self animmode( self.defaultanimmode );
            break;
    }
}

// Namespace interaction_common
// Params 2
// Checksum 0xf5d537d9, Offset: 0xf05
// Size: 0x51
function function_ac09dd92b7250c46( statename, params )
{
    assert( params.size == 1 );
    phasename = params[ 0 ];
    self._blackboard.bseqphase = phasename;
    function_c3d7c7c36e9eeb93( phasename );
}

// Namespace interaction_common
// Params 2
// Checksum 0x18911210, Offset: 0xf5e
// Size: 0x26f
function startcap( statename, params )
{
    if ( self.startinteractionimmediate )
    {
        params[ params.size ] = 1;
        startcap_immediate( statename, params );
        return;
    }
    
    capinfo = getcapinfoforparticipant( self );
    
    if ( !isdefined( capinfo ) )
    {
        capinfo = getcapinfoforrole( self, params[ 0 ] );
        
        if ( !isdefined( capinfo ) )
        {
            return;
        }
    }
    
    capname = capinfo.capname;
    animset = capinfo.animation;
    arrivalstateoverride = capinfo.arrivalstateoverride;
    introstatename = capinfo.initialstate;
    introaliasname = capinfo.initialalias;
    interaction = spawnstruct();
    interaction.angles = self._blackboard.var_54bc96b8017ea2ee;
    interaction.origin = self._blackboard.var_8690cdaf3fef6fec;
    
    if ( isdefined( self findoverridearchetype( "default" ) ) )
    {
        var_7f3a6317b7eb7494 = self findoverridearchetype( "default" ) + "_cap_arrival";
        
        if ( archetypehasstate( capname, var_7f3a6317b7eb7494 ) )
        {
            arrivalstateoverride = var_7f3a6317b7eb7494;
        }
    }
    
    if ( isdefined( introstatename ) && isdefined( introaliasname ) )
    {
        alias = archetypegetalias( animset, introstatename, introaliasname );
        animation = alias.anims;
        
        if ( isarray( animation ) )
        {
            animation = animation[ 0 ];
        }
        
        originalangles = interaction.angles;
        originalorigin = interaction.origin;
        interaction.origin = getstartorigin( originalorigin, originalangles, animation );
        interaction.angles = getstartangles( originalorigin, originalangles, animation );
    }
    
    self.interaction_angles = interaction.angles;
    self.interaction_origin = getgroundposition( interaction.origin, 1 );
    function_af52c68ab6343492();
    
    if ( self.skitvars[ self.var_47b8cd06c0de3934 ].skitrole == "unknown" )
    {
        self.skitvars[ self.var_47b8cd06c0de3934 ].skitrole = params[ 0 ];
    }
    
    function_67f4eef6ba6c5c29( arrivalstateoverride, animset );
    cap::cap_reach_and_arrive( interaction, capname, animset, arrivalstateoverride );
}

// Namespace interaction_common
// Params 0
// Checksum 0x6b749164, Offset: 0x11d5
// Size: 0x341
function function_af52c68ab6343492()
{
    skitid = self getinteractionid();
    skitname = function_80eb2badd88a772d( skitid );
    bundle = getaiinteractionscriptbundle( skitname );
    
    if ( bundle.roleinfos.size == 1 )
    {
        role = bundle.roleinfos[ 0 ].rolename;
    }
    else
    {
        role = "unknown";
    }
    
    capinfo = getcapinfoforparticipant( self );
    capname = capinfo.capname;
    
    if ( !isdefined( self.skitvars ) )
    {
        self.skitvars = [];
    }
    
    self.var_47b8cd06c0de3934 = self.skitvars.size;
    self.skitvars[ self.var_47b8cd06c0de3934 ] = spawnstruct();
    self.skitvars[ self.var_47b8cd06c0de3934 ].var_dfd897fa26bc57eb = capname;
    self.skitvars[ self.var_47b8cd06c0de3934 ].skitname = skitname;
    self.skitvars[ self.var_47b8cd06c0de3934 ].var_89e39ca8d7769234 = [];
    self.skitvars[ self.var_47b8cd06c0de3934 ].var_fb669c29dae2afbb = gettime();
    self.skitvars[ self.var_47b8cd06c0de3934 ].skitrole = role;
    self.skitvars[ self.var_47b8cd06c0de3934 ].skitid = skitid;
    self.skitvars[ self.var_47b8cd06c0de3934 ].skittags = function_a1855cd8cb545853( skitid );
    self.skitvars[ self.var_47b8cd06c0de3934 ].skitloc = self.interaction_origin;
    self.skitvars[ self.var_47b8cd06c0de3934 ].skitangles = self.interaction_angles;
    self.skitvars[ self.var_47b8cd06c0de3934 ].plan = self.var_46bdb508bb396b63 ?? "none";
    self.skitvars[ self.var_47b8cd06c0de3934 ].planid = self.var_e6f77a8052580740 ?? undefined;
    
    if ( self.skitvars[ self.var_47b8cd06c0de3934 ].skittags.information_tag.size > 0 )
    {
        for ( i = 0; i < self.skitvars[ self.var_47b8cd06c0de3934 ].skittags.information_tag.size ; i++ )
        {
            tag = self.skitvars[ self.var_47b8cd06c0de3934 ].skittags.information_tag[ i ];
            self.skitvars[ self.var_47b8cd06c0de3934 ].var_89e39ca8d7769234[ self.skitvars[ self.var_47b8cd06c0de3934 ].var_89e39ca8d7769234.size ] = tag;
        }
    }
}

// Namespace interaction_common
// Params 2
// Checksum 0x58f66170, Offset: 0x151e
// Size: 0x27d
function startcap_immediate( statename, params )
{
    capinfo = getcapinfoforparticipant( self );
    
    if ( !isdefined( capinfo ) )
    {
        capinfo = getcapinfoforrole( self, params[ 0 ] );
        
        if ( !isdefined( capinfo ) )
        {
            return;
        }
    }
    
    capname = capinfo.capname;
    animset = capinfo.animation;
    arrivalstateoverride = capinfo.arrivalstateoverride;
    introstatename = capinfo.initialstate;
    introaliasname = capinfo.initialalias;
    self.var_6a5e9f806fe6f239 = params[ 0 ];
    interaction = spawnstruct();
    interaction.angles = self._blackboard.var_54bc96b8017ea2ee;
    interaction.origin = self._blackboard.var_8690cdaf3fef6fec;
    
    if ( isdefined( self findoverridearchetype( "default" ) ) )
    {
        var_7f3a6317b7eb7494 = self findoverridearchetype( "default" ) + "_cap_arrival";
        
        if ( archetypehasstate( capname, var_7f3a6317b7eb7494 ) )
        {
            arrivalstateoverride = var_7f3a6317b7eb7494;
        }
    }
    
    if ( isdefined( introstatename ) && isdefined( introaliasname ) )
    {
        alias = archetypegetalias( animset, introstatename, introaliasname );
        animation = alias.anims;
        
        if ( isarray( animation ) )
        {
            animation = animation[ 0 ];
        }
        
        originalangles = interaction.angles;
        originalorigin = interaction.origin;
        interaction.origin = getstartorigin( originalorigin, originalangles, animation );
        interaction.angles = getstartangles( originalorigin, originalangles, animation );
    }
    
    self.interaction_angles = interaction.angles;
    self.interaction_origin = interaction.origin;
    
    if ( params[ 1 ] )
    {
        self forceteleport( self.interaction_origin, self.interaction_angles, 2048 );
    }
    
    function_af52c68ab6343492();
    
    if ( self.skitvars[ self.var_47b8cd06c0de3934 ].skitrole == "unknown" )
    {
        self.skitvars[ self.var_47b8cd06c0de3934 ].skitrole = params[ 0 ];
    }
    
    cap::cap_start( capname, animset, 0 );
    asm::asm_fireephemeralevent( "move", "end" );
}

// Namespace interaction_common
// Params 4
// Checksum 0xe002f695, Offset: 0x17a3
// Size: 0x2c
function function_1ac2b621b44f294f( asmname, statename, tostatename, params )
{
    return self function_51631ea7d587647d();
}

// Namespace interaction_common
// Params 4
// Checksum 0xcbe217c1, Offset: 0x17d8
// Size: 0x3a, Type: bool
function function_35b47a28ed5af7f5( asmname, statename, tostatename, params )
{
    return self function_51631ea7d587647d() && !self.arriving;
}

// Namespace interaction_common
// Params 3
// Checksum 0x6869da4e, Offset: 0x181b
// Size: 0xb2
function interaction_cap_playanim( asmname, statename, params )
{
    if ( self.var_9221857bb3db537a )
    {
        self animmode( "noclip" );
    }
    
    animid = asm::asm_getanim( asmname, statename );
    xanim = asm::asm_getxanim( statename, animid );
    
    if ( params == "loop" )
    {
        self._bseq_animlength = getanimlength( xanim );
        asm_cap::cap_loopanim( asmname, statename, params );
        return;
    }
    
    asm_cap::cap_playanim_internal( asmname, statename, params, animid );
    
    if ( isalive( self ) && self.var_5d4829c8b859716f )
    {
        self.var_d4da0a58a936a837 = 1;
    }
}

// Namespace interaction_common
// Params 3
// Checksum 0x96d6fb0a, Offset: 0x18d5
// Size: 0x98, Type: bool
function function_ac130d84a0eb32ff( asmname, statename, params )
{
    if ( self._blackboard.idlenode.repeat_interaction )
    {
        return !self._blackboard.idlenode.repeat_interaction;
    }
    
    if ( self.var_88af750d8cd349c1 )
    {
        return false;
    }
    
    if ( self.var_65b1528eab2fb4ea > 0 )
    {
        curtime = gettime();
        return ( curtime >= self.var_65b1528eab2fb4ea );
    }
    
    return true;
}

// Namespace interaction_common
// Params 3
// Checksum 0xfcf6f26f, Offset: 0x1976
// Size: 0x2e, Type: bool
function function_36e116420f58ccb3( asmname, statename, params )
{
    if ( self.startinteractionimmediate )
    {
        return true;
    }
    
    return false;
}

// Namespace interaction_common
// Params 2
// Checksum 0x851055c8, Offset: 0x19ad
// Size: 0x3a, Type: bool
function withindisttogoal( statename, params )
{
    mindist = params[ 0 ];
    
    if ( self.pathpending )
    {
        return false;
    }
    
    return self pathdisttogoal() <= mindist;
}

// Namespace interaction_common
// Params 3
// Checksum 0x3785fd27, Offset: 0x19f0
// Size: 0x19d, Type: bool
function processevent( receiver, info, origin )
{
    self notify( #"interaction_process_event" );
    
    if ( info == "relaxed" )
    {
        return true;
    }
    else if ( info == "panicked" || info == "cower" || info == "scared" || info == "flee" )
    {
        asm_cap::prop_drop();
        self._blackboard.bseqphase = "exit";
    }
    else if ( info == "curious" )
    {
        self._blackboard.var_8acd86e75a05d61a = self._blackboard.bseqphase;
        var_4d127952a867f5cb = self function_78c2e7c4a70a2205();
        
        if ( asm_cap::cap_hasalias( "curious", "curious_anim" ) )
        {
            self._blackboard.bseqphase = "curious";
            return true;
        }
        else if ( !var_4d127952a867f5cb )
        {
            return true;
        }
        else
        {
            asm_cap::prop_drop();
            self._blackboard.bseqphase = "exit";
            return false;
        }
    }
    else if ( !isdefined( self._blackboard.bseqphase ) || isdefined( self._blackboard.bseqphase ) && self._blackboard.bseqphase != "end" )
    {
        self._blackboard.bseqphase = "react";
        return true;
    }
    
    return false;
}

// Namespace interaction_common
// Params 1
// Checksum 0x39e87258, Offset: 0x1b96
// Size: 0xc
function empty( params )
{
    
}

// Namespace interaction_common
// Params 1
// Checksum 0x570b70f2, Offset: 0x1baa
// Size: 0x50, Type: bool
function function_320f55574f0726f4( param )
{
    statename = "curious";
    alias = "curious_anim";
    animresult = archetypegetrandomalias( self.animsetname, statename, alias );
    
    if ( isdefined( animresult ) )
    {
        return true;
    }
    
    return false;
}

// Namespace interaction_common
// Params 2
// Checksum 0xd11fa7ca, Offset: 0x1c03
// Size: 0x68
function inplace( statename, params )
{
    self._blackboard.bseqinplace = 1;
    interactionid = self getinteractionid();
    assert( isdefined( interactionid ) );
    
    if ( level.var_bbff6df6ad9df430 )
    {
        createinteractionnavobstacle( interactionid );
        return;
    }
    
    createinteractionnavrepulsor( interactionid );
}

// Namespace interaction_common
// Params 1
// Checksum 0xf715d2f, Offset: 0x1c73
// Size: 0x27
function function_9abedd84e16a2b9b( interactionid )
{
    repulsorname = function_562beb2c3d9ef8e2( interactionid );
    destroynavrepulsor( repulsorname );
}

// Namespace interaction_common
// Params 1
// Checksum 0xe609234b, Offset: 0x1ca2
// Size: 0x111
function function_de2253ab2039ac7c( interactionid )
{
    if ( isdefined( self._blackboard.var_c6236bc6766c2c2 ) )
    {
        destroynavobstacle( self._blackboard.var_c6236bc6766c2c2 );
        self._blackboard.var_c6236bc6766c2c2 = undefined;
    }
    
    bsequsers = getbsequsers( interactionid );
    
    if ( bsequsers.size == 0 )
    {
        return;
    }
    
    foreach ( bsequser in bsequsers )
    {
        obstacleid = bsequser._blackboard.var_c6236bc6766c2c2;
        
        if ( isdefined( obstacleid ) )
        {
            destroynavobstacle( obstacleid );
            bsequser._blackboard.var_c6236bc6766c2c2 = undefined;
        }
    }
}

// Namespace interaction_common
// Params 1, eflags: 0x4
// Checksum 0x4fbab975, Offset: 0x1dbb
// Size: 0x14
function private function_562beb2c3d9ef8e2( interactionid )
{
    return "civilian_interaction_" + interactionid;
}

// Namespace interaction_common
// Params 1, eflags: 0x4
// Checksum 0xfd4c0eba, Offset: 0x1dd8
// Size: 0x2ec
function private createinteractionnavrepulsor( interactionid )
{
    bsequsers = getbsequsers( interactionid );
    
    if ( bsequsers.size == 0 )
    {
        return;
    }
    
    var_86394cebdfe9c9a1 = [];
    
    foreach ( bsequser in bsequsers )
    {
        if ( isdefined( bsequser._blackboard ) && bsequser._blackboard.bseqinplace )
        {
            var_86394cebdfe9c9a1[ var_86394cebdfe9c9a1.size ] = bsequser;
        }
    }
    
    if ( var_86394cebdfe9c9a1.size <= 1 )
    {
        return;
    }
    
    circleorigin = ( 0, 0, 0 );
    circleradius = 0;
    
    if ( var_86394cebdfe9c9a1.size >= 2 )
    {
        minx = var_86394cebdfe9c9a1[ 0 ].origin[ 0 ];
        maxx = var_86394cebdfe9c9a1[ 0 ].origin[ 0 ];
        miny = var_86394cebdfe9c9a1[ 0 ].origin[ 1 ];
        maxy = var_86394cebdfe9c9a1[ 0 ].origin[ 1 ];
        
        for ( bsequserindex = 1; bsequserindex < var_86394cebdfe9c9a1.size ; bsequserindex++ )
        {
            bsequserorigin = var_86394cebdfe9c9a1[ bsequserindex ].origin;
            
            if ( bsequserorigin[ 0 ] < minx )
            {
                minx = bsequserorigin[ 0 ];
            }
            else if ( bsequserorigin[ 0 ] > maxx )
            {
                maxx = bsequserorigin[ 0 ];
            }
            
            if ( bsequserorigin[ 1 ] < miny )
            {
                miny = bsequserorigin[ 1 ];
                continue;
            }
            
            if ( bsequserorigin[ 1 ] > maxy )
            {
                maxy = bsequserorigin[ 1 ];
            }
        }
        
        circleorigin = ( ( maxx + minx ) / 2, ( maxy + miny ) / 2, 0 );
        circleradiussq = 0;
        circleoriginz = 0;
        
        foreach ( user in var_86394cebdfe9c9a1 )
        {
            circleoriginz += user.origin[ 2 ];
            distancefromcentersq = distance2dsquared( circleorigin, user.origin );
            
            if ( distancefromcentersq > circleradiussq )
            {
                circleradiussq = distancefromcentersq;
            }
        }
        
        circleoriginz /= var_86394cebdfe9c9a1.size;
        circleorigin += ( 0, 0, circleoriginz );
        circleradius = sqrt( circleradiussq ) + 24;
    }
    
    repulsorname = function_562beb2c3d9ef8e2( interactionid );
    destroynavrepulsor( repulsorname );
    createnavrepulsor( repulsorname, -1, circleorigin, circleradius, 0, "all" );
    thread function_b5b810a40f914e06();
}

// Namespace interaction_common
// Params 1, eflags: 0x4
// Checksum 0xbec26988, Offset: 0x20cc
// Size: 0x2f1
function private createinteractionnavobstacle( interactionid )
{
    bsequsers = getbsequsers( interactionid );
    
    if ( bsequsers.size == 0 )
    {
        return;
    }
    
    var_86394cebdfe9c9a1 = [];
    
    foreach ( bsequser in bsequsers )
    {
        if ( bsequser._blackboard.bseqinplace )
        {
            var_86394cebdfe9c9a1[ var_86394cebdfe9c9a1.size ] = bsequser;
        }
    }
    
    if ( var_86394cebdfe9c9a1.size <= 1 )
    {
        return;
    }
    
    obstacleorigin = ( 0, 0, 0 );
    obstacleangle = ( 0, 0, 0 );
    var_8e37c62c6e25e49e = 0;
    var_8e37c72c6e25e6d1 = 0;
    userhalfsize = 7;
    
    if ( var_86394cebdfe9c9a1.size == 2 )
    {
        obstacleorigin = ( var_86394cebdfe9c9a1[ 0 ].origin + var_86394cebdfe9c9a1[ 1 ].origin ) / 2;
        userdiff = var_86394cebdfe9c9a1[ 1 ].origin - var_86394cebdfe9c9a1[ 0 ].origin;
        obstacleangle = vectortoangles( userdiff );
        var_8e37c72c6e25e6d1 = userhalfsize;
        var_8e37c62c6e25e49e = length( userdiff ) / 2 + userhalfsize;
    }
    else if ( var_86394cebdfe9c9a1.size > 2 )
    {
        minx = var_86394cebdfe9c9a1[ 0 ].origin[ 0 ];
        maxx = var_86394cebdfe9c9a1[ 0 ].origin[ 0 ];
        miny = var_86394cebdfe9c9a1[ 0 ].origin[ 1 ];
        maxy = var_86394cebdfe9c9a1[ 0 ].origin[ 1 ];
        obstacleoriginz = 0;
        
        for ( bsequserindex = 1; bsequserindex < var_86394cebdfe9c9a1.size ; bsequserindex++ )
        {
            obstacleoriginz += var_86394cebdfe9c9a1[ bsequserindex ].origin[ 2 ];
            bsequserorigin = var_86394cebdfe9c9a1[ bsequserindex ].origin;
            
            if ( bsequserorigin[ 0 ] < minx )
            {
                minx = bsequserorigin[ 0 ];
            }
            else if ( bsequserorigin[ 0 ] > maxx )
            {
                maxx = bsequserorigin[ 0 ];
            }
            
            if ( bsequserorigin[ 1 ] < miny )
            {
                miny = bsequserorigin[ 1 ];
                continue;
            }
            
            if ( bsequserorigin[ 1 ] > maxy )
            {
                maxy = bsequserorigin[ 1 ];
            }
        }
        
        obstacleoriginz /= var_86394cebdfe9c9a1.size;
        obstacleorigin = ( ( maxx + minx ) / 2, ( maxy + miny ) / 2, obstacleoriginz );
        var_8e37c62c6e25e49e = ( maxx - minx ) / 2 + userhalfsize;
        var_8e37c72c6e25e6d1 = ( maxy - miny ) / 2 + userhalfsize;
    }
    
    function_de2253ab2039ac7c( interactionid );
    bounds = ( var_8e37c62c6e25e49e, var_8e37c72c6e25e6d1, userhalfsize );
    self._blackboard.var_c6236bc6766c2c2 = createnavbadplacebybounds( obstacleorigin, bounds, obstacleangle, 5 );
    thread function_b5b810a40f914e06();
}

// Namespace interaction_common
// Params 4
// Checksum 0x17fe31c2, Offset: 0x23c5
// Size: 0x187, Type: bool
function function_a6d48b868d228471( asmname, statename, tostatename, params )
{
    reactyaw = 0;
    
    if ( !archetypehasstate( self.animsetname, tostatename ) )
    {
        return false;
    }
    
    if ( isdefined( self.var_dd6868ae78a8de98 ) )
    {
        delta = self.var_dd6868ae78a8de98 - self.origin;
        deltayaw = vectortoyaw( delta );
        reactyaw = self.angles[ 1 ] - deltayaw;
    }
    
    reactyaw = angleclamp180( reactyaw );
    directionindex = function_71a9f15871d4c043( reactyaw );
    alias = directionindex;
    animresult = archetypegetrandomalias( self.animsetname, tostatename, alias );
    
    if ( animresult )
    {
        return true;
    }
    
    if ( directionindex == 2 || directionindex == 8 )
    {
        doleft = 0;
        suffix = directionindex;
        
        if ( reactyaw < -120 && reactyaw > -180 )
        {
            doleft = 1;
        }
        
        alias = doleft ? suffix + "l" : suffix + "r";
        animresult = archetypegetrandomalias( self.animsetname, tostatename, alias );
        
        if ( !animresult )
        {
            doleft = !doleft;
            alias = doleft ? suffix + "l" : suffix + "r";
            animresult = archetypegetrandomalias( self.animsetname, tostatename, alias );
        }
        
        if ( animresult )
        {
            return true;
        }
        
        return false;
    }
    
    return false;
}

// Namespace interaction_common
// Params 3
// Checksum 0x91b5d221, Offset: 0x2555
// Size: 0x2e, Type: bool
function function_286d9284164cc9c5( asmname, statename, params )
{
    if ( self.var_286d9284164cc9c5 )
    {
        return true;
    }
    
    return false;
}

// Namespace interaction_common
// Params 1
// Checksum 0x131878b9, Offset: 0x258c
// Size: 0x5a
function function_71a9f15871d4c043( angle )
{
    angle = angleclamp180( angle );
    
    if ( angle > 120 || angle < -120 )
    {
        index = 2;
    }
    else if ( angle < -30 )
    {
        index = 4;
    }
    else if ( angle > 30 )
    {
        index = 6;
    }
    else
    {
        index = 8;
    }
    
    return index;
}

// Namespace interaction_common
// Params 2
// Checksum 0x3060a24b, Offset: 0x25ef
// Size: 0xaf
function function_4bb4e69fc697b378( statename, params )
{
    newstate = "custom_patrol_lookaround_passthrough";
    
    if ( !isdefined( params[ 0 ] ) )
    {
        newstate = "stl_react_passthrough";
        
        if ( !isdefined( self.var_6002aa8166897fd7 ) )
        {
            if ( isdefined( self.var_8bb2da6a6aef303 ) )
            {
                self.var_6002aa8166897fd7 = self.var_8bb2da6a6aef303;
            }
            else
            {
                self.var_6002aa8166897fd7 = "med";
            }
        }
    }
    
    if ( self asmhasstate( self.asmname, newstate ) )
    {
        assert( self asmhasstate( self.asmname, newstate ) );
        self asmsetstate( self.asmname, newstate );
    }
}

// Namespace interaction_common
// Params 2
// Checksum 0x675b77ad, Offset: 0x26a6
// Size: 0x88
function function_245a8ceff5a9a894( statename, param )
{
    scriptlinkname = self function_13445ee74cf145d4();
    
    if ( isdefined( scriptlinkname ) )
    {
        scriptmodel = getent( scriptlinkname, #script_linkname );
        id = self getinteractionid();
        
        if ( isdefined( scriptmodel ) )
        {
            scriptmodel function_188718242ae3c942( id );
            return;
        }
        
        scriptable = getentitylessscriptablearray( scriptlinkname, #script_linkname );
        scriptable[ 0 ] function_efa6f9f9ab8d2157( id );
    }
}

// Namespace interaction_common
// Params 2
// Checksum 0xa874550c, Offset: 0x2736
// Size: 0x4f
function setupscriptmodel( statename, param )
{
    if ( self isscriptableinstance() )
    {
        return;
    }
    
    self.animname = "script_model";
    self useanimtree( level.scr_animtree[ self.animname ] );
    self.var_e2d942184cb56c33 = 0;
}

// Namespace interaction_common
// Params 2
// Checksum 0xa6bdbd08, Offset: 0x278d
// Size: 0x3b
function setupscriptable( statename, param )
{
    if ( !self isscriptableinstance() )
    {
        return;
    }
    
    self.partname = self function_1102885d01e4b19b();
    self.endstatename = self function_b20ed534a5f3a9c0();
}

// Namespace interaction_common
// Params 2
// Checksum 0x56981ba7, Offset: 0x27d0
// Size: 0x53
function cleanupscriptmodel( statename, param )
{
    if ( self isscriptableinstance() )
    {
        return;
    }
    
    self stopanimscripted();
    self unlink();
    
    if ( !self.var_e2d942184cb56c33 )
    {
        self physicslaunchserver( self.origin, ( 0, 0, 0 ) );
    }
}

// Namespace interaction_common
// Params 2
// Checksum 0x50a2403e, Offset: 0x282b
// Size: 0x38
function cleanupscriptable( statename, param )
{
    if ( !self isscriptableinstance() )
    {
        return;
    }
    
    self setscriptablepartstate( self.partname, self.endstatename, 0 );
}

// Namespace interaction_common
// Params 2
// Checksum 0x98dfa2a5, Offset: 0x286b
// Size: 0x3a
function function_f9cec32b76c81972( statename, param )
{
    interactionscriptmodel = self function_90f71263a5ae4ecb();
    
    if ( isdefined( interactionscriptmodel ) )
    {
        interactionscriptmodel.var_e2d942184cb56c33 = 1;
    }
}

// Namespace interaction_common
// Params 2, eflags: 0x4
// Checksum 0xac33e7f7, Offset: 0x28ad
// Size: 0x4d
function private function_67f4eef6ba6c5c29( statename, animset )
{
    aliases = archetypegetaliases( animset, statename );
    
    if ( isdefined( aliases ) )
    {
        if ( aliases.size == 18 )
        {
            self.var_e0bc276499c18875 = 1;
            return;
        }
    }
    
    self.var_e0bc276499c18875 = 0;
}

// Namespace interaction_common
// Params 1, eflags: 0x4
// Checksum 0x76a15bc1, Offset: 0x2902
// Size: 0x15f
function private function_c3d7c7c36e9eeb93( phasename )
{
    userhalfsize = 5;
    
    if ( phasename == "single_loop" || phasename == "looping" )
    {
        if ( !isdefined( self._blackboard.var_627cb979706023d4 ) )
        {
            if ( level.var_bbff6df6ad9df430 )
            {
                bounds = ( userhalfsize, userhalfsize, userhalfsize );
                self._blackboard.var_627cb979706023d4 = createnavbadplacebybounds( self.origin, bounds, self.angles, 5 );
            }
            else
            {
                interactionid = self getinteractionid();
                self._blackboard.var_627cb979706023d4 = "solo_interaction_" + interactionid;
                createnavrepulsor( self._blackboard.var_627cb979706023d4, -1, self, undefined, undefined, "allies", "neutral", "axis" );
            }
            
            thread function_b5b810a40f914e06();
        }
        
        return;
    }
    
    if ( isdefined( self._blackboard.var_627cb979706023d4 ) )
    {
        if ( level.var_bbff6df6ad9df430 )
        {
            destroynavobstacle( self._blackboard.var_627cb979706023d4 );
        }
        else
        {
            destroynavrepulsor( self._blackboard.var_627cb979706023d4 );
        }
        
        self._blackboard.var_627cb979706023d4 = undefined;
    }
}

// Namespace interaction_common
// Params 0, eflags: 0xc
// Checksum 0x87a4f297, Offset: 0x2a69
// Size: 0xdf
function private function_b5b810a40f914e06()
{
    self notify( #"hash_2a4cdd3b82a5d289" );
    self endon( #"hash_2a4cdd3b82a5d289" );
    level endon( #"game_ended" );
    self waittill( #"death" );
    
    if ( isdefined( self._blackboard.var_c6236bc6766c2c2 ) )
    {
        if ( level.var_bbff6df6ad9df430 )
        {
            destroynavobstacle( self._blackboard.var_c6236bc6766c2c2 );
        }
        else
        {
            destroynavrepulsor( self._blackboard.var_c6236bc6766c2c2 );
        }
    }
    
    if ( isdefined( self._blackboard.var_627cb979706023d4 ) )
    {
        if ( level.var_bbff6df6ad9df430 )
        {
            destroynavobstacle( self._blackboard.var_627cb979706023d4 );
            return;
        }
        
        destroynavrepulsor( self._blackboard.var_627cb979706023d4 );
    }
}

// Namespace interaction_common
// Params 4
// Checksum 0x8ab15db6, Offset: 0x2b50
// Size: 0x30
function stealthisenabled( asmname, statename, tostatename, params )
{
    return self.stealth_enabled;
}

// Namespace interaction_common
// Params 2
// Checksum 0x41383ee, Offset: 0x2b89
// Size: 0x47
function function_ff3fb91b3d4e6197( statename, param )
{
    id = self getinteractionid();
    
    if ( isdefined( level.var_ea329ecfbda528dc[ id ] ) )
    {
        return self [[ level.var_ea329ecfbda528dc[ id ] ]]();
    }
    
    return 0;
}

// Namespace interaction_common
// Params 1
// Checksum 0x4a2e405b, Offset: 0x2bd9
// Size: 0x4d
function function_65677bdf595d0c10( skit )
{
    skitinfo = getaiinteractionscriptbundle( skit );
    
    if ( isdefined( skitinfo ) && skitinfo.interactionassetbundle != "" )
    {
        return getscriptbundle( skitinfo.interactionassetbundle );
    }
    
    return;
}

// Namespace interaction_common
// Params 0, eflags: 0x4
// Checksum 0x4bd35b19, Offset: 0x2c2e
// Size: 0x144
function private function_74c1da714488705c()
{
    if ( !isdefined( level.skitlist ) )
    {
        level.skitlist = [];
    }
    
    interactionid = self getinteractionid();
    skitname = function_80eb2badd88a772d( interactionid );
    skitfound = 0;
    skitindex = undefined;
    
    if ( level.skitlist.size > 0 )
    {
        for ( i = 0; i < level.skitlist.size ; i++ )
        {
            if ( level.skitlist[ i ].skitname == skitname )
            {
                skitindex = i;
                skitfound = 1;
                break;
            }
        }
    }
    
    if ( !skitfound )
    {
        skitindex = level.skitlist.size;
        level.skitlist[ level.skitlist.size ] = spawnstruct();
        level.skitlist[ skitindex ].skitname = skitname;
        level.skitlist[ skitindex ].designdata = function_65677bdf595d0c10( skitname );
    }
    
    skitinfo = level.skitlist[ skitindex ];
    function_7a66f7ad5b1e4e2b( skitinfo );
    function_cc8bd33e9467ea51( skitinfo );
    function_d8af3dd60e0f9dd8( skitinfo );
    function_fd3432db2be7becf( skitinfo );
    return skitinfo;
}

// Namespace interaction_common
// Params 1, eflags: 0x4
// Checksum 0xa95cf51, Offset: 0x2d7b
// Size: 0xac
function private function_d8af3dd60e0f9dd8( skitinfo )
{
    self.var_9221857bb3db537a = skitinfo.designdata.interaction_designdata.disablecollision;
    self.var_fda053823240135f = skitinfo.designdata.interaction_designdata.var_c0f48b7e563e339b;
    self.var_14c834e9d5890f26 = skitinfo.designdata.interaction_designdata.var_fc417ba53b712766;
    self.var_ca126cc79643ebe7 = skitinfo.designdata.interaction_designdata.var_92038f0454243433;
}

// Namespace interaction_common
// Params 1, eflags: 0x4
// Checksum 0x6a8685d9, Offset: 0x2e2f
// Size: 0x6e
function private function_cc8bd33e9467ea51( skitinfo )
{
    if ( isdefined( skitinfo.designdata.interaction_designdata.var_35289731ad3e1f9f ) )
    {
        self.var_4f2af3a3297f77a3 = skitinfo.designdata.interaction_designdata.var_35289731ad3e1f9f;
        
        if ( self.var_4f2af3a3297f77a3 )
        {
            self.var_88af750d8cd349c1 = 1;
        }
    }
}

// Namespace interaction_common
// Params 1, eflags: 0x4
// Checksum 0xada8c25d, Offset: 0x2ea5
// Size: 0x17a
function private function_7a66f7ad5b1e4e2b( skitinfo )
{
    if ( isdefined( skitinfo.designdata.interaction_designdata.sightconfig ) )
    {
        self.var_56f4e62552a79fe7 = 1;
        self.var_2e193c17d5de0ad5 = skitinfo.designdata.interaction_designdata.sightconfig;
        self.var_3e167603fbee66b4 = skitinfo.designdata.interaction_designdata.var_2f766e8b86557248;
        self.var_cc855622aeaa2420 = skitinfo.designdata.interaction_designdata.var_71b6a29997a37897 == "" ? undefined : skitinfo.designdata.interaction_designdata.var_71b6a29997a37897;
        self.var_1a0d19442eb7c4c1 = skitinfo.designdata.interaction_designdata.var_9f9ec768a850f92 == "" ? undefined : skitinfo.designdata.interaction_designdata.var_9f9ec768a850f92;
        self.var_f51597b9c53acf08 = self getsightconfigtemplateoverride();
    }
    else
    {
        self.var_56f4e62552a79fe7 = 0;
    }
    
    if ( skitinfo.designdata.interaction_designdata.var_d4da0a58a936a837 )
    {
        self.var_5d4829c8b859716f = 1;
    }
}

// Namespace interaction_common
// Params 0, eflags: 0x4
// Checksum 0x86e8f4cb, Offset: 0x3027
// Size: 0x1c
function private function_91053ba261a3aefc()
{
    if ( self.var_fda053823240135f )
    {
        thread function_1f94d499721f7add();
        thread function_4fe3adfc69187fba();
    }
}

// Namespace interaction_common
// Params 1, eflags: 0x4
// Checksum 0xb3b33a1b, Offset: 0x304b
// Size: 0x6f
function private function_fd3432db2be7becf( skitinfo )
{
    self.var_286d9284164cc9c5 = skitinfo.designdata.interaction_designdata.canmove;
    self.var_74e6943ef6ad6db1 = skitinfo.designdata.interaction_designdata.disabletraversals;
    
    if ( self.var_74e6943ef6ad6db1 )
    {
        self enabletraversals( 0 );
    }
}

// Namespace interaction_common
// Params 0, eflags: 0xc
// Checksum 0x8565df90, Offset: 0x30c2
// Size: 0x8f
function private function_744cbf36477daa5b()
{
    self notify( #"hash_70d18e909a7b5e96" );
    self endon( #"hash_70d18e909a7b5e96" );
    self endon( #"death" );
    waitstrings = [ "game_ended", "clear_skit_designdata", "cap_exit_completed", "cleared_sight_config" ];
    
    for ( i = 0; i < waitstrings.size ; i++ )
    {
        thread waittill_string( waitstrings[ i ] );
    }
    
    self waittill( #"hash_9c1cc117d32c1642" );
    function_88c7216b32d58113();
}

// Namespace interaction_common
// Params 2
// Checksum 0x2b8d2d0b, Offset: 0x3159
// Size: 0xf4
function function_fc05e3b2b222ba78( statename, params )
{
    skitid = self.var_47b8cd06c0de3934;
    
    if ( !isarray( params ) )
    {
        params = [ params ];
    }
    
    foreach ( val in params )
    {
        if ( arraycontains( self.skitvars[ skitid ].var_89e39ca8d7769234, val ) )
        {
            self.skitvars[ skitid ].var_89e39ca8d7769234 = arrayremove( self.skitvars[ skitid ].var_89e39ca8d7769234, val );
        }
    }
}

// Namespace interaction_common
// Params 2
// Checksum 0xedb4d2fe, Offset: 0x3255
// Size: 0x94
function skit_setvalue( statename, params )
{
    skitid = self.var_47b8cd06c0de3934;
    
    if ( !isarray( params ) )
    {
        params = [ params ];
    }
    
    for ( i = 0; i < params.size ; i++ )
    {
        val = params[ i ];
        self.skitvars[ skitid ].var_89e39ca8d7769234[ self.skitvars[ skitid ].var_89e39ca8d7769234.size ] = val;
    }
}

// Namespace interaction_common
// Params 2
// Checksum 0xe02c6c61, Offset: 0x32f1
// Size: 0xd3
function skit_checkvalue( statename, params )
{
    skitid = self.var_47b8cd06c0de3934;
    valfound = 0;
    
    if ( !isarray( params ) )
    {
        params = [ params ];
    }
    
    foreach ( val in params )
    {
        if ( arraycontains( self.skitvars[ skitid ].var_89e39ca8d7769234, val ) )
        {
            valfound = 1;
        }
    }
    
    return valfound;
}

// Namespace interaction_common
// Params 1
// Checksum 0x385d8728, Offset: 0x33cd
// Size: 0x36
function waittill_string( string )
{
    self endon( #"hash_9c1cc117d32c1642" );
    self endon( #"death" );
    self waittill( string );
    self notify( #"hash_9c1cc117d32c1642" );
}

// Namespace interaction_common
// Params 0, eflags: 0xc
// Checksum 0xe35836fb, Offset: 0x340b
// Size: 0xb4
function private function_1f94d499721f7add()
{
    self notify( #"hash_993ac3956acf9834" );
    self endon( #"hash_993ac3956acf9834" );
    self endon( #"death" );
    self endon( #"death_or_disconnect" );
    self endon( #"game_ended" );
    self endon( #"clear_skit_designdata" );
    self endon( #"cap_exit_completed" );
    
    while ( true )
    {
        if ( isdefined( self.var_14c834e9d5890f26 ) && self.var_14c834e9d5890f26 != "" )
        {
            self waittill( self.var_14c834e9d5890f26 );
        }
        else
        {
            self waittill( #"hash_2e2ae6edf0e0febf" );
        }
        
        updatecollision( undefined, "enable" );
        self notify( #"hash_badeab1835bb5f25" );
    }
}

// Namespace interaction_common
// Params 0, eflags: 0xc
// Checksum 0x3f2f2380, Offset: 0x34c7
// Size: 0xb4
function private function_4fe3adfc69187fba()
{
    self notify( #"hash_3a620784632665cb" );
    self endon( #"hash_3a620784632665cb" );
    self endon( #"death" );
    self endon( #"death_or_disconnect" );
    self endon( #"game_ended" );
    self endon( #"clear_skit_designdata" );
    self endon( #"cap_exit_completed" );
    
    while ( true )
    {
        if ( isdefined( self.var_ca126cc79643ebe7 ) && self.var_ca126cc79643ebe7 != "" )
        {
            self waittill( self.var_ca126cc79643ebe7 );
        }
        else
        {
            self waittill( #"hash_a1042b1cc227c75e" );
        }
        
        updatecollision( undefined, "disable" );
        self notify( #"hash_92537a6cc3d49a0e" );
    }
}

// Namespace interaction_common
// Params 0, eflags: 0xc
// Checksum 0x4366df4e, Offset: 0x3583
// Size: 0x93
function private function_61857cad428ddd0f()
{
    self notify( #"hash_c7c8d32d1978f73b" );
    self endon( #"hash_c7c8d32d1978f73b" );
    self endon( #"cleared_sight_config" );
    self endon( #"death" );
    
    if ( !self.var_3e167603fbee66b4 )
    {
        thread function_38f8b447cf8ea7cc();
        return;
    }
    
    if ( isdefined( self.var_cc855622aeaa2420 ) && self.var_cc855622aeaa2420 != "" )
    {
        self waittill( self.var_cc855622aeaa2420 );
        thread function_38f8b447cf8ea7cc();
        return;
    }
    else
    {
        self waittill( #"applysight" );
    }
    
    thread function_38f8b447cf8ea7cc();
}

// Namespace interaction_common
// Params 0
// Checksum 0x13865ee0, Offset: 0x361e
// Size: 0x121
function function_38f8b447cf8ea7cc()
{
    self notify( #"hash_dca631375a2c2c40" );
    self endon( #"cleared_sight_config" );
    self endon( #"hash_dca631375a2c2c40" );
    self endon( #"death" );
    thread function_744cbf36477daa5b();
    var_17f4877ddc6f0be8 = 0;
    
    if ( self.var_c92a7956029e02a5 && self.var_c92a7956029e02a5 != self getsightconfigtemplateoverride() )
    {
        var_17f4877ddc6f0be8 = 1;
    }
    
    if ( isdefined( self.var_2e193c17d5de0ad5 ) && self.var_2e193c17d5de0ad5 != #"" && ( !var_17f4877ddc6f0be8 || self.var_2e193c17d5de0ad5 == "sightless" ) )
    {
        self setsightconfigtemplateoverride( self.var_2e193c17d5de0ad5 );
        self.var_56f4e62552a79fe7 = 1;
    }
    else
    {
        self.var_56f4e62552a79fe7 = 0;
        return;
    }
    
    if ( !self.var_3e167603fbee66b4 )
    {
        return;
    }
    
    if ( isdefined( self.var_1a0d19442eb7c4c1 ) && self.var_1a0d19442eb7c4c1 != "" )
    {
        self waittill( self.var_1a0d19442eb7c4c1 );
    }
    else
    {
        self waittill( #"clearsight" );
    }
    
    function_88c7216b32d58113();
}

// Namespace interaction_common
// Params 0
// Checksum 0xbc16b65d, Offset: 0x3747
// Size: 0x3d
function function_88c7216b32d58113()
{
    if ( self.var_56f4e62552a79fe7 )
    {
        self setsightconfigtemplateoverride( self.var_f51597b9c53acf08 );
    }
    
    self.var_2e193c17d5de0ad5 = undefined;
    self.var_56f4e62552a79fe7 = 0;
    self notify( #"cleared_sight_config" );
}

// Namespace interaction_common
// Params 2
// Checksum 0x27433c32, Offset: 0x378c
// Size: 0x17, Type: bool
function function_3d3f02fd7a5fbeab( statename, params )
{
    return true;
}

// Namespace interaction_common
// Params 1
// Checksum 0xc3380c0b, Offset: 0x37ac
// Size: 0x35, Type: bool
function function_9eb2dc936807b17a( ent )
{
    assert( isai( self ) );
    skitid = ent getinteractionid();
    
    if ( isdefined( skitid ) )
    {
        return true;
    }
    
    return false;
}

// Namespace interaction_common
// Params 1
// Checksum 0x1f7b55ce, Offset: 0x37ea
// Size: 0x47
function function_60f1e301b0c68bed( skit )
{
    id = skit;
    
    if ( isstring( skit ) )
    {
        id = getinteractionidfortargetname( skit );
    }
    
    user = getbsequsers( id );
    
    if ( user.size == 0 )
    {
        return 0;
    }
    
    return user;
}

// Namespace interaction_common
// Params 2
// Checksum 0x30747b4e, Offset: 0x383a
// Size: 0x20
function function_6c11755fd3d9f83d( skit, function )
{
    level thread function_e6f138d784c2d32a( skit, function );
}

// Namespace interaction_common
// Params 2, eflags: 0x4
// Checksum 0x783555dc, Offset: 0x3862
// Size: 0x78
function private function_e6f138d784c2d32a( skit, function )
{
    level endon( #"game_ended" );
    skitid = skit;
    
    if ( isstring( skit ) )
    {
        skitid = getinteractionidfortargetname( skit );
    }
    
    while ( true )
    {
        level waittill( #"hash_2c3976b23c85f2a1", id, user );
        
        if ( id == skitid )
        {
            [[ function ]]( user );
            return;
        }
        
        waitframe();
    }
}

// Namespace interaction_common
// Params 1
// Checksum 0xa1fe8580, Offset: 0x38e2
// Size: 0x65
function leaveskit( var_ef89f9968497f2ba )
{
    assert( isai( self ) );
    self leaveinteraction();
    
    if ( var_ef89f9968497f2ba )
    {
        self._blackboard.bseqphase = "end";
    }
    else
    {
        self._blackboard.bseqphase = "react";
    }
    
    self notify( #"clear_skit_designdata" );
}

// Namespace interaction_common
// Params 2
// Checksum 0xb6e8f4af, Offset: 0x394f
// Size: 0x1f
function function_509792c4021ac833( startfunction, skit )
{
    thread function_3b17088f679311c8( startfunction, skit );
}

// Namespace interaction_common
// Params 2, eflags: 0x4
// Checksum 0xb01de73b, Offset: 0x3976
// Size: 0x8a
function private function_3b17088f679311c8( startfunction, skit )
{
    self endon( #"death" );
    
    if ( isdefined( skit ) )
    {
        skitid = skit;
        
        if ( isstring( skit ) )
        {
            skitid = getinteractionidfortargetname( skit );
        }
        
        while ( true )
        {
            self waittill( #"interaction_started", id );
            
            if ( id == skitid )
            {
                [[ startfunction ]]();
                break;
            }
            
            waitframe();
        }
        
        return;
    }
    
    self waittill( #"interaction_started" );
    [[ startfunction ]]();
}

// Namespace interaction_common
// Params 2
// Checksum 0xd13b0837, Offset: 0x3a08
// Size: 0x1f
function function_f305b6c589bc702a( endfunction, skit )
{
    thread function_424dcfcc5c62676d( endfunction, skit );
}

// Namespace interaction_common
// Params 2, eflags: 0x4
// Checksum 0x1e01addc, Offset: 0x3a2f
// Size: 0x88
function private function_424dcfcc5c62676d( endfunction, skit )
{
    self endon( #"death" );
    
    if ( isdefined( skit ) )
    {
        skitid = skit;
        
        if ( isstring( skit ) )
        {
            skitid = getinteractionidfortargetname( skit );
        }
        
        while ( true )
        {
            self waittill( #"interaction_ended", id );
            
            if ( id == skitid )
            {
                [[ endfunction ]]();
                return;
            }
            
            waitframe();
        }
        
        return;
    }
    
    self waittill( #"interaction_ended" );
    [[ endfunction ]]();
}

// Namespace interaction_common
// Params 3
// Checksum 0x344dac4a, Offset: 0x3abf
// Size: 0x4b
function function_c75f85a96a10a251( skit, function, userdata )
{
    skitid = skit;
    
    if ( isstring( skit ) )
    {
        skitid = getinteractionidfortargetname( skit );
    }
    
    level.var_ea329ecfbda528dc[ skitid ] = function;
}

// Namespace interaction_common
// Params 1
// Checksum 0xe94065cd, Offset: 0x3b12
// Size: 0x5e
function function_81357cba41e3a886( interactionid )
{
    if ( !isdefined( interactionid ) || !function_e0737745ca681ec7( interactionid ) )
    {
        return;
    }
    
    if ( !isdefined( level.var_c7c3dd285a0dccc9 ) )
    {
        level.var_c7c3dd285a0dccc9 = [];
    }
    
    if ( level.var_c7c3dd285a0dccc9[ interactionid ] )
    {
        return;
    }
    
    level.var_c7c3dd285a0dccc9[ interactionid ] = 1;
    level thread function_20f3817c6d8c01d3( interactionid );
}

// Namespace interaction_common
// Params 1, eflags: 0x4
// Checksum 0x5590da63, Offset: 0x3b78
// Size: 0x47
function private function_20f3817c6d8c01d3( interactionid )
{
    level endon( #"game_ended" );
    
    while ( function_e0737745ca681ec7( interactionid ) )
    {
        if ( getbsequsers( interactionid ).size == 0 )
        {
            despawninteraction( interactionid );
            break;
        }
        
        waitframe();
    }
    
    level.var_c7c3dd285a0dccc9[ interactionid ] = undefined;
}

// Namespace interaction_common
// Params 1
// Checksum 0xae375633, Offset: 0x3bc7
// Size: 0x75
function function_634eb2b5c9b9484f( planname )
{
    squadid = function_8398629a6c526ce3( self ) ?? "noPlanId";
    
    if ( !isint( squadid ) )
    {
        println( "<dev string:x15a>" );
        return;
    }
    
    if ( utility::issharedfuncdefined( #"aiplanner", #"hash_75beb6489f29aa4e", 0 ) )
    {
        utility::callsharedfunc( #"aiplanner", #"hash_75beb6489f29aa4e", planname, squadid );
    }
}

// Namespace interaction_common
// Params 1
// Checksum 0xcd5f94b4, Offset: 0x3c44
// Size: 0x59
function function_57780e4dc66759bb( skitname )
{
    nearbyskits = function_24e9e867df213b84( skitname, "information_tag", self.origin );
    
    if ( nearbyskits.size > 0 )
    {
        skit = nearbyskits[ 0 ];
        self function_895b16b8fcd857ba( skit );
        return;
    }
    
    println( "<dev string:x1a2>" );
}

// Namespace interaction_common
// Params 1
// Checksum 0xd0a3f30b, Offset: 0x3ca5
// Size: 0x4b
function function_3ab78ff54084fa1e( skitname )
{
    skits = getinteractionidsfortargetname( skitname );
    
    if ( skits.size > 0 )
    {
        skit = skits[ 0 ];
        self function_895b16b8fcd857ba( skit );
        return;
    }
    
    println( "<dev string:x201>" );
}

// Namespace interaction_common
// Params 1
// Checksum 0x2106174c, Offset: 0x3cf8
// Size: 0x47
function function_db31d7c8e2a192e1( skitname )
{
    loc = self.origin;
    skitid = spawninteraction( skitname, loc, ( 0, 0, 0 ) );
    self function_895b16b8fcd857ba( skitid );
}

// Namespace interaction_common
// Params 1
// Checksum 0x5dc49e05, Offset: 0x3d47
// Size: 0xc
function function_2f6ac664c6d76a89( sequencestep )
{
    
}

