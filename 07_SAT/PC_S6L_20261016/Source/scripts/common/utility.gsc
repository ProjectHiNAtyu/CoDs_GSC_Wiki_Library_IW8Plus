// scripts\common\utility.gsc  (hash_692b19b8e5f8f9e8.gscc) (size: 191827 Bytes / 0x2ed53 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xbca72e71 (3165073009)
// size ...... 191827 (0x2ed53)
// includes .. 18  (offset: 0x2cf23)
// strings ... 247 (offset: 0x2cfb3)
// dev strs .. 264 (offset: 0x2dfcf)
// exports ... 760 (offset: 0x1e7cb)
// cseg ...... 0x12a3 + 0x1d528 (0x1e7cb)
// imports ... 770 (offset: 0x25e8b)
// animtree1 . 0   (offset: 0x2ed53)
// animtree2 . 0   (offset: 0x2ed53)
#using scripts\anim\shared;
#using scripts\asm\asm_bb;
#using scripts\common\anim;
#using scripts\common\callbacks;
#using scripts\common\createfx;
#using scripts\common\devgui;
#using scripts\common\dof;
#using scripts\common\exploder;
#using scripts\common\flags;
#using scripts\common\math;
#using scripts\common\trace;
#using scripts\common\ui;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\common\vehicle;
#using scripts\common\vehicle_code;
#using scripts\common\vehicle_paths;
#using scripts\common\weapon;

#namespace utility;

// Namespace utility
// Params 3
// Checksum 0x7aeecf9, Offset: 0x12c1
// Size: 0x9c, Type: bool
function issharedfuncdefined( category, funcname, shouldassert )
{
    if ( isstring( category ) )
    {
        category = getxhash( category );
    }
    
    func = level.sharedfuncs[ category ][ funcname ];
    
    if ( !isdefined( func ) )
    {
        /#
            if ( shouldassert )
            {
                if ( isstring( funcname ) )
                {
                    assertmsg( "<dev string:x24>" + funcname + "<dev string:x2e>" );
                }
                
                assertmsg( getxhashsourcename( category ) + "<dev string:x45>" + getxhashsourcename( funcname ) + "<dev string:x48>" );
            }
        #/
        
        return false;
    }
    
    return true;
}

// Namespace utility
// Params 0
// Checksum 0xbd1249fd, Offset: 0x1366
// Size: 0x86
function issp()
{
    if ( !isdefined( level.issp ) )
    {
        mapname = getdvar( @"g_mapname" );
        substring = "";
        
        for ( i = 0; i < min( mapname.size, 3 ) ; i++ )
        {
            substring += mapname[ i ];
        }
        
        level.issp = substring != "mp_" && substring != "zm_";
    }
    
    return level.issp;
}

// Namespace utility
// Params 1
// Checksum 0x510c5565, Offset: 0x13f5
// Size: 0x2a, Type: bool
function ismeatshielddamage( meansofdeath )
{
    if ( !isdefined( meansofdeath ) )
    {
        assertmsg( "<dev string:x68>" );
        return false;
    }
    
    return meansofdeath == "MOD_MEATSHIELD";
}

// Namespace utility
// Params 1
// Checksum 0x38ab2bd0, Offset: 0x1428
// Size: 0x2a, Type: bool
function ismeleedamage( meansofdeath )
{
    if ( !isdefined( meansofdeath ) )
    {
        assertmsg( "<dev string:x68>" );
        return false;
    }
    
    return meansofdeath == "MOD_MELEE";
}

// Namespace utility
// Params 0
// Checksum 0xa2680c9, Offset: 0x145b
// Size: 0x3c, Type: bool
function ismp()
{
    return isstartstr( getdvar( @"g_mapname" ), "mp_" ) || isdefined( level.mapname ) && isstartstr( level.mapname, "mp_" );
}

// Namespace utility
// Params 0
// Checksum 0x6ca36886, Offset: 0x14a0
// Size: 0x3c, Type: bool
function iszm()
{
    return isstartstr( getdvar( @"g_mapname" ), "zm_" ) || isdefined( level.mapname ) && isstartstr( level.mapname, "zm_" );
}

// Namespace utility
// Params 1
// Checksum 0x53f47f4c, Offset: 0x14e5
// Size: 0x26, Type: bool
function is_moving_platform_ent( ent )
{
    if ( level.var_222eeb7fbf311452[ ent getentitynumber() ] === ent )
    {
        return true;
    }
    
    return false;
}

// Namespace utility
// Params 1
// Checksum 0x8a55ce44, Offset: 0x1514
// Size: 0x40
function register_moving_platform_ent( ent )
{
    if ( !isent( ent ) )
    {
        return;
    }
    
    if ( !isdefined( level.var_222eeb7fbf311452 ) )
    {
        level.var_222eeb7fbf311452 = [];
    }
    
    level.var_222eeb7fbf311452[ ent getentitynumber() ] = ent;
}

// Namespace utility
// Params 1
// Checksum 0xd205dfaa, Offset: 0x155c
// Size: 0x59
function function_d0758bbb62e77367( var_8f466242edfed9cd )
{
    level.var_b71007f65426e929 = 1;
    
    if ( !isdefined( var_8f466242edfed9cd ) )
    {
        var_8f466242edfed9cd = 0;
    }
    
    if ( !var_8f466242edfed9cd )
    {
        if ( issp() )
        {
            level.player function_5b48eb5bc6ce8669( 1 );
            return;
        }
        
        level callback::add( #"player_connect", &function_a416e8fa7c98708a );
    }
}

// Namespace utility
// Params 1, eflags: 0x4
// Checksum 0x67784cad, Offset: 0x15bd
// Size: 0x24
function private function_a416e8fa7c98708a( params )
{
    player = self;
    player function_5b48eb5bc6ce8669( 1 );
}

// Namespace utility
// Params 1
// Checksum 0xee96e3df, Offset: 0x15e9
// Size: 0x20
function function_5b48eb5bc6ce8669( bool = 1 )
{
    self.iscold = bool;
}

// Namespace utility
// Params 4
// Checksum 0xcc506ef2, Offset: 0x1611
// Size: 0x34b
function make_weapon_model( basename, attachments = [], viewmodel = 0, precache )
{
    if ( isdefined( level.fnbuildweaponspecial ) && isdefined( [[ level.fnbuildweaponspecial ]]( basename ) ) )
    {
        weapon = [[ level.fnbuildweaponspecial ]]( basename );
    }
    else
    {
        weapon = [[ level.fnbuildweapon ]]( basename, attachments );
    }
    
    if ( isent( self ) && !isdefined( precache ) )
    {
        self setmodel( getweaponmodel( weapon ) );
    }
    
    attachmentmodels = getweaponattachmentworldmodels( weapon );
    
    foreach ( model in attachmentmodels )
    {
        if ( viewmodel )
        {
            array = strtok( model, "_" );
            
            foreach ( i, tok in array )
            {
                if ( i == 0 )
                {
                    model = tok;
                    continue;
                }
                
                if ( tok == "wm" )
                {
                    model += "_vm";
                    continue;
                }
                
                model = model + "_" + tok;
            }
        }
        
        if ( precache )
        {
            precachemodel( model );
            continue;
        }
        
        self attach( model );
    }
    
    if ( !precache )
    {
        switch ( basename )
        {
            case #"hash_bf2d3ffce9ef56d1":
                self hidepart( "j_b_loader" );
                self hidepart( "j_b_loader_01" );
                self hidepart( "j_b_loader_02" );
                self hidepart( "j_b_loader_03" );
                self hidepart( "j_b_loader_04" );
                self hidepart( "j_b_loader_05" );
                self hidepart( "j_b_loader_06" );
                break;
            case #"hash_9703d13dcfc6b555":
                self hidepart( "j_shell" );
                self hidepart( "j_shell_fired" );
                break;
        }
        
        foreach ( model in attachmentmodels )
        {
            part = "tag_sight_on";
            
            if ( has_part( model, part ) )
            {
                if ( issubstr( model, "reflex" ) )
                {
                    self hidepart( part );
                    continue;
                }
                
                if ( issubstr( model, "holo" ) )
                {
                    self hidepart( part );
                    continue;
                }
                
                if ( issubstr( model, "acog" ) )
                {
                    self hidepart( part );
                    continue;
                }
                
                if ( issubstr( model, "scope" ) )
                {
                    self hidepart( part );
                }
            }
        }
    }
}

// Namespace utility
// Params 2, eflags: 0x4
// Checksum 0x6746dafa, Offset: 0x1964
// Size: 0x50, Type: bool
function private has_part( model, part )
{
    numparts = getnumparts( model );
    
    for ( i = 0; i < numparts ; i++ )
    {
        if ( part == getpartname( model, i ) )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace utility
// Params 5
// Checksum 0xed860b53, Offset: 0x19bd
// Size: 0x3c0
function make_weapon_and_attach( basename, attachments, tagname, viewmodel, precache )
{
    if ( !precache )
    {
        isvalid = 0;
        
        if ( isent( self ) || isai( self ) )
        {
            isvalid = 1;
        }
        
        assert( isvalid, "<dev string:x8c>" );
    }
    
    if ( !isdefined( attachments ) )
    {
        attachments = [];
    }
    
    if ( !isdefined( viewmodel ) )
    {
        viewmodel = 0;
    }
    
    if ( isdefined( level.fnbuildweaponspecial ) && isdefined( [[ level.fnbuildweaponspecial ]]( basename ) ) )
    {
        weapon = [[ level.fnbuildweaponspecial ]]( basename );
    }
    else
    {
        weapon = [[ level.fnbuildweapon ]]( basename, attachments );
    }
    
    if ( !precache )
    {
        if ( isdefined( tagname ) )
        {
            self attach( getweaponmodel( basename ), tagname );
        }
        else
        {
            self attach( getweaponmodel( basename ) );
        }
    }
    
    self.attachedweaponmodels[ 0 ] = basename;
    attachmentmodels = getweaponattachmentworldmodels( weapon );
    lasermodelindex = undefined;
    var_ecce528020dacdb0 = undefined;
    
    for ( i = 0; i < attachmentmodels.size ; i++ )
    {
        if ( var_ecce528020dacdb0 )
        {
            model = attachmentmodels[ lasermodelindex ];
        }
        else
        {
            model = attachmentmodels[ i ];
        }
        
        if ( !isdefined( var_ecce528020dacdb0 ) && isstartstr( model, "att_wm_laser" ) )
        {
            lasermodelindex = i;
            continue;
        }
        
        if ( viewmodel )
        {
            array = strtok( model, "_" );
            
            foreach ( i, tok in array )
            {
                if ( i == 0 )
                {
                    model = tok;
                    continue;
                }
                
                if ( tok == "wm" )
                {
                    model += "_vm";
                    continue;
                }
                
                model = model + "_" + tok;
            }
        }
        
        if ( precache )
        {
            precachemodel( model );
        }
        else
        {
            self attach( model );
            self.attachedweaponmodels[ self.attachedweaponmodels.size ] = model;
        }
        
        if ( !isdefined( var_ecce528020dacdb0 ) && isdefined( lasermodelindex ) && i == attachmentmodels.size - 1 )
        {
            i -= 1;
            var_ecce528020dacdb0 = 1;
        }
    }
    
    if ( !precache )
    {
        switch ( basename )
        {
            case #"hash_bf2d3ffce9ef56d1":
                self hidepart( "j_b_loader" );
                self hidepart( "j_b_loader_01" );
                self hidepart( "j_b_loader_02" );
                self hidepart( "j_b_loader_03" );
                self hidepart( "j_b_loader_04" );
                self hidepart( "j_b_loader_05" );
                self hidepart( "j_b_loader_06" );
                break;
            case #"hash_9703d13dcfc6b555":
                self hidepart( "j_shell" );
                self hidepart( "j_shell_fired" );
                break;
        }
        
        foreach ( model in attachmentmodels )
        {
            part = "tag_sight_on";
            
            if ( has_part( model, part ) )
            {
                if ( issubstr( model, "reflex" ) )
                {
                    self hidepart( part );
                    continue;
                }
                
                if ( issubstr( model, "holo" ) )
                {
                    self hidepart( part );
                    continue;
                }
                
                if ( issubstr( model, "acog" ) )
                {
                    self hidepart( part );
                }
            }
        }
    }
}

// Namespace utility
// Params 5
// Checksum 0xc36363d9, Offset: 0x1d85
// Size: 0x46e
function make_weapon_random( weaponname, possibilities, attachment_combos, camos, randomizereticle )
{
    attachments = get_random_attachments( possibilities, attachment_combos );
    weapon = [[ level.fnbuildweapon ]]( weaponname, attachments );
    
    /#
        if ( getdvarint( @"hash_45281f93550798" ) )
        {
            if ( !isdefined( weapon ) )
            {
                complete_weapon = weaponname;
                
                foreach ( attachment in attachments )
                {
                    complete_weapon += "<dev string:xc8>" + attachment;
                }
                
                iprintlnbold( complete_weapon + "<dev string:xca>" );
                return [[ level.fnbuildweapon ]]( weaponname );
            }
            
            has_tag_clip = undefined;
            attachment_models = getweaponattachmentworldmodels( weapon );
            
            foreach ( attachment_model in attachment_models )
            {
                part_num = getnumparts( attachment_model );
                
                for ( i = 0; i < part_num ; i++ )
                {
                    if ( getpartname( attachment_model, i ) == "<dev string:xdb>" )
                    {
                        has_tag_clip = 1;
                        break;
                    }
                }
            }
            
            if ( !isdefined( has_tag_clip ) && !issubstr( weaponname, "<dev string:xe4>" ) && !issubstr( weaponname, "<dev string:xe9>" ) && !issubstr( weaponname, "<dev string:xee>" ) )
            {
                iprintlnbold( getcompleteweaponname( weapon ) + "<dev string:xf3>" );
            }
            
            var_ac46e6a0a5ae17d6 = 1;
            
            foreach ( possibility in possibilities )
            {
                probability_100 = 0;
                
                if ( isint( possibility[ 0 ] ) && possibility[ 0 ] == 100 )
                {
                    probability_100 = -1;
                }
                
                var_ac46e6a0a5ae17d6 *= possibility.size + probability_100;
            }
            
            println( "<dev string:x10b>" + weaponname + "<dev string:x117>" + var_ac46e6a0a5ae17d6 );
        }
    #/
    
    if ( camos.size > 0 && cointoss() )
    {
        weapon = weapon withcamo( camos[ randomint( camos.size ) ] );
    }
    
    if ( randomizereticle )
    {
        foreach ( attachment in attachments )
        {
            if ( isstartstr( attachment, "acog" ) )
            {
                weapon = weapon withreticle( randomint( 8 ) );
                continue;
            }
            
            if ( isstartstr( attachment, "hybrid_west" ) )
            {
                weapon = weapon withreticle( randomint( 8 ) );
                continue;
            }
            
            if ( isstartstr( attachment, "thermalsnpr" ) )
            {
                weapon = weapon withreticle( randomint( 8 ) );
                continue;
            }
            
            if ( isstartstr( attachment, "thermal" ) )
            {
                weapon = weapon withreticle( randomint( 8 ) );
                continue;
            }
            
            if ( isstartstr( attachment, "holo" ) )
            {
                weapon = weapon withreticle( randomint( 11 ) );
                continue;
            }
            
            if ( isstartstr( attachment, "reflex" ) )
            {
                weapon = weapon withreticle( randomint( 12 ) );
                continue;
            }
            
            if ( isstartstr( attachment, "minireddot" ) )
            {
                weapon = weapon withreticle( randomint( 10 ) );
                continue;
            }
            
            if ( isstartstr( attachment, "snprscope" ) )
            {
                weapon = weapon withreticle( randomint( 13 ) );
                continue;
            }
            
            if ( isstartstr( attachment, "vzscope" ) )
            {
                weapon = weapon withreticle( randomint( 13 ) );
            }
        }
    }
    
    return weapon;
}

// Namespace utility
// Params 2
// Checksum 0xae4f9e8c, Offset: 0x21fc
// Size: 0x2c5
function get_random_attachments( possibilities, attachment_combos )
{
    assert( isdefined( possibilities ), "<dev string:x127>" );
    
    if ( attachment_combos.size > 0 )
    {
        if ( possibilities.size < 1 )
        {
            return attachment_combos[ randomint( attachment_combos.size ) ];
        }
        
        if ( randomint( 4 ) == 0 )
        {
            return attachment_combos[ randomint( attachment_combos.size ) ];
        }
    }
    
    attachments = [];
    
    if ( possibilities.size < 1 )
    {
        return attachments;
    }
    
    foreach ( i, type in possibilities )
    {
        if ( isint( possibilities[ i ][ 0 ] ) )
        {
            if ( randomint( 100 ) < possibilities[ i ][ 0 ] )
            {
                if ( level.script == "nightwar" && i == "scopes" )
                {
                    newtype = [];
                    
                    foreach ( s, scope in type )
                    {
                        if ( !issubstr( type[ s ], "therm" ) && !issubstr( type[ s ], "nvg" ) )
                        {
                            newtype[ newtype.size ] = scope;
                        }
                    }
                    
                    type = newtype;
                }
                
                if ( type.size > 1 )
                {
                    attachments[ attachments.size ] = type[ randomint( type.size - 1 ) + 1 ];
                }
            }
            
            continue;
        }
        
        return attachments;
    }
    
    ub_entry = undefined;
    grip_entry = undefined;
    
    foreach ( i, attachment in attachments )
    {
        if ( isstartstr( attachment, "grip" ) )
        {
            grip_entry = i;
            continue;
        }
        
        if ( issubstr( attachment, "ub_" ) || issubstr( attachment, "glmini" ) )
        {
            ub_entry = i;
        }
    }
    
    if ( isdefined( ub_entry ) && isdefined( grip_entry ) )
    {
        if ( randomint( 3 ) == 0 )
        {
            attachments[ ub_entry ] = undefined;
            
            if ( isint( ub_entry ) )
            {
                function_cdc669dbc8ea2101( attachments );
            }
        }
        else
        {
            attachments[ grip_entry ] = undefined;
            
            if ( isint( grip_entry ) )
            {
                function_cdc669dbc8ea2101( attachments );
            }
        }
    }
    
    return attachments;
}

// Namespace utility
// Params 1
// Checksum 0x40660535, Offset: 0x24ca
// Size: 0xd7
function get_target_array( target = self.target )
{
    assert( isdefined( target ), "<dev string:x155>" );
    ents = getentarray( target, #targetname );
    
    if ( ents.size > 0 )
    {
        return ents;
    }
    
    if ( issp() )
    {
        ents = builtin [[ level.getnodearrayfunction ]]( target, #targetname );
        
        if ( ents.size > 0 )
        {
            return ents;
        }
    }
    
    if ( isdefined( level.struct_class_names ) )
    {
        ents = getstructarray( target, "targetname" );
        
        if ( ents.size > 0 )
        {
            return ents;
        }
    }
    
    ents = getvehiclenodearray( target, #targetname );
    
    if ( ents.size > 0 )
    {
        return ents;
    }
    
    assertmsg( "<dev string:x169>" + target + "<dev string:x17b>" );
}

// Namespace utility
// Params 1
// Checksum 0x5f16a944, Offset: 0x25a9
// Size: 0xe1
function get_target_ent( target = self.target )
{
    assert( isdefined( target ), "<dev string:x155>" );
    var_7237854e3be197ca = getent( target, #targetname );
    
    if ( isdefined( var_7237854e3be197ca ) )
    {
        return var_7237854e3be197ca;
    }
    
    if ( issp() )
    {
        var_7237854e3be197ca = builtin [[ level.getnodefunction ]]( target, "targetname" );
        
        if ( isdefined( var_7237854e3be197ca ) )
        {
            return var_7237854e3be197ca;
        }
        
        var_7237854e3be197ca = builtin [[ level.func[ "getspawner" ] ]]( target, "targetname" );
        
        if ( isdefined( var_7237854e3be197ca ) )
        {
            return var_7237854e3be197ca;
        }
    }
    
    var_7237854e3be197ca = getstruct( target, "targetname" );
    
    if ( isdefined( var_7237854e3be197ca ) )
    {
        return var_7237854e3be197ca;
    }
    
    var_7237854e3be197ca = getvehiclenode( target, #targetname );
    
    if ( isdefined( var_7237854e3be197ca ) )
    {
        return var_7237854e3be197ca;
    }
    
    assertmsg( "<dev string:x169>" + target + "<dev string:x194>" );
}

// Namespace utility
// Params 3
// Checksum 0x74de4f22, Offset: 0x2692
// Size: 0xc0
function function_6827a4ce28e62b74( org, array, maxdist )
{
    maxdistsquared = maxdist * maxdist;
    finalarray = [];
    
    foreach ( ent in array )
    {
        if ( distance2dsquared( org, ent.origin ) < maxdistsquared )
        {
            finalarray[ finalarray.size ] = ent;
        }
    }
    
    return finalarray;
}

// Namespace utility
// Params 2
// Checksum 0x49edc4b6, Offset: 0x275b
// Size: 0x28
function function_b720276ae54a4d70( value, message )
{
    if ( !isdefined( value ) )
    {
        assertmsg( message );
    }
    
    return value;
}

// Namespace utility
// Params 2
// Checksum 0x8f607284, Offset: 0x278c
// Size: 0x311
function get_weapon_weighted( weapons, definedprobabilities )
{
    probabilities = [];
    keys = getarraykeys( definedprobabilities );
    
    foreach ( i, weapon in weapons )
    {
        index = function_f02c63b99c9614c9( keys, weapon );
        
        if ( isdefined( index ) )
        {
            probabilities[ probabilities.size ] = definedprobabilities[ keys[ index ] ];
            continue;
        }
        
        probabilities[ probabilities.size ] = 0;
    }
    
    probability_total = 0;
    
    foreach ( probability in probabilities )
    {
        probability_total += probability;
    }
    
    /#
        if ( probability_total > 100 )
        {
            println( "<dev string:x1ac>" + probability_total );
        }
    #/
    
    if ( probability_total < 100 )
    {
        remaining = 100 - probability_total;
        empty_entries = 0;
        
        foreach ( probability in probabilities )
        {
            if ( probability == 0 )
            {
                empty_entries += 1;
            }
        }
        
        if ( empty_entries > 0 )
        {
            split_probability = remaining / empty_entries;
            
            foreach ( i, probability in probabilities )
            {
                if ( probability == 0 )
                {
                    probabilities[ i ] = split_probability;
                }
            }
        }
    }
    
    diceroll = randomint( 100 );
    
    foreach ( i, probability in probabilities )
    {
        if ( i > 0 )
        {
            probabilities[ i ] = probability + probabilities[ i - 1 ];
        }
        
        if ( diceroll < probabilities[ i ] )
        {
            return weapons[ i ];
        }
    }
    
    /#
        if ( getdvarint( @"hash_45281f93550798" ) )
        {
            if ( weapons.size > 1 )
            {
                println( "<dev string:x1e4>" );
            }
        }
    #/
    
    return weapons[ 0 ];
}

// Namespace utility
// Params 0
// Checksum 0x6b2de066, Offset: 0x2aa6
// Size: 0x32, Type: bool
function shouldskipfirstraise()
{
    if ( !isdefined( level.skipfirstraise ) )
    {
        level.skipfirstraise = getdvarint( @"scr_game_weapon_skip_first_raise", 0 ) == 1;
    }
    
    return istrue( level.skipfirstraise );
}

// Namespace utility
// Params 4
// Checksum 0xb865410d, Offset: 0x2ae1
// Size: 0x83
function registersharedfunc( category, funcname, function, nooverride )
{
    /#
        if ( isstring( funcname ) )
        {
            assertmsg( "<dev string:x24>" + funcname + "<dev string:x2e>" );
        }
    #/
    
    if ( isstring( category ) )
    {
        category = getxhash( category );
    }
    
    if ( nooverride && isdefined( level.sharedfuncs[ category ][ funcname ] ) )
    {
        return;
    }
    
    level.sharedfuncs[ category ][ funcname ] = function;
}

// Namespace utility
// Params 1
// Checksum 0x3bb180a4, Offset: 0x2b6c
// Size: 0xf7
function function_a4a8a4c917fab476( object )
{
    assert( is_partition(), "<dev string:x20e>" );
    assert( isdefined( object ), "<dev string:x26f>" );
    assert( isdefined( object.origin ), "<dev string:x2a1>" );
    [ x, y ] = function_890559684b1ecb60( object.origin );
    test_array_x = self.array[ x ];
    
    if ( isdefined( test_array_x[ y ] ) )
    {
        self.array[ x ][ y ] = arrayremove( test_array_x[ y ], object );
        
        if ( self.array[ x ][ y ].size == 0 )
        {
            self.array[ x ][ y ] = undefined;
            
            if ( self.array[ x ].size == 0 )
            {
                self.array[ x ] = undefined;
            }
        }
    }
}

// Namespace utility
// Params 3
// Checksum 0x470ae069, Offset: 0x2c6b
// Size: 0x3c
function removeconflictingattachments( attachments, defaults, weapon_base_name )
{
    assert( isdefined( weapon_base_name ) );
    
    if ( isdefined( weapon_base_name ) )
    {
        return removeconflictingdefaultattachment( attachments, defaults, weapon_base_name );
    }
    
    return defaults;
}

// Namespace utility
// Params 4
// Checksum 0x279bc4e9, Offset: 0x2cb0
// Size: 0x34e
function removeconflictingdefaultattachment( attachment_array, default_array, weapon_base_name, sanity_check_defaults = 1 )
{
    defaults_filtered = default_array;
    attach_1 = undefined;
    attach_1_slot = undefined;
    attach_1_priority = undefined;
    attach_2 = undefined;
    attach_2_slot = undefined;
    attach_2_priority = undefined;
    var_283db49f3d7bf4fb = undefined;
    var_e12ac324cb87db7f = undefined;
    weap = makeweaponfromstring( weapon_base_name );
    final_attachments = defaults_filtered;
    
    if ( sanity_check_defaults )
    {
        for ( i = 0; i < default_array.size - 1 ; i++ )
        {
            attach_1 = default_array[ i ];
            attach_1_slot = getattachmentslot( weap, attach_1 );
            
            for ( j = i + 1; j < default_array.size ; j++ )
            {
                attach_2 = default_array[ j ];
                
                if ( attach_1 == attach_2 )
                {
                    continue;
                }
                
                attach_2_slot = getattachmentslot( weap, attach_2 );
                
                if ( attach_1_slot == attach_2_slot && attach_1_slot != "other" )
                {
                    attach_1_priority = getattachmentslotpriority( weap, attach_1 );
                    attach_2_priority = getattachmentslotpriority( weap, attach_2 );
                    
                    if ( attach_1_priority >= attach_2_priority )
                    {
                        final_attachments = arrayremove( final_attachments, attach_2 );
                    }
                }
                
                var_283db49f3d7bf4fb = _attachmentblocks( weap, attach_1, attach_2 );
                var_e12ac324cb87db7f = _attachmentblocks( weap, attach_2, attach_1 );
                
                if ( var_283db49f3d7bf4fb && var_e12ac324cb87db7f )
                {
                    defaults_filtered = arrayremove( defaults_filtered, attach_2 );
                    continue;
                }
                
                if ( var_283db49f3d7bf4fb )
                {
                    defaults_filtered = arrayremove( defaults_filtered, attach_2 );
                    continue;
                }
                
                if ( var_e12ac324cb87db7f )
                {
                    defaults_filtered = arrayremove( defaults_filtered, attach_1 );
                }
            }
        }
    }
    
    attach_1 = undefined;
    attach_1_slot = undefined;
    attach_1_priority = undefined;
    attach_2 = undefined;
    attach_2_slot = undefined;
    attach_2_priority = undefined;
    var_283db49f3d7bf4fb = undefined;
    var_e12ac324cb87db7f = undefined;
    final_attachments = defaults_filtered;
    
    foreach ( attach_1 in attachment_array )
    {
        if ( issubstr( attach_1, "|" ) )
        {
            [ attach_1 ] = strtok( attach_1, "|" );
        }
        
        attach_1_slot = getattachmentslot( weap, attach_1 );
        
        foreach ( attach_2 in defaults_filtered )
        {
            if ( issubstr( attach_2, "|" ) )
            {
                [ attach_2 ] = strtok( attach_2, "|" );
            }
            
            attach_2_slot = getattachmentslot( weap, attach_2 );
            
            if ( attach_1_slot == attach_2_slot && attach_1_slot != "other" )
            {
                attach_1_priority = getattachmentslotpriority( weap, attach_1 );
                attach_2_priority = getattachmentslotpriority( weap, attach_2 );
                
                if ( attach_1_priority >= attach_2_priority )
                {
                    final_attachments = arrayremove( final_attachments, attach_2 );
                    continue;
                }
            }
            
            var_283db49f3d7bf4fb = _attachmentblocks( weap, attach_1, attach_2 );
            var_e12ac324cb87db7f = _attachmentblocks( weap, attach_2, attach_1 );
            
            if ( var_283db49f3d7bf4fb && var_e12ac324cb87db7f )
            {
                final_attachments = arrayremove( final_attachments, attach_2 );
                continue;
            }
            
            if ( var_283db49f3d7bf4fb )
            {
                final_attachments = arrayremove( final_attachments, attach_2 );
            }
        }
    }
    
    return final_attachments;
}

// Namespace utility
// Params 3, eflags: 0x4
// Checksum 0xbf0ff4a, Offset: 0x3007
// Size: 0xdb, Type: bool
function private _attachmentblocks( weaponasset, attachment1, attachment2 )
{
    basetypesblocked = getattachmentbasetypesblocked( weaponasset, attachment1 );
    
    if ( basetypesblocked.size > 0 && arraycontains( basetypesblocked, getattachmentbasetype( weaponasset, attachment2 ) ) )
    {
        return true;
    }
    
    attachment1slot = getattachmentslot( weaponasset, attachment1 );
    attachment2slot = getattachmentslot( weaponasset, attachment2 );
    
    if ( attachment1slot == attachment2slot )
    {
        if ( attachment1slot != "other" || attachment1 == attachment2 )
        {
            return true;
        }
    }
    
    slotsblocked = getattachmentslotsblocked( weaponasset, attachment1 );
    
    if ( slotsblocked.size > 0 && arraycontains( slotsblocked, attachment2slot ) )
    {
        return true;
    }
    
    attachmentsblocked = getattachmentsblocked( weaponasset, attachment1 );
    
    if ( attachmentsblocked.size > 0 && arraycontains( attachmentsblocked, attachment2 ) )
    {
        return true;
    }
    
    return false;
}

// Namespace utility
// Params 2
// Checksum 0x7f663a5c, Offset: 0x30eb
// Size: 0xa7
function spawn_script_origin( org, ang )
{
    if ( !isdefined( ang ) && isdefined( self.angles ) )
    {
        ang = self.angles;
    }
    
    if ( !isdefined( org ) && isdefined( self.origin ) )
    {
        org = self.origin;
    }
    
    if ( !isdefined( org ) )
    {
        org = ( 0, 0, 0 );
    }
    
    script_origin = spawn( "script_origin", org );
    script_origin.targetname = "spawn_script_origin";
    
    if ( isdefined( ang ) )
    {
        script_origin.angles = ang;
    }
    
    return script_origin;
}

// Namespace utility
// Params 2
// Checksum 0x29ad74aa, Offset: 0x319b
// Size: 0xa9
function spawn_tag_origin( org, ang )
{
    if ( !isdefined( ang ) && isdefined( self.angles ) )
    {
        ang = self.angles;
    }
    
    if ( !isdefined( org ) && isdefined( self.origin ) )
    {
        org = self.origin;
    }
    
    if ( !isdefined( org ) )
    {
        org = ( 0, 0, 0 );
    }
    
    tag_origin = spawn( "script_model", org );
    tag_origin setmodel( "tag_origin" );
    tag_origin hide();
    
    if ( isdefined( ang ) )
    {
        tag_origin.angles = ang;
    }
    
    return tag_origin;
}

// Namespace utility
// Params 2
// Checksum 0xded9e57a, Offset: 0x324d
// Size: 0x33
function function_1808878d1c511ce8( org, ang )
{
    tag_origin = spawn_tag_origin( org, ang );
    tag_origin show();
    return tag_origin;
}

// Namespace utility
// Params 6
// Checksum 0x4d0537d9, Offset: 0x3289
// Size: 0xc4
function function_a0b2f814bf08507f( weaponname, origin, weaponattachments, angles = ( 0, 0, 0 ), spawnflags = 0, camoid )
{
    assert( isdefined( origin ), "<dev string:x2e3>" );
    weaponobject = weapon::buildweapon( weaponname, weaponattachments, camoid );
    weaponentity = spawn( "weapon_" + getcompleteweaponname( weaponobject ), origin, spawnflags );
    weaponentity.angles = angles;
    level thread callsharedfunc( #"loot", #"dropWeaponPost", weaponentity );
    return weaponentity;
}

// Namespace utility
// Params 5
// Checksum 0xafdba421, Offset: 0x3356
// Size: 0x4b
function loop_fx_sound( alias, origin, culled, ender, createfx_ent )
{
    loop_fx_sound_with_angles( alias, origin, ( 0, 0, 0 ), culled, ender, createfx_ent );
}

// Namespace utility
// Params 7
// Checksum 0x88e61e29, Offset: 0x33a9
// Size: 0x117
function loop_fx_sound_interval_with_angles( alias, origin, angles, ender, timeout, delay_min, delay_max )
{
    self.origin = origin;
    self.angles = angles;
    
    if ( isdefined( ender ) )
    {
        self endon( ender );
    }
    
    if ( delay_min >= delay_max )
    {
        while ( true )
        {
            /#
                print3d( origin, "<dev string:x312>", ( 1, 0, 0 ), 1, 1 );
            #/
            
            wait 0.05;
        }
    }
    
    if ( !soundexists( alias ) )
    {
        while ( true )
        {
            /#
                print3d( origin, "<dev string:x329>" + alias, ( 1, 0, 0 ), 1, 1 );
            #/
            
            wait 0.05;
        }
    }
    
    while ( true )
    {
        wait randomfloatrange( delay_min, delay_max );
        lock( "createfx_looper" );
        thread play_sound_in_space_with_angles( alias, self.origin, self.angles, undefined );
        unlock( "createfx_looper" );
    }
}

// Namespace utility
// Params 7
// Checksum 0x13539a87, Offset: 0x34c8
// Size: 0x14b
function loop_fx_sound_with_angles( alias, origin, angles, culled, ender, createfx_ent, shape )
{
    if ( culled )
    {
        if ( !isdefined( level.first_frame ) || level.first_frame == 1 )
        {
            spawnloopingsound( alias, origin, angles );
        }
        
        return;
    }
    
    if ( level.createfx_enabled && isdefined( createfx_ent.loopsound_ent ) )
    {
        org = createfx_ent.loopsound_ent;
    }
    else
    {
        org = spawn( "script_origin", ( 0, 0, 0 ) );
        org.targetname = "loop_fx_sound_with_angles";
    }
    
    /#
        if ( isdefined( self.v ) )
        {
            org.createfx_ent = 1;
        }
    #/
    
    if ( isdefined( ender ) )
    {
        thread loop_sound_delete( ender, org );
        self endon( ender );
    }
    
    org.origin = origin;
    org.angles = angles;
    org playloopsound( alias );
    
    if ( level.createfx_enabled )
    {
        createfx_ent.loopsound_ent = org;
        return;
    }
    
    org willneverchange();
}

// Namespace utility
// Params 2
// Checksum 0xc7011c0a, Offset: 0x361b
// Size: 0x2f
function loop_sound_delete( ender, ent )
{
    ent endon( #"death" );
    self waittill( ender );
    ent delete();
}

// Namespace utility
// Params 1, eflags: 0x4
// Checksum 0x2940c7d, Offset: 0x3652
// Size: 0xa1
function private function_295d140a604847b8( weapon )
{
    struct = spawnstruct();
    struct.origin = weapon.origin;
    struct.angles = weapon.angles;
    struct.targetname = weapon.targetname;
    struct.bulletweapon = function_41bec0232e24ee41( weapon.classname, "weapon_" );
    struct.spawnflags = weapon.spawnflags;
    addstruct( struct );
}

// Namespace utility
// Params 0
// Checksum 0x9bf72e22, Offset: 0x36fb
// Size: 0x447
function fixplacedweapons()
{
    /#
        level.placedweapons = [];
    #/
    
    weapons = [];
    entities = getentarray();
    
    foreach ( ent in entities )
    {
        if ( !isdefined( ent.classname ) )
        {
            continue;
        }
        
        if ( isstartstr( ent.classname, "weapon_" ) )
        {
            weapons[ weapons.size ] = ent;
        }
    }
    
    foreach ( weapon in weapons )
    {
        if ( isent( weapon ) && weapon.spawnflags & 32 )
        {
            function_295d140a604847b8( weapon );
            weapon delete();
            continue;
        }
        
        weaponattachments = strtok( weapon.classname, "+" );
        weaponname = getsubstr( weaponattachments[ 0 ], 7, weaponattachments[ 0 ].size );
        weaponattachments[ 0 ] = undefined;
        
        if ( isint( 0 ) )
        {
            function_cdc669dbc8ea2101( weaponattachments );
        }
        
        weaponcamoid = weapon.script_camo;
        
        if ( isdefined( level.var_78443cb099dedf63 ) )
        {
            weaponfixed = [[ level.var_78443cb099dedf63 ]]( weaponname, weapon.origin, weaponattachments, weapon.angles, weapon.spawnflags, weaponcamoid );
        }
        else
        {
            weaponfixed = function_a0b2f814bf08507f( weaponname, weapon.origin, weaponattachments, weapon.angles, weapon.spawnflags, weaponcamoid );
        }
        
        if ( isdefined( weapon.targetname ) )
        {
            weaponfixed.targetname = weapon.targetname;
        }
        
        if ( isdefined( weapon.script_noteworthy ) )
        {
            weaponfixed.script_noteworthy = weapon.script_noteworthy;
        }
        
        if ( isdefined( weapon.script_namenumber ) )
        {
            weaponfixed.script_namenumber = weapon.script_namenumber;
        }
        
        if ( isdefined( weapon.script_parameters ) )
        {
            weaponfixed.script_parameters = weapon.script_parameters;
        }
        
        if ( isdefined( weapon.script_label ) )
        {
            weaponfixed.script_label = weapon.script_label;
        }
        
        if ( isdefined( weapon.script_ammo_alt_clip ) )
        {
            weaponfixed.script_ammo_alt_clip = weapon.script_ammo_alt_clip;
        }
        
        if ( isdefined( weapon.script_ammo_alt_extra ) )
        {
            weaponfixed.script_ammo_alt_extra = weapon.script_ammo_alt_extra;
        }
        
        if ( isdefined( weapon.script_ammo_clip ) )
        {
            weaponfixed.script_ammo_clip = weapon.script_ammo_clip;
        }
        
        if ( isdefined( weapon.script_ammo_extra ) )
        {
            weaponfixed.script_ammo_extra = weapon.script_ammo_extra;
        }
        else if ( isdefined( weapon.script_ammo_clip ) )
        {
            weaponfixed.script_ammo_extra = 0;
        }
        
        if ( isdefined( weapon.script_ammo_max ) )
        {
            weaponfixed.script_ammo_max = weapon.script_ammo_max;
        }
        
        if ( isdefined( weapon.script_item_def ) )
        {
            weaponfixed.script_item_def = weapon.script_item_def;
        }
        
        hasub = function_9955d5b2a1d97c43( weapon );
        weaponfixed shared::setscriptammo( weapon, hasub );
        thread callsharedfunc( #"loot", #"dropWeaponPost", weaponfixed );
        
        /#
            level.placedweapons[ level.placedweapons.size ] = weaponfixed;
        #/
        
        weapon delete();
    }
}

// Namespace utility
// Params 1
// Checksum 0xae1019d8, Offset: 0x3b4a
// Size: 0x15
function show_exploder_models( num )
{
    exploder::show_exploder_models_proc( num );
}

// Namespace utility
// Params 1
// Checksum 0x1076f1bd, Offset: 0x3b67
// Size: 0x1a
function sign( x )
{
    return x >= 0 ? 1 : -1;
}

// Namespace utility
// Params 3
// Checksum 0x789eadaa, Offset: 0x3b8a
// Size: 0x28
function single_func_argarray( entity, func, a_vars )
{
    return single_func_internal( entity, func, a_vars );
}

// Namespace utility
// Params 3, eflags: 0x4
// Checksum 0xe746ed87, Offset: 0x3bbb
// Size: 0x31
function private single_func_internal( entity, func, a_vars )
{
    a_vars = function_5713d46873b29625( a_vars );
    return entity [[ func ]]( flat_args( a_vars, a_vars.size ) );
}

// Namespace utility
// Params 4, eflags: 0x40 variadic
// Checksum 0xd03f0067, Offset: 0x3bf5
// Size: 0x4a
function single_thread( entity, func, ... )
{
    if ( !isfunction( func ) )
    {
        assert( 0, "<dev string:x334>" );
        return;
    }
    
    entity thread [[ func ]]( flat_args( vararg, varargcount ) );
}

// Namespace utility
// Params 5
// Checksum 0x24f870a, Offset: 0x3c47
// Size: 0x185
function spawn_damage_proxy( parentent, model, offsetorigin, offsetangles, tag )
{
    assert( isent( parentent ) );
    assert( isdefined( model ) );
    
    if ( !isdefined( offsetorigin ) )
    {
        offsetorigin = ( 0, 0, 0 );
    }
    
    if ( !isdefined( offsetangles ) )
    {
        offsetangles = ( 0, 0, 0 );
    }
    
    damageproxy = spawn( "script_model", coordtransform( offsetorigin, parentent.origin, parentent.angles ) );
    
    if ( !isdefined( damageproxy ) )
    {
        /#
            iprintln( "<dev string:x360>" + parentent.origin[ 0 ] + "<dev string:x45>" + parentent.origin[ 1 ] + "<dev string:x45>" + parentent.origin[ 2 ] + "<dev string:x37d>" );
        #/
        
        return;
    }
    
    damageproxy.angles = combineangles( parentent.angles, offsetangles );
    damageproxy setmodel( model );
    damageproxy.health = 999999;
    damageproxy.takedamage = 1;
    damageproxy hide();
    damageproxy function_f721683d9ae86377( 1 );
    damageproxy setcandamage( 1 );
    
    if ( isdefined( tag ) )
    {
        damageproxy linkto( parentent, tag, offsetorigin, offsetangles );
    }
    else
    {
        damageproxy linkto( parentent );
    }
    
    parentent thread damage_proxy_cleanup( damageproxy );
    damageproxy thread function_9e0058b45819027c( parentent );
    return damageproxy;
}

// Namespace utility
// Params 1, eflags: 0x4
// Checksum 0x8e21d98a, Offset: 0x3dd5
// Size: 0x101
function private function_9e0058b45819027c( owner )
{
    self endon( #"death_or_disconnect" );
    owner endon( #"death_or_disconnect" );
    
    while ( true )
    {
        self waittill( #"damage", amount, attacker, direction_vec, damageloc, meansofdeath, modelname, attachtagname, partname, dflags, objweapon, origin, angles, normal, inflictor, time );
        owner notify( #"damage", amount, attacker, direction_vec, damageloc, meansofdeath, modelname, attachtagname, partname, dflags, objweapon, origin, angles, normal, inflictor, time );
        self.health = 999999;
    }
}

// Namespace utility
// Params 1, eflags: 0x4
// Checksum 0x70af22f6, Offset: 0x3ede
// Size: 0x26
function private damage_proxy_cleanup( linked )
{
    self waittill( #"death_or_disconnect" );
    
    if ( isdefined( linked ) )
    {
        linked delete();
    }
}

// Namespace utility
// Params 2
// Checksum 0x92ac785c, Offset: 0x3f0c
// Size: 0x65
function lookatentity( ent, intensity )
{
    actual_intensity = 1;
    
    if ( isdefined( intensity ) )
    {
        actual_intensity = intensity;
    }
    
    self.entitylookingat = ent;
    
    if ( isdefined( ent ) )
    {
        self.lookingatent = 1;
        self setlookatentity( ent, actual_intensity );
        return;
    }
    
    self.lookingatent = 0;
    self setlookatentity();
}

// Namespace utility
// Params 2
// Checksum 0x81e57687, Offset: 0x3f79
// Size: 0x66
function choose_from_weighted_array( values, weights )
{
    assert( values.size == weights.size );
    randomval = randomint( weights[ weights.size - 1 ] + 1 );
    
    for ( i = 0; i < weights.size ; i++ )
    {
        if ( randomval <= weights[ i ] )
        {
            return values[ i ];
        }
    }
}

// Namespace utility
// Params 1
// Checksum 0xe25c7261, Offset: 0x3fe7
// Size: 0x67
function civ_glancedownpath( duration )
{
    if ( !isdefined( self.pathgoalpos ) )
    {
        return;
    }
    
    self.internal_entitytolookat = self.entitylookingat;
    lookatentity();
    internal_civglancedownpath( gettime(), duration );
    lookatentity( self.internal_entitytolookat );
    self.internal_entitytolookat = undefined;
    self notify( #"glance_finished" );
}

// Namespace utility
// Params 2, eflags: 0x4
// Checksum 0xfd27375d, Offset: 0x4056
// Size: 0x95
function private internal_civglancedownpath( starttime, duration )
{
    too_close_dist_sq = 2500;
    lookdownpathdist = self.lookdownpathdist ?? 75;
    
    while ( starttime + duration > gettime() )
    {
        glanceatpos = self getposonpath( lookdownpathdist );
        glanceatpos += ( 0, 0, 60 );
        
        if ( distancesquared( self.origin, glanceatpos ) < too_close_dist_sq )
        {
            break;
        }
        
        self setlookat( glanceatpos );
        waitframe();
    }
    
    self stoplookat();
}

// Namespace utility
// Params 2
// Checksum 0xaf6a66e7, Offset: 0x40f3
// Size: 0x86
function internal_wait_for_any_flag_or_time_elapses( flag_arr, timer )
{
    foreach ( flag_msg in flag_arr )
    {
        level endon( flag_msg );
    }
    
    wait timer;
}

// Namespace utility
// Params 0
// Checksum 0xd8c2ffa5, Offset: 0x4181
// Size: 0x8
function glancestop()
{
    self stoplookat();
}

// Namespace utility
// Params 2
// Checksum 0x7225131b, Offset: 0x4191
// Size: 0x43
function lookatpos( pos, intensity )
{
    self notify( #"newlookat" );
    
    if ( !isdefined( intensity ) )
    {
        intensity = 1;
    }
    
    if ( !isdefined( pos ) )
    {
        self stoplookat();
        return;
    }
    
    self setlookat( pos, intensity );
}

// Namespace utility
// Params 1
// Checksum 0x2da6c001, Offset: 0x41dc
// Size: 0x9b, Type: bool
function isvalidpeekoutdir( dir )
{
    node = self;
    peekouts = node getvalidcoverpeekouts();
    
    foreach ( peekout in peekouts )
    {
        if ( peekout == dir )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace utility
// Params 2
// Checksum 0x654eeedc, Offset: 0x4280
// Size: 0x32, Type: bool
function isvehiclecrushdamage( inflictor, meansofdeath )
{
    if ( !( isdefined( inflictor ) && isdefined( inflictor vehicle::get_ref() ) ) )
    {
        return false;
    }
    
    return meansofdeath == "MOD_CRUSH";
}

// Namespace utility
// Params 1
// Checksum 0x4b95295, Offset: 0x42bb
// Size: 0x61
function isbulletdamage( meansofdeath )
{
    if ( !isdefined( meansofdeath ) )
    {
        assertmsg( "<dev string:x380>" );
        return 0;
    }
    
    switch ( meansofdeath )
    {
        case #"hash_590bdb04e515167b":
        case #"hash_5f1054c48d66fd1c":
        case #"hash_966768b3f0c94767":
            return 1;
        default:
            return 0;
    }
}

// Namespace utility
// Params 1
// Checksum 0xb04a8d0e, Offset: 0x4324
// Size: 0x4e, Type: bool
function isdamageweapon( weapon )
{
    objweapon = self.damageweapon;
    
    if ( !isdefined( objweapon ) )
    {
        return false;
    }
    
    if ( isnullweapon( objweapon ) )
    {
        return false;
    }
    
    if ( objweapon.basename != getweaponbasename( weapon ) )
    {
        return false;
    }
    
    return true;
}

// Namespace utility
// Params 2
// Checksum 0x3c168902, Offset: 0x437b
// Size: 0xb6
function setrecoilscale( scaler = 0, scaleoverride )
{
    if ( !isdefined( self.recoilscale ) )
    {
        self.recoilscale = scaler;
    }
    else
    {
        self.recoilscale += scaler;
    }
    
    if ( isdefined( scaleoverride ) )
    {
        if ( scaleoverride < self.recoilscale )
        {
            scaleoverride = self.recoilscale;
        }
        
        scale = 100 - scaleoverride;
    }
    else
    {
        scale = 100 - self.recoilscale;
    }
    
    scale = int( clamp( scale, 0, 255 ) );
    
    if ( scale == 100 )
    {
        self player_recoilscaleoff();
        return;
    }
    
    self player_recoilscaleon( scale );
}

// Namespace utility
// Params 2, eflags: 0x40 variadic
// Checksum 0xdc4d2da7, Offset: 0x4439
// Size: 0x4f
function maximum( ... )
{
    assert( varargcount >= 1 );
    
    if ( isarray( vararg[ 0 ] ) )
    {
        assert( varargcount == 1 );
        return array_max( vararg[ 0 ] );
    }
    
    return array_max( vararg );
}

// Namespace utility
// Params 0
// Checksum 0xf6ce82a6, Offset: 0x4490
// Size: 0x7f, Type: bool
function meleegrab_ksweapon_used()
{
    assert( isplayer( self ) );
    killstreak_weaps = [ "mars_killstreak", "iw7_jackal_support_designator" ];
    currentweapon = self getcurrentweapon();
    
    if ( arraycontains( killstreak_weaps, currentweapon.basename ) )
    {
        return true;
    }
    
    if ( self isdroppingweapon() )
    {
        return true;
    }
    
    if ( self israisingweapon() )
    {
        if ( arraycontains( killstreak_weaps, currentweapon.basename ) )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace utility
// Params 0
// Checksum 0x91b36fef, Offset: 0x4518
// Size: 0x4b, Type: bool
function wasdamagedbyoffhandshield()
{
    if ( self.damagemod != "MOD_MELEE" )
    {
        return false;
    }
    
    objweapon = self.damageweapon;
    
    if ( !isdefined( objweapon ) || objweapon.type != "shield" )
    {
        return false;
    }
    
    return true;
}

// Namespace utility
// Params 1
// Checksum 0x1f3b0640, Offset: 0x456c
// Size: 0x70
function function_64003742d8f5c781( weapon )
{
    if ( isweapon( weapon ) )
    {
        return weapon;
    }
    else if ( isstring( weapon ) )
    {
        return ( level.var_d53b344e2aeda06f[ weapon ] ?? function_c8852ed0b886c6bd( weapon ) );
    }
    else if ( isxhashasset( weapon ) )
    {
        return ( level.var_8a2f4f6d7534396a[ weapon ] ?? function_ea577e55c7daf2b2( weapon ) );
    }
    
    assert( isdefined( weapon ), "<dev string:x3a5>" );
}

// Namespace utility
// Params 2, eflags: 0x4
// Checksum 0xc770f8cd, Offset: 0x45e5
// Size: 0x2d
function private function_7508ecd9410f7dfa( var_8ef80df233884b8e, var_3c04a2b892cbba04 )
{
    if ( weaponexists( var_8ef80df233884b8e ) )
    {
        return [[ var_3c04a2b892cbba04 ]]( var_8ef80df233884b8e );
    }
    
    return level.weaponnone;
}

// Namespace utility
// Params 4
// Checksum 0x191119, Offset: 0x461b
// Size: 0x31
function within_fov( start_origin, start_angles, end_origin, fov )
{
    return withinfov( start_origin, start_angles, end_origin, fov );
}

// Namespace utility
// Params 2
// Checksum 0xa4d7ca01, Offset: 0x4655
// Size: 0x10c
function wrap_text( text, line_limit )
{
    tokenized = strtok( text, " " );
    checked_words = "";
    lines = [];
    i = 0;
    total_characters = 0;
    
    foreach ( word in tokenized )
    {
        if ( total_characters > line_limit )
        {
            lines[ lines.size ] = checked_words;
            checked_words = "";
            total_characters = 0;
        }
        
        total_characters += word.size;
        checked_words += word;
        
        if ( i != tokenized.size - 1 )
        {
            checked_words += " ";
        }
        else
        {
            lines[ lines.size ] = checked_words;
        }
        
        i++;
    }
    
    return lines;
}

// Namespace utility
// Params 1
// Checksum 0x96347e96, Offset: 0x476a
// Size: 0x5c, Type: bool
function shouldburnfromdamage( damageweapon )
{
    if ( issubstr( damageweapon.basename, "molotov" ) || damageweapon.isdragonsbreath || self.var_30465dead0b9fadb || self.shouldburnfromdamage || function_51251d8c19498b74( damageweapon ) )
    {
        return true;
    }
    
    return false;
}

// Namespace utility
// Params 1
// Checksum 0xeb2c1792, Offset: 0x47cf
// Size: 0x3a, Type: bool
function hasanim( anime )
{
    assert( isdefined( self.animname ), "<dev string:x3d7>" );
    return isdefined( level.scr_anim[ self.animname ][ anime ] );
}

// Namespace utility
// Params 1
// Checksum 0x5b7bd1bb, Offset: 0x4812
// Size: 0x1f, Type: bool
function hasanim_generic( anime )
{
    return isdefined( level.scr_anim[ "generic" ][ anime ] );
}

// Namespace utility
// Params 2
// Checksum 0xdc87ce22, Offset: 0x483a
// Size: 0xe1
function hastag( model, tag )
{
    if ( !isdefined( model ) || model == "" )
    {
        return 0;
    }
    
    if ( !isdefined( level.has_tag ) )
    {
        level.has_tag = [];
    }
    
    key = model + "_" + tag;
    
    if ( isdefined( level.has_tag[ key ] ) )
    {
        return level.has_tag[ key ];
    }
    
    partcount = getnumparts( model );
    
    if ( partcount > 0 )
    {
        for ( i = 0; i < partcount ; i++ )
        {
            partname = getpartname( model, i );
            
            if ( partname == tolower( tag ) )
            {
                level.has_tag[ key ] = 1;
                return 1;
            }
        }
        
        level.has_tag[ key ] = 0;
    }
    
    return 0;
}

// Namespace utility
// Params 1
// Checksum 0x688dc50c, Offset: 0x4924
// Size: 0x51, Type: bool
function function_51251d8c19498b74( damageweapon )
{
    weaponmetadata = level.weaponmetadata[ getxhashasset( damageweapon.basename ) ];
    return weaponmetadata.elementdamagetype == "fire" && weaponmetadata.var_e02edeb9004f44ac;
}

// Namespace utility
// Params 4, eflags: 0x40 variadic
// Checksum 0xa6e71b59, Offset: 0x497e
// Size: 0x51
function function_72169425ae4544fd( wait_seconds, function, ... )
{
    if ( wait_seconds > 0 )
    {
        wait wait_seconds;
    }
    
    if ( isbuiltinmethod( function ) )
    {
        return self builtin [[ function ]]( flat_args( vararg, varargcount ) );
    }
    
    return self [[ function ]]( flat_args( vararg, varargcount ) );
}

// Namespace utility
// Params 3, eflags: 0x40 variadic
// Checksum 0xf415c7e5, Offset: 0x49d7
// Size: 0x78
function function_1e67f95b5bdb410( delay, ... )
{
    assert( isdefined( delay ) );
    
    /#
        function_8ae6ad9600816017( flat_args( vararg, varargcount ) );
    #/
    
    i = 0;
    
    while ( i < varargcount )
    {
        if ( isdefined( vararg[ i ] ) && isdefined( vararg[ i + 1 ] ) )
        {
            vararg[ i ] endon( vararg[ i + 1 ] );
        }
        
        i += 2;
    }
    
    wait delay;
}

// Namespace utility
// Params 2
// Checksum 0xf013eb08, Offset: 0x4a57
// Size: 0x1d
function wait_for_flag_or_time_elapses( flagname, timer )
{
    level endon( flagname );
    wait timer;
}

// Namespace utility
// Params 1
// Checksum 0x4ec996cd, Offset: 0x4a7c
// Size: 0x2c
function wait_frames( framecount )
{
    frames = framecount;
    
    while ( frames > 0 )
    {
        frames -= 1;
        waitframe();
    }
}

// Namespace utility
// Params 4, eflags: 0x40 variadic
// Checksum 0xdb430af1, Offset: 0x4ab0
// Size: 0x4d
function function_bf6bc5af32465d3c( time_seconds, func, ... )
{
    if ( !isfunction( func ) )
    {
        assertmsg( "<dev string:x400>" );
        return;
    }
    
    thread function_df28a485be61386e( time_seconds, func, flat_args( vararg, varargcount ) );
}

// Namespace utility
// Params 1
// Checksum 0x3f79d342, Offset: 0x4b05
// Size: 0x2d
function wait_time_in_ms( waittimems )
{
    endtimems = gettime() + waittimems;
    
    while ( gettime() < endtimems )
    {
        waitframe();
    }
}

// Namespace utility
// Params 3, eflags: 0x40 variadic
// Checksum 0xadf746aa, Offset: 0x4b3a
// Size: 0x3f
function function_c2dfd06e2639cc7e( function, ... )
{
    waitframe();
    
    if ( isbuiltinmethod( function ) )
    {
        return self builtin [[ function ]]( flat_args( vararg, varargcount ) );
    }
    
    return self [[ function ]]( flat_args( vararg, varargcount ) );
}

// Namespace utility
// Params 1
// Checksum 0x58be766a, Offset: 0x4b81
// Size: 0x4b
function waittill_all_in_array( string_array )
{
    assert( isdefined( string_array ) );
    assert( isarray( string_array ) );
    
    while ( string_array.size )
    {
        msg = waittill_any_in_array_return( string_array );
        string_array = arrayremove( string_array, msg );
    }
}

// Namespace utility
// Params 2
// Checksum 0x4833fec0, Offset: 0x4bd4
// Size: 0xb4
function function_bc06a8c564f539e5( job_funcs, arg_array )
{
    assert( isarray( job_funcs ) );
    
    if ( !isdefined( arg_array ) )
    {
        arg_array = [];
    }
    
    jobpool = spawnstruct();
    jobpool.alldonenotify = "all_workers_done";
    jobpool.pendingcount = job_funcs.size;
    
    for ( i = 0; i < job_funcs.size ; i++ )
    {
        assert( isfunction( job_funcs[ i ] ) );
        jobpool childthread function_f847fdaebc753c59( self, job_funcs[ i ], arg_array );
    }
    
    if ( jobpool.pendingcount == 0 )
    {
        return;
    }
    
    jobpool waittill( jobpool.alldonenotify );
}

// Namespace utility
// Params 3
// Checksum 0xaafc327c, Offset: 0x4c90
// Size: 0x1cd
function function_f87fb88f9c5add54( var_ab9ec058017ae13, var_2d0993b24a32cf26, time )
{
    ent = spawnstruct();
    ent.threads = 0;
    
    foreach ( endonnotify in var_2d0993b24a32cf26 )
    {
        self endon( endonnotify );
    }
    
    foreach ( stringnotify in var_ab9ec058017ae13 )
    {
        childthread waittill_string_no_endon_death( stringnotify, ent );
        ent.threads++;
    }
    
    if ( isdefined( time ) )
    {
        ent childthread timeout_struct( time );
    }
    else if ( ent.threads == 0 )
    {
        return "success";
    }
    
    while ( true )
    {
        ent waittill( #"returned", message );
        
        if ( message == "timeout" )
        {
            self notify( #"monitornotify", "timeout" );
            ent notify( #"die" );
            return "timeout";
        }
        
        ent.threads--;
        
        if ( ent.threads == 0 )
        {
            break;
        }
    }
    
    ent notify( #"die" );
    return "success";
}

// Namespace utility
// Params 2
// Checksum 0xfeee4546, Offset: 0x4e66
// Size: 0x1e
function function_3be250f0ba0da4f6( msg, time )
{
    self waittill( msg );
    wait time;
}

// Namespace utility
// Params 3, eflags: 0x40 variadic
// Checksum 0x90ee23, Offset: 0x4e8c
// Size: 0x3f
function waittill_any( string1, ... )
{
    assert( isdefined( string1 ) );
    
    if ( function_f29c9b5e11b055b( vararg ) )
    {
        self endon( flat_args( vararg, varargcount ) );
    }
    
    self waittill( string1 );
}

// Namespace utility
// Params 4, eflags: 0x40 variadic
// Checksum 0xf11fca2b, Offset: 0x4ed3
// Size: 0x8f
function waittill_any_ents( ent1, string1, ... )
{
    assert( isdefined( ent1 ) );
    assert( isdefined( string1 ) );
    
    /#
        function_8ae6ad9600816017( flat_args( vararg, varargcount ) );
    #/
    
    i = 0;
    
    while ( i < varargcount )
    {
        if ( isdefined( vararg[ i ] ) && isdefined( vararg[ i + 1 ] ) )
        {
            vararg[ i ] endon( vararg[ i + 1 ] );
        }
        
        i += 2;
    }
    
    ent1 waittill( string1 );
}

// Namespace utility
// Params 4, eflags: 0x40 variadic
// Checksum 0x7d422930, Offset: 0x4f6a
// Size: 0x142
function waittill_any_ents_array( ents, string1, ... )
{
    assert( isdefined( ents ) );
    assert( isarray( ents ) );
    assert( isdefined( ents[ 0 ] ) );
    assert( isdefined( string1 ) );
    
    foreach ( ent in ents )
    {
        if ( ent != ents[ 0 ] )
        {
            ent endon( string1 );
        }
        
        foreach ( varstring in vararg )
        {
            ent endon( varstring );
        }
    }
    
    ents[ 0 ] waittill( string1 );
}

// Namespace utility
// Params 3, eflags: 0x40 variadic
// Checksum 0x424524db, Offset: 0x50b4
// Size: 0xc3
function waittill_any_ents_or_timeout_return( timeout, ... )
{
    assert( isdefined( timeout ) );
    
    /#
        function_8ae6ad9600816017( flat_args( vararg, varargcount ) );
    #/
    
    self endon( #"death" );
    ent = {};
    i = 0;
    
    while ( i < varargcount )
    {
        if ( isdefined( vararg[ i ] ) && isdefined( vararg[ i + 1 ] ) )
        {
            vararg[ i ] childthread waittill_string( vararg[ i + 1 ], ent );
        }
        
        i += 2;
    }
    
    ent childthread timeout_struct( timeout );
    ent waittill( #"returned", msg );
    ent notify( #"die" );
    return msg;
}

// Namespace utility
// Params 3, eflags: 0x40 variadic
// Checksum 0x9ea3f721, Offset: 0x5180
// Size: 0xf4
function waittill_any_ents_or_timeout_return_always( timeout, ... )
{
    assert( !isdefined( timeout ) || timeout > 0 );
    assert( varargcount >= 2 );
    assert( varargcount % 2 == 0 );
    self endon( #"death" );
    context = spawnstruct();
    context.var_281430b4e3937048 = 0;
    context.var_f866e0b41edac98a = arraycontains( vararg, "death" );
    i = 0;
    
    while ( i < varargcount )
    {
        function_bd5f115c5b978f93( vararg[ i ], vararg[ i + 1 ], context );
        i += 2;
    }
    
    if ( isdefined( timeout ) )
    {
        context childthread timeout_struct( timeout );
    }
    
    context waittill( #"returned", msg );
    context notify( #"die" );
    return msg;
}

// Namespace utility
// Params 3, eflags: 0x40 variadic
// Checksum 0x20462b40, Offset: 0x527d
// Size: 0xb7
function function_f755811828e739dd( timeout, ... )
{
    assert( isdefined( timeout ) );
    
    /#
        function_8ae6ad9600816017( flat_args( vararg, varargcount ) );
    #/
    
    ent = {};
    i = 0;
    
    while ( i < varargcount )
    {
        if ( isdefined( vararg[ i ] ) && isdefined( vararg[ i + 1 ] ) )
        {
            vararg[ i ] childthread waittill_string_no_endon_death( vararg[ i + 1 ], ent );
        }
        
        i += 2;
    }
    
    ent childthread timeout_struct( timeout );
    ent waittill( #"returned", msg );
    ent notify( #"die" );
    return msg;
}

// Namespace utility
// Params 2, eflags: 0x40 variadic
// Checksum 0xcc429076, Offset: 0x533d
// Size: 0xa5
function waittill_any_ents_return( ... )
{
    /#
        function_8ae6ad9600816017( flat_args( vararg, varargcount ) );
    #/
    
    self endon( #"death" );
    ent = {};
    i = 0;
    
    while ( i < varargcount )
    {
        if ( isdefined( vararg[ i ] ) && isdefined( vararg[ i + 1 ] ) )
        {
            vararg[ i ] childthread waittill_string( vararg[ i + 1 ], ent );
        }
        
        i += 2;
    }
    
    ent waittill( #"returned", msg );
    ent notify( #"die" );
    return msg;
}

// Namespace utility
// Params 2, eflags: 0x40 variadic
// Checksum 0xd59df970, Offset: 0x53eb
// Size: 0xa8
function waittill_any_ents_return_no_endon_death( ... )
{
    /#
        function_8ae6ad9600816017( flat_args( vararg, varargcount ) );
    #/
    
    self endon( #"death" );
    ent = spawnstruct();
    i = 0;
    
    while ( i < varargcount )
    {
        if ( isdefined( vararg[ i ] ) && isdefined( vararg[ i + 1 ] ) )
        {
            vararg[ i ] childthread waittill_string_no_endon_death( vararg[ i + 1 ], ent );
        }
        
        i += 2;
    }
    
    ent waittill( #"returned", msg );
    ent notify( #"die" );
    return msg;
}

// Namespace utility
// Params 2
// Checksum 0x339090f4, Offset: 0x549c
// Size: 0xe0
function function_247f4cc1c6c325d1( ents, string )
{
    assert( isdefined( ents ) );
    assert( isdefined( string ) );
    self endon( #"death" );
    dummyent = spawnstruct();
    
    foreach ( ent in ents )
    {
        ent childthread function_cbd0402bd3cd13f1( string, dummyent );
    }
    
    dummyent waittill( #"returned", msg );
    dummyent notify( #"die" );
    return msg;
}

// Namespace utility
// Params 2, eflags: 0x40 variadic
// Checksum 0x9d4e6e04, Offset: 0x5585
// Size: 0x9c
function waittill_any_ents_return_params( ... )
{
    /#
        function_8ae6ad9600816017( flat_args( vararg, varargcount ) );
    #/
    
    struct = spawnstruct();
    i = 0;
    
    while ( i < varargcount )
    {
        if ( isdefined( vararg[ i ] ) && isdefined( vararg[ i + 1 ] ) )
        {
            vararg[ i ] childthread function_85c91016b4b45c34( vararg[ i + 1 ], struct );
        }
        
        i += 2;
    }
    
    struct waittill( #"returned", results_array );
    struct notify( #"struct_delete" );
    return results_array;
}

// Namespace utility
// Params 3, eflags: 0x40 variadic
// Checksum 0xf41e1a4d, Offset: 0x562a
// Size: 0xef
function function_22939e0bc589604e( timeout, ... )
{
    /#
        if ( !isnumber( timeout ) )
        {
            assertmsg( "<dev string:x422>" );
        }
        
        function_8ae6ad9600816017( flat_args( vararg, varargcount ) );
    #/
    
    if ( !arraycontains( vararg, "death" ) )
    {
        self endon( #"death" );
    }
    
    struct = spawnstruct();
    i = 0;
    
    while ( i < varargcount )
    {
        if ( isdefined( vararg[ i ] ) && isdefined( vararg[ i + 1 ] ) )
        {
            vararg[ i ] childthread function_85c91016b4b45c34( vararg[ i + 1 ], struct );
        }
        
        i += 2;
    }
    
    if ( timeout > 0 )
    {
        level childthread function_76c1b3b34ade2ea3( struct, "returned", timeout );
    }
    
    struct waittill( #"returned", results_array );
    struct notify( #"struct_delete" );
    return results_array;
}

// Namespace utility
// Params 1
// Checksum 0x6b2d3947, Offset: 0x5722
// Size: 0x4f
function waittill_any_in_array( string_array )
{
    assert( string_array.size > 0, "<dev string:x473>" );
    
    for ( i = 0; i < string_array.size - 1 ; i++ )
    {
        self endon( string_array[ i ] );
    }
    
    self waittill( string_array[ string_array.size - 1 ] );
}

// Namespace utility
// Params 2
// Checksum 0x5ceca093, Offset: 0x5779
// Size: 0x55
function waittill_any_in_array_notify_ent( msg_array, ent )
{
    assert( isdefined( msg_array ) && isdefined( ent ) );
    assert( msg_array.size > 0 );
    self endon( #"die" );
    waittill_any_in_array( msg_array );
    ent notify( #"returned" );
}

// Namespace utility
// Params 2
// Checksum 0xccf94240, Offset: 0x57d6
// Size: 0xe2
function waittill_any_in_array_or_timeout( string_array, timeout )
{
    ent = spawnstruct();
    
    foreach ( string in string_array )
    {
        childthread waittill_string( string, ent );
    }
    
    if ( !arraycontains( string_array, "death" ) )
    {
        self endon( #"death" );
    }
    
    ent childthread timeout_struct( timeout );
    ent waittill( #"returned", msg );
    ent notify( #"die" );
    return msg;
}

// Namespace utility
// Params 2
// Checksum 0x4043030, Offset: 0x58c1
// Size: 0xc7
function waittill_any_in_array_or_timeout_no_endon_death( string_array, timeout )
{
    ent = spawnstruct();
    
    foreach ( string in string_array )
    {
        childthread waittill_string_no_endon_death( string, ent );
    }
    
    ent thread timeout_struct( timeout );
    ent waittill( #"returned", msg );
    ent notify( #"die" );
    return msg;
}

// Namespace utility
// Params 1
// Checksum 0x74d263f9, Offset: 0x5991
// Size: 0xcf
function waittill_any_in_array_return( string_array )
{
    ent = spawnstruct();
    
    foreach ( string in string_array )
    {
        childthread waittill_string( string, ent );
    }
    
    if ( !arraycontains( string_array, "death" ) )
    {
        self endon( #"death" );
    }
    
    ent waittill( #"returned", msg );
    ent notify( #"die" );
    return msg;
}

// Namespace utility
// Params 1
// Checksum 0x9e5b2d54, Offset: 0x5a69
// Size: 0xb4
function waittill_any_in_array_return_no_endon_death( string_array )
{
    ent = spawnstruct();
    
    foreach ( string in string_array )
    {
        childthread waittill_string_no_endon_death( string, ent );
    }
    
    ent waittill( #"returned", msg );
    ent notify( #"die" );
    return msg;
}

// Namespace utility
// Params 1
// Checksum 0x38a958a9, Offset: 0x5b26
// Size: 0xcb
function function_86c5bdf01bdba64e( pairs_array )
{
    assert( isdefined( pairs_array ) );
    assert( pairs_array.size > 0 );
    ent = spawnstruct();
    ent.threads = 0;
    
    for ( i = 0; i < pairs_array.size ; i++ )
    {
        pair = pairs_array[ i ];
        pair.ent childthread waittill_any_in_array_notify_ent( pair.msg_array, ent );
        ent.threads++;
    }
    
    while ( ent.threads )
    {
        ent waittill( #"returned" );
        ent.threads--;
    }
    
    ent notify( #"die" );
}

// Namespace utility
// Params 2, eflags: 0x40 variadic
// Checksum 0x111919e, Offset: 0x5bf9
// Size: 0xe5
function waittill_any_return( ... )
{
    assert( varargcount >= 1 );
    
    if ( !arraycontains( vararg, "death" ) )
    {
        self endon( #"death" );
    }
    
    ent = spawnstruct();
    
    foreach ( varstring in vararg )
    {
        childthread waittill_string( varstring, ent );
    }
    
    ent waittill( #"returned", msg );
    ent notify( #"die" );
    return msg;
}

// Namespace utility
// Params 2, eflags: 0x40 variadic
// Checksum 0x1cd2c66f, Offset: 0x5ce7
// Size: 0xbd
function waittill_any_return_no_endon_death( ... )
{
    ent = spawnstruct();
    
    foreach ( varstring in vararg )
    {
        childthread waittill_string_no_endon_death( varstring, ent );
    }
    
    ent waittill( #"returned", msg );
    ent notify( #"die" );
    return msg;
}

// Namespace utility
// Params 2, eflags: 0x40 variadic
// Checksum 0x46e50cc5, Offset: 0x5dad
// Size: 0x20
function waittill_any_return_params( ... )
{
    return waittill_any_return_params_or_timeout( 0, flat_args( vararg, varargcount ) );
}

// Namespace utility
// Params 3, eflags: 0x40 variadic
// Checksum 0x3313f9c7, Offset: 0x5dd6
// Size: 0x11f
function waittill_any_return_params_or_timeout( timeout, ... )
{
    assert( varargcount >= 1 );
    
    /#
        if ( !isnumber( timeout ) )
        {
            assertmsg( "<dev string:x422>" );
        }
    #/
    
    if ( !arraycontains( vararg, "death" ) )
    {
        self endon( #"death" );
    }
    
    struct = spawnstruct();
    
    foreach ( varstring in vararg )
    {
        childthread function_85c91016b4b45c34( varstring, struct );
    }
    
    if ( timeout > 0 )
    {
        childthread function_76c1b3b34ade2ea3( struct, "returned", timeout );
    }
    
    struct waittill( #"returned", results_array );
    struct notify( #"struct_delete" );
    return results_array;
}

// Namespace utility
// Params 3, eflags: 0x40 variadic
// Checksum 0x34e5743e, Offset: 0x5efe
// Size: 0xeb
function waittill_any_timeout( timeout, ... )
{
    if ( !arraycontains( vararg, "death" ) )
    {
        self endon( #"death" );
    }
    
    ent = spawnstruct();
    
    foreach ( varstring in vararg )
    {
        childthread waittill_string( varstring, ent );
    }
    
    ent childthread timeout_struct( timeout );
    ent waittill( #"returned", msg );
    ent notify( #"die" );
    return msg;
}

// Namespace utility
// Params 3, eflags: 0x40 variadic
// Checksum 0x1970efcb, Offset: 0x5ff2
// Size: 0xd0
function waittill_any_timeout_no_endon_death( timeout, ... )
{
    ent = spawnstruct();
    
    foreach ( varstring in vararg )
    {
        childthread waittill_string_no_endon_death( varstring, ent );
    }
    
    ent childthread timeout_struct( timeout );
    ent waittill( #"returned", msg );
    ent notify( #"die" );
    return msg;
}

// Namespace utility
// Params 2
// Checksum 0x366249a, Offset: 0x60cb
// Size: 0x5a
function function_cae7240c7de68a7( entity, context )
{
    context endon( #"die" );
    entity waittill( #"death" );
    context.var_281430b4e3937048--;
    
    if ( context.var_281430b4e3937048 == 0 )
    {
        context notify( #"returned", undefined );
    }
}

// Namespace utility
// Params 3
// Checksum 0x387ed6df, Offset: 0x612d
// Size: 0x2c
function function_1c579064b3fda85d( msg, match, endonmsg )
{
    self endon( endonmsg );
    self waittillmatch( msg, match );
}

// Namespace utility
// Params 3
// Checksum 0x53314e62, Offset: 0x6161
// Size: 0x58
function waittill_match_or_timeout( msg, match, timer )
{
    ent = spawnstruct();
    ent endon( #"complete" );
    ent delaythread( timer, &send_notify, "complete" );
    self waittillmatch( msg, match );
}

// Namespace utility
// Params 3
// Checksum 0x1982b7e9, Offset: 0x61c1
// Size: 0x59
function waittill_match_or_timeout_return( msg, match, timer )
{
    ent = spawnstruct();
    ent endon( #"complete" );
    ent delaythread( timer, &send_notify, "complete" );
    self waittill( msg, match );
    return match;
}

// Namespace utility
// Params 2, eflags: 0x40 variadic
// Checksum 0xdfd0722a, Offset: 0x6223
// Size: 0xf3
function waittill_multiple( ... )
{
    self endon( #"death" );
    ent = spawnstruct();
    ent.threads = 0;
    
    foreach ( varstring in vararg )
    {
        childthread waittill_string( varstring, ent );
        ent.threads++;
    }
    
    while ( ent.threads )
    {
        ent waittill( #"returned" );
        ent.threads--;
    }
    
    ent notify( #"die" );
}

// Namespace utility
// Params 2
// Checksum 0x582fef08, Offset: 0x631e
// Size: 0x67
function waittill_notify_and_time( msg, time )
{
    starttime = gettime();
    self waittill( msg );
    endtime = starttime + time * 1000;
    timeleft = endtime - starttime;
    
    if ( timeleft > 0 )
    {
        waittime = timeleft / 1000;
        wait waittime;
    }
}

// Namespace utility
// Params 2
// Checksum 0x76e5bd1, Offset: 0x638d
// Size: 0x1d
function waittill_notify_or_timeout( msg, timer )
{
    self endon( msg );
    wait timer;
}

// Namespace utility
// Params 2
// Checksum 0x63b1823a, Offset: 0x63b2
// Size: 0x29
function function_7ce22801650d61d4( msg, timer )
{
    level endon( #"game_ended" );
    self endon( msg );
    wait timer;
}

// Namespace utility
// Params 2
// Checksum 0xe09e63f4, Offset: 0x63e3
// Size: 0x53
function waittill_notify_or_timeout_return( notifymessage, timer )
{
    notifystruct = spawnstruct();
    thread waittill_notify_proc( notifystruct, notifymessage );
    thread waittill_timeout_proc( notifystruct, timer );
    notifystruct waittill( #"waittill_proc", result );
    return result;
}

// Namespace utility
// Params 2
// Checksum 0x3dc6ad70, Offset: 0x643f
// Size: 0x37
function waittill_notify_proc( notifystruct, notifymessage )
{
    notifystruct endon( #"waittill_proc" );
    self waittill( notifymessage );
    notifystruct notify( #"waittill_proc", notifymessage );
}

// Namespace utility
// Params 2
// Checksum 0x7c50b902, Offset: 0x647e
// Size: 0x43
function function_cbd0402bd3cd13f1( string, ent )
{
    ent endon( #"die" );
    self waittill( string, msg );
    ent notify( #"returned", msg );
}

// Namespace utility
// Params 2
// Checksum 0x532f25c8, Offset: 0x64c9
// Size: 0x4e
function waittill_string( msg, ent )
{
    if ( msg != "death" )
    {
        self endon( #"death" );
    }
    
    ent endon( #"die" );
    self waittill( msg );
    ent notify( #"returned", msg );
}

// Namespace utility
// Params 2
// Checksum 0xd0d8640, Offset: 0x651f
// Size: 0x37
function waittill_string_no_endon_death( msg, ent )
{
    ent endon( #"die" );
    self waittill( msg );
    ent notify( #"returned", msg );
}

// Namespace utility
// Params 3
// Checksum 0x19e92b74, Offset: 0x655e
// Size: 0x4e
function function_bd5f115c5b978f93( entity, message, context )
{
    entity childthread waittill_string( message, context );
    
    if ( !context.var_f866e0b41edac98a )
    {
        context.var_281430b4e3937048++;
        childthread function_cae7240c7de68a7( entity, context );
    }
}

// Namespace utility
// Params 2, eflags: 0x4
// Checksum 0x7e6f9959, Offset: 0x65b4
// Size: 0x153
function private function_85c91016b4b45c34( msg, struct )
{
    if ( msg != "death" )
    {
        self endon( #"death" );
    }
    
    struct endon( #"struct_delete" );
    self waittill( msg, param1, param2, param3, param4, param5, param6, param7, param8, param9, param10 );
    result = [];
    
    if ( isdefined( param1 ) )
    {
        result[ 0 ] = param1;
    }
    
    if ( isdefined( param2 ) )
    {
        result[ 1 ] = param2;
    }
    
    if ( isdefined( param3 ) )
    {
        result[ 2 ] = param3;
    }
    
    if ( isdefined( param4 ) )
    {
        result[ 3 ] = param4;
    }
    
    if ( isdefined( param5 ) )
    {
        result[ 4 ] = param5;
    }
    
    if ( isdefined( param6 ) )
    {
        result[ 5 ] = param6;
    }
    
    if ( isdefined( param7 ) )
    {
        result[ 6 ] = param7;
    }
    
    if ( isdefined( param8 ) )
    {
        result[ 7 ] = param8;
    }
    
    if ( isdefined( param9 ) )
    {
        result[ 8 ] = param9;
    }
    
    if ( isdefined( param10 ) )
    {
        result[ 9 ] = param10;
    }
    
    result[ "ent" ] = self;
    result[ "message" ] = msg;
    struct notify( #"returned", result );
}

// Namespace utility
// Params 2
// Checksum 0xcdc389c, Offset: 0x670f
// Size: 0x37
function waittill_timeout_proc( notifystruct, timeout )
{
    notifystruct endon( #"waittill_proc" );
    wait timeout;
    notifystruct notify( #"waittill_proc", "timeout" );
}

// Namespace utility
// Params 3, eflags: 0x4
// Checksum 0xe5cdffff, Offset: 0x674e
// Size: 0x57
function private function_76c1b3b34ade2ea3( ent, msg, timeout )
{
    self endon( msg );
    wait timeout;
    results = [];
    results[ "ent" ] = undefined;
    results[ "message" ] = "timeout";
    ent notify( #"returned", results );
}

// Namespace utility
// Params 3, eflags: 0x40 variadic
// Checksum 0xa7280729, Offset: 0x67ad
// Size: 0xde
function waittillmatch_any_return( stringmatch, ... )
{
    if ( stringmatch != "death" )
    {
        self endon( #"death" );
    }
    
    ent = spawnstruct();
    
    foreach ( varstring in vararg )
    {
        childthread function_8037626f98cd5225( stringmatch, varstring, ent );
    }
    
    ent waittill( #"returned", msg );
    ent notify( #"die" );
    return msg;
}

// Namespace utility
// Params 3
// Checksum 0xa4348f1b, Offset: 0x6894
// Size: 0x38
function waittillmatch_notify( anim_name, match_msg, notify_str )
{
    self endon( #"death" );
    self waittillmatch( anim_name, match_msg );
    self notify( notify_str );
}

// Namespace utility
// Params 3
// Checksum 0xd79a81ba, Offset: 0x68d4
// Size: 0x43
function function_8037626f98cd5225( stringmatch, msg, ent )
{
    ent endon( #"die" );
    self waittillmatch( stringmatch, msg );
    ent notify( #"returned", msg );
}

// Namespace utility
// Params 0
// Checksum 0xb6e077a1, Offset: 0x691f
// Size: 0x138, Type: bool
function wasdamagedbyexplosive()
{
    if ( isdefined( self.damagemod ) )
    {
        if ( isexplosivedamagemod( self.damagemod ) )
        {
            return true;
        }
        
        if ( isdefined( self.damageweapon ) && shouldburnfromdamage( self.damageweapon ) && !self.var_30465dead0b9fadb )
        {
            return true;
        }
        
        if ( wasdamagedbyoffhandshield() )
        {
            return true;
        }
        
        if ( isdefined( self.attacker ) && self.damagemod == "MOD_MELEE" && self.attacker.unittype == "c8" )
        {
            return true;
        }
    }
    
    if ( gettime() - anim.lastcarexplosiontime <= 50 )
    {
        rangesq = anim.lastcarexplosionrange * anim.lastcarexplosionrange * 1.2 * 1.2;
        
        if ( distancesquared( self.origin, anim.lastcarexplosiondamagelocation ) < rangesq )
        {
            var_abf45e9f7b58c8e1 = rangesq * 0.5 * 0.5;
            self.maydoupwardsdeath = distancesquared( self.origin, anim.lastcarexplosionlocation ) < var_abf45e9f7b58c8e1;
            return true;
        }
    }
    
    return false;
}

// Namespace utility
// Params 3
// Checksum 0xde8fe355, Offset: 0x6a60
// Size: 0x10e
function function_4325398d215ecda5( org, array, maxdist )
{
    closestent = undefined;
    closestdistancesq = isdefined( maxdist ) ? squared( maxdist ) : undefined;
    
    foreach ( ent in array )
    {
        if ( isent( ent ) )
        {
            point = ent.origin;
        }
        else if ( isvector( ent ) )
        {
            point = ent;
        }
        
        if ( !isdefined( point ) )
        {
            continue;
        }
        
        distancesq = distance2dsquared( point, org );
        
        if ( !isdefined( closestdistancesq ) || distancesq < closestdistancesq )
        {
            closestent = ent;
            closestdistancesq = distancesq;
        }
    }
    
    return closestent;
}

// Namespace utility
// Params 4
// Checksum 0x50333090, Offset: 0x6b77
// Size: 0x12b
function function_10d135e2ebebca29( name, type, origin, radius )
{
    assert( isdefined( name ) && isdefined( type ), "<dev string:x49b>" );
    assert( isdefined( origin ) && isdefined( radius ), "<dev string:x4ba>" );
    
    if ( !( isdefined( origin ) && isdefined( radius ) ) )
    {
        return;
    }
    
    structarray = getstructarray( name, type );
    
    if ( structarray.size == 0 )
    {
        return;
    }
    
    bestdistance = radius * radius;
    beststruct = undefined;
    
    foreach ( struct in structarray )
    {
        distancesquared = distancesquared( origin, struct.origin );
        
        if ( distancesquared <= bestdistance )
        {
            bestdistance = distancesquared;
            beststruct = struct;
        }
    }
    
    return beststruct;
}

// Namespace utility
// Params 1
// Checksum 0x6a541a06, Offset: 0x6cab
// Size: 0x101
function getdamagetype( smeansofdeath )
{
    if ( !isdefined( smeansofdeath ) )
    {
        return #"unknown";
    }
    
    switch ( smeansofdeath )
    {
        case #"hash_5f1054c48d66fd1c":
        case #"hash_966768b3f0c94767":
            return #"bullet";
        case #"hash_a5123f4d02745600":
        case #"hash_abb1587cdc6def23":
            return #"melee";
        case #"hash_3c20f39c73a1422b":
        case #"hash_571e46e17a3cf2e3":
        case #"hash_66cb246f3e55fbe2":
        case #"hash_a86d8c43482948a4":
        case #"hash_a911a1880d996edb":
        case #"hash_c22b13f81bed11f0":
            return #"splash";
        case #"hash_b1078ff213fddba6":
            return #"impact";
        case #"hash_1b5395c651f95456":
        case #"hash_61e42661ac27b9f2":
        default:
            return #"unknown";
    }
}

// Namespace utility
// Params 1
// Checksum 0x8bf2dd3b, Offset: 0x6db4
// Size: 0x93, Type: bool
function isprotectedbyriotshield( enemy )
{
    if ( enemy.hasriotshield )
    {
        enemytome = self.origin - enemy.origin;
        enemyfacing = anglestoforward( enemy.angles );
        angletome = vectordot( enemyfacing, enemytome );
        
        if ( enemy.hasriotshieldequipped )
        {
            if ( angletome > 0.766 )
            {
                return true;
            }
        }
        else if ( angletome < -0.766 )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace utility
// Params 5
// Checksum 0xda7b83f2, Offset: 0x6e50
// Size: 0xb2, Type: bool
function function_148a680721859842( point, cylindercenter, cylinderradius, var_affa37a7712516f, var_2c6a84126820785d )
{
    assert( isvector( point ) );
    assert( isvector( cylindercenter ) );
    assert( isnumber( cylinderradius ) );
    assert( isnumber( var_affa37a7712516f ) );
    
    if ( !isdefined( var_2c6a84126820785d ) )
    {
        var_2c6a84126820785d = 0;
    }
    
    assert( isnumber( var_2c6a84126820785d ) );
    
    if ( ispointinsidecircle( point, cylindercenter, cylinderradius ) && point[ 2 ] - cylindercenter[ 2 ] <= var_affa37a7712516f && point[ 2 ] - cylindercenter[ 2 ] >= var_2c6a84126820785d * -1 )
    {
        return true;
    }
    
    return false;
}

// Namespace utility
// Params 5
// Checksum 0x5a1fc742, Offset: 0x6f0b
// Size: 0xcc, Type: bool
function function_3fa3de7c5aef7907( point, corner_a, corner_b, corner_c, corner_d )
{
    corner_a = ( corner_a[ 0 ], corner_a[ 1 ], 0 );
    corner_b = ( corner_b[ 0 ], corner_b[ 1 ], 0 );
    corner_c = ( corner_c[ 0 ], corner_c[ 1 ], 0 );
    corner_d = ( corner_d[ 0 ], corner_d[ 1 ], 0 );
    point = ( point[ 0 ], point[ 1 ], 0 );
    center = vectorlerp( corner_a, corner_c, 0.5 );
    var_78d1e6ceef996a8a = pointonsegmentnearesttopoint( corner_a, corner_b, point );
    var_78ded7ceefa75e12 = pointonsegmentnearesttopoint( corner_b, corner_c, point );
    
    if ( distance2dsquared( center, point ) <= distance2dsquared( center, var_78d1e6ceef996a8a ) && distance2dsquared( center, point ) <= distance2dsquared( center, var_78ded7ceefa75e12 ) )
    {
        return true;
    }
    
    return false;
}

// Namespace utility
// Params 5
// Checksum 0xea98350a, Offset: 0x6fe0
// Size: 0xf6, Type: bool
function function_f1534d42bbbf62e( point, cornera, cornerb, cornerd, epsilon = 1.19209e-07 )
{
    ab = ( cornerb[ 0 ] - cornera[ 0 ], cornerb[ 1 ] - cornera[ 1 ], 0 );
    ap = ( point[ 0 ] - cornera[ 0 ], point[ 1 ] - cornera[ 1 ], 0 );
    var_4c5171d534b77466 = vectordot( ap, ab );
    
    if ( epsilon <= var_4c5171d534b77466 )
    {
        dotab_ab = vectordot( ab, ab );
        
        if ( var_4c5171d534b77466 <= dotab_ab )
        {
            ad = ( cornerd[ 0 ] - cornera[ 0 ], cornerd[ 1 ] - cornera[ 1 ], 0 );
            var_4c5173d534b778cc = vectordot( ap, ad );
            
            if ( epsilon <= var_4c5173d534b778cc )
            {
                var_69b964ed97531f68 = vectordot( ad, ad );
                
                if ( var_4c5173d534b778cc <= var_69b964ed97531f68 )
                {
                    return true;
                }
            }
        }
    }
    
    return false;
}

// Namespace utility
// Params 1
// Checksum 0x51fba69f, Offset: 0x70df
// Size: 0x35
function ispointinwater( point )
{
    excludearray = [];
    return physics_querypoint( point, 0, physics_createcontents( [ "physicscontents_water" ] ), excludearray, "physicsquery_any" );
}

// Namespace utility
// Params 1
// Checksum 0xcfb6d1fe, Offset: 0x711d
// Size: 0xd5, Type: bool
function function_d9f2bbbeb0e054b8( origin )
{
    raycastcontents = physics_createcontents( [ "physicscontents_water", "physicscontents_playerclip" ] );
    raycastend = ( origin[ 0 ], origin[ 1 ], -1000 );
    castresults = physics_raycast( origin, raycastend, raycastcontents, undefined, 0, "physicsquery_closest" );
    
    if ( !isdefined( castresults ) || castresults.size == 0 )
    {
        return false;
    }
    
    surfaceflags = castresults[ 0 ][ "surfaceflags" ];
    var_ec968b73046c4f79 = physics_getsurfacetypefromflags( surfaceflags );
    stringsurfacename = var_ec968b73046c4f79[ "name" ];
    
    if ( isstartstr( stringsurfacename, "surftype_water" ) )
    {
        return false;
    }
    
    closestnavmeshpoint = getclosestpointonnavmesh( castresults[ 0 ][ "position" ] );
    return distance2dsquared( closestnavmeshpoint, origin ) < 1000;
}

// Namespace utility
// Params 1
// Checksum 0xbfabd9dc, Offset: 0x71fb
// Size: 0x137
function isprotectedbyaxeblock( source )
{
    enemy_blocked = 0;
    currentweapon = self getcurrentweapon();
    player_is_ads = self adsbuttonpressed();
    enemy_in_front = 0;
    melee_in_hand = 0;
    melee_weapon_health = 0;
    playerforwardvector = anglestoforward( self.angles );
    playertoenemyvector = vectornormalize( source.origin - self.origin );
    dotproduct = vectordot( playertoenemyvector, playerforwardvector );
    
    if ( dotproduct > 0.5 )
    {
        enemy_in_front = 1;
    }
    
    if ( currentweapon.basename == "iw6_axe_mp" || currentweapon.basename == "iw7_axe_zm" )
    {
        melee_weapon_health = self getcurrentweaponclipammo();
        melee_in_hand = 1;
    }
    
    if ( melee_in_hand && player_is_ads && enemy_in_front && melee_weapon_health > 0 )
    {
        self setweaponammoclip( currentweapon, melee_weapon_health - 1 );
        self playsound( "crate_impact" );
        earthquake( 0.75, 0.5, self.origin, 100 );
        enemy_blocked = 1;
    }
    
    return enemy_blocked;
}

// Namespace utility
// Params 1
// Checksum 0x650ee283, Offset: 0x733b
// Size: 0x6f
function isairdropmarker( weaponname )
{
    switch ( weaponname )
    {
        case #"hash_2f9061ae7f4b0174":
        case #"hash_6b6ba32b55308fd1":
        case #"hash_73258c6de50c988a":
        case #"hash_abb7a2d7e9d5a6ff":
        case #"hash_e64f015026a52907":
        case #"hash_e861ccef0beefbbb":
            return 1;
        default:
            return 0;
    }
}

// Namespace utility
// Params 1
// Checksum 0x344b7035, Offset: 0x73b2
// Size: 0x60, Type: bool
function isdestructibleweapon( weapon )
{
    if ( !isdefined( weapon ) )
    {
        assertmsg( "<dev string:x4df>" );
        return false;
    }
    
    switch ( weapon )
    {
        case #"hash_5e7c026ffa426ef2":
        case #"hash_a2f8ba701e9cf4d4":
        case #"hash_b6aeb2ab5add627b":
        case #"hash_e06c18584a141cef":
            return true;
    }
    
    return false;
}

// Namespace utility
// Params 0
// Checksum 0xbbc71fe, Offset: 0x741b
// Size: 0x34
function enable_pain()
{
    assert( isai( self ), "<dev string:x51b>" );
    self.a.disablepain = 0;
    self.allowpain = 1;
}

// Namespace utility
// Params 0
// Checksum 0xcec0ad95, Offset: 0x7457
// Size: 0x9
function enable_teamflashbangimmunity()
{
    thread enable_teamflashbangimmunity_proc();
}

// Namespace utility
// Params 0, eflags: 0x4
// Checksum 0xf7768a94, Offset: 0x7468
// Size: 0x27
function private enable_teamflashbangimmunity_proc()
{
    self endon( #"death" );
    
    while ( true )
    {
        self.teamflashbangimmunity = 1;
        wait 0.05;
    }
}

// Namespace utility
// Params 0
// Checksum 0xe7cb3c20, Offset: 0x7497
// Size: 0xc
function disable_teamflashbangimmunity()
{
    self.teamflashbangimmunity = undefined;
}

// Namespace utility
// Params 1
// Checksum 0x96b5e702, Offset: 0x74ab
// Size: 0x17
function setflashbangimmunity( immune )
{
    self.flashbangimmunity = immune;
}

// Namespace utility
// Params 1
// Checksum 0x5618e79b, Offset: 0x74ca
// Size: 0x215
function getbestcovermultinodetype( node )
{
    assert( isai( self ) );
    nodetypelist = node getvalidcovermultinodetypes();
    
    if ( nodetypelist.size <= 0 )
    {
        return;
    }
    
    yaw_diff = 0;
    
    if ( isdefined( self.enemy ) )
    {
        enemy_pos = self.enemy.origin;
        
        if ( issentient( self.enemy ) && self lastknowntime( self.enemy ) > 0 )
        {
            enemy_pos = self lastknownpos( self.enemy );
        }
        
        ang_to_enemy = vectortoangles( enemy_pos - node.origin );
        yaw_diff = angleclamp180( ang_to_enemy[ 1 ] - node.angles[ 1 ] );
    }
    
    foreach ( nodetypeit in nodetypelist )
    {
        switch ( nodetypeit )
        {
            case #"hash_78b110033ccb68b0":
            case #"hash_c3b74422dec48736":
                if ( abs( yaw_diff ) < 30 )
                {
                    return nodetypeit;
                }
                
                break;
            case #"hash_55ed607005f12d49":
            case #"hash_e1d8e1adebed5a61":
                if ( yaw_diff > 30 )
                {
                    return "Cover Left";
                }
                
                break;
            case #"hash_667bc7e605903a6c":
            case #"hash_cd3ffe799551db82":
                if ( yaw_diff < -30 )
                {
                    return "Cover Right";
                }
                
                break;
            default:
                assertmsg( "<dev string:x53c>" );
                break;
        }
    }
    
    nodetype = nodetypelist[ 0 ];
    
    switch ( nodetype )
    {
        case #"hash_55ed607005f12d49":
            return "Cover Left";
        case #"hash_667bc7e605903a6c":
            return "Cover Right";
    }
    
    return nodetype;
}

// Namespace utility
// Params 1
// Checksum 0xfbc74b84, Offset: 0x76e8
// Size: 0x5e
function getcamotablecolumnindex( columnname )
{
    switch ( columnname )
    {
        case #"hash_34b6339587dcb48b":
            return 0;
        case #"hash_1a71dd59b555167":
            return 1;
        case #"hash_f545dd6e3ce1266f":
            return 2;
        case #"hash_7398d228375ae0d1":
            return 3;
        default:
            return;
    }
}

// Namespace utility
// Params 0
// Checksum 0x3b9e5825, Offset: 0x774e
// Size: 0x58
function getdifficulty()
{
    assert( isdefined( level.gameskill ) );
    
    if ( level.gameskill < 1 )
    {
        return "easy";
    }
    
    if ( level.gameskill < 2 )
    {
        return "medium";
    }
    
    if ( level.gameskill < 3 )
    {
        return "hard";
    }
    
    return "fu";
}

// Namespace utility
// Params 1
// Checksum 0x9c581c48, Offset: 0x77af
// Size: 0x37
function clear_exception( type )
{
    assert( isdefined( self.exception[ type ] ) );
    self.exception[ type ] = anim.defaultexception;
}

// Namespace utility
// Params 0
// Checksum 0x96dc1c01, Offset: 0x77ee
// Size: 0x8
function clear_movement_speed()
{
    self aiclearscriptdesiredspeed();
}

// Namespace utility
// Params 0
// Checksum 0xed270a8c, Offset: 0x77fe
// Size: 0x1f
function clear_partition()
{
    assert( is_partition(), "<dev string:x572>" );
    self.array = [];
}

// Namespace utility
// Params 1
// Checksum 0x4745750, Offset: 0x7825
// Size: 0x29, Type: bool
function flag( message )
{
    assert( isdefined( message ), "<dev string:x5cd>" );
    return istrue( level.flag[ message ] );
}

/#

    // Namespace utility
    // Params 1
    // Checksum 0x24dd2660, Offset: 0x7857
    // Size: 0x2b, Type: dev
    function flag_assert( msg )
    {
        assert( !flag( msg ), "<dev string:x5ff>" + msg + "<dev string:x605>" );
    }

#/

// Namespace utility
// Params 1
// Checksum 0xc91065be, Offset: 0x788a
// Size: 0x35
function flag_clear( message )
{
    if ( !flag( message ) )
    {
        return;
    }
    
    level.flag[ message ] = 0;
    set_trigger_flag_permissions( message );
    level notify( message );
}

// Namespace utility
// Params 1
// Checksum 0x608a6d64, Offset: 0x78c7
// Size: 0x19, Type: bool
function flag_exist( message )
{
    return isdefined( level.flag[ message ] );
}

// Namespace utility
// Params 1
// Checksum 0xc21266c, Offset: 0x78e9
// Size: 0x83
function flag_init( message )
{
    if ( !isdefined( level.flag ) )
    {
        flags::init_flags();
    }
    
    /#
        if ( level.first_frame == -1 )
        {
            assert( !isdefined( level.flag[ message ] ), "<dev string:x614>" + message );
        }
    #/
    
    level.flag[ message ] = 0;
    init_trigger_flags();
    
    if ( !isdefined( level.trigger_flags[ message ] ) )
    {
        level.trigger_flags[ message ] = [];
    }
}

// Namespace utility
// Params 2
// Checksum 0xa947f86a, Offset: 0x7974
// Size: 0x56
function flag_set( message, setter )
{
    if ( !flag_exist( message ) )
    {
        flag_init( message );
    }
    
    level.flag[ message ] = 1;
    set_trigger_flag_permissions( message );
    
    if ( isdefined( setter ) )
    {
        level notify( message, setter );
        return;
    }
    
    level notify( message );
}

// Namespace utility
// Params 1
// Checksum 0x6dce5ab0, Offset: 0x79d2
// Size: 0x7e
function flag_set_array( flag_array )
{
    foreach ( flg in flag_array )
    {
        flag_set( flg );
    }
}

// Namespace utility
// Params 3
// Checksum 0x73a0c59d, Offset: 0x7a58
// Size: 0x2b
function flag_set_delayed( message, delay, setter )
{
    wait delay;
    flag_set( message, setter );
}

// Namespace utility
// Params 5, eflags: 0x40 variadic
// Checksum 0xf70a2a6e, Offset: 0x7a8b
// Size: 0x6c
function function_5085f5ebc9b25c97( flags, delay, condition, ... )
{
    level endon( #"game_ended" );
    
    while ( ![[ condition ]]( flat_args( vararg, varargcount ) ) )
    {
        wait delay;
    }
    
    if ( isarray( flags ) )
    {
        flag_set_array( flags );
        return;
    }
    
    flag_set( flags );
}

// Namespace utility
// Params 1
// Checksum 0x2ab5b970, Offset: 0x7aff
// Size: 0x21
function flag_wait( msg )
{
    while ( !flag( msg ) )
    {
        level waittill( msg );
    }
}

// Namespace utility
// Params 2, eflags: 0x40 variadic
// Checksum 0xee098b77, Offset: 0x7b28
// Size: 0x87
function flag_wait_all( ... )
{
    foreach ( varflag in vararg )
    {
        flag_wait( varflag );
    }
}

// Namespace utility
// Params 1
// Checksum 0xecaffc6c, Offset: 0x7bb7
// Size: 0x10c
function flag_wait_all_array( flags )
{
    flags = function_5713d46873b29625( flags );
    
    for ( ;; )
    {
        foreach ( flagname in flags )
        {
            flag_wait( flagname );
        }
        
        flagsetcount = 0;
        
        foreach ( flagname in flags )
        {
            if ( flag( flagname ) )
            {
                flagsetcount++;
            }
        }
        
        if ( flagsetcount == flags.size )
        {
            break;
        }
    }
}

// Namespace utility
// Params 2, eflags: 0x40 variadic
// Checksum 0xad389583, Offset: 0x7ccb
// Size: 0xaf
function flag_wait_any( ... )
{
    if ( varargcount < 2 )
    {
        assertmsg( "<dev string:x63c>" );
        return;
    }
    
    for ( ;; )
    {
        foreach ( varflag in vararg )
        {
            if ( flag( varflag ) )
            {
                return;
            }
        }
        
        level waittill_any( flat_args( vararg, varargcount ) );
    }
}

// Namespace utility
// Params 1
// Checksum 0x75574b5f, Offset: 0x7d82
// Size: 0x61
function flag_wait_any_array( flags )
{
    assert( isarray( flags ), "<dev string:x670>" );
    flags = function_5713d46873b29625( flags );
    
    for ( ;; )
    {
        for ( i = 0; i < flags.size ; i++ )
        {
            if ( flag( flags[ i ] ) )
            {
                return flags[ i ];
            }
        }
        
        level waittill_any_in_array( flags );
    }
}

// Namespace utility
// Params 1
// Checksum 0x52a45e32, Offset: 0x7deb
// Size: 0x14
function flag_wait_any_array_return( flags )
{
    return flag_wait_any_array( flags );
}

// Namespace utility
// Params 2, eflags: 0x40 variadic
// Checksum 0xa5514065, Offset: 0x7e08
// Size: 0xb9
function flag_wait_any_return( ... )
{
    if ( varargcount < 2 )
    {
        assertmsg( "<dev string:x6ac>" );
        return;
    }
    
    foreach ( varflag in vararg )
    {
        if ( flag( varflag ) )
        {
            return varflag;
        }
    }
    
    msg = level waittill_any_return( flat_args( vararg, varargcount ) );
    return msg;
}

// Namespace utility
// Params 3, eflags: 0x40 variadic
// Checksum 0xe206cc25, Offset: 0x7ecd
// Size: 0x11f
function flag_wait_any_timeout( timer, ... )
{
    if ( varargcount < 2 )
    {
        assertmsg( "<dev string:x6e7>" );
        return;
    }
    
    assert( timer > 0, "<dev string:x723>" );
    timerms = timer * 1000;
    start_time = gettime();
    
    for ( ;; )
    {
        foreach ( varflag in vararg )
        {
            if ( flag( varflag ) )
            {
                return;
            }
        }
        
        curr_time = gettime();
        
        if ( curr_time >= start_time + timerms )
        {
            break;
        }
        
        timeremaining = timerms - curr_time - start_time;
        timeremainingsecs = timeremaining / 1000;
        internal_wait_for_any_flag_or_time_elapses( vararg, timeremainingsecs );
    }
}

// Namespace utility
// Params 2
// Checksum 0xd1013b2a, Offset: 0x7ff4
// Size: 0x83
function flag_wait_or_timeout( flagname, timer )
{
    timerms = timer * 1000;
    start_time = gettime();
    
    for ( ;; )
    {
        if ( flag( flagname ) )
        {
            break;
        }
        
        if ( gettime() >= start_time + timerms )
        {
            break;
        }
        
        timeremaining = timerms - gettime() - start_time;
        timeremainingsecs = timeremaining / 1000;
        wait_for_flag_or_time_elapses( flagname, timeremainingsecs );
    }
}

// Namespace utility
// Params 1
// Checksum 0x1421bd4c, Offset: 0x807f
// Size: 0x20
function flag_waitopen( msg )
{
    while ( flag( msg ) )
    {
        level waittill( msg );
    }
}

// Namespace utility
// Params 1
// Checksum 0xdf49690f, Offset: 0x80a7
// Size: 0x10d
function flag_waitopen_all_array( flags )
{
    flags = function_5713d46873b29625( flags );
    
    for ( ;; )
    {
        foreach ( flagname in flags )
        {
            flag_waitopen( flagname );
        }
        
        var_9527b70f552d82a8 = 0;
        
        foreach ( flagname in flags )
        {
            if ( !flag( flagname ) )
            {
                var_9527b70f552d82a8++;
            }
        }
        
        if ( var_9527b70f552d82a8 == flags.size )
        {
            break;
        }
    }
}

// Namespace utility
// Params 2, eflags: 0x40 variadic
// Checksum 0xc490363d, Offset: 0x81bc
// Size: 0x1e
function flag_waitopen_any( ... )
{
    flag_waitopen_any_in_array( vararg );
}

// Namespace utility
// Params 1
// Checksum 0x4cb12a5b, Offset: 0x81e2
// Size: 0xaa
function flag_waitopen_any_in_array( flags )
{
    flags = function_5713d46873b29625( flags );
    
    foreach ( f in flags )
    {
        if ( !flag( f ) )
        {
            return;
        }
    }
    
    while ( true )
    {
        f = level waittill_any_in_array_return( flags );
        
        if ( !flag( f ) )
        {
            return;
        }
    }
}

// Namespace utility
// Params 2
// Checksum 0x512f3d11, Offset: 0x8294
// Size: 0x54
function flag_waitopen_or_timeout( flagname, timer )
{
    start_time = gettime();
    
    for ( ;; )
    {
        if ( !flag( flagname ) )
        {
            break;
        }
        
        if ( gettime() >= start_time + timer * 1000 )
        {
            break;
        }
        
        wait_for_flag_or_time_elapses( flagname, timer );
    }
}

// Namespace utility
// Params 0
// Checksum 0x2b843331, Offset: 0x82f0
// Size: 0xc
function flashbangstop()
{
    self.flashendtime = undefined;
}

// Namespace utility
// Params 2, eflags: 0x40 variadic
// Checksum 0xfd747713, Offset: 0x8304
// Size: 0x15
function empty_init_func( ... )
{
    
}

// Namespace utility
// Params 1
// Checksum 0xbb98c51b, Offset: 0x8321
// Size: 0x4b
function enable_cqbwalk( autoenabled )
{
    if ( self.type == "dog" )
    {
        return;
    }
    
    if ( !isdefined( autoenabled ) )
    {
        self.cqbenabled = 1;
    }
    
    self.turnrate = 0.2;
    demeanor_override( "cqb" );
}

// Namespace utility
// Params 1
// Checksum 0x41481ff1, Offset: 0x8374
// Size: 0x33
function destroy_on_death( ent )
{
    ent endon( #"death" );
    self waittill( #"death" );
    
    if ( isdefined( ent ) )
    {
        ent destroy();
    }
}

// Namespace utility
// Params 0
// Checksum 0xeca6b37a, Offset: 0x83af
// Size: 0x61
function disable_cqbwalk()
{
    if ( self.type == "dog" )
    {
        return;
    }
    
    self.cqbenabled = undefined;
    self.turnrate = 0.3;
    
    if ( isdefined( self.cqb_point_of_interest ) )
    {
        self.cqb_point_of_interest = undefined;
        self function_e885c7bb61b04474( 0 );
    }
    
    /#
        self notify( #"hash_109d4c39cc7ff8ef" );
    #/
    
    clear_demeanor_override();
}

// Namespace utility
// Params 4, eflags: 0x40 variadic
// Checksum 0x513f44e3, Offset: 0x8418
// Size: 0x35
function delaycall( timer, func, ... )
{
    thread delaycall_proc( func, undefined, timer, varargcount, vararg );
}

// Namespace utility
// Params 5, eflags: 0x4
// Checksum 0x95393139, Offset: 0x8455
// Size: 0x12b
function private delaycall_proc( func, endonevent, timer, varargcount, vararg )
{
    if ( issp() )
    {
        self endon( #"death" );
        self endon( #"stop_delay_call" );
    }
    
    if ( isdefined( endonevent ) )
    {
        if ( !isarray( endonevent ) )
        {
            endonevent = [ endonevent ];
        }
        
        foreach ( endonname in endonevent )
        {
            self endon( endonname );
        }
    }
    
    wait timer;
    
    if ( issp() )
    {
        if ( isdefined( self ) && isdefined( func ) )
        {
            self builtin [[ func ]]( flat_args( vararg, varargcount ) );
        }
        
        return;
    }
    
    if ( isdefined( self ) )
    {
        if ( isbuiltinfunction( func ) || isbuiltinmethod( func ) )
        {
            self builtin [[ func ]]( flat_args( vararg, varargcount ) );
            return;
        }
        
        self [[ func ]]( flat_args( vararg, varargcount ) );
    }
}

// Namespace utility
// Params 5, eflags: 0x40 variadic
// Checksum 0x7d5ba68c, Offset: 0x8588
// Size: 0x3e
function delaycallendon( timer, endonevent, func, ... )
{
    thread delaycall_proc( func, endonevent, timer, varargcount, vararg );
}

// Namespace utility
// Params 4, eflags: 0x40 variadic
// Checksum 0x20d463c, Offset: 0x85ce
// Size: 0x37
function delaythread( timer, func, ... )
{
    thread delaythread_internal( timer, undefined, func, undefined, varargcount, vararg );
}

// Namespace utility
// Params 6
// Checksum 0xd8c0b18b, Offset: 0x860d
// Size: 0x114
function delaythread_internal( timer, endonevent, func, threaduid, varargcount, vararg )
{
    if ( isdefined( self ) && !isarray( self ) )
    {
        self endon( #"stop_delay_thread" );
        self endon( #"death_or_disconnect" );
        
        if ( isdefined( endonevent ) )
        {
            if ( !isarray( endonevent ) )
            {
                endonevent = [ endonevent ];
            }
            
            foreach ( endonname in endonevent )
            {
                self endon( endonname );
            }
        }
    }
    
    if ( timer < 0 )
    {
        waitframe();
    }
    else
    {
        wait timer;
    }
    
    if ( threaduid )
    {
        self.pendingdelaythread[ threaduid ] = undefined;
    }
    
    if ( func )
    {
        thread [[ func ]]( flat_args( vararg, varargcount ) );
    }
}

// Namespace utility
// Params 6, eflags: 0x4
// Checksum 0xcc6f7237, Offset: 0x8729
// Size: 0x118
function private function_497f28b18d6094f5( timer, endonevent, func, threaduid, varargcount, vararg )
{
    self endon( "stop_delay_thread_" + threaduid );
    
    if ( isdefined( self ) && !isarray( self ) )
    {
        self endon( #"stop_delay_thread" );
        
        if ( isdefined( endonevent ) )
        {
            if ( !isarray( endonevent ) )
            {
                endonevent = [ endonevent ];
            }
            
            foreach ( endonname in endonevent )
            {
                self endon( endonname );
            }
        }
    }
    
    if ( timer < 0 )
    {
        waitframe();
    }
    else
    {
        wait timer;
    }
    
    if ( threaduid && self )
    {
        self.pendingdelaythread[ threaduid ] = undefined;
    }
    
    if ( func )
    {
        thread [[ func ]]( flat_args( vararg, varargcount ) );
    }
}

// Namespace utility
// Params 5, eflags: 0x40 variadic
// Checksum 0xe4cb0fa7, Offset: 0x8849
// Size: 0x3f
function delaythreadendon( timer, endonevent, func, ... )
{
    thread delaythread_internal( timer, endonevent, func, undefined, varargcount, vararg );
}

// Namespace utility
// Params 6, eflags: 0x40 variadic
// Checksum 0xe9543e9d, Offset: 0x8890
// Size: 0xb7
function function_a9cdce367aa4fef5( threaduid, timer, endonevent, func, ... )
{
    self notify( "stop_delay_thread_" + threaduid );
    self endon( "stop_delay_thread_" + threaduid );
    
    if ( !isdefined( self.pendingdelaythread ) )
    {
        self.pendingdelaythread = [];
    }
    
    self.pendingdelaythread[ threaduid ] = 1;
    
    if ( !isdefined( endonevent ) )
    {
        endonevent = [];
    }
    
    if ( !isarray( endonevent ) )
    {
        endonevent = [ endonevent ];
    }
    
    endonevent[ endonevent.size ] = #"stop_delay_thread";
    thread function_871075c166bd1ba2( threaduid, endonevent );
    thread function_497f28b18d6094f5( timer, endonevent, func, threaduid, varargcount, vararg );
}

// Namespace utility
// Params 2, eflags: 0x4
// Checksum 0x9e90adf2, Offset: 0x894f
// Size: 0x3f
function private function_871075c166bd1ba2( threaduid, endonevent )
{
    self endon( "stop_delay_thread_" + threaduid );
    waittill_any_in_array( endonevent );
    
    if ( threaduid && self )
    {
        self.pendingdelaythread[ threaduid ] = undefined;
    }
}

// Namespace utility
// Params 1
// Checksum 0xfe5d07c5, Offset: 0x8996
// Size: 0x1a
function delete_after_delay( delay )
{
    wait delay;
    
    if ( isdefined( self ) )
    {
        self delete();
    }
}

// Namespace utility
// Params 2
// Checksum 0xbf8992e8, Offset: 0x89b8
// Size: 0x28
function function_9a9165839779317f( ent, msg )
{
    self waittill( msg );
    
    if ( isdefined( ent ) )
    {
        ent delete();
    }
}

// Namespace utility
// Params 1
// Checksum 0x42c57843, Offset: 0x89e8
// Size: 0x15
function delete_exploder( num )
{
    exploder::delete_exploder_proc( num );
}

// Namespace utility
// Params 2
// Checksum 0x6ca7b724, Offset: 0x8a05
// Size: 0x44
function delete_on_death( ent, var_576f92913177486d )
{
    ent endon( #"death" );
    self waittill( #"death" );
    
    if ( var_576f92913177486d )
    {
        wait var_576f92913177486d;
    }
    
    if ( isdefined( ent ) )
    {
        ent delete();
    }
}

// Namespace utility
// Params 1
// Checksum 0x8afb2f25, Offset: 0x8a51
// Size: 0x33
function delete_on_flag( msg )
{
    self endon( #"death" );
    self endon( #"entitydeleted" );
    flag_wait( msg );
    self delete();
}

// Namespace utility
// Params 1
// Checksum 0xb1fd26c9, Offset: 0x8a8c
// Size: 0x18
function delete_on_notify( msg )
{
    self waittill( msg );
    self delete();
}

// Namespace utility
// Params 1
// Checksum 0xc57f615, Offset: 0x8aac
// Size: 0x34
function delete_on_removed( ent )
{
    ent endon( #"death" );
    
    while ( isdefined( self ) )
    {
        wait 0.05;
    }
    
    if ( isdefined( ent ) )
    {
        ent delete();
    }
}

// Namespace utility
// Params 2
// Checksum 0x50c41657, Offset: 0x8ae8
// Size: 0x26
function function_fb5b19421bb35e50( object, string )
{
    object waittill( string );
    
    if ( isdefined( self ) )
    {
        self delete();
    }
}

// Namespace utility
// Params 1
// Checksum 0x6db7d468, Offset: 0x8b16
// Size: 0x457
function deletestruct_ref( struct )
{
    if ( !isdefined( struct ) )
    {
        return;
    }
    
    value = struct.script_linkname;
    
    if ( isdefined( value ) && isdefined( level.struct_class_names[ "script_linkname" ][ value ] ) )
    {
        foreach ( i, _struct in level.struct_class_names[ "script_linkname" ][ value ] )
        {
            if ( struct == _struct )
            {
                level.struct_class_names[ "script_linkname" ][ value ][ i ] = undefined;
            }
        }
        
        if ( level.struct_class_names[ "script_linkname" ][ value ].size == 0 )
        {
            level.struct_class_names[ "script_linkname" ][ value ] = undefined;
        }
    }
    
    value = struct.script_noteworthy;
    
    if ( isdefined( value ) && isdefined( level.struct_class_names[ "script_noteworthy" ][ value ] ) )
    {
        foreach ( i, _struct in level.struct_class_names[ "script_noteworthy" ][ value ] )
        {
            if ( struct == _struct )
            {
                level.struct_class_names[ "script_noteworthy" ][ value ][ i ] = undefined;
            }
        }
        
        if ( level.struct_class_names[ "script_noteworthy" ][ value ].size == 0 )
        {
            level.struct_class_names[ "script_noteworthy" ][ value ] = undefined;
        }
    }
    
    value = struct.script_label;
    
    if ( isdefined( value ) && isdefined( level.struct_class_names[ "script_label" ][ value ] ) )
    {
        foreach ( i, _struct in level.struct_class_names[ "script_label" ][ value ] )
        {
            if ( struct == _struct )
            {
                level.struct_class_names[ "script_label" ][ value ][ i ] = undefined;
            }
        }
        
        if ( level.struct_class_names[ "script_label" ][ value ].size == 0 )
        {
            level.struct_class_names[ "script_label" ][ value ] = undefined;
        }
    }
    
    value = struct.target;
    
    if ( isdefined( value ) && isdefined( level.struct_class_names[ "target" ][ value ] ) )
    {
        foreach ( i, _struct in level.struct_class_names[ "target" ][ value ] )
        {
            if ( struct == _struct )
            {
                level.struct_class_names[ "target" ][ value ][ i ] = undefined;
            }
        }
        
        if ( level.struct_class_names[ "target" ][ value ].size == 0 )
        {
            level.struct_class_names[ "target" ][ value ] = undefined;
        }
    }
    
    value = struct.targetname;
    
    if ( isdefined( value ) && isdefined( level.struct_class_names[ "targetname" ][ value ] ) )
    {
        foreach ( i, _struct in level.struct_class_names[ "targetname" ][ value ] )
        {
            if ( struct == _struct )
            {
                level.struct_class_names[ "targetname" ][ value ][ i ] = undefined;
            }
        }
        
        if ( level.struct_class_names[ "targetname" ][ value ].size == 0 )
        {
            level.struct_class_names[ "targetname" ][ value ] = undefined;
        }
    }
}

// Namespace utility
// Params 2
// Checksum 0xd209595f, Offset: 0x8f75
// Size: 0x127
function deletestructarray_ref( structs, delay )
{
    if ( !isarray( structs ) || structs.size == 0 )
    {
        return;
    }
    
    if ( !isdefined( delay ) )
    {
        delay = 0;
    }
    
    delay = delay > 0 ? delay : 0;
    
    if ( delay > 0 )
    {
        foreach ( struct in structs )
        {
            deletestruct_ref( struct );
            wait delay;
        }
        
        return;
    }
    
    foreach ( struct in structs )
    {
        deletestruct_ref( struct );
    }
}

// Namespace utility
// Params 1
// Checksum 0xc13d3d4b, Offset: 0x90a4
// Size: 0x5f
function demeanor_override( demeanor )
{
    self clearoverridearchetype( "demeanor", 0, 0 );
    basearchetype = self getbasearchetype();
    demeanorarchetype = basearchetype + "_" + demeanor;
    
    if ( archetypeassetloaded( demeanorarchetype ) )
    {
        self setoverridearchetype( "demeanor", demeanorarchetype, 1 );
    }
    
    self demeanoroverride( demeanor );
}

// Namespace utility
// Params 2
// Checksum 0x2fdbd3cd, Offset: 0x910b
// Size: 0x3c
function function_911d2d3c6d773726( storage_int, flag_index )
{
    assert( flag_index >= 0 && flag_index <= 30, "<dev string:x76e>" );
    storage_int &= ~( 1 << flag_index );
    return storage_int;
}

// Namespace utility
// Params 0
// Checksum 0x4970fefa, Offset: 0x9150
// Size: 0x16
function clear_demeanor_override()
{
    self clearoverridearchetype( "demeanor", 0, 1 );
    self cleardemeanoroverride();
}

// Namespace utility
// Params 1
// Checksum 0x656a600d, Offset: 0x916e
// Size: 0x39, Type: bool
function isweaponinitialized( objweapon )
{
    assert( isweapon( objweapon ) );
    weaponname = getcompleteweaponname( objweapon );
    return isdefined( self.weaponinfo[ weaponname ] );
}

// Namespace utility
// Params 0
// Checksum 0xcb53f10c, Offset: 0x91b0
// Size: 0x44
function init_trigger_flags()
{
    if ( !add_init_script( "trigger_flags", &init_trigger_flags ) )
    {
        return;
    }
    
    level.trigger_flags = [];
    level.trigger_func[ 1 ] = &trigger_on;
    level.trigger_func[ 0 ] = &trigger_off;
}

// Namespace utility
// Params 1
// Checksum 0x8e40767b, Offset: 0x91fc
// Size: 0xb3
function initweapon( objweapon )
{
    assert( isweapon( objweapon ) );
    weaponname = getcompleteweaponname( objweapon );
    self.weaponinfo[ weaponname ] = spawnstruct();
    self.weaponinfo[ weaponname ].position = "none";
    self.weaponinfo[ weaponname ].hasclip = 1;
    
    if ( issp() )
    {
        self.weaponinfo[ weaponname ].useclip = objweapon function_d4b37be81fe8abbf();
        return;
    }
    
    self.weaponinfo[ weaponname ].useclip = 0;
}

// Namespace utility
// Params 0
// Checksum 0x451a2093, Offset: 0x92b7
// Size: 0xb3
function function_d43a7e1cc86b52b0()
{
    sharedsettings = getscriptbundle( %"hash_5d2895ef18b1a537" );
    self.pers[ "sharedGamerProfiles" ] = [];
    
    foreach ( gamerprofile in sharedsettings.optionslist )
    {
        ui::lui_registercallback( gamerprofile.gamerprofileref, &function_e181ee0008ac136f );
    }
}

// Namespace utility
// Params 1, eflags: 0x4
// Checksum 0xc104995d, Offset: 0x9372
// Size: 0x59
function private function_e181ee0008ac136f( value )
{
    if ( isdefined( self.pers[ "sharedGamerProfiles" ] ) )
    {
        gamerprofile = self.var_b458a7ace288c777;
        self.pers[ "sharedGamerProfiles" ][ gamerprofile ] = value;
        ui::lui_notify_callback( gamerprofile + "_updated", value, undefined );
    }
}

// Namespace utility
// Params 0
// Checksum 0xac581e85, Offset: 0x93d3
// Size: 0xa9
function function_182a53e9f537187f()
{
    self endon( #"death" );
    
    while ( level.riotshielddamagefeedback )
    {
        waitframe();
        self waittill( #"bullet_hitshield", dmg, attacker );
        
        if ( isplayer( attacker ) )
        {
            level.player setclientomnvar( "damage_feedback_icon", "hitnobulletdamage" );
            level.player setclientomnvar( "damage_feedback_icon_notify", gettime() );
            hitsound = "hit_marker_3d_armor";
            
            if ( soundexists( hitsound ) )
            {
                thread play_sound_in_space( hitsound, self.origin );
            }
            
            wait 0.05;
        }
    }
}

// Namespace utility
// Params 0
// Checksum 0x46b40d05, Offset: 0x9484
// Size: 0x20
function get_doublejumpenergy()
{
    if ( !isdefined( self.doublejumpenergy ) )
    {
        return self energy_getenergy( 0 );
    }
    
    return self.doublejumpenergy;
}

// Namespace utility
// Params 2
// Checksum 0x30740a68, Offset: 0x94ad
// Size: 0x3b
function set_bit_flag( storage_int, flag_index )
{
    assert( flag_index >= 0 && flag_index <= 30, "<dev string:x76e>" );
    storage_int |= 1 << flag_index;
    return storage_int;
}

// Namespace utility
// Params 1
// Checksum 0x254b1b10, Offset: 0x94f1
// Size: 0x17
function set_cautious_navigation( enabled )
{
    self.cautiousnavigation = enabled;
}

// Namespace utility
// Params 0
// Checksum 0xa8842240, Offset: 0x9510
// Size: 0x2f
function set_createfx_enabled()
{
    if ( !isdefined( level.createfx_enabled ) )
    {
        level.createfx_enabled = getdvar( @"createfx", "" ) != "";
    }
}

// Namespace utility
// Params 1
// Checksum 0x4c4063b, Offset: 0x9547
// Size: 0x31
function set_doublejumpenergy( value )
{
    if ( !isdefined( self.doublejumpenergy ) )
    {
        self energy_setenergy( 0, value );
        return;
    }
    
    self.doublejumpenergy = value;
}

// Namespace utility
// Params 0
// Checksum 0xff558acc, Offset: 0x9580
// Size: 0x20
function get_doublejumpenergyrestorerate()
{
    if ( !isdefined( self.doublejumpenergyrestorerate ) )
    {
        return self energy_getrestorerate( 0 );
    }
    
    return self.doublejumpenergyrestorerate;
}

// Namespace utility
// Params 1
// Checksum 0x48dd4fd0, Offset: 0x95a9
// Size: 0x31
function set_doublejumpenergyrestorerate( value )
{
    if ( !isdefined( self.doublejumpenergyrestorerate ) )
    {
        self energy_setrestorerate( 0, value );
        return;
    }
    
    self.doublejumpenergyrestorerate = value;
}

// Namespace utility
// Params 0
// Checksum 0xcde65c77, Offset: 0x95e2
// Size: 0xf
function playerarmorenabled()
{
    return getdvarint( @"scr_player_armor_enabled" );
}

// Namespace utility
// Params 0
// Checksum 0xdf7c03ab, Offset: 0x95fa
// Size: 0xf
function playerhelmetenabled()
{
    return getdvarint( @"hash_425e93b8de8f141c" );
}

// Namespace utility
// Params 1
// Checksum 0x58bc42b8, Offset: 0x9612
// Size: 0x107
function function_dc226e1c2f06ea0b( bundlename )
{
    if ( !isxhashasset( bundlename ) )
    {
        bundlename = getxhashasset( tolower( bundlename ) );
    }
    
    if ( !isdefined( level.globalbundles ) )
    {
        level.globalbundles = [];
    }
    
    if ( !isdefined( level.globalbundles[ bundlename ] ) )
    {
        level.globalbundles[ bundlename ] = [];
        level.globalbundles[ bundlename ][ 0 ] = getscriptbundle( bundlename );
        
        if ( isdefined( level.globalbundles[ bundlename ][ 0 ] ) )
        {
            if ( !isdefined( level.globalbundles[ bundlename ][ 0 ].var_5d185975a2bb0b35 ) )
            {
                level.globalbundles[ bundlename ][ 0 ].var_5d185975a2bb0b35 = bundlename;
            }
            
            level.globalbundles[ bundlename ][ 1 ] = 0;
        }
        else
        {
            level.globalbundles[ bundlename ] = undefined;
            return;
        }
    }
    
    level.globalbundles[ bundlename ][ 1 ] += 1;
    return level.globalbundles[ bundlename ][ 0 ];
}

// Namespace utility
// Params 1
// Checksum 0x69917adc, Offset: 0x9722
// Size: 0xa2
function function_cacdd05a312a4bf0( bundlestruct )
{
    if ( !isdefined( bundlestruct ) )
    {
        return;
    }
    
    if ( !isdefined( level.globalbundles ) )
    {
        return;
    }
    
    assert( isdefined( bundlestruct.var_5d185975a2bb0b35 ) );
    bundlename = bundlestruct.var_5d185975a2bb0b35;
    
    if ( !isdefined( level.globalbundles[ bundlename ] ) )
    {
        return;
    }
    
    level.globalbundles[ bundlename ][ 1 ] -= 1;
    
    if ( level.globalbundles[ bundlename ][ 1 ] <= 0 )
    {
        level.globalbundles[ bundlename ] = undefined;
    }
}

// Namespace utility
// Params 2
// Checksum 0x12d45e2a, Offset: 0x97cc
// Size: 0x25
function groundpos( origin, up )
{
    return drop_to_ground( origin, 0, -100000, up );
}

// Namespace utility
// Params 1
// Checksum 0xb08a5cb7, Offset: 0x97fa
// Size: 0x2a
function vectorsign( vec )
{
    return ( sign( vec[ 0 ] ), sign( vec[ 1 ] ), sign( vec[ 2 ] ) );
}

// Namespace utility
// Params 0
// Checksum 0xc4ddb34a, Offset: 0x982d
// Size: 0x9
function vehicle_detachfrompath()
{
    vehicle_code::vehicle_pathdetach();
}

// Namespace utility
// Params 0
// Checksum 0xa3ba9b9, Offset: 0x983e
// Size: 0x9
function vehicle_resumepath()
{
    thread vehicle_paths::vehicle_resumepathvehicle();
}

// Namespace utility
// Params 2
// Checksum 0x34772ae6, Offset: 0x984f
// Size: 0x1f
function vehicle_dynamicpath( node, var_847b4b4977c8450 )
{
    vehicle::vehicle_paths( node, var_847b4b4977c8450 );
}

// Namespace utility
// Params 3
// Checksum 0x21180363, Offset: 0x9876
// Size: 0x4a
function getvehiclespawner( value, key, allowundefined )
{
    spawners = getvehiclespawnerarray( value, key );
    
    if ( !allowundefined )
    {
        assert( spawners.size == 1 );
    }
    
    return spawners[ 0 ];
}

// Namespace utility
// Params 2
// Checksum 0xdd4e4d6a, Offset: 0x98c9
// Size: 0x1e
function getvehiclespawnerarray( value, key )
{
    return vehicle_code::_getvehiclespawnerarray( value, key );
}

// Namespace utility
// Params 3
// Checksum 0x9bf804a2, Offset: 0x98f0
// Size: 0x9c
function getpredictedaimpitchtoshootentorpos3d( time, shootent, shootpos )
{
    if ( !isdefined( shootent ) )
    {
        if ( !isdefined( shootpos ) )
        {
            return 0;
        }
        
        return getaimpitchtopoint3d( shootpos );
    }
    
    v = ( 0, 0, 0 );
    
    if ( isplayer( shootent ) )
    {
        v = shootent getvelocity();
    }
    else if ( isai( shootent ) )
    {
        v = shootent.velocity;
    }
    
    predictedpos = shootent.origin + v * time;
    return getaimpitchtopoint3d( predictedpos );
}

// Namespace utility
// Params 3
// Checksum 0xdd43fa09, Offset: 0x9995
// Size: 0x9c
function getpredictedaimyawtoshootentorpos( time, shootent, shootpos )
{
    if ( !isdefined( shootent ) )
    {
        if ( !isdefined( shootpos ) )
        {
            return 0;
        }
        
        return getaimyawtopoint( shootpos );
    }
    
    v = ( 0, 0, 0 );
    
    if ( isplayer( shootent ) )
    {
        v = shootent getvelocity();
    }
    else if ( isai( shootent ) )
    {
        v = shootent.velocity;
    }
    
    predictedpos = shootent.origin + v * time;
    return getaimyawtopoint( predictedpos );
}

// Namespace utility
// Params 3
// Checksum 0x856581b6, Offset: 0x9a3a
// Size: 0x9c
function getpredictedaimyawtoshootentorpos3d( time, shootent, shootpos )
{
    if ( !isdefined( shootent ) )
    {
        if ( !isdefined( shootpos ) )
        {
            return 0;
        }
        
        return getaimyawtopoint3d( shootpos );
    }
    
    v = ( 0, 0, 0 );
    
    if ( isplayer( shootent ) )
    {
        v = shootent getvelocity();
    }
    else if ( isai( shootent ) )
    {
        v = shootent.velocity;
    }
    
    predictedpos = shootent.origin + v * time;
    return getaimyawtopoint3d( predictedpos );
}

// Namespace utility
// Params 9
// Checksum 0x916d5153, Offset: 0x9adf
// Size: 0x277
function function_d0e6aed2d8648374( start_pos, vel, accel, contentoverride, ignoreents, max_time = 8, delta_time = 0.15, debug_color, var_afe7fa4c43ea8c61 = 0 )
{
    level endon( #"game_ended" );
    
    /#
        debug_render = getdvarint( @"hash_f6e0be2a1a634e44", 0 );
        
        if ( debug_render )
        {
            debug_duration_frames = getdvarint( @"hash_d69378863f107ad1", 1 );
            debug_radius = getdvarfloat( @"hash_67b9f0ba27a83e72", 0 );
            
            if ( !isdefined( debug_color ) )
            {
                debug_color = ( 1, 0.65, 0 );
            }
        }
    #/
    
    if ( !isdefined( accel ) )
    {
        accel = ( 0, 0, -1 * getdvarfloat( @"bg_gravity", 800 ) );
    }
    
    position = start_pos;
    position_prev = start_pos;
    t = 0;
    var_9b21fd8bac1a558a = max_time / delta_time;
    b_hit = 0;
    v = undefined;
    
    for ( i = 0; i <= var_9b21fd8bac1a558a ; i++ )
    {
        t += delta_time;
        position = start_pos + vel * t + accel * 0.5 * t * t;
        trace = trace::ray_trace( position_prev, position, ignoreents, contentoverride );
        
        if ( isdefined( trace[ "position" ] ) && trace[ "position" ] != position )
        {
            b_hit = 1;
            position = trace[ "position" ];
        }
        
        /#
            if ( debug_render )
            {
                if ( debug_radius > 0 )
                {
                    cylinder( position, position_prev, debug_radius, debug_color, 0, debug_duration_frames );
                }
                else
                {
                    line( position, position_prev, debug_color, 1, 1, debug_duration_frames );
                }
            }
        #/
        
        position_prev = position;
        
        if ( b_hit )
        {
            break;
        }
    }
    
    v = vel + accel * t;
    
    /#
        if ( b_hit && var_afe7fa4c43ea8c61 > 0 )
        {
            thread draw_circle( position, var_afe7fa4c43ea8c61, debug_color, 1, 1, debug_duration_frames );
        }
    #/
    
    result = spawnstruct();
    result.position = position;
    result.travel_time = t;
    result.velocity = v;
    result.b_hit = b_hit;
    result.trace = trace;
    return result;
}

// Namespace utility
// Params 0
// Checksum 0xe50bb70a, Offset: 0x9d5f
// Size: 0x36, Type: bool
function is_map_using_locales_only()
{
    mapname = getdvar( @"g_mapname" );
    
    if ( mapname == "mp_donesk" || mapname == "mp_locale_test" )
    {
        return true;
    }
    
    return false;
}

// Namespace utility
// Params 0
// Checksum 0xdb5795a4, Offset: 0x9d9e
// Size: 0x30
function iswegameplatform()
{
    if ( !isdefined( level.iswegameplatform ) )
    {
        level.iswegameplatform = getdvarint( @"g_wegame_platform", 0 ) > 0;
    }
    
    return level.iswegameplatform;
}

// Namespace utility
// Params 3
// Checksum 0xa3e3d444, Offset: 0x9dd7
// Size: 0x62, Type: bool
function function_48f723fdc612ec65( dvar_name, default_value, var_704edfac805ac331 )
{
    assert( isdefined( default_value ) );
    assert( isfloat( default_value ) );
    dvar_value = isdvardefined( dvar_name ) ? getdvarfloat( dvar_name ) : undefined;
    return dvar_value ?? var_704edfac805ac331 ?? default_value;
}

// Namespace utility
// Params 3
// Checksum 0xcd134a29, Offset: 0x9e42
// Size: 0x62, Type: bool
function function_edc4cc03e9e60b3e( dvar_name, default_value, var_704edfac805ac331 )
{
    assert( isdefined( default_value ) );
    assert( isint( default_value ) );
    dvar_value = isdvardefined( dvar_name ) ? getdvarint( dvar_name ) : undefined;
    return dvar_value ?? var_704edfac805ac331 ?? default_value;
}

// Namespace utility
// Params 3
// Checksum 0x433a2fe1, Offset: 0x9ead
// Size: 0x62, Type: bool
function function_49a778e73bbb0f58( dvar_name, default_value, var_704edfac805ac331 )
{
    assert( isdefined( default_value ) );
    assert( isstring( default_value ) );
    dvar_value = isdvardefined( dvar_name ) ? getdvar( dvar_name ) : undefined;
    return dvar_value ?? var_704edfac805ac331 ?? default_value;
}

// Namespace utility
// Params 3
// Checksum 0xf6a85235, Offset: 0x9f18
// Size: 0x62, Type: bool
function function_5eb6ca497c84f302( dvar_name, default_value, var_704edfac805ac331 )
{
    assert( isdefined( default_value ) );
    assert( isvector( default_value ) );
    dvar_value = isdvardefined( dvar_name ) ? getdvarvector( dvar_name ) : undefined;
    return dvar_value ?? var_704edfac805ac331 ?? default_value;
}

// Namespace utility
// Params 3, eflags: 0x4
// Checksum 0xd6bfa996, Offset: 0x9f83
// Size: 0x62
function private function_41c078929be6e7fe( center, radius, ang_perc )
{
    x = radius * cos( ang_perc ) + center[ 0 ];
    y = radius * sin( ang_perc ) + center[ 1 ];
    z = center[ 2 ];
    return ( x, y, z );
}

// Namespace utility
// Params 1
// Checksum 0x339b0ce8, Offset: 0x9fee
// Size: 0x4c
function get_enemy_team( team )
{
    assert( team != "<dev string:x78d>", "<dev string:x795>" );
    teams = [];
    teams[ "axis" ] = "allies";
    teams[ "allies" ] = "axis";
    return teams[ team ];
}

// Namespace utility
// Params 1
// Checksum 0xd02d1885, Offset: 0xa043
// Size: 0x3e
function get_entity_number( ent )
{
    if ( !ent )
    {
        return;
    }
    
    if ( !isdefined( ent.entnum ) )
    {
        ent.entnum = ent getentitynumber();
    }
    
    return ent.entnum;
}

// Namespace utility
// Params 2
// Checksum 0x16da1508, Offset: 0xa08a
// Size: 0x3c
function function_3a444812a9926ec( source, target )
{
    distanceinches = distance( source, target );
    distancemeters = distanceinches * 0.0254;
    return distancemeters;
}

// Namespace utility
// Params 3
// Checksum 0x41af75af, Offset: 0xa0cf
// Size: 0x54, Type: bool
function playerwithindistance( player, point, distance )
{
    actualdistancesquared = distancesquared( player.origin, point );
    maxdistancesquared = distance * distance;
    
    if ( actualdistancesquared <= maxdistancesquared )
    {
        return true;
    }
    
    return false;
}

// Namespace utility
// Params 3
// Checksum 0x2c3376f9, Offset: 0xa12c
// Size: 0x54, Type: bool
function function_92fc197c20834b39( player, point, distance )
{
    actualdistancesquared = distance2dsquared( player.origin, point );
    maxdistancesquared = distance * distance;
    
    if ( actualdistancesquared <= maxdistancesquared )
    {
        return true;
    }
    
    return false;
}

// Namespace utility
// Params 3
// Checksum 0x4bcbbf2e, Offset: 0xa189
// Size: 0x46, Type: bool
function function_db36b3921345bdf4( player, point, distancesquared )
{
    actualdistancesquared = distancesquared( player.origin, point );
    
    if ( actualdistancesquared <= distancesquared )
    {
        return true;
    }
    
    return false;
}

// Namespace utility
// Params 2
// Checksum 0x16f2c374, Offset: 0xa1d8
// Size: 0x20
function playersnear( point, distance )
{
    return charactersnear( point, distance, 1 );
}

// Namespace utility
// Params 0
// Checksum 0x5dfc32d8, Offset: 0xa201
// Size: 0x9
function activate_individual_exploder()
{
    exploder::activate_individual_exploder_proc();
}

// Namespace utility
// Params 0
// Checksum 0xab5728c8, Offset: 0xa212
// Size: 0x8
function actor_is3d()
{
    return actor_isspace();
}

// Namespace utility
// Params 0
// Checksum 0x27d6cca6, Offset: 0xa223
// Size: 0xc, Type: bool
function actor_isspace()
{
    return istrue( self.space );
}

// Namespace utility
// Params 1
// Checksum 0x7e29730d, Offset: 0xa238
// Size: 0x14b
function function_d25424f1ac9f1290( struct )
{
    if ( !isdefined( struct.var_a86c7b90ea136b4 ) )
    {
        return;
    }
    
    if ( !isdefined( level._fx ) )
    {
        level._fx = {};
    }
    
    if ( !isdefined( level._fx.ambientwar ) )
    {
        level._fx.ambientwar = {};
    }
    
    if ( !isdefined( level._fx.ambientwar.nodes ) )
    {
        level._fx.ambientwar.nodes = [];
    }
    
    if ( !isdefined( level._fx.ambientwar.nodes[ struct.var_a86c7b90ea136b4 ] ) )
    {
        level._fx.ambientwar.nodes[ struct.var_a86c7b90ea136b4 ] = [];
    }
    
    level._fx.ambientwar.nodes[ struct.var_a86c7b90ea136b4 ][ level._fx.ambientwar.nodes[ struct.var_a86c7b90ea136b4 ].size ] = struct;
}

// Namespace utility
// Params 1
// Checksum 0xde2bbe82, Offset: 0xa38b
// Size: 0x4b
function add_frame_event( event )
{
    if ( !isdefined( self.frame_events ) )
    {
        self.frame_events = [ event ];
        thread process_frame_events();
        return;
    }
    
    self.frame_events[ self.frame_events.size ] = event;
}

// Namespace utility
// Params 2
// Checksum 0x3433fee6, Offset: 0xa3de
// Size: 0xed
function add_fx( fx_id, fx_path )
{
    if ( !isdefined( level._effect ) )
    {
        level._effect = [];
    }
    
    if ( !isdefined( fx_id ) || !isdefined( fx_path ) )
    {
        /#
            str_fx_id = fx_id ? isxhash( fx_id ) ? getxhashsourcename( fx_id ) : fx_id : "<dev string:x7b1>";
            str_fx_path = fx_path ? isxhash( fx_path ) ? getxhashsourcename( fx_path ) : fx_path : "<dev string:x7b1>";
            println( "<dev string:x7bb>" + str_fx_id + "<dev string:x7d2>" + str_fx_path + "<dev string:x7df>" );
            assert( isdefined( fx_id ), "<dev string:x7ed>" + str_fx_path );
            assert( isdefined( fx_path ), "<dev string:x815>" + str_fx_id );
        #/
        
        return;
    }
    
    level._effect[ fx_id ] = load_fx( fx_path );
}

// Namespace utility
// Params 2
// Checksum 0x7c91b835, Offset: 0xa4d3
// Size: 0x4d, Type: bool
function add_init_script( name, init_function )
{
    if ( !isdefined( level.init_script ) )
    {
        level.init_script = [];
    }
    
    if ( isdefined( level.init_script[ name ] ) )
    {
        return false;
    }
    
    level.init_script[ name ] = init_function;
    return true;
}

// Namespace utility
// Params 1
// Checksum 0xc3909e38, Offset: 0xa529
// Size: 0xfa
function add_to_partition( object )
{
    assert( is_partition(), "<dev string:x83d>" );
    assert( isdefined( object ), "<dev string:x899>" );
    assert( isdefined( object.origin ), "<dev string:x8c6>" );
    [ x, y ] = function_890559684b1ecb60( object.origin );
    test_array_x = self.array[ x ];
    
    if ( !isdefined( test_array_x ) )
    {
        self.array[ x ] = [];
        test_array_x = [];
    }
    
    var_1e8357156b843e8b = test_array_x[ y ];
    
    if ( !isdefined( var_1e8357156b843e8b ) )
    {
        self.array[ x ][ y ] = [];
        var_bcb2a3b8f4f86415 = 0;
    }
    else
    {
        var_bcb2a3b8f4f86415 = var_1e8357156b843e8b.size;
    }
    
    self.array[ x ][ y ][ var_bcb2a3b8f4f86415 ] = object;
}

// Namespace utility
// Params 1
// Checksum 0x33cf5671, Offset: 0xa62b
// Size: 0x607
function addstruct( struct )
{
    assert( isdefined( level.struct_class_names ), "<dev string:x903>" );
    
    if ( isdefined( struct.targetname ) )
    {
        if ( !isdefined( level.struct_class_names[ "targetname" ][ struct.targetname ] ) )
        {
            level.struct_class_names[ "targetname" ][ struct.targetname ] = [];
        }
        
        size = level.struct_class_names[ "targetname" ][ struct.targetname ].size;
        level.struct_class_names[ "targetname" ][ struct.targetname ][ size ] = struct;
    }
    
    if ( isdefined( struct.target ) )
    {
        if ( !isdefined( level.struct_class_names[ "target" ][ struct.target ] ) )
        {
            level.struct_class_names[ "target" ][ struct.target ] = [];
        }
        
        size = level.struct_class_names[ "target" ][ struct.target ].size;
        level.struct_class_names[ "target" ][ struct.target ][ size ] = struct;
    }
    
    if ( isdefined( struct.script_noteworthy ) )
    {
        if ( !isdefined( level.struct_class_names[ "script_noteworthy" ][ struct.script_noteworthy ] ) )
        {
            level.struct_class_names[ "script_noteworthy" ][ struct.script_noteworthy ] = [];
        }
        
        size = level.struct_class_names[ "script_noteworthy" ][ struct.script_noteworthy ].size;
        level.struct_class_names[ "script_noteworthy" ][ struct.script_noteworthy ][ size ] = struct;
    }
    
    if ( isdefined( struct.script_label ) )
    {
        if ( !isdefined( level.struct_class_names[ "script_label" ][ struct.script_label ] ) )
        {
            level.struct_class_names[ "script_label" ][ struct.script_label ] = [];
        }
        
        size = level.struct_class_names[ "script_label" ][ struct.script_label ].size;
        level.struct_class_names[ "script_label" ][ struct.script_label ][ size ] = struct;
    }
    
    if ( isdefined( struct.script_linkname ) )
    {
        if ( !isdefined( level.struct_class_names[ "script_linkname" ][ struct.script_linkname ] ) )
        {
            level.struct_class_names[ "script_linkname" ][ struct.script_linkname ] = [];
        }
        
        size = level.struct_class_names[ "script_linkname" ][ struct.script_linkname ].size;
        level.struct_class_names[ "script_linkname" ][ struct.script_linkname ][ size ] = struct;
    }
    
    if ( isdefined( struct.script_vehicleref ) )
    {
        if ( !isdefined( level.struct_class_names[ "script_vehicleref" ][ struct.script_vehicleref ] ) )
        {
            level.struct_class_names[ "script_vehicleref" ][ struct.script_vehicleref ] = [];
        }
        
        size = level.struct_class_names[ "script_vehicleref" ][ struct.script_vehicleref ].size;
        level.struct_class_names[ "script_vehicleref" ][ struct.script_vehicleref ][ size ] = struct;
    }
    
    if ( isdefined( struct.script_vehiclebundle ) )
    {
        if ( !isdefined( level.struct_class_names[ "script_vehiclebundle" ][ struct.script_vehiclebundle ] ) )
        {
            level.struct_class_names[ "script_vehiclebundle" ][ struct.script_vehiclebundle ] = [];
        }
        
        size = level.struct_class_names[ "script_vehiclebundle" ][ struct.script_vehiclebundle ].size;
        level.struct_class_names[ "script_vehiclebundle" ][ struct.script_vehiclebundle ][ size ] = struct;
    }
    
    if ( isdefined( struct.vehicletype ) )
    {
        hash = getxhashasset( struct.vehicletype );
        struct.vehicletype = hash;
        
        if ( !isdefined( level.struct_class_names[ "vehicletype" ][ hash ] ) )
        {
            level.struct_class_names[ "vehicletype" ][ hash ] = [];
        }
        
        size = level.struct_class_names[ "vehicletype" ][ hash ].size;
        level.struct_class_names[ "vehicletype" ][ hash ][ size ] = struct;
    }
    
    if ( isdefined( struct.variantname ) )
    {
        if ( !isdefined( level.struct_class_names[ "variantname" ][ struct.variantname ] ) )
        {
            level.struct_class_names[ "variantname" ][ struct.variantname ] = [];
        }
        
        size = level.struct_class_names[ "variantname" ][ struct.variantname ].size;
        level.struct_class_names[ "variantname" ][ struct.variantname ][ size ] = struct;
    }
    
    if ( isdefined( struct.agent_noteworthy ) )
    {
        if ( !isdefined( level.struct_class_names[ "script_agent_noteworthy" ][ struct.agent_noteworthy ] ) )
        {
            level.struct_class_names[ "script_agent_noteworthy" ][ struct.agent_noteworthy ] = [];
        }
        
        size = level.struct_class_names[ "script_agent_noteworthy" ][ struct.agent_noteworthy ].size;
        level.struct_class_names[ "script_agent_noteworthy" ][ struct.agent_noteworthy ][ size ] = struct;
    }
    
    if ( isdefined( struct.script_agent_noteworthy ) )
    {
        if ( !isdefined( level.struct_class_names[ "script_agent_noteworthy" ][ struct.script_agent_noteworthy ] ) )
        {
            level.struct_class_names[ "script_agent_noteworthy" ][ struct.script_agent_noteworthy ] = [];
        }
        
        size = level.struct_class_names[ "script_agent_noteworthy" ][ struct.script_agent_noteworthy ].size;
        level.struct_class_names[ "script_agent_noteworthy" ][ struct.script_agent_noteworthy ][ size ] = struct;
    }
}

// Namespace utility
// Params 2
// Checksum 0x197329a5, Offset: 0xac3a
// Size: 0x1f
function agentsnear( point, distance )
{
    return charactersnear( point, distance, 0 );
}

// Namespace utility
// Params 3
// Checksum 0xe9e906f9, Offset: 0xac62
// Size: 0x11c
function charactersnear( point, distance, playersonly )
{
    playercontents = physics_createcontents( [ "physicscontents_characterproxy" ] );
    radiusvector = ( distance, distance, distance );
    aabbmin = point - radiusvector;
    aabbmax = point + radiusvector;
    hits = physics_aabbbroadphasequery( aabbmin, aabbmax, playercontents, [] );
    
    if ( !isdefined( playersonly ) )
    {
        return hits;
    }
    
    filteredhits = [];
    
    foreach ( hit in hits )
    {
        if ( playersonly && isplayer( hit ) || playersonly == 0 && isscriptedai( hit ) )
        {
            filteredhits[ filteredhits.size ] = hit;
        }
    }
    
    return filteredhits;
}

// Namespace utility
// Params 6
// Checksum 0x2ab12102, Offset: 0xad87
// Size: 0x4f
function playersincylinder( point, radius, var_39608ff9f170fda3, halfheightoverride = 1000, var_7d41775d8f6afcf3, ignorelaststand )
{
    return function_d63fe6a4c08ba6f5( point, radius, halfheightoverride, ignorelaststand, var_39608ff9f170fda3, var_7d41775d8f6afcf3 );
}

// Namespace utility
// Params 3, eflags: 0x40 variadic
// Checksum 0xfdf102b9, Offset: 0xaddf
// Size: 0x2f
function function_704b6016a179b4ab( func, ... )
{
    if ( !isdefined( func ) )
    {
        return;
    }
    
    return self [[ func ]]( flat_args( vararg, varargcount ) );
}

// Namespace utility
// Params 4, eflags: 0x40 variadic
// Checksum 0x626f8755, Offset: 0xae17
// Size: 0x40
function noself_call_on_notify( notifystring, method, ... )
{
    self endon( #"death_or_disconnect" );
    childthread noself_call_on_notify_proc( notifystring, method, varargcount, vararg );
}

// Namespace utility
// Params 4
// Checksum 0xd904c35e, Offset: 0xae5f
// Size: 0x36
function noself_call_on_notify_proc( notifystring, method, varargcount, vararg )
{
    self waittill( notifystring );
    builtin [[ method ]]( flat_args( vararg, varargcount ) );
}

// Namespace utility
// Params 4, eflags: 0x40 variadic
// Checksum 0xda85d933, Offset: 0xae9d
// Size: 0x40
function call_on_notify( notifystring, method, ... )
{
    self endon( #"death_or_disconnect" );
    childthread call_on_notify_proc( notifystring, method, varargcount, vararg );
}

// Namespace utility
// Params 4
// Checksum 0x9cb9b706, Offset: 0xaee5
// Size: 0x37
function call_on_notify_proc( notifystring, method, varargcount, vararg )
{
    self waittill( notifystring );
    self builtin [[ method ]]( flat_args( vararg, varargcount ) );
}

// Namespace utility
// Params 4, eflags: 0x40 variadic
// Checksum 0x90eccfb8, Offset: 0xaf24
// Size: 0xb2
function callsharedfunc( category, funcname, ... )
{
    if ( isstring( category ) )
    {
        category = getxhash( category );
    }
    
    func = level.sharedfuncs[ category ][ funcname ];
    
    if ( isfunction( func ) )
    {
        return self [[ func ]]( flat_args( vararg, varargcount ) );
    }
    else if ( isbuiltinfunction( func ) )
    {
        return builtin [[ func ]]( flat_args( vararg, varargcount ) );
    }
    else if ( isbuiltinmethod( func ) )
    {
        return self builtin [[ func ]]( flat_args( vararg, varargcount ) );
    }
    
    /#
        if ( isstring( funcname ) )
        {
            assertmsg( "<dev string:x24>" + funcname + "<dev string:x2e>" );
        }
    #/
}

// Namespace utility
// Params 4
// Checksum 0x43ddacba, Offset: 0xafdf
// Size: 0x8a
function can_trace_to_ai( start, ai, ignoreentarray, contentoverride )
{
    if ( isent( self ) || isai( self ) )
    {
        ignoregroup = [ self, ai ];
    }
    else
    {
        ignoregroup = [ ai ];
    }
    
    if ( isdefined( ignoreentarray ) )
    {
        ignoregroup = arraycombine( ignoregroup, ignoreentarray );
    }
    
    content = contentoverride ?? trace::create_default_contents();
    return cantracetoai( ai, start, ignoreentarray, content );
}

// Namespace utility
// Params 5
// Checksum 0xa4c3ea20, Offset: 0xb072
// Size: 0x56
function function_f754506ecfae9afb( point, radius, var_8925d7e90df06109, cylinderhalfheight = 1000, includeplayers )
{
    ignoreplayers = includeplayers === 0;
    return function_51b8ce76eb43aed5( point, radius, cylinderhalfheight, undefined, ignoreplayers, var_8925d7e90df06109 );
}

// Namespace utility
// Params 3
// Checksum 0xa9480d90, Offset: 0xb0d1
// Size: 0x29
function playersinsphere( point, radius, excludedplayers )
{
    return getplayersinradius( point, radius, undefined, undefined, excludedplayers );
}

// Namespace utility
// Params 3
// Checksum 0x4da330f6, Offset: 0xb103
// Size: 0x34
function function_1b1340a94b43b874( point, radius, includeplayers )
{
    if ( includeplayers === 0 )
    {
        return getaiarrayinradius( point, radius );
    }
    
    return getplayersandaiarrayinradius( point, radius );
}

// Namespace utility
// Params 2
// Checksum 0x4a0b0084, Offset: 0xb140
// Size: 0x56
function getsharedfunc( category, funcname )
{
    /#
        if ( isstring( funcname ) )
        {
            assertmsg( "<dev string:x24>" + funcname + "<dev string:x2e>" );
        }
    #/
    
    if ( isstring( category ) )
    {
        category = getxhash( category );
    }
    
    return level.sharedfuncs[ category ][ funcname ];
}

// Namespace utility
// Params 2
// Checksum 0x7b05fbb6, Offset: 0xb19f
// Size: 0x146
function getstruct( name, type = "targetname" )
{
    assert( isdefined( name ), "<dev string:x933>" );
    
    /#
        if ( !isdefined( level.struct_class_names ) )
        {
            if ( level.var_13b70b3b5724494f )
            {
                assertmsg( "<dev string:x948>" );
            }
            else
            {
                assertmsg( "<dev string:x978>" );
            }
        }
    #/
    
    array = level.struct_class_names[ type ][ name ];
    
    if ( !isdefined( array ) )
    {
        return;
    }
    
    if ( array.size > 1 )
    {
        if ( isdefined( array[ 0 ] ) && isdefined( array[ 0 ].origin ) )
        {
            originstr1 = "" + array[ 0 ].origin;
        }
        else
        {
            originstr1 = "<UNKNOWN>";
        }
        
        if ( isdefined( array[ 1 ] ) && isdefined( array[ 1 ].origin ) )
        {
            originstr2 = "" + array[ 1 ].origin;
        }
        else
        {
            originstr2 = "<UNKNOWN>";
        }
        
        assertmsg( "<dev string:x9a8>" + type + "<dev string:x9da>" + name + "<dev string:x9e5>" + originstr1 + "<dev string:xa18>" + originstr2 );
        return;
    }
    
    return array[ 0 ];
}

// Namespace utility
// Params 2
// Checksum 0xc412d90f, Offset: 0xb2ee
// Size: 0x9a
function getstructarray( name, type = "targetname" )
{
    /#
        if ( !isdefined( level.struct_class_names ) )
        {
            if ( level.var_13b70b3b5724494f )
            {
                assertmsg( "<dev string:x948>" );
            }
            else
            {
                assertmsg( "<dev string:x978>" );
            }
        }
    #/
    
    if ( !isdefined( level.struct_class_names ) )
    {
        return [];
    }
    
    if ( !( isdefined( type ) && isdefined( name ) ) )
    {
        return [];
    }
    
    array = level.struct_class_names[ type ][ name ] ?? [];
    return array;
}

// Namespace utility
// Params 3
// Checksum 0xd5f4b89d, Offset: 0xb391
// Size: 0x3f
function getstructarray_delete( value, key, delay )
{
    structs = getstructarray( value, key );
    deletestructarray_ref( structs, delay );
    return structs;
}

// Namespace utility
// Params 4
// Checksum 0x20bfea5b, Offset: 0xb3d9
// Size: 0x121
function function_b7f3d374aa10aa51( name, type, origin, radius )
{
    assert( isdefined( name ) && isdefined( type ), "<dev string:x49b>" );
    assert( isdefined( origin ) && isdefined( radius ), "<dev string:x4ba>" );
    
    if ( !( isdefined( origin ) && isdefined( radius ) ) )
    {
        return [];
    }
    
    structarray = getstructarray( name, type );
    
    if ( structarray.size == 0 )
    {
        return [];
    }
    
    radiussquared = radius * radius;
    var_2f8bcafcfeb23a45 = [];
    
    foreach ( struct in structarray )
    {
        if ( distance2dsquared( origin, struct.origin ) <= radiussquared )
        {
            var_2f8bcafcfeb23a45[ var_2f8bcafcfeb23a45.size ] = struct;
        }
    }
    
    return var_2f8bcafcfeb23a45;
}

// Namespace utility
// Params 6
// Checksum 0xd5b0c82a, Offset: 0xb503
// Size: 0xdd
function function_d6c8833c6628c415( origin, radius, height, ignorelaststand, var_39608ff9f170fda3, desiredteam )
{
    players_nearby = getplayersinradius( origin, radius, height, ignorelaststand, var_39608ff9f170fda3, desiredteam );
    teams_nearby = [];
    
    foreach ( player_nearby in players_nearby )
    {
        teams_nearby = arraycombineunique( teams_nearby, [ player_nearby.team ] );
    }
    
    return teams_nearby;
}

// Namespace utility
// Params 7, eflags: 0x40 variadic
// Checksum 0x813cc972, Offset: 0xb5e9
// Size: 0x164
function thread_on_notify( notifystring, function, ent, endonentities, endonmessages, ... )
{
    self endon( #"death" );
    
    if ( isdefined( endonentities ) && isdefined( endonmessages ) )
    {
        if ( !isarray( endonentities ) )
        {
            endonentities = [ endonentities ];
        }
        
        if ( !isarray( endonmessages ) )
        {
            endonmessages = [ endonmessages ];
        }
        
        foreach ( entity in endonentities )
        {
            foreach ( message in endonmessages )
            {
                entity endon( message );
            }
        }
    }
    
    childthread thread_on_notify_proc( notifystring, function, ent, flat_args( vararg, varargcount ) );
}

// Namespace utility
// Params 5, eflags: 0x40 variadic
// Checksum 0x4568dd81, Offset: 0xb755
// Size: 0x3f
function thread_on_notify_no_endon_death( notifystring, function, ent, ... )
{
    childthread thread_on_notify_proc( notifystring, function, ent, flat_args( vararg, varargcount ) );
}

// Namespace utility
// Params 5, eflags: 0x44 variadic
// Checksum 0x3cb090cf, Offset: 0xb79c
// Size: 0x48
function private thread_on_notify_proc( notifystring, function, ent, ... )
{
    self waittill( notifystring );
    
    if ( !isdefined( ent ) )
    {
        ent = self;
    }
    
    ent thread [[ function ]]( flat_args( vararg, varargcount ) );
}

// Namespace utility
// Params 2
// Checksum 0xa854d5c9, Offset: 0xb7ec
// Size: 0x3e, Type: bool
function time_has_passed( timestamp, seconds )
{
    if ( !isdefined( timestamp ) )
    {
        return false;
    }
    
    if ( !isdefined( seconds ) || seconds == 0 )
    {
        return true;
    }
    
    return gettime() - timestamp >= seconds * 1000;
}

// Namespace utility
// Params 2
// Checksum 0xe70bef65, Offset: 0xb833
// Size: 0x97, Type: bool
function time_has_passed_array( a_timestamps, seconds )
{
    if ( !isdefined( a_timestamps ) )
    {
        return false;
    }
    
    foreach ( timestamp in a_timestamps )
    {
        if ( time_has_passed( timestamp, seconds ) )
        {
            return false;
        }
    }
    
    return true;
}

// Namespace utility
// Params 1
// Checksum 0x2c2b8b1b, Offset: 0xb8d3
// Size: 0x37
function timeout_struct( delay )
{
    self endon( #"die" );
    
    if ( delay > 0 )
    {
        wait delay;
    }
    else
    {
        waitframe();
    }
    
    self notify( #"returned", "timeout" );
}

// Namespace utility
// Params 2
// Checksum 0x232c4c12, Offset: 0xb912
// Size: 0x6b
function trigger_off( name, type )
{
    if ( isdefined( name ) && isdefined( type ) )
    {
        ents = getentarray( name, type );
        array_thread( ents, &trigger_off_proc );
        vols = getnoentvolumearray( name, type );
        array_thread( vols, &trigger_off_proc );
        return;
    }
    
    trigger_off_proc();
}

// Namespace utility
// Params 0
// Checksum 0x662f08fd, Offset: 0xb985
// Size: 0x34
function trigger_off_proc()
{
    if ( issubstr( self.classname, "trigger" ) )
    {
        self triggerdisable();
    }
    
    self.trigger_off = 1;
    self notify( #"trigger_off" );
}

// Namespace utility
// Params 2
// Checksum 0x36f6fb39, Offset: 0xb9c1
// Size: 0x6b
function trigger_on( name, type )
{
    if ( isdefined( name ) && isdefined( type ) )
    {
        ents = getentarray( name, type );
        array_thread( ents, &trigger_on_proc );
        vols = getnoentvolumearray( name, type );
        array_thread( vols, &trigger_on_proc );
        return;
    }
    
    trigger_on_proc();
}

// Namespace utility
// Params 0
// Checksum 0x762c2c5e, Offset: 0xba34
// Size: 0x12
function trigger_on_proc()
{
    self triggerenable();
    self.trigger_off = undefined;
}

// Namespace utility
// Params 3, eflags: 0x40 variadic
// Checksum 0x3d099e1b, Offset: 0xba4e
// Size: 0x2e
function trycall( functionpointer, ... )
{
    if ( !isdefined( functionpointer ) )
    {
        return;
    }
    
    return [[ functionpointer ]]( flat_args( vararg, varargcount ) );
}

// Namespace utility
// Params 0
// Checksum 0x873e2b, Offset: 0xba85
// Size: 0x188
function spawncorpsehider()
{
    if ( !( level.var_ce11fa8b9f14341d ?? iswegameplatform() ) )
    {
        return;
    }
    
    corpsetable_mapname = 1;
    corpsetable_model = 2;
    corpsetable_loc = 3;
    corpsetable_rot = 4;
    corpsetable_collision = 5;
    corpsetablename = "sp/hideCorpseTable.csv";
    curmapname = tolower( getdvar( @"g_mapname" ) );
    var_d374f94865e7eef9 = tablelookupgetnumrows( corpsetablename );
    
    for ( i = 0; i < var_d374f94865e7eef9 ; i++ )
    {
        if ( curmapname == tolower( tablelookupbyrow( corpsetablename, i, corpsetable_mapname ) ) )
        {
            modelname = tablelookupbyrow( corpsetablename, i, corpsetable_model );
            arrloc = strtok( tablelookupbyrow( corpsetablename, i, corpsetable_loc ), "_" );
            arrrot = strtok( tablelookupbyrow( corpsetablename, i, corpsetable_rot ), "_" );
            icollision = int( tablelookupbyrow( corpsetablename, i, corpsetable_collision ) );
            model = spawn( "script_model", ( float( arrloc[ 0 ] ), float( arrloc[ 1 ] ), float( arrloc[ 2 ] ) ) );
            model setmodel( modelname );
            model.angles = ( float( arrrot[ 0 ] ), float( arrrot[ 1 ] ), float( arrrot[ 2 ] ) );
            
            if ( icollision > 0 )
            {
                model solid();
                continue;
            }
            
            model notsolid();
        }
    }
}

// Namespace utility
// Params 0
// Checksum 0x138a6975, Offset: 0xbc15
// Size: 0x3e, Type: bool
function function_de1f80d93273abf5()
{
    if ( isstruct( self ) || !isdefined( self ) )
    {
        return false;
    }
    
    if ( isent( self ) && !self isscriptable() )
    {
        return false;
    }
    
    if ( !isent( self ) && !self isscriptableinstance() )
    {
        return false;
    }
    
    return true;
}

// Namespace utility
// Params 2
// Checksum 0x94915074, Offset: 0xbc5c
// Size: 0xce, Type: bool
function function_9f2c41c1dcc8c94( part, state )
{
    if ( isdefined( self ) )
    {
        if ( isent( self ) && self isscriptable() || !isent( self ) && self isscriptableinstance() )
        {
            if ( self getscriptablehaspart( part ) )
            {
                if ( !state )
                {
                    error_msg = "Error: Get Scriptable part: " + part + " of an undefined state on scriptable classname: " + ( self.classname ?? "none" ) + " model: " + ( self.model ?? "none" );
                    println( error_msg );
                    logstring( error_msg );
                    return false;
                }
                
                if ( self getscriptableparthasstate( part, state ) )
                {
                    curstate = self getscriptablepartstate( part, 1 );
                    
                    if ( curstate == state )
                    {
                        return true;
                    }
                }
            }
        }
    }
    
    return false;
}

// Namespace utility
// Params 2
// Checksum 0xb33d255c, Offset: 0xbd33
// Size: 0x65
function function_30dbabe3200518b( name, key )
{
    a_sbls = getentitylessscriptablearray( name, key );
    assert( a_sbls.size < 2, "<dev string:xa1e>" + name + "<dev string:xa48>" + getxhashsourcename( key ) + "<dev string:xa53>" );
    
    if ( a_sbls.size == 1 )
    {
        return a_sbls[ 0 ];
    }
    
    return;
}

// Namespace utility
// Params 2
// Checksum 0xd77585e5, Offset: 0xbda0
// Size: 0x65
function function_b3fc2f9ce7786d99( name, key )
{
    a_sbls = getscriptablearray( name, key );
    assert( a_sbls.size < 2, "<dev string:xa1e>" + name + "<dev string:xa48>" + getxhashsourcename( key ) + "<dev string:xa53>" );
    
    if ( a_sbls.size == 1 )
    {
        return a_sbls[ 0 ];
    }
    
    return;
}

// Namespace utility
// Params 2
// Checksum 0x93c2219f, Offset: 0xbe0d
// Size: 0x62, Type: bool
function function_7c10ea82c1e305b8( part, state )
{
    if ( isdefined( self ) )
    {
        if ( isent( self ) && self isscriptable() || !isent( self ) && self isscriptableinstance() )
        {
            if ( self getscriptablehaspart( part ) )
            {
                if ( self getscriptableparthasstate( part, state ) )
                {
                    self setscriptablepartstate( part, state, 1 );
                    return true;
                }
            }
        }
    }
    
    return false;
}

// Namespace utility
// Params 1
// Checksum 0x74df8a82, Offset: 0xbe78
// Size: 0x1c, Type: bool
function function_6407872c2eb0e9c9( name )
{
    return isdefined( function_43b5ed5a14a56573( #"scriptabledef", name ) );
}

// Namespace utility
// Params 3
// Checksum 0x5c30dce8, Offset: 0xbe9d
// Size: 0xe1
function scriptable_setparententity( parent, offset, angles )
{
    assert( isdefined( self ) && self isscriptableinstance() );
    assert( isent( parent ) );
    
    if ( isdefined( offset ) && isdefined( angles ) )
    {
        self scriptablesetparententity( parent, offset, angles );
    }
    else if ( isdefined( offset ) )
    {
        self scriptablesetparententity( parent, offset );
    }
    else
    {
        self scriptablesetparententity( parent );
    }
    
    self.linkedparent = parent;
    
    if ( !isdefined( parent.linkedchildren ) )
    {
        parent.linkedchildren = [];
    }
    
    parent.linkedchildren[ parent.linkedchildren.size ] = self;
    
    if ( parent.linkedchildren.size % 10 == 0 )
    {
        parent.linkedchildren = function_5713d46873b29625( parent.linkedchildren );
    }
}

// Namespace utility
// Params 0
// Checksum 0x13c0019d, Offset: 0xbf86
// Size: 0x89
function scriptable_clearparententity()
{
    assert( isdefined( self ) && self isscriptableinstance() );
    self scriptableclearparententity();
    parent = self.linkedparent;
    
    if ( !( isdefined( parent ) && isdefined( parent.linkedchildren ) ) )
    {
        return;
    }
    
    parent.linkedchildren = arrayremove( parent.linkedchildren, self );
    
    if ( parent.linkedchildren.size == 0 )
    {
        parent.linkedchildren = undefined;
    }
    
    self.linkedparent = undefined;
}

// Namespace utility
// Params 0
// Checksum 0x5dfa97a4, Offset: 0xc017
// Size: 0x54, Type: bool
function script_delay()
{
    if ( isdefined( self.script_delay ) )
    {
        wait self.script_delay;
        return true;
    }
    else if ( isdefined( self.script_delay_min ) && isdefined( self.script_delay_max ) )
    {
        wait randomfloatrange( self.script_delay_min, self.script_delay_max );
        return true;
    }
    
    return false;
}

// Namespace utility
// Params 1
// Checksum 0x74eb02b1, Offset: 0xc074
// Size: 0xfe
function function_1e649d305e872d9f( ent )
{
    if ( isdefined( self.script_flag_wait ) )
    {
        flags = create_flags_and_return_tokens( self.script_flag_wait );
        flag_wait_all_array( flags );
    }
    
    if ( isdefined( self.script_flag_waitopen ) )
    {
        flags = create_flags_and_return_tokens( self.script_flag_waitopen );
        flag_waitopen_all_array( flags );
    }
    
    if ( isdefined( self.script_ent_flag_wait ) )
    {
        if ( !isdefined( ent ) )
        {
            assertmsg( "<dev string:xa7d>" + self.script_ent_flag_wait + "<dev string:xaa9>" );
            return;
        }
        
        flags = create_flags_and_return_tokens( self.script_ent_flag_wait );
        ent ent_flag_wait_all_array( flags );
    }
    
    if ( isdefined( self.var_8a58f20e06232412 ) )
    {
        if ( !isdefined( ent ) )
        {
            assertmsg( "<dev string:xabf>" + self.var_8a58f20e06232412 + "<dev string:xaa9>" );
            return;
        }
        
        flags = create_flags_and_return_tokens( self.var_8a58f20e06232412 );
        ent ent_flag_waitopen_all_array( flags );
    }
}

// Namespace utility
// Params 3, eflags: 0x40 variadic
// Checksum 0xb04dedd4, Offset: 0xc17a
// Size: 0x43
function script_func( func, ... )
{
    if ( !isdefined( level.func[ func ] ) )
    {
        return;
    }
    
    return self [[ level.func[ func ] ]]( flat_args( vararg, varargcount ) );
}

// Namespace utility
// Params 0
// Checksum 0x75150ad3, Offset: 0xc1c6
// Size: 0xd2
function script_wait()
{
    starttime = gettime();
    
    if ( isdefined( self.script_wait ) )
    {
        wait self.script_wait;
        
        if ( isdefined( self.script_wait_add ) )
        {
            self.script_wait += self.script_wait_add;
        }
    }
    else if ( isdefined( self.script_wait_min ) && isdefined( self.script_wait_max ) )
    {
        wait randomfloatrange( self.script_wait_min, self.script_wait_max );
        
        if ( isdefined( self.script_wait_add ) )
        {
            self.script_wait_min += self.script_wait_add;
            self.script_wait_max += self.script_wait_add;
        }
    }
    
    return gettime() - starttime;
}

// Namespace utility
// Params 1
// Checksum 0x41ea0d71, Offset: 0xc2a1
// Size: 0xac
function function_b6cf35b57ecf329c( part )
{
    var_5619be43a25599e3 = 0;
    
    foreach ( player in level.players )
    {
        if ( !player isscriptable() )
        {
            continue;
        }
        
        var_5619be43a25599e3 = 1;
        
        if ( player getscriptablehaspart( part ) )
        {
            return 1;
        }
    }
    
    if ( var_5619be43a25599e3 )
    {
        return 0;
    }
}

// Namespace utility
// Params 2
// Checksum 0x7ce18b1d, Offset: 0xc356
// Size: 0x6b, Type: bool
function function_32b24db3127bff40( part, state )
{
    if ( isent( self ) && self isscriptable() || !isent( self ) && self isscriptableinstance() )
    {
        if ( self getscriptablehaspart( part ) )
        {
            if ( self getscriptableparthasstate( part, state ) && self getscriptablepartstate( part ) != state )
            {
                self setscriptablepartstate( part, state, 1 );
                return true;
            }
        }
    }
    
    return false;
}

// Namespace utility
// Params 6
// Checksum 0xb91fa6e2, Offset: 0xc3ca
// Size: 0xb1
function function_38add6d321fde077( scriptabledefname, startpos, landingpos, part, state, parentent )
{
    payload = calcscriptablepayloadgravityarc( startpos, landingpos );
    updatedyaw = vectortoyaw( landingpos - startpos );
    landingangles = ( 0, updatedyaw, 0 );
    assert( landingpos[ 2 ] < startpos[ 2 ], "<dev string:xaef>" );
    scriptable = spawnscriptable( scriptabledefname, startpos, landingangles, parentent, payload );
    
    if ( isdefined( part ) && isdefined( state ) )
    {
        scriptable function_7c10ea82c1e305b8( part, state );
    }
    
    return scriptable;
}

// Namespace utility
// Params 1
// Checksum 0xefff6908, Offset: 0xc484
// Size: 0x63, Type: bool
function function_1b9fac8cf533a8ae( origin )
{
    if ( origin[ 0 ] < -2097150 || origin[ 0 ] > 2097150 )
    {
        return false;
    }
    
    if ( origin[ 1 ] < -2097150 || origin[ 1 ] > 2097150 )
    {
        return false;
    }
    
    if ( origin[ 2 ] < -524285 || origin[ 2 ] > 524285 )
    {
        return false;
    }
    
    return true;
}

// Namespace utility
// Params 1
// Checksum 0x9e94baef, Offset: 0xc4f0
// Size: 0x33
function function_51a662d7927dccc7( scriptable )
{
    scriptable endon( #"death" );
    self waittill( #"death" );
    
    if ( isdefined( scriptable ) )
    {
        scriptable freescriptable();
    }
}

// Namespace utility
// Params 1
// Checksum 0x86f4a7b3, Offset: 0xc52b
// Size: 0x7c
function scripted_melee_enable( bool )
{
    assert( isdefined( bool ) );
    
    if ( bool && isdefined( level.scripted_melee.fnenable ) )
    {
        self [[ level.scripted_melee.fnenable ]]();
        return;
    }
    
    if ( isdefined( level.scripted_melee.fndisable ) )
    {
        self [[ level.scripted_melee.fndisable ]]();
    }
}

// Namespace utility
// Params 1
// Checksum 0xd2feda2d, Offset: 0xc5af
// Size: 0x22
function function_f9e51c00b0629d02( bool )
{
    assert( isdefined( bool ) );
    self.var_f9e51c00b0629d02 = bool;
}

// Namespace utility
// Params 1
// Checksum 0xa2dd3531, Offset: 0xc5d9
// Size: 0x2e
function function_fe6d25a3e1864403( arms )
{
    assert( isdefined( arms ) );
    delaythread( level.framedurationseconds, &function_c16563cbb137443d, arms );
}

// Namespace utility
// Params 1, eflags: 0x4
// Checksum 0x6baaa968, Offset: 0xc60f
// Size: 0x5f
function private function_c16563cbb137443d( arms )
{
    self.scripted_melee_player_rig delete();
    level.scr_model[ "scripted_melee_player_rig" ] = arms;
    self [[ level.scripted_melee.var_6f2f135cec97b20f ]]();
    self.scripted_melee_player_rig notsolid();
    self.scripted_melee_player_rig hide();
}

// Namespace utility
// Params 1
// Checksum 0x67e8d3f9, Offset: 0xc676
// Size: 0x22
function function_397a4bcf78452bdc( weapon )
{
    assert( isdefined( weapon ) );
    self.scripted_melee_weapon = weapon;
}

// Namespace utility
// Params 1
// Checksum 0x195c96bd, Offset: 0xc6a0
// Size: 0x35
function function_e1abd7cc8ceda351( usedefault = 1 )
{
    if ( usedefault )
    {
        self.scripted_melee_weapon = "att_vm_p33_me_tac_knife01_v0";
        return;
    }
    
    self.scripted_melee_weapon = undefined;
}

// Namespace utility
// Params 0
// Checksum 0x562d507f, Offset: 0xc6dd
// Size: 0x2c
function function_46d43fd040a6ae9d()
{
    self endon( #"death" );
    self waittill( #"scripted_melee_anim_ended" );
    waittillframeend();
    
    while ( self.scripted_melee_launching )
    {
        waitframe();
    }
}

// Namespace utility
// Params 0
// Checksum 0xdc22d553, Offset: 0xc711
// Size: 0x7
function function_215bebaff8aa653c()
{
    return "scripted_melee_start";
}

// Namespace utility
// Params 0
// Checksum 0x5c2d5602, Offset: 0xc721
// Size: 0x7
function function_6dfdb2aec72da552()
{
    return "scripted_melee_anim_started";
}

// Namespace utility
// Params 0
// Checksum 0xc7686a3f, Offset: 0xc731
// Size: 0x7
function function_f1be1a2888b846d3()
{
    return "scripted_melee_anim_ended";
}

// Namespace utility
// Params 0
// Checksum 0xc411d3a2, Offset: 0xc741
// Size: 0x7
function function_87c61df7722fc4b()
{
    return "scripted_melee_anim_ended_longest";
}

// Namespace utility
// Params 0
// Checksum 0x3dc99ff0, Offset: 0xc751
// Size: 0xb
function function_327848c6aff4647c()
{
    return self.scripted_melee_victim;
}

// Namespace utility
// Params 0
// Checksum 0xd3632cd0, Offset: 0xc765
// Size: 0x15
function function_678495e68cb5d66e()
{
    return level.scripted_melee.anim_ent;
}

// Namespace utility
// Params 0
// Checksum 0xa741821c, Offset: 0xc783
// Size: 0x7
function function_a5e22ba9824328cb()
{
    return "scripted_melee_player_rig";
}

// Namespace utility
// Params 10
// Checksum 0xd8bd8acf, Offset: 0xc793
// Size: 0x206
function function_a8a4213debc3f803( animScene, direction, rules, victimLives, startStance, endStance, override, marina_hack, usePistol, boneOverride )
{
    assert( isdefined( animScene ), "<dev string:xb52>" );
    assert( isdefined( direction ), "<dev string:xb6c>" );
    direction = tolower( direction );
    array = [];
    array[ direction ][ "animScene" ] = animScene;
    
    if ( isdefined( rules ) )
    {
        if ( isarray( rules ) )
        {
            array[ direction ][ "rules" ] = rules;
        }
        else
        {
            array[ direction ][ "rules" ] = [[ rules ]]();
        }
    }
    else
    {
        array[ direction ][ "rules" ] = [[ level.scripted_melee.var_7bd5690bbc077c7a ]]();
    }
    
    if ( isdefined( victimLives ) )
    {
        array[ direction ][ "victimLives" ] = victimLives;
    }
    else
    {
        array[ direction ][ "victimLives" ] = 0;
    }
    
    if ( isdefined( startStance ) )
    {
        array[ direction ][ "startStance" ] = endStance;
    }
    else
    {
        array[ direction ][ "startStance" ] = undefined;
    }
    
    if ( isdefined( endStance ) )
    {
        array[ direction ][ "endStance" ] = endStance;
    }
    else
    {
        array[ direction ][ "endStance" ] = undefined;
    }
    
    if ( isdefined( marina_hack ) )
    {
        array[ direction ][ "marina_hack" ] = marina_hack;
    }
    else
    {
        array[ direction ][ "marina_hack" ] = undefined;
    }
    
    if ( isdefined( usePistol ) )
    {
        array[ direction ][ "usePistol" ] = usePistol;
    }
    else
    {
        array[ direction ][ "usePistol" ] = undefined;
    }
    
    if ( isdefined( boneOverride ) )
    {
        array[ direction ][ "boneOverride" ] = boneOverride;
    }
    else
    {
        array[ direction ][ "boneOverride" ] = "TAG_ACCESSORY_RIGHT";
    }
    
    if ( level == self )
    {
        function_3ab07422aadfce73( level.scripted_melee, animScene, direction, override, array );
        return;
    }
    
    if ( !isdefined( self.scripted_melee ) )
    {
        self.scripted_melee = spawnstruct();
    }
    
    function_3ab07422aadfce73( self.scripted_melee, animScene, direction, override, array );
}

// Namespace utility
// Params 5, eflags: 0x4
// Checksum 0xdb506f4, Offset: 0xc9a1
// Size: 0x1be
function private function_3ab07422aadfce73( struct, animScene, direction, override, array )
{
    if ( override )
    {
        if ( !isdefined( struct.anims_override ) )
        {
            struct.anims_override = [];
        }
        
        if ( !isdefined( struct.anims_override[ direction ] ) )
        {
            struct.anims_override[ direction ] = [];
        }
        
        if ( struct.anims_override[ direction ].size > 0 )
        {
            for ( i = 0; i < struct.anims_override[ direction ].size ; i++ )
            {
                if ( struct.anims_override[ direction ][ i ][ "animScene" ] == animScene )
                {
                    println( "<dev string:xb85>" + animScene + "<dev string:xbb5>" + direction + "<dev string:xbc6>" );
                    struct.anims_override[ direction ][ i ] = undefined;
                    
                    if ( isint( i ) )
                    {
                        function_cdc669dbc8ea2101( struct.anims_override[ direction ] );
                    }
                }
            }
        }
        
        assert( struct.anims_override[ direction ].size < 4, "<dev string:xbc8>" + direction + "<dev string:xbf4>" );
        struct.anims_override[ direction ] = arraycombine( struct.anims_override[ direction ], array );
        return;
    }
    
    if ( !isdefined( struct.anims ) )
    {
        struct.anims = [];
    }
    
    if ( !isdefined( struct.anims[ direction ] ) )
    {
        struct.anims[ direction ] = [];
    }
    
    struct.anims[ direction ] = arraycombine( struct.anims[ direction ], array );
}

// Namespace utility
// Params 2
// Checksum 0xdc9092f8, Offset: 0xcb67
// Size: 0xbe
function function_160ec6921e7a620c( animScene, override )
{
    if ( override )
    {
        if ( isdefined( self.scripted_melee_overrides ) && isdefined( self.scripted_melee ) && isdefined( self.scripted_melee.anims_override ) )
        {
            function_d52b5a925cef201f( self.scripted_melee, animScene, override );
        }
        else if ( isdefined( level.scripted_melee.anims_override ) && isdefined( self.scripted_melee_overrides ) )
        {
            function_d52b5a925cef201f( level.scripted_melee, animScene, override );
        }
        else
        {
            /#
                iprintln( "<dev string:xc0c>" );
            #/
        }
        
        return;
    }
    
    function_d52b5a925cef201f( level.scripted_melee, animScene, override );
}

// Namespace utility
// Params 3, eflags: 0x4
// Checksum 0x538a8a98, Offset: 0xcc2d
// Size: 0x280
function private function_d52b5a925cef201f( struct, animScene, override )
{
    if ( override )
    {
        directions = getarraykeys( struct.anims_override );
        
        foreach ( direction in directions )
        {
            found = undefined;
            
            for ( i = 0; i < struct.anims_override[ direction ].size ; i++ )
            {
                if ( struct.anims_override[ direction ][ i ][ "animScene" ] == animScene )
                {
                    found = 1;
                }
                
                if ( found && struct.anims_override[ direction ].size > 1 )
                {
                    struct.anims_override[ direction ][ i ] = undefined;
                    
                    if ( isint( i ) )
                    {
                        function_cdc669dbc8ea2101( struct.anims_override[ direction ] );
                    }
                    
                    continue;
                }
                
                if ( found )
                {
                    self.scripted_melee_overrides = arrayremove( self.scripted_melee_overrides, direction );
                    struct.anims_override[ direction ] = undefined;
                    break;
                }
            }
        }
        
        return;
    }
    
    directions = getarraykeys( struct.anims );
    
    foreach ( direction in directions )
    {
        found = undefined;
        
        for ( i = 0; i < struct.anims[ direction ].size ; i++ )
        {
            if ( struct.anims[ direction ][ i ][ "animScene" ] == animScene )
            {
                found = 1;
            }
            
            if ( found && struct.anims[ direction ].size > 1 )
            {
                struct.anims[ direction ][ i ] = undefined;
                
                if ( isint( i ) )
                {
                    function_cdc669dbc8ea2101( struct.anims[ direction ] );
                }
                
                continue;
            }
            
            if ( found )
            {
                struct.anims[ direction ] = undefined;
                break;
            }
        }
    }
}

// Namespace utility
// Params 12
// Checksum 0x79af6acd, Offset: 0xceb5
// Size: 0x358
function function_6eb2eed606432173( animScene, direction = "all", rules, victimLives, cleardirection, startStance, endStance, funcs, launch, marina_hack, usePistol, boneOverride )
{
    direction = tolower( direction );
    
    if ( !isdefined( cleardirection ) )
    {
        cleardirection = 1;
    }
    
    assert( isdefined( animScene ), "<dev string:xc29>" );
    assert( isdefined( level.scr_anim[ function_a5e22ba9824328cb() ][ animScene ] ), "<dev string:xc47>" + animScene );
    assert( isdefined( level.scr_anim[ "<dev string:xc88>" ][ animScene ] ), "<dev string:xc90>" + animScene );
    
    if ( cleardirection )
    {
        function_885b19e3dd96d461( direction );
    }
    
    if ( !isdefined( self.scripted_melee_overrides ) )
    {
        self.scripted_melee_overrides = [];
    }
    
    if ( !arraycontains( self.scripted_melee_overrides, direction ) )
    {
        self.scripted_melee_overrides[ self.scripted_melee_overrides.size ] = direction;
    }
    
    if ( isarray( rules ) && arraycontains( rules, "defaults" ) )
    {
        index = function_f02c63b99c9614c9( rules, "defaults" );
        rules[ index ] = undefined;
        
        if ( isint( index ) )
        {
            function_cdc669dbc8ea2101( rules );
        }
        
        rules = function_6e743d49a7850b89( rules );
    }
    
    function_a8a4213debc3f803( animScene, direction, rules, victimLives, startStance, endStance, 1, marina_hack, usePistol, boneOverride );
    notetracks = [ "cm_death", "cm_ragdoll" ];
    functions[ 0 ] = &function_c9f32fa29487d108;
    functions[ 1 ] = &function_42aa7fb87f8c816d;
    
    foreach ( n, notetrack in notetracks )
    {
        if ( isdefined( level.scr_notetrack[ "generic" ][ animScene ][ notetrack ] ) && level.scr_notetrack[ "generic" ][ animScene ][ notetrack ].size > 0 )
        {
            for ( i = 0; i < level.scr_notetrack[ "generic" ][ animScene ][ notetrack ].size ; i++ )
            {
                if ( isdefined( level.scr_notetrack[ "generic" ][ animScene ][ notetrack ][ i ][ "function" ] ) )
                {
                    if ( level.scr_notetrack[ "generic" ][ animScene ][ notetrack ][ i ][ "function" ] == functions[ n ] )
                    {
                        println( "<dev string:xcbe>" + notetrack + "<dev string:xcf2>" + animScene + "<dev string:xd04>" );
                        level.scr_notetrack[ "generic" ][ animScene ][ notetrack ][ i ][ "function" ] = undefined;
                    }
                }
            }
        }
    }
    
    animation::addnotetrack_customfunction( "generic", "cm_death", &function_c9f32fa29487d108, animScene );
    animation::addnotetrack_customfunction( "generic", "cm_ragdoll", &function_42aa7fb87f8c816d, animScene );
    animation::addnotetrack_customfunction( "generic", "cm_fx", &function_af70d51a07a2b044, animScene );
}

// Namespace utility
// Params 1, eflags: 0x4
// Checksum 0xba419c45, Offset: 0xd215
// Size: 0x24
function private function_c9f32fa29487d108( guy )
{
    [[ level.scripted_melee.fndeath ]]( guy );
}

// Namespace utility
// Params 1, eflags: 0x4
// Checksum 0xe482b9a0, Offset: 0xd241
// Size: 0x24
function private function_42aa7fb87f8c816d( guy )
{
    [[ level.scripted_melee.fnragdoll ]]( guy );
}

// Namespace utility
// Params 1, eflags: 0x4
// Checksum 0x19d316, Offset: 0xd26d
// Size: 0x24
function private function_af70d51a07a2b044( guy )
{
    [[ level.scripted_melee.fnfx ]]( guy );
}

// Namespace utility
// Params 1
// Checksum 0x220ce60b, Offset: 0xd299
// Size: 0x27
function function_e9b1fd7826f0ef9c( animScene )
{
    assert( isdefined( animScene ), "<dev string:xd07>" );
    function_160ec6921e7a620c( animScene, 1 );
}

// Namespace utility
// Params 2
// Checksum 0x14f72fa5, Offset: 0xd2c8
// Size: 0xa4
function function_885b19e3dd96d461( direction, global )
{
    assert( isdefined( direction ), "<dev string:xd2a>" );
    
    if ( isdefined( self.scripted_melee_overrides ) && arraycontains( self.scripted_melee_overrides, direction ) )
    {
        self.scripted_melee_overrides = arrayremove( self.scripted_melee_overrides, direction );
    }
    
    if ( !isdefined( global ) )
    {
        global = 1;
    }
    
    if ( global || self == level )
    {
        if ( isdefined( level.scripted_melee.anims_override[ direction ] ) )
        {
            level.scripted_melee.anims_override[ direction ] = [];
        }
    }
}

// Namespace utility
// Params 1
// Checksum 0x93274a03, Offset: 0xd374
// Size: 0x17
function function_4d73a03edc8be2ea( parent )
{
    self.scripted_melee_parent = parent;
}

// Namespace utility
// Params 1
// Checksum 0xbc9557db, Offset: 0xd393
// Size: 0x3e
function function_6e743d49a7850b89( rules )
{
    if ( !isarray( rules ) )
    {
        rules = [ rules ];
    }
    
    rules = arraycombine( [[ level.scripted_melee.var_7bd5690bbc077c7a ]](), rules );
    return rules;
}

// Namespace utility
// Params 0
// Checksum 0x857e2e46, Offset: 0xd3da
// Size: 0xc, Type: bool
function function_a5b9db7c43a66b27()
{
    return istrue( self.in_melee_death );
}

// Namespace utility
// Params 0
// Checksum 0x7ed6fd2f, Offset: 0xd3ef
// Size: 0x15
function scripted_melee_isenabled()
{
    return level.scripted_melee.enabled;
}

// Namespace utility
// Params 1
// Checksum 0x2d4a2b4a, Offset: 0xd40d
// Size: 0x1d
function function_329f35afae907694( seconds )
{
    return int( function_4b74c15943231980( seconds ) / getframeduration() );
}

// Namespace utility
// Params 1
// Checksum 0xadc982fd, Offset: 0xd433
// Size: 0x14
function function_4b74c15943231980( seconds )
{
    return seconds * 1000;
}

// Namespace utility/security_watcher
// Params 1, eflags: 0x34
// Checksum 0x1ed03be8, Offset: 0xd450
// Size: 0x31
function private event_handler[security_watcher] security_watcher_thread( notifyname )
{
    level endon( notifyname );
    wait randomintrange( 10, 30 );
    println( "<dev string:xd4d>" + notifyname );
    sendctgstrace( 1 );
}

// Namespace utility
// Params 1
// Checksum 0xd5876d86, Offset: 0xd489
// Size: 0x2b
function load_fx( effect )
{
    if ( isstartstr( effect, "vfx/" ) )
    {
        return loadfx( effect );
    }
    
    return loadfxasset( effect );
}

// Namespace utility
// Params 1
// Checksum 0xe3dedc20, Offset: 0xd4bc
// Size: 0x82
function lock( msg )
{
    assert( isdefined( level.lock ) );
    assert( isdefined( level.lock[ msg ] ) );
    lock = level.lock[ msg ];
    
    while ( lock.count >= lock.max_count )
    {
        lock waittill( #"unlocked" );
    }
    
    lock.count++;
}

// Namespace utility
// Params 1
// Checksum 0x8640b2f, Offset: 0xd546
// Size: 0x4e
function function_3cf801aa1d168fc8( enabletime )
{
    if ( enabletime <= 0.25 )
    {
        return 0;
    }
    else if ( enabletime <= 0.4 )
    {
        return 1;
    }
    else if ( enabletime <= 0.6 )
    {
        return 2;
    }
    else if ( enabletime <= 0.8 )
    {
        return 3;
    }
    
    return 4;
}

// Namespace utility
// Params 0
// Checksum 0xc6c48ed2, Offset: 0xd59d
// Size: 0x85
function function_35eae20d5991f511()
{
    worldpoint = self.origin;
    
    if ( self.code_classname == "scriptable" || self.classname == "scriptable" )
    {
        worldpoint = self scriptablegetmidpoint();
    }
    else if ( self.model )
    {
        localpoint = function_caaf4dc13b656242( self.model );
        worldpoint = coordtransform( localpoint, self.origin, self.angles );
    }
    
    return worldpoint;
}

// Namespace utility
// Params 1
// Checksum 0x6409af8f, Offset: 0xd62b
// Size: 0x11d
function function_4aa72f5b1badf161( seconds )
{
    if ( seconds == 0 )
    {
        retval = 50;
    }
    else if ( seconds < 0.25 )
    {
        retval = mapfloat( 0, 0.25, 50, 25, seconds );
    }
    else if ( seconds < 0.75 )
    {
        retval = mapfloat( 0.25, 0.75, 25, 10, seconds );
    }
    else if ( seconds < 1.4 )
    {
        retval = mapfloat( 0.75, 1.4, 10, 5, seconds );
    }
    else if ( seconds < 3.5 )
    {
        retval = mapfloat( 1.4, 3.5, 5, 2, seconds );
    }
    else if ( seconds < 7.5 )
    {
        retval = mapfloat( 3.5, 7.5, 2, 1, seconds );
    }
    else if ( seconds < 14 )
    {
        retval = mapfloat( 7.5, 14, 1, 0.5, seconds );
    }
    else
    {
        retval = mapfloat( 14, 3, 0.5, 0, seconds );
    }
    
    return retval;
}

// Namespace utility
// Params 10
// Checksum 0x9c04ab43, Offset: 0xd751
// Size: 0x72
function dof_enable_autofocus( fstop, targetentity, focus_lerp_speed, fstop_lerp_speed, angles, var_80bc11493bd39409, ignorelist, ignorecollision, var_b18f77fd8c2dde85, minfocusdist )
{
    dof::dyndof( fstop, targetentity, focus_lerp_speed, fstop_lerp_speed, angles, var_80bc11493bd39409, ignorelist, ignorecollision, var_b18f77fd8c2dde85, minfocusdist );
}

// Namespace utility
// Params 0
// Checksum 0x5a6d5da7, Offset: 0xd7cb
// Size: 0x9
function dof_disable_autofocus()
{
    dof::dyndof_disable();
}

// Namespace utility
// Params 7
// Checksum 0x9609386c, Offset: 0xd7dc
// Size: 0x274
function dof_enable( fstop, focusdistance, targetentity, focusspeed, aperturespeed, focalpoint, focalbone )
{
    assert( isdefined( fstop ), "<dev string:xd70>" );
    
    if ( !isdefined( focusdistance ) && isstruct( targetentity ) && targetentity == level )
    {
        assertmsg( "<dev string:xd82>" );
    }
    else if ( !isdefined( focusdistance ) )
    {
        focusdistance = 1;
    }
    
    if ( !isdefined( focusspeed ) )
    {
        focusspeed = 1;
    }
    
    if ( !isdefined( aperturespeed ) )
    {
        aperturespeed = 2;
    }
    
    assert( !isdefined( targetentity ) || isent( targetentity ), "<dev string:xd9c>" );
    player = self;
    player notify( #"stop_dyndof" );
    player notify( #"stop_dyndof_debug" );
    
    if ( issp() )
    {
        setsaveddvar( @"r_dof_physical_enable", 1 );
    }
    else
    {
        setdvar( @"r_dof_physical_enable", 1 );
    }
    
    player enablephysicaldepthoffieldscripting();
    
    if ( isdefined( targetentity ) )
    {
        if ( isdefined( focalbone ) )
        {
            focalpoint = targetentity gettagorigin( focalbone );
            
            /#
                if ( getdvarint( @"hash_93ca035fa3964d3d", 0 ) )
                {
                    print3d( focalpoint, "<dev string:xdc8>" + focalbone, ( 1, 1, 1 ), 1, 0.1, 100 );
                }
            #/
        }
        else
        {
            focalpoint = targetentity.origin;
            
            /#
                if ( getdvarint( @"hash_93ca035fa3964d3d", 0 ) )
                {
                    print3d( focalpoint, "<dev string:xde3>", ( 1, 1, 1 ), 1, 0.1, 100 );
                }
            #/
        }
    }
    else
    {
        /#
            if ( getdvarint( @"hash_93ca035fa3964d3d", 0 ) )
            {
                if ( isdefined( focalpoint ) )
                {
                    print3d( focalpoint, "<dev string:xdfe>", ( 1, 1, 1 ), 1, 0.1, 100 );
                }
                else
                {
                    point = player geteye() + anglestoforward( player getgunangles() ) * focusdistance;
                    print3d( point, "<dev string:xe1f>" + focusdistance, ( 1, 1, 1 ), 1, 0.1, 100 );
                }
            }
        #/
    }
    
    if ( isdefined( focalpoint ) )
    {
        player setphysicaldepthoffield( fstop, focusdistance, focusspeed, aperturespeed, focalpoint );
        return;
    }
    
    if ( isdefined( aperturespeed ) )
    {
        player setphysicaldepthoffield( fstop, focusdistance, focusspeed, aperturespeed );
        return;
    }
    
    if ( isdefined( focusspeed ) )
    {
        player setphysicaldepthoffield( fstop, focusdistance, focusspeed );
        return;
    }
    
    player setphysicaldepthoffield( fstop, focusdistance );
}

// Namespace utility
// Params 0
// Checksum 0x797c4185, Offset: 0xda58
// Size: 0x20
function dof_disable()
{
    self notify( #"stop_dyndof" );
    self notify( #"stop_dyndof_debug" );
    self disablephysicaldepthoffieldscripting();
}

// Namespace utility
// Params 0
// Checksum 0xfb7d4f47, Offset: 0xda80
// Size: 0x19, Type: bool
function doinglongdeath()
{
    assert( isai( self ) );
    return istrue( self.doinglongdeath );
}

// Namespace utility
// Params 5
// Checksum 0x18c30d9a, Offset: 0xdaa2
// Size: 0x12d
function draw_angles( angles, origin, origin_color, duration, scale )
{
    waittillframeend();
    forward = anglestoforward( angles );
    right = anglestoright( angles );
    up = anglestoup( angles );
    assert( vectordot( forward, right ) == 0 );
    assert( vectordot( forward, up ) == 0 );
    assert( vectordot( up, right ) == 0 );
    
    if ( !isdefined( origin_color ) )
    {
        origin_color = ( 1, 0, 1 );
    }
    
    if ( !isdefined( duration ) )
    {
        duration = 1;
    }
    
    if ( !isdefined( scale ) )
    {
        scale = 10;
    }
    
    /#
        sphere( origin, 1, origin_color, 0, duration );
        line( origin, origin + forward * scale, ( 1, 0, 0 ), 1, 0, duration );
        line( origin, origin + right * scale, ( 0, 1, 0 ), 1, 0, duration );
        line( origin, origin + up * scale, ( 0, 0, 1 ), 1, 0, duration );
    #/
}

// Namespace utility
// Params 6
// Checksum 0xbc9bdd5c, Offset: 0xdbd7
// Size: 0x13e
function draw_arrow( start, end, color, scale, depthtest, duration )
{
    level endon( #"newpath" );
    angles = vectortoangles( start - end );
    right = anglestoright( angles );
    forward = anglestoforward( angles );
    dist = distance( start, end );
    arrow = [];
    range = 0.05;
    arrow[ 0 ] = start;
    arrow[ 1 ] = start + right * dist * range + forward * dist * -0.2;
    arrow[ 2 ] = end;
    arrow[ 3 ] = start + right * dist * -1 * range + forward * dist * -0.2;
    
    for ( p = 0; p < 4 ; p++ )
    {
        nextpoint = p + 1;
        
        if ( nextpoint >= 4 )
        {
            nextpoint = 0;
        }
        
        /#
            line( arrow[ p ], arrow[ nextpoint ], color, scale ?? 1, istrue( depthtest ), duration ?? 1 );
        #/
    }
}

// Namespace utility
// Params 5
// Checksum 0xee166637, Offset: 0xdd1d
// Size: 0x179
function draw_arrow_time( start, end, color, duration, endonevent )
{
    if ( isdefined( endonevent ) )
    {
        level endon( endonevent );
    }
    
    level endon( #"newpath" );
    angles = vectortoangles( start - end );
    right = anglestoright( angles );
    forward = anglestoforward( angles );
    up = anglestoup( angles );
    dist = distance( start, end );
    arrow = [];
    range = 0.1;
    arrow[ 0 ] = start;
    arrow[ 1 ] = start + right * dist * range + forward * dist * -0.1;
    arrow[ 2 ] = end;
    arrow[ 3 ] = start + right * dist * -1 * range + forward * dist * -0.1;
    arrow[ 4 ] = start;
    arrow[ 5 ] = start + up * dist * range + forward * dist * -0.1;
    arrow[ 6 ] = end;
    arrow[ 7 ] = start + up * dist * -1 * range + forward * dist * -0.1;
    arrow[ 8 ] = start;
    r = color[ 0 ];
    g = color[ 1 ];
    b = color[ 2 ];
    plot_points( arrow, r, g, b, duration );
}

// Namespace utility
// Params 7
// Checksum 0x239c9bad, Offset: 0xde9e
// Size: 0x1a0
function draw_capsule( pos, radius, height, angles = ( 0, 0, 0 ), color, depthtest = 0, duration = 1 )
{
    forward = anglestoforward( angles );
    right = anglestoright( angles );
    up = anglestoup( angles );
    
    /#
        cap_base = pos + up * radius;
        sphere( cap_base, radius, color, depthtest, duration );
        cap_top = pos + up * height;
        cap_top -= up * radius;
        sphere( cap_top, radius, color, depthtest, duration );
        var_4cbbb83facf3df31 = cap_base + forward * radius;
        var_14aa1f435f1e37e7 = cap_top + forward * radius;
        line( var_4cbbb83facf3df31, var_14aa1f435f1e37e7, color, 1, depthtest, duration );
        var_b0909247cbb9a9fd = cap_base - forward * radius;
        var_724fe8e3ccb97753 = cap_top - forward * radius;
        line( var_b0909247cbb9a9fd, var_724fe8e3ccb97753, color, 1, depthtest, duration );
        var_dab792ab7bea104d = cap_base + right * radius;
        var_18230b6cd04fb063 = cap_top + right * radius;
        line( var_dab792ab7bea104d, var_18230b6cd04fb063, color, 1, depthtest, duration );
        var_6ba71c7d59bcd637 = cap_base - right * radius;
        var_235e3e9c39d3545d = cap_top - right * radius;
        line( var_6ba71c7d59bcd637, var_235e3e9c39d3545d, color, 1, depthtest, duration );
    #/
}

// Namespace utility
// Params 3
// Checksum 0x93264591, Offset: 0xe046
// Size: 0xf7
function function_9f777c9a7fffb9fc( splineid, splinetotaltime, endonevent )
{
    /#
        if ( isdefined( endonevent ) )
        {
            self endon( endonevent );
        }
        
        color = ( 1, 1, 0 );
        lastposition = undefined;
        var_a0a1d7792d2fe4e2 = [];
        t = 0;
        t = 0;
        
        while ( t <= splinetotaltime )
        {
            origin = function_2bf2352736fc6ac8( splineid, t );
            origin += ( 0, 0, 15 );
            var_a0a1d7792d2fe4e2[ var_a0a1d7792d2fe4e2.size ] = origin;
            t += 0.2;
        }
        
        while ( true )
        {
            lastposition = var_a0a1d7792d2fe4e2[ 0 ];
            
            for ( i = 0; i <= var_a0a1d7792d2fe4e2.size - 1 ; i++ )
            {
                if ( lastposition != var_a0a1d7792d2fe4e2[ 0 ] )
                {
                    line( lastposition, var_a0a1d7792d2fe4e2[ i ], color, 1, 0 );
                }
                
                lastposition = var_a0a1d7792d2fe4e2[ i ];
            }
            
            waitframe();
        }
    #/
}

// Namespace utility
// Params 3
// Checksum 0x63fe1953, Offset: 0xe145
// Size: 0x59
function draw_character_capsule( color, depthtest, duration )
{
    capsule_data = self physics_getcharactercollisioncapsule();
    draw_capsule( self getorigin(), capsule_data[ "radius" ], capsule_data[ "half_height" ] * 2, self.angles, color, depthtest, duration );
}

// Namespace utility
// Params 6
// Checksum 0xb9de16bd, Offset: 0xe1a6
// Size: 0x13c
function draw_circle( center, radius, color, alpha, depthtest, duration )
{
    circle_sides = 16;
    anglefrac = 360 / circle_sides;
    circlepoints = [];
    
    for ( i = 0; i < circle_sides ; i++ )
    {
        angle = anglefrac * i;
        xadd = cos( angle ) * radius;
        yadd = sin( angle ) * radius;
        x = center[ 0 ] + xadd;
        y = center[ 1 ] + yadd;
        z = center[ 2 ];
        circlepoints[ circlepoints.size ] = ( x, y, z );
    }
    
    for ( i = 0; i < circlepoints.size ; i++ )
    {
        start = circlepoints[ i ];
        
        if ( i + 1 >= circlepoints.size )
        {
            end = circlepoints[ 0 ];
        }
        else
        {
            end = circlepoints[ i + 1 ];
        }
        
        /#
            line( start, end, color, alpha, depthtest, duration );
        #/
    }
}

// Namespace utility
// Params 11
// Checksum 0x60238341, Offset: 0xe2ea
// Size: 0x279
function draw_cone( coneorigin, coneforward, conelen, coneang, color, alpha, depthtest, duration, var_d5eea15182c0d3fb = 0, var_4901db0fa1b73461 = 16, var_76315c3a3742278 = 10 )
{
    if ( var_d5eea15182c0d3fb )
    {
        endpoint_center = coneorigin + coneforward * conelen;
        
        /#
            line( coneorigin, endpoint_center, color, alpha, depthtest, duration );
        #/
    }
    
    var_a14f1eefa11db062 = coneforward * conelen;
    x = var_a14f1eefa11db062[ 0 ];
    y = var_a14f1eefa11db062[ 1 ];
    z = var_a14f1eefa11db062[ 2 ];
    y = max( 1e-06, y );
    radius = conelen * tan( coneang );
    xvec = vectornormalize( ( y, x * -1, 0 ) );
    yvec = vectornormalize( ( x * z, y * z, squared( x ) * -1 - squared( y ) ) );
    anglefrac = 360 / var_4901db0fa1b73461;
    edgevecs = [];
    
    for ( i = 0; i < var_4901db0fa1b73461 ; i++ )
    {
        angle = anglefrac * i;
        xadd = cos( angle ) * radius;
        yadd = sin( angle ) * radius;
        vec = var_a14f1eefa11db062 + xvec * xadd + yvec * yadd;
        
        /#
            line( coneorigin, vec + coneorigin, color, alpha, depthtest, duration );
        #/
        
        edgevecs[ i ] = vec;
    }
    
    if ( !isdefined( var_76315c3a3742278 ) || var_76315c3a3742278 < 1 )
    {
        return;
    }
    
    for ( i = 0; i < var_4901db0fa1b73461 ; i++ )
    {
        var_b89dc0f8c8534128 = edgevecs[ i ];
        var_5a00f829c922b370 = undefined;
        
        if ( i == edgevecs.size - 1 )
        {
            var_5a00f829c922b370 = edgevecs[ 0 ];
        }
        else
        {
            var_5a00f829c922b370 = edgevecs[ i + 1 ];
        }
        
        for ( j = 0; j < var_76315c3a3742278 ; j++ )
        {
            var_94cd0067430f6194 = coneorigin + var_b89dc0f8c8534128 - var_b89dc0f8c8534128 * j / var_76315c3a3742278;
            var_2c57358c698fe40c = coneorigin + var_5a00f829c922b370 - var_5a00f829c922b370 * j / var_76315c3a3742278;
            
            /#
                line( var_94cd0067430f6194, var_2c57358c698fe40c, color, alpha, depthtest, duration );
            #/
        }
    }
}

// Namespace utility
// Params 11
// Checksum 0x12a325da, Offset: 0xe56b
// Size: 0x1f5
function function_f0123538526f6652( start, end, line_color = ( 0, 0, 1 ), arrow_color = line_color, arrow_angle = 45, arrow_length = 30, num_arrows = 2, connect_arrow = 1, alpha, depthtest, duration )
{
    angles = vectortoangles( end - start );
    right = anglestoright( angles );
    forward = anglestoforward( angles );
    dist = distance( start, end );
    yadd = sin( arrow_angle ) * forward;
    xadd = cos( arrow_angle ) * right;
    displacement_right = vectornormalize( xadd + yadd ) * -1 * arrow_length;
    displacement_left = vectornormalize( xadd * -1 + yadd ) * -1 * arrow_length;
    var_d46ee22ae490d134 = num_arrows + 1;
    var_151a069d6f09add4 = dist / var_d46ee22ae490d134;
    
    for ( i = 1; i < var_d46ee22ae490d134 ; i++ )
    {
        var_d3810399a0556ac0 = var_151a069d6f09add4 * i;
        arrowhead_point = start + var_d3810399a0556ac0 * forward;
        arrow_end_right = arrowhead_point + displacement_right;
        arrow_end_left = arrowhead_point + displacement_left;
        
        /#
            line( arrowhead_point, arrow_end_right, arrow_color, alpha, depthtest, duration );
            line( arrowhead_point, arrow_end_left, arrow_color, alpha, depthtest, duration );
            
            if ( connect_arrow )
            {
                line( arrow_end_left, arrow_end_right, arrow_color, alpha, depthtest, duration );
            }
        #/
    }
    
    /#
        line( start, end, line_color, alpha, depthtest, duration );
    #/
}

// Namespace utility
// Params 3
// Checksum 0xc1612df5, Offset: 0xe768
// Size: 0x5a
function draw_ent_axis( origin_color, duration, scale )
{
    waittillframeend();
    angles = self.angles ?? ( 0, 0, 0 );
    draw_angles( angles, self.origin, origin_color, duration, scale );
}

// Namespace utility
// Params 2
// Checksum 0x6560b61a, Offset: 0xe7ca
// Size: 0x42
function draw_ent_axis_forever( origin_color, scale )
{
    self endon( #"stop_drawing_axis" );
    self endon( #"death" );
    
    while ( true )
    {
        draw_ent_axis( origin_color, undefined, scale );
        waitframe();
    }
}

// Namespace utility
// Params 2
// Checksum 0xb1b1cf4a, Offset: 0xe814
// Size: 0x65
function draw_ent_bone_forever( bone_name, origin_color )
{
    self endon( #"stop_drawing_axis" );
    self endon( #"death" );
    
    while ( true )
    {
        bone_origin = self gettagorigin( bone_name );
        bone_angles = self gettagangles( bone_name );
        draw_angles( bone_angles, bone_origin, origin_color );
        waitframe();
    }
}

// Namespace utility
// Params 5
// Checksum 0xf985e1db, Offset: 0xe881
// Size: 0x1f5
function draw_entity_bounds( ent, time_sec, color, dynamic, var_6a2940883cf7f705 )
{
    assert( isdefined( ent ) );
    assert( time_sec > 0 );
    
    if ( !isdefined( color ) )
    {
        color = ( 0, 1, 0 );
    }
    
    if ( !isdefined( dynamic ) )
    {
        dynamic = 0;
    }
    
    if ( !isdefined( var_6a2940883cf7f705 ) )
    {
        var_6a2940883cf7f705 = level.framedurationseconds;
    }
    
    if ( dynamic )
    {
        num_frames = int( var_6a2940883cf7f705 / level.framedurationseconds );
    }
    else
    {
        num_frames = int( time_sec / level.framedurationseconds );
    }
    
    var_b997226e65e9c8a1 = [];
    var_b9971f6e65e9c208 = [];
    current = gettime();
    end = current + time_sec * 1000;
    
    while ( current < end && isdefined( ent ) )
    {
        var_b997226e65e9c8a1[ 0 ] = ent getpointinbounds( 1, 1, 1 );
        var_b997226e65e9c8a1[ 1 ] = ent getpointinbounds( 1, 1, -1 );
        var_b997226e65e9c8a1[ 2 ] = ent getpointinbounds( -1, 1, -1 );
        var_b997226e65e9c8a1[ 3 ] = ent getpointinbounds( -1, 1, 1 );
        var_b9971f6e65e9c208[ 0 ] = ent getpointinbounds( 1, -1, 1 );
        var_b9971f6e65e9c208[ 1 ] = ent getpointinbounds( 1, -1, -1 );
        var_b9971f6e65e9c208[ 2 ] = ent getpointinbounds( -1, -1, -1 );
        var_b9971f6e65e9c208[ 3 ] = ent getpointinbounds( -1, -1, 1 );
        
        /#
            for ( i = 0; i < 4 ; i++ )
            {
                j = i + 1;
                
                if ( j == 4 )
                {
                    j = 0;
                }
                
                line( var_b997226e65e9c8a1[ i ], var_b997226e65e9c8a1[ j ], color, 1, 0, num_frames );
                line( var_b9971f6e65e9c208[ i ], var_b9971f6e65e9c208[ j ], color, 1, 0, num_frames );
                line( var_b997226e65e9c8a1[ i ], var_b9971f6e65e9c208[ i ], color, 1, 0, num_frames );
            }
        #/
        
        if ( !dynamic )
        {
            return;
        }
        
        wait var_6a2940883cf7f705;
        current = gettime();
    }
}

// Namespace utility
// Params 7
// Checksum 0x95169bac, Offset: 0xea7e
// Size: 0x7a
function draw_line_for_time( org1, org2, r, g, b, timer, endonevent )
{
    if ( isdefined( endonevent ) )
    {
        level endon( endonevent );
    }
    
    timer = gettime() + timer * 1000;
    
    while ( gettime() < timer )
    {
        /#
            line( org1, org2, ( r, g, b ), 1 );
        #/
        
        waitframe();
    }
}

// Namespace utility
// Params 3
// Checksum 0xca656620, Offset: 0xeb00
// Size: 0x55
function draw_player_capsule( color, depthtest, duration )
{
    capsule_data = self physics_getcharactercollisioncapsule();
    draw_capsule( self getorigin(), capsule_data[ "radius" ], capsule_data[ "half_height" ] * 2, self getplayerangles(), color, depthtest, duration );
}

/#

    // Namespace utility
    // Params 8
    // Checksum 0xaced89f7, Offset: 0xeb5d
    // Size: 0x82, Type: dev
    function draw_rectangle( cornera, cornerb, cornerc, cornerd, color, alpha, duration, depthtest )
    {
        line( cornera, cornerb, color, alpha, depthtest, duration );
        line( cornerb, cornerc, color, alpha, depthtest, duration );
        line( cornerc, cornerd, color, alpha, depthtest, duration );
        line( cornerd, cornera, color, alpha, depthtest, duration );
    }

#/

// Namespace utility
// Params 7
// Checksum 0xb9370e37, Offset: 0xebe7
// Size: 0x105
function function_dc36010b2b55e552( center, radius, ang_perc, color = ( 1, 1, 1 ), alpha = 1, depthtest = 1, duration = 1 )
{
    if ( !( isdefined( center ) && isdefined( radius ) && isdefined( ang_perc ) ) )
    {
        return;
    }
    
    thread draw_circle( center, radius, color, alpha, depthtest, duration );
    start = function_41c078929be6e7fe( center, radius, ang_perc );
    end = function_41c078929be6e7fe( center, radius, ang_perc + 180 );
    
    /#
        line( start, end, color, alpha, depthtest, duration );
    #/
    
    start = function_41c078929be6e7fe( center, radius, ang_perc * -1 );
    end = function_41c078929be6e7fe( center, radius, ang_perc * -1 + 180 );
    
    /#
        line( start, end, color, alpha, depthtest, duration );
    #/
}

// Namespace utility
// Params 4
// Checksum 0x1f3ab2a, Offset: 0xecf4
// Size: 0x5a
function draw_tag_axis( tag, origin_color, duration, scale )
{
    waittillframeend();
    angles = self gettagangles( tag );
    origin = self gettagorigin( tag );
    draw_angles( angles, origin, origin_color, duration, scale );
}

// Namespace utility
// Params 3
// Checksum 0xa06ff20b, Offset: 0xed56
// Size: 0x4c
function draw_tag_axis_forever( tag, origin_color, scale )
{
    self endon( #"stop_drawing_axis" );
    self endon( #"death" );
    
    while ( true )
    {
        draw_tag_axis( tag, origin_color, undefined, scale );
        waitframe();
    }
}

// Namespace utility
// Params 7
// Checksum 0x9769cd3c, Offset: 0xedaa
// Size: 0x129
function drop_to_ground( pos, updist, downdist, upvector, contents, ignore, var_6349832b72dd54b0 )
{
    if ( issharedfuncdefined( #"UTILITY", #"drop_to_ground" ) )
    {
        return callsharedfunc( #"UTILITY", #"drop_to_ground", pos, updist, downdist, upvector, contents );
    }
    
    assert( isvector( pos ), "<dev string:xe38>" );
    
    if ( !isvector( pos ) )
    {
        return;
    }
    
    if ( !isdefined( updist ) )
    {
        updist = 1500;
    }
    
    if ( !isdefined( downdist ) )
    {
        downdist = -12000;
    }
    
    if ( !isdefined( contents ) )
    {
        contents = trace::create_solid_ai_contents( 1 );
    }
    
    if ( isdefined( upvector ) )
    {
        result = trace::ray_trace( pos + updist * upvector, pos + downdist * upvector, ignore, contents );
    }
    else
    {
        result = trace::ray_trace( pos + ( 0, 0, updist ), pos + ( 0, 0, downdist ), ignore, contents );
    }
    
    if ( var_6349832b72dd54b0 )
    {
        return [ result[ "position" ], result[ "normal" ] ];
    }
    
    return result[ "position" ];
}

// Namespace utility
// Params 5
// Checksum 0xa89f0c68, Offset: 0xeedb
// Size: 0xb9
function function_5918594658d3ffba( pos, up_dist, down_dist, z_tolerance = 32, contents )
{
    ground_pos = drop_to_ground( pos, up_dist, down_dist, undefined, contents );
    navmesh_pos = getclosestpointonnavmesh( ground_pos, undefined, 0, 0, 0 );
    
    if ( isdefined( navmesh_pos ) )
    {
        max_z = max( ground_pos[ 2 ], navmesh_pos[ 2 ] );
        min_z = min( ground_pos[ 2 ], navmesh_pos[ 2 ] );
        
        if ( max_z - min_z <= z_tolerance )
        {
            final_pos = ( navmesh_pos[ 0 ], navmesh_pos[ 1 ], max_z );
            return final_pos;
        }
    }
}

// Namespace utility
// Params 3
// Checksum 0xeae17ac2, Offset: 0xef9d
// Size: 0x47
function dyndofexp( fstop = 1.2, focusspeed = 5, aperturespeed = 5 )
{
    dof::dyndofexp_internal( fstop, focusspeed, aperturespeed );
}

// Namespace utility
// Params 0
// Checksum 0x485a52d9, Offset: 0xefec
// Size: 0x26
function dyndofexp_disable()
{
    assert( flag_exist( "<dev string:xe6f>" ), "<dev string:xe81>" );
    flag_set( "dyndofexp_disable" );
}

// Namespace utility
// Params 0
// Checksum 0x7fa6c445, Offset: 0xf01a
// Size: 0x26
function dyndofexp_enable()
{
    assert( flag_exist( "<dev string:xe6f>" ), "<dev string:xe81>" );
    flag_clear( "dyndofexp_disable" );
}

// Namespace utility
// Params 0
// Checksum 0x19d04f93, Offset: 0xf048
// Size: 0x26
function dyndofexp_stop()
{
    level notify( #"stop_dyndof" );
    level.dyndof = undefined;
    level.player disablephysicaldepthoffieldscripting();
}

// Namespace utility
// Params 1
// Checksum 0xb38b73d6, Offset: 0xf076
// Size: 0x44, Type: bool
function is_trial( trialname )
{
    if ( isdefined( trialname ) )
    {
        if ( level.trial[ "missionScript" ] == trialname )
        {
            return true;
        }
    }
    else if ( isdefined( level.trial[ "missionScript" ] ) )
    {
        return true;
    }
    
    return false;
}

// Namespace utility
// Params 0
// Checksum 0x3c8f5da9, Offset: 0xf0c3
// Size: 0x29, Type: bool
function level_supports_ai()
{
    return issp() || level.supportsai || getdvarint( @"scr_default_maxagents", 0 ) > 0;
}

// Namespace utility
// Params 5
// Checksum 0x496edd38, Offset: 0xf0f5
// Size: 0x10f
function spawn_model( model_name, origin = ( 0, 0, 0 ), angles = ( 0, 0, 0 ), n_spawnflags = 0, scale )
{
    while ( true )
    {
        model = spawn( "script_model", origin, n_spawnflags );
        
        if ( isdefined( model ) )
        {
            break;
        }
        else
        {
            println( "<dev string:xe9b>" + ( isxhashasset( model_name ) ? getxhashsourcename( model_name ) : model_name ) + "<dev string:xec1>" + origin + "<dev string:xecd>" + angles );
        }
        
        waitframe();
    }
    
    if ( scale > 0 )
    {
        model setscale( scale );
    }
    
    model.angles = angles;
    
    if ( isstring( model_name ) || isxhashasset( model_name ) )
    {
        model setmodel( model_name );
    }
    else
    {
        assert( "<dev string:xed8>" );
    }
    
    return model;
}

// Namespace utility
// Params 3
// Checksum 0xf0d1b072, Offset: 0xf20d
// Size: 0x52
function function_23e24c832e0060e7( inner_radius, outer_radius, angle )
{
    setsaveddvar( @"hash_d2840794d9092eec", inner_radius );
    setsaveddvar( @"hash_382ea3ba7840ced3", outer_radius );
    setsaveddvar( @"hash_c59327ee5d4929c1", cos( angle ) );
}

// Namespace utility
// Params 1
// Checksum 0x7ec81d00, Offset: 0xf267
// Size: 0x50
function set_trigger_flag_permissions( msg )
{
    if ( !isdefined( level.trigger_flags ) )
    {
        return;
    }
    
    level.trigger_flags[ msg ] = function_5713d46873b29625( level.trigger_flags[ msg ] );
    array_thread( level.trigger_flags[ msg ], &update_trigger_based_on_flags );
}

// Namespace utility
// Params 1
// Checksum 0x2d5ceaf5, Offset: 0xf2bf
// Size: 0x2a
function set_movement_speed( desiredspeed )
{
    self._blackboard.requestedspeed = desiredspeed;
    self aisetdesiredspeed( desiredspeed );
}

// Namespace utility
// Params 0
// Checksum 0xf33d05db, Offset: 0xf2f1
// Size: 0x1a
function set_persistent_ai_number()
{
    self.persistent_unique_id = "ai" + getpersistentainumber();
    incrementpersistentainumber();
}

// Namespace utility
// Params 3
// Checksum 0x5f692d82, Offset: 0xf313
// Size: 0x84
function function_bfb9c0e58baeab74( inner_radius, outer_radius, angle )
{
    if ( !isdefined( level.var_7364a1cf7e2bc44a ) )
    {
        level.var_7364a1cf7e2bc44a = spawnstruct();
    }
    
    level.var_7364a1cf7e2bc44a.inner_radius = inner_radius;
    level.var_7364a1cf7e2bc44a.outer_radius = outer_radius;
    level.var_7364a1cf7e2bc44a.angle = angle;
    function_23e24c832e0060e7( inner_radius, outer_radius, angle );
}

// Namespace utility
// Params 0
// Checksum 0xe8f0c995, Offset: 0xf39f
// Size: 0x34
function disable_pain()
{
    assert( isai( self ), "<dev string:xf07>" );
    self.a.disablepain = 1;
    self.allowpain = 0;
}

// Namespace utility
// Params 0
// Checksum 0x207b0e4c, Offset: 0xf3db
// Size: 0x2f
function function_ad87e0aca8abb939()
{
    setsaveddvar( @"hash_d2840794d9092eec", 0 );
    setsaveddvar( @"hash_382ea3ba7840ced3", 0 );
    setsaveddvar( @"hash_c59327ee5d4929c1", 0 );
}

// Namespace utility
// Params 1
// Checksum 0x6c1c7532, Offset: 0xf412
// Size: 0xfa
function requestgamerprofile( var_26cc343082007a73 )
{
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    frameswaited = 0;
    var_1732b50a7ff34a5f = 1000;
    
    while ( self.var_e8ea309192bf4aa0 && frameswaited < var_1732b50a7ff34a5f )
    {
        waitframe();
        frameswaited++;
    }
    
    if ( !self )
    {
        return;
    }
    
    if ( self.var_e8ea309192bf4aa0 == 1 )
    {
        self notify( self.requestinggamerprofile + "_received", undefined );
        waitframe();
    }
    
    if ( !self )
    {
        return;
    }
    
    self.var_e8ea309192bf4aa0 = 1;
    self sendrequestgamerprofilecmd( var_26cc343082007a73 );
    self.requestinggamerprofile = var_26cc343082007a73;
    ui::lui_registercallback( "gamerprofile_request", &function_7ce86f1f9971b24a );
    self waittill( var_26cc343082007a73 + "_received", value );
    
    if ( !self )
    {
        return;
    }
    
    self.var_e8ea309192bf4aa0 = 0;
    ui::function_c2505ff7b7fc55a4( "gamerprofile_request", &function_7ce86f1f9971b24a );
    self.requestinggamerprofile = undefined;
    return value;
}

// Namespace utility
// Params 0
// Checksum 0x3c4d3e5d, Offset: 0xf515
// Size: 0x51
function function_f670b438cfe8dfcc()
{
    if ( !isdefined( level.var_7364a1cf7e2bc44a ) )
    {
        return;
    }
    
    function_bfb9c0e58baeab74( level.var_7364a1cf7e2bc44a.inner_radius, level.var_7364a1cf7e2bc44a.outer_radius, level.var_7364a1cf7e2bc44a.angle );
}

// Namespace utility
// Params 1
// Checksum 0xda1d5a5c, Offset: 0xf56e
// Size: 0xaa
function string_is_single_digit_integer( str )
{
    if ( str.size > 1 )
    {
        return 0;
    }
    
    switch ( str )
    {
        case #"hash_31100bbc01bd3230":
        case #"hash_31100cbc01bd33c3":
        case #"hash_31100dbc01bd3556":
        case #"hash_31100ebc01bd36e9":
        case #"hash_31100fbc01bd387c":
        case #"hash_311010bc01bd3a0f":
        case #"hash_311011bc01bd3ba2":
        case #"hash_311012bc01bd3d35":
        case #"hash_311017bc01bd4514":
        case #"hash_311018bc01bd46a7":
            return 1;
        default:
            return 0;
    }
}

// Namespace utility
// Params 4
// Checksum 0xec74c2f8, Offset: 0xf620
// Size: 0xbd
function string_replace( string, find, replace, n = 1 )
{
    start_index = 0;
    
    for ( i = 0; i < n ; i++ )
    {
        if ( !issubstr( string, find ) )
        {
            return string;
        }
        
        for ( j = start_index; j < string.size ; j++ )
        {
            if ( getsubstr( string, j, j + find.size ) == find )
            {
                string = getsubstr( string, 0, j ) + replace + getsubstr( string, j + find.size );
                start_index = replace.size - find.size + j + 1;
                break;
            }
        }
    }
    
    return string;
}

// Namespace utility
// Params 1
// Checksum 0xd2daf209, Offset: 0xf6e6
// Size: 0x7e
function string_to_bool( the_string )
{
    retval = undefined;
    
    switch ( the_string )
    {
        case #"hash_31100fbc01bd387c":
        case #"hash_8328fb6e4f43ba45":
            retval = 1;
            break;
        case #"hash_311010bc01bd3a0f":
        case #"hash_a9152f56f0c74738":
            retval = 0;
            break;
        default:
            assertmsg( "<dev string:xf29>" );
            break;
    }
    
    return retval;
}

// Namespace utility
// Params 4
// Checksum 0xcdd7e159, Offset: 0xf76d
// Size: 0x35
function stop_exploder( num, players, radius, origin )
{
    exploder::stop_exploder_proc( num, players, 0, radius, origin );
}

// Namespace utility
// Params 1
// Checksum 0x1f3bcdd7, Offset: 0xf7aa
// Size: 0x17
function stop_loop_sound_on_entity( alias )
{
    self notify( "stop sound" + alias );
}

// Namespace utility
// Params 1
// Checksum 0x4a0755c9, Offset: 0xf7c9
// Size: 0x7e
function function_e4e418bde2160c35( str )
{
    if ( str.size > 1 && getsubstr( str, 0, 1 ) == "-" )
    {
        str = getsubstr( str, 1, str.size );
    }
    
    isint = 1;
    
    for ( var_9b09b44583feb12c = 0; var_9b09b44583feb12c < str.size ; var_9b09b44583feb12c++ )
    {
        isint &= string_is_single_digit_integer( getsubstr( str, var_9b09b44583feb12c, var_9b09b44583feb12c + 1 ) );
        
        if ( !isint )
        {
            break;
        }
    }
    
    return isint;
}

/#

    // Namespace utility
    // Params 2, eflags: 0x44 variadic
    // Checksum 0x5915763b, Offset: 0xf850
    // Size: 0xd7, Type: dev
    function private function_8ae6ad9600816017( ... )
    {
        assert( varargcount % 2 == 0 );
        assert( varargcount == vararg.size );
        i = 0;
        
        while ( i < varargcount )
        {
            if ( !isent( vararg[ i ] ) && !isstruct( vararg[ i ] ) && !function_9d35bda59d2a81bd( vararg[ i ] ) )
            {
                assertmsg( "<dev string:xf53>" + i + 1 + "<dev string:xf5b>" + i / 2 + 1 + "<dev string:xf61>" );
            }
            
            if ( !isstring( vararg[ i + 1 ] ) )
            {
                assertmsg( "<dev string:xf53>" + i + 2 + "<dev string:xf90>" + ( i + 1 ) / 2 + "<dev string:xf99>" );
            }
            
            i += 2;
        }
    }

#/

// Namespace utility
// Params 1
// Checksum 0x2f04a3c7, Offset: 0xf92f
// Size: 0x31
function function_ad3f0d564c1791e9( v )
{
    return "(" + v[ 0 ] + ", " + v[ 1 ] + ", " + v[ 2 ] + ")";
}

// Namespace utility
// Params 1
// Checksum 0xab65dae4, Offset: 0xf969
// Size: 0xb9
function function_8586225841e38b51( var )
{
    str = "";
    
    foreach ( value in var )
    {
        str += ( str ? ", " : "[ " ) + string( value );
    }
    
    str += str ? " ]" : "[ ]";
    return str;
}

// Namespace utility
// Params 1
// Checksum 0xc241b33b, Offset: 0xfa2b
// Size: 0x82
function set_battlechatter( state )
{
    if ( !isalive( self ) )
    {
        return;
    }
    
    if ( isdefined( self.script_bcdialog ) && !self.script_bcdialog )
    {
        state = 0;
    }
    
    if ( !isdefined( self.battlechatterallowed ) && !state )
    {
        return;
    }
    
    if ( isbattlechatterenabled() )
    {
        if ( isscriptedai( self ) )
        {
            self setbattlechatterflag( "disabled", !state );
        }
        
        return;
    }
    
    if ( !isdefined( level.battlechatter ) )
    {
        return;
    }
    
    self.battlechatterallowed = state;
}

// Namespace utility
// Params 2
// Checksum 0x1f606699, Offset: 0xfab5
// Size: 0x10c
function register_area_swap( swapname, swapstates )
{
    if ( !isstring( swapname ) || !isarray( swapstates ) || swapstates.size < 2 )
    {
        assertmsg( "<dev string:xfc8>" );
        return;
    }
    
    foreach ( state in swapstates )
    {
        if ( !isstring( state ) )
        {
            assertmsg( "<dev string:xff4>" );
            return;
        }
    }
    
    if ( !hasareaswap( swapname ) )
    {
        assertmsg( level.mapname + "<dev string:x102e>" + swapname );
        return;
    }
    
    if ( !isdefined( level.areaswaps ) )
    {
        level.areaswaps = [];
    }
    
    level.areaswaps[ swapname ] = swapstates;
}

/#

    // Namespace utility
    // Params 0
    // Checksum 0xd9a062f4, Offset: 0xfbc9
    // Size: 0x169, Type: dev
    function function_52e26ab708ddc270()
    {
        if ( !isdefined( level.areaswaps ) )
        {
            return;
        }
        
        foreach ( swapname, swapstates in level.areaswaps )
        {
            devgui::function_9082edeb5db93280( "<dev string:x1056>" + toupper( swapname ) + "<dev string:x1061>" );
            
            foreach ( state in swapstates )
            {
                devgui::add_devgui_command( "<dev string:x1063>" + toupper( state ), "<dev string:x1064>" + swapname + "<dev string:x107b>" + state + "<dev string:x107d>" );
            }
            
            devgui::function_77df7fe7dd273e10();
        }
        
        devgui::function_9082edeb5db93280( "<dev string:x1056>" );
        devgui::add_devgui_command( "<dev string:x1080>", "<dev string:x1095>" );
        devgui::function_77df7fe7dd273e10();
        level thread function_ccb30a25d5b84d67();
        level thread function_da4b85941018251f();
    }

    // Namespace utility
    // Params 0, eflags: 0x4
    // Checksum 0xa3fd8213, Offset: 0xfd3a
    // Size: 0xad, Type: dev
    function private function_ccb30a25d5b84d67()
    {
        setdvar( @"scr_area_swap", "<dev string:x1063>" );
        
        while ( true )
        {
            while ( getdvar( @"scr_area_swap", "<dev string:x1063>" ) == "<dev string:x1063>" )
            {
                wait 1;
            }
            
            [ swapname, swapstate ] = strtok( getdvar( @"scr_area_swap", "<dev string:x1063>" ), "<dev string:x107b>" );
            iprintlnbold( "<dev string:x10c0>" );
            set_area_swap_state( swapname, swapstate, 10 );
            setdvar( @"scr_area_swap", "<dev string:x1063>" );
        }
    }

    // Namespace utility
    // Params 0, eflags: 0x4
    // Checksum 0xb70cd204, Offset: 0xfdef
    // Size: 0xd0, Type: dev
    function private function_da4b85941018251f()
    {
        while ( true )
        {
            waitframe();
            
            if ( getdvarint( @"hash_a32934ef2bee6d49", 0 ) )
            {
                setdvar( @"hash_a32934ef2bee6d49", 0 );
                
                if ( isdefined( level.var_d7f3f21a8ec3a774 ) )
                {
                    foreach ( object in level.var_d7f3f21a8ec3a774 )
                    {
                        if ( isdefined( object ) && isdefined( object.var_145494368702fcf2 ) )
                        {
                            object [[ object.var_145494368702fcf2 ]]();
                        }
                    }
                }
            }
        }
    }

#/

// Namespace utility
// Params 3, eflags: 0x40 variadic
// Checksum 0xce67972b, Offset: 0xfec7
// Size: 0x43
function self_func( func, ... )
{
    if ( !isdefined( level.func[ func ] ) )
    {
        return;
    }
    
    return self builtin [[ level.func[ func ] ]]( flat_args( vararg, varargcount ) );
}

// Namespace utility
// Params 2
// Checksum 0x6019351d, Offset: 0xff13
// Size: 0x29
function send_notify( msg, optional_param )
{
    if ( isdefined( optional_param ) )
    {
        self notify( msg, optional_param );
        return;
    }
    
    self notify( msg );
}

// Namespace utility
// Params 0
// Checksum 0xc23628f5, Offset: 0xff44
// Size: 0x3a
function set_ai_number()
{
    if ( !isdefined( level.ai_number ) )
    {
        level.ai_number = 0;
    }
    
    self.unique_id = "ai" + level.ai_number;
    level.ai_number++;
}

// Namespace utility
// Params 3
// Checksum 0xeb5983bd, Offset: 0xff86
// Size: 0x1a3
function set_area_swap_state( swapname, swapstate, hintduration )
{
    if ( !isstring( swapname ) || !isstring( swapstate ) || !isnumber( hintduration ) )
    {
        assertmsg( "<dev string:x10d6>" );
        return;
    }
    
    if ( !isdefined( level.areaswaps[ swapname ] ) || !arraycontains( level.areaswaps[ swapname ], swapstate ) )
    {
        assertmsg( "<dev string:x1103>" );
        return;
    }
    
    startingstate = get_area_swap_state( swapname );
    
    if ( startingstate == swapstate )
    {
        assertmsg( "<dev string:x1138>" );
        return;
    }
    
    if ( isdefined( level.areaswaphints ) && arraycontains( level.areaswaphints, swapname ) )
    {
        assertmsg( "<dev string:x116f>" );
        return;
    }
    
    if ( !isdefined( level.areaswaphints ) )
    {
        level.areaswaphints = [];
    }
    
    level.areaswaphints[ level.areaswaphints.size ] = swapname;
    script_func( "area_swap_begin", swapname, swapstate, hintduration );
    setareaswaphint( swapname, swapstate );
    wait hintduration;
    setareaswapstate( swapname, swapstate );
    level.areaswaphints = arrayremove( level.areaswaphints, swapname );
    
    if ( level.areaswaphints.size == 0 )
    {
        level.areaswaphints = undefined;
    }
    
    level.areaswaps[ swapname ] = arrayremove( level.areaswaps[ swapname ], swapstate );
    arrayinsert( level.areaswaps[ swapname ], swapstate, 0 );
    clean_area_swap_state( swapname, startingstate );
    script_func( "area_swap_complete", swapname, swapstate );
}

// Namespace utility
// Params 2
// Checksum 0xbfb900f1, Offset: 0x10131
// Size: 0x12f
function clean_area_swap_state( swapname, state )
{
    entities = function_cf47c04b810cd4f7( swapname, state );
    scriptables = function_b33c28f4c194745f( swapname, state );
    
    if ( isdefined( entities ) )
    {
        foreach ( entity in entities )
        {
            entity thread script_func( "delete_entity_in_swap" );
        }
    }
    
    if ( isdefined( scriptables ) )
    {
        foreach ( scriptable in scriptables )
        {
            scriptable thread script_func( "delete_scriptable_in_swap" );
        }
    }
}

// Namespace utility
// Params 1
// Checksum 0xb3a8f2d4, Offset: 0x10268
// Size: 0xc6
function get_alive_players( include_last_stand = 1 )
{
    a_players = level.players;
    a_alive_players = [];
    
    foreach ( player in a_players )
    {
        if ( isalive( player ) )
        {
            if ( !include_last_stand && player.inlaststand )
            {
                continue;
            }
            
            a_alive_players[ a_alive_players.size ] = player;
        }
    }
    
    return a_alive_players;
}

// Namespace utility
// Params 0
// Checksum 0xfe562898, Offset: 0x10337
// Size: 0x100
function function_67292ed50d12c006()
{
    assert( is_partition(), "<dev string:x11ba>" );
    all_arrays = [];
    
    foreach ( x_array in self.array )
    {
        foreach ( y_array in x_array )
        {
            all_arrays[ all_arrays.size ] = y_array;
        }
    }
    
    return all_arrays;
}

// Namespace utility
// Params 1
// Checksum 0xa88d549b, Offset: 0x10440
// Size: 0x51
function get_area_swap_state( swapname )
{
    if ( !isstring( swapname ) )
    {
        assertmsg( "<dev string:x1214>" );
        return;
    }
    
    if ( !isdefined( level.areaswaps[ swapname ] ) )
    {
        assertmsg( "<dev string:x1241>" );
        return;
    }
    
    return level.areaswaps[ swapname ][ 0 ];
}

// Namespace utility
// Params 3
// Checksum 0x44f8ea83, Offset: 0x1049a
// Size: 0x61
function is_origin_in_area_swap( origin, swapname, swapstate )
{
    scriptorigin = spawn( "script_origin", origin );
    scriptorigin.targetname = "is_origin_in_area_swap";
    inareaswap = scriptorigin isinareaswap( swapname, swapstate );
    scriptorigin delete();
    return inareaswap;
}

// Namespace utility
// Params 1
// Checksum 0x5ea9496f, Offset: 0x10504
// Size: 0x41
function is_area_swap_in_progress( swapname )
{
    if ( !isstring( swapname ) )
    {
        assertmsg( "<dev string:x1276>" );
        return;
    }
    
    return isdefined( level.areaswaphints ) && arraycontains( level.areaswaphints, swapname );
}

// Namespace utility
// Params 0
// Checksum 0x44c7ea5b, Offset: 0x1054e
// Size: 0xe, Type: bool
function function_860415b49e2ba9d9()
{
    return level.areaswaphints.size > 0;
}

// Namespace utility
// Params 1
// Checksum 0x4a10f9d7, Offset: 0x10565
// Size: 0x62
function function_8a74027bdea84771( callback )
{
    self.var_145494368702fcf2 = callback;
    
    /#
        if ( !isdefined( level.var_d7f3f21a8ec3a774 ) )
        {
            level.var_d7f3f21a8ec3a774 = [];
        }
        
        level.var_d7f3f21a8ec3a774 = arraycombineunique( level.var_d7f3f21a8ec3a774, [ self ] );
        level.var_d7f3f21a8ec3a774 = function_5713d46873b29625( level.var_d7f3f21a8ec3a774 );
    #/
}

// Namespace utility
// Params 1
// Checksum 0x62cc200e, Offset: 0x105cf
// Size: 0x5b
function function_d8f5310928e6277f( var_eaf49754fe570d74 = 1 )
{
    while ( true )
    {
        x = randomfloatrange( -1, 1 );
        y = randomfloatrange( -1, 1 );
        
        if ( x * x + y * y < 1 )
        {
            return ( ( x, y, 0 ) * var_eaf49754fe570d74 );
        }
    }
}

// Namespace utility
// Params 1
// Checksum 0xc73c8083, Offset: 0x10632
// Size: 0x15
function unlock( msg )
{
    thread unlock_thread( msg );
}

// Namespace utility
// Params 1
// Checksum 0x8492b545, Offset: 0x1064f
// Size: 0x7f
function unlock_thread( msg )
{
    wait 0.05;
    assert( isdefined( level.lock ) );
    assert( isdefined( level.lock[ msg ] ) );
    lock = level.lock[ msg ];
    lock.count--;
    assert( lock.count >= 0 );
    lock notify( #"unlocked" );
}

// Namespace utility
// Params 1
// Checksum 0x3650eaf8, Offset: 0x106d6
// Size: 0x1b
function unlock_wait( msg )
{
    thread unlock_thread( msg );
    wait 0.05;
}

// Namespace utility
// Params 0
// Checksum 0x9b98241d, Offset: 0x106f9
// Size: 0x26
function function_6dd166af865685e8()
{
    self.var_145494368702fcf2 = undefined;
    
    /#
        level.var_d7f3f21a8ec3a774 = arrayremove( level.var_d7f3f21a8ec3a774, self );
    #/
}

// Namespace utility
// Params 0
// Checksum 0x736cd6d1, Offset: 0x10727
// Size: 0x173
function update_trigger_based_on_flags()
{
    var_67fb1eecf93c0f72 = 1;
    
    if ( isdefined( self.script_flag_true ) )
    {
        tokens = create_flags_and_return_tokens( self.script_flag_true );
        
        foreach ( token in tokens )
        {
            if ( !flag( token ) )
            {
                var_67fb1eecf93c0f72 = 0;
                break;
            }
        }
    }
    
    var_d69544f2191d2665 = 1;
    
    if ( isdefined( self.script_flag_false ) )
    {
        tokens = create_flags_and_return_tokens( self.script_flag_false );
        
        foreach ( token in tokens )
        {
            if ( flag( token ) )
            {
                var_d69544f2191d2665 = 0;
                break;
            }
        }
    }
    
    value = var_67fb1eecf93c0f72 && var_d69544f2191d2665 ? 1 : 0;
    [[ level.trigger_func[ value ] ]]();
}

// Namespace utility
// Params 3
// Checksum 0x3622efe2, Offset: 0x108a2
// Size: 0xe5
function use_turret( turret, pose, tag = "tag_gunner" )
{
    /#
        owner = turret getturretowner();
        assert( !isdefined( owner ), "<dev string:x12a8>" );
    #/
    
    requestedturret = asm_bb::bb_getrequestedturret();
    
    if ( requestedturret != turret )
    {
        asm_bb::bb_requestturret( turret );
    }
    
    if ( !isdefined( pose ) && isdefined( requestedturret.vehicle ) )
    {
        pose = "stand";
    }
    
    asm_bb::bb_requestturretpose( pose );
    origin = turret gettagorigin( tag );
    angles = turret gettagangles( tag );
    
    if ( self islinked() )
    {
        self unlink();
    }
    
    self forceteleport( origin, angles );
    self linktoblendtotag( turret, tag, 0 );
    self.using_vehicle_turret = 1;
}

// Namespace utility
// Params 4
// Checksum 0x6484e440, Offset: 0x1098f
// Size: 0x166
function use_vehicle_turret( vehicle, index, pose = "stand", tag )
{
    assert( vehicle vehicle::is_common_vehicle() );
    data = vehicle::get_data( vehicle vehicle::get_ref() );
    vehicle_seat = self.vehicle_position;
    [ requestedvehicle, var_f3f0849be35ec1ec ] = asm_bb::function_988e0cf7bedac7eb();
    
    if ( !isdefined( requestedvehicle ) || !isdefined( var_f3f0849be35ec1ec ) )
    {
        asm_bb::function_d97733fe1476f19e( vehicle, index );
        [ requestedvehicle, var_f3f0849be35ec1ec ] = asm_bb::function_988e0cf7bedac7eb();
    }
    
    self usevehicleturret( requestedvehicle, index );
    
    if ( !isdefined( tag ) )
    {
        tag = data.aiseats[ vehicle_seat ].sittag;
    }
    
    asm_bb::bb_requestturretpose( pose );
    origin = vehicle gettagorigin( tag );
    angles = vehicle gettagangles( tag );
    
    if ( self islinked() )
    {
        self unlink();
    }
    
    self forceteleport( origin, angles );
    self linktoblendtotag( vehicle, tag, 0 );
    self.using_vehicle_turret = 1;
    self.vehicle_turret_index = var_f3f0849be35ec1ec;
    self.vehicle_turret_tag = tag;
}

// Namespace utility
// Params 1
// Checksum 0x253ab35, Offset: 0x10afd
// Size: 0xac
function alphabetize( array )
{
    if ( array.size <= 1 )
    {
        return array;
    }
    
    array = arraycopy( array );
    
    for ( asize = array.size - 1; asize >= 1 ; asize-- )
    {
        largest = array[ asize ];
        largestindex = asize;
        
        for ( i = 0; i < asize ; i++ )
        {
            string1 = array[ i ];
            
            if ( stricmp( string1, largest ) > 0 )
            {
                largest = string1;
                largestindex = i;
            }
        }
        
        if ( largestindex != asize )
        {
            array[ largestindex ] = array[ asize ];
            array[ asize ] = largest;
        }
    }
    
    return array;
}

// Namespace utility
// Params 2, eflags: 0x40 variadic
// Checksum 0xe1f564f5, Offset: 0x10bb2
// Size: 0x16, Type: bool
function always_false( ... )
{
    return false;
}

// Namespace utility
// Params 2, eflags: 0x40 variadic
// Checksum 0x7904dbc8, Offset: 0x10bd1
// Size: 0x17, Type: bool
function always_true( ... )
{
    return true;
}

// Namespace utility
// Params 4
// Checksum 0xb1203ff3, Offset: 0x10bf1
// Size: 0x168, Type: bool
function function_30510fa2d89a52aa( a_points, tolerance, min_radius = 0, max_radius = 99999 )
{
    centroid = averagepoint( a_points );
    all_radii = [];
    
    foreach ( point in a_points )
    {
        all_radii[ all_radii.size ] = distance( point, centroid );
    }
    
    avg_radius = array_average( all_radii );
    
    if ( avg_radius < min_radius || avg_radius > max_radius )
    {
        return false;
    }
    
    foreach ( radius in all_radii )
    {
        if ( abs( radius - avg_radius ) > tolerance )
        {
            return false;
        }
    }
    
    return true;
}

// Namespace utility
// Params 2
// Checksum 0xebd8ff17, Offset: 0x10d62
// Size: 0xb1
function array_any_wait( array, message )
{
    notifystruct = spawnstruct();
    
    foreach ( element in array )
    {
        thread array_any_wait_proc( notifystruct, element, message );
    }
    
    notifystruct waittill( #"array_wait_proc", result );
    return result;
}

// Namespace utility
// Params 3
// Checksum 0x4576480c, Offset: 0x10e1c
// Size: 0x47
function array_any_wait_proc( notifystruct, element, message )
{
    result = element waittill_any_return_no_endon_death( message, "death" );
    notifystruct notify( #"array_wait_proc", result );
}

// Namespace utility
// Params 2
// Checksum 0xa76e14d1, Offset: 0x10e6b
// Size: 0xa9
function array_any_wait_return( array, message )
{
    notifystruct = spawnstruct();
    
    foreach ( element in array )
    {
        thread array_any_wait_return_proc( notifystruct, element, message );
    }
    
    notifystruct waittill( #"array_wait_proc", element );
    return element;
}

// Namespace utility
// Params 3
// Checksum 0xfd7f1127, Offset: 0x10f1d
// Size: 0x47
function array_any_wait_return_proc( notifystruct, element, message )
{
    result = element waittill_any_return( message, "death" );
    notifystruct notify( #"array_wait_proc", element );
}

// Namespace utility
// Params 3
// Checksum 0x6723a1e2, Offset: 0x10f6c
// Size: 0xc4
function array_any_wait_timeout( array, message, timeout )
{
    notifystruct = spawnstruct();
    thread array_any_wait_timeout_proc( notifystruct, timeout );
    
    foreach ( element in array )
    {
        thread array_any_wait_proc( notifystruct, element, message );
    }
    
    notifystruct waittill( #"array_wait_proc", result );
    return result;
}

// Namespace utility
// Params 2
// Checksum 0x5feabfb4, Offset: 0x11039
// Size: 0x37
function array_any_wait_timeout_proc( notifystruct, timeout )
{
    notifystruct endon( #"array_wait_proc" );
    wait timeout;
    notifystruct notify( #"array_wait_proc", "timeout" );
}

// Namespace utility
// Params 1
// Checksum 0x6b63adf9, Offset: 0x11078
// Size: 0x18
function array_average( array )
{
    return array_sum( array ) / array.size;
}

// Namespace utility
// Params 4, eflags: 0x40 variadic
// Checksum 0xa35a6868, Offset: 0x11099
// Size: 0x9a
function array_call( entities, process, ... )
{
    foreach ( ent in entities )
    {
        ent builtin [[ process ]]( flat_args( vararg, varargcount ) );
    }
}

// Namespace utility
// Params 4, eflags: 0x40 variadic
// Checksum 0xf7e66dec, Offset: 0x1113b
// Size: 0x9a
function array_childthread( entities, process, ... )
{
    foreach ( ent in entities )
    {
        ent childthread [[ process ]]( flat_args( vararg, varargcount ) );
    }
}

// Namespace utility
// Params 1
// Checksum 0xdd84e385, Offset: 0x111dd
// Size: 0x8b
function array_combine_multiple( arr2d )
{
    arr1d = [];
    
    foreach ( arr in arr2d )
    {
        arr1d = arraycombine( arr1d, arr );
    }
    
    return arr1d;
}

// Namespace utility
// Params 1
// Checksum 0x4d2264ad, Offset: 0x11271
// Size: 0x82
function array_delete( array )
{
    foreach ( ent in array )
    {
        if ( isdefined( ent ) )
        {
            ent delete();
        }
    }
}

// Namespace utility
// Params 2
// Checksum 0x41bd0cc8, Offset: 0x112fb
// Size: 0xd9
function array_ent_flag_wait( entities, flag )
{
    notifystruct = spawnstruct();
    
    foreach ( entity in entities )
    {
        if ( entity ent_flag( flag ) )
        {
            entities = arrayremove( entities, entity );
        }
    }
    
    array_thread( entities, &array_ent_flag_wait_proc, notifystruct, flag );
    
    for ( i = 0; i < entities.size ; i++ )
    {
        notifystruct waittill( #"notify" );
    }
}

// Namespace utility
// Params 2
// Checksum 0x237290e0, Offset: 0x113dc
// Size: 0x2b
function array_ent_flag_wait_proc( notifystruct, flag )
{
    ent_flag_wait( flag );
    notifystruct notify( #"notify" );
}

// Namespace utility
// Params 2
// Checksum 0xf7de5a5, Offset: 0x1140f
// Size: 0xc2
function function_5fdf0884f9b2d470( array, var_5de849e01abd2013 )
{
    assert( isarray( array ), "<dev string:x12cf>" );
    assert( isfunction( var_5de849e01abd2013 ), "<dev string:x12f9>" );
    result = [];
    
    foreach ( test in array )
    {
        if ( self [[ var_5de849e01abd2013 ]]( test ) )
        {
            result[ result.size ] = test;
        }
    }
    
    return result;
}

// Namespace utility
// Params 1
// Checksum 0x77b30668, Offset: 0x114da
// Size: 0x14
function array_get_first_item( array )
{
    return array[ getfirstarraykey( array ) ];
}

// Namespace utility
// Params 1
// Checksum 0x1248a00a, Offset: 0x114f7
// Size: 0x14
function function_f1933af772476229( array )
{
    return array[ getlastarraykey( array ) ];
}

// Namespace utility
// Params 3
// Checksum 0x126baff9, Offset: 0x11514
// Size: 0x92
function array_insert_array( array1, array2, index )
{
    assert( index >= 0, "<dev string:x1327>" );
    
    for ( i = array1.size + array2.size - 1; true ; i-- )
    {
        if ( i < index + array2.size )
        {
            for ( j = array2.size - 1; j >= 0 ; j-- )
            {
                array1[ i ] = array2[ j ];
                i--;
            }
            
            return array1;
        }
        
        array1[ i ] = array1[ i - array2.size ];
    }
}

// Namespace utility
// Params 2
// Checksum 0x9bf4c9b1, Offset: 0x115ae
// Size: 0x8d, Type: bool
function array_is_touching( a_ents, e_volume )
{
    foreach ( e_ent in a_ents )
    {
        if ( !e_ent istouching( e_volume ) )
        {
            return false;
        }
    }
    
    return true;
}

// Namespace utility
// Params 6
// Checksum 0x21e6cc93, Offset: 0x11644
// Size: 0x21b
function function_a38b3ca4783bca3b( array, var_88397eced8b3629c, var_8e0831c9133f47d9, var_297c33ed3c94cefd, iterationtimeinseconds = 5, shouldthread = 0 )
{
    assert( isarray( array ), "<dev string:x12cf>" );
    assert( isfunction( var_88397eced8b3629c ), "<dev string:x12f9>" );
    var_bf7b7ad6fd69e36a = 0;
    
    if ( isfunction( var_8e0831c9133f47d9 ) )
    {
        var_bf7b7ad6fd69e36a = 1;
    }
    
    var_49d4677a21b1ab3b = array.size;
    var_f1b01d788e6d3db4 = max( iterationtimeinseconds / level.framedurationseconds, 1 );
    var_2397229ee106724a = max( var_49d4677a21b1ab3b / var_f1b01d788e6d3db4, 1 );
    var_2397229ee106724a = ceil( var_2397229ee106724a );
    var_856c40ba487440b = 0;
    
    if ( shouldthread )
    {
        foreach ( arraykey, arrayobject in array )
        {
            var_c9255c447cc081c0 = !var_bf7b7ad6fd69e36a || var_bf7b7ad6fd69e36a && self [[ var_8e0831c9133f47d9 ]]( arrayobject );
            
            if ( var_c9255c447cc081c0 )
            {
                self thread [[ var_88397eced8b3629c ]]( arrayobject, arraykey );
            }
            
            var_856c40ba487440b++;
            
            if ( var_856c40ba487440b >= var_2397229ee106724a )
            {
                waitframe();
                var_856c40ba487440b = 0;
            }
        }
    }
    else
    {
        foreach ( arraykey, arrayobject in array )
        {
            var_c9255c447cc081c0 = !var_bf7b7ad6fd69e36a || var_bf7b7ad6fd69e36a && self [[ var_8e0831c9133f47d9 ]]( arrayobject );
            
            if ( var_c9255c447cc081c0 )
            {
                self [[ var_88397eced8b3629c ]]( arrayobject, arraykey );
            }
            
            var_856c40ba487440b++;
            
            if ( var_856c40ba487440b >= var_2397229ee106724a )
            {
                waitframe();
                var_856c40ba487440b = 0;
            }
        }
    }
    
    if ( isfunction( var_297c33ed3c94cefd ) )
    {
        self [[ var_297c33ed3c94cefd ]]();
    }
}

// Namespace utility
// Params 4, eflags: 0x40 variadic
// Checksum 0xce39ca25, Offset: 0x11867
// Size: 0x9a
function array_levelthread( array, process, ... )
{
    foreach ( ent in array )
    {
        thread [[ process ]]( ent, flat_args( vararg, varargcount ) );
    }
}

// Namespace utility
// Params 2
// Checksum 0x2b84bd38, Offset: 0x11909
// Size: 0xbe
function array_map( array, mapfunction )
{
    assert( isarray( array ), "<dev string:x12cf>" );
    assert( isfunction( mapfunction ), "<dev string:x12f9>" );
    newarray = [];
    
    foreach ( arrayobject in array )
    {
        newarray[ newarray.size ] = self [[ mapfunction ]]( arrayobject );
    }
    
    return newarray;
}

// Namespace utility
// Params 1
// Checksum 0xe1bacf80, Offset: 0x119d0
// Size: 0x98
function array_max( array )
{
    maximum = undefined;
    
    foreach ( item in array )
    {
        if ( isdefined( maximum ) )
        {
            maximum = max( maximum, item );
            continue;
        }
        
        maximum = item;
    }
    
    return maximum;
}

// Namespace utility
// Params 1
// Checksum 0xaa4a96c5, Offset: 0x11a71
// Size: 0x31
function array_random( array )
{
    size = array.size;
    
    if ( size > 0 )
    {
        return array[ getarraykey( array, randomint( size ) ) ];
    }
}

// Namespace utility
// Params 2
// Checksum 0xf5291790, Offset: 0x11aaa
// Size: 0xd5
function function_879489791c3d805( array, excluded_items )
{
    if ( !isarray( array ) || array.size == 0 )
    {
        return;
    }
    
    if ( excluded_items.size == 0 )
    {
        return array_random( array );
    }
    
    keys = arrayrandomize( getarraykeys( array ) );
    
    foreach ( key in keys )
    {
        element = array[ key ];
        
        if ( arraycontains( excluded_items, element ) )
        {
            continue;
        }
        
        return element;
    }
}

// Namespace utility
// Params 2
// Checksum 0x18c67a6e, Offset: 0x11b88
// Size: 0x145
function array_random_slice( array, slicesize )
{
    assert( array.size > slicesize, "<dev string:x134f>" );
    randomindices = [];
    returnarr = [];
    counter = 0;
    totalchecks = 0;
    maxchecks = slicesize * 10;
    
    while ( counter < slicesize )
    {
        rndidx = randomint( array.size );
        totalchecks++;
        
        if ( totalchecks == maxchecks )
        {
            break;
        }
        
        if ( arraycontains( randomindices, rndidx ) )
        {
            continue;
        }
        
        randomindices[ randomindices.size ] = rndidx;
        counter++;
    }
    
    if ( randomindices.size < slicesize )
    {
        return;
    }
    
    currindex = 0;
    
    foreach ( object in array )
    {
        if ( returnarr.size == slicesize )
        {
            break;
        }
        
        if ( arraycontains( randomindices, currindex ) )
        {
            returnarr[ returnarr.size ] = object;
        }
        
        currindex++;
    }
    
    return returnarr;
}

// Namespace utility
// Params 5
// Checksum 0x3abf2c0d, Offset: 0x11cd6
// Size: 0xdb
function function_40662075b6c8798c( array, seed, a, c, m )
{
    if ( !( isdefined( array ) && isdefined( seed ) ) )
    {
        assertmsg( "<dev string:x138c>" );
        return [];
    }
    
    array = arraycopy( array );
    x = seed;
    
    if ( !isdefined( a ) )
    {
        a = 29;
    }
    
    if ( !isdefined( c ) )
    {
        c = 19;
    }
    
    if ( !isdefined( m ) )
    {
        m = int( max( array.size, 41 ) );
    }
    
    for ( i = 0; i < array.size ; i++ )
    {
        x = ( x * a + c ) % m;
        randval = x % array.size;
        tmp = array[ i ];
        array[ i ] = array[ randval ];
        array[ randval ] = tmp;
    }
    
    return array;
}

// Namespace utility
// Params 3
// Checksum 0x328a2ea6, Offset: 0x11dba
// Size: 0xc2
function function_6ed29b1b786df49a( array, condition, keepkeys )
{
    if ( !array || !isdefined( condition ) )
    {
        return;
    }
    
    newarray = [];
    
    foreach ( key, val in array )
    {
        if ( ![[ condition ]]( key, val ) )
        {
            if ( keepkeys )
            {
                newarray[ key ] = val;
                continue;
            }
            
            newarray[ newarray.size ] = val;
        }
    }
    
    return newarray;
}

// Namespace utility
// Params 2
// Checksum 0x5773d24, Offset: 0x11e85
// Size: 0x4e
function function_d751969553a4bddd( array, remover )
{
    new_array = arraycopy( array );
    key = function_f02c63b99c9614c9( new_array, remover, 1 );
    
    if ( isdefined( key ) )
    {
        new_array[ key ] = undefined;
    }
    
    function_cdc669dbc8ea2101( new_array );
    return new_array;
}

// Namespace utility
// Params 2
// Checksum 0x6e1d0e5a, Offset: 0x11edc
// Size: 0xd7
function array_removedead_or_dying( array, var_d617f2628e8fa9d3 = 1 )
{
    newarray = [];
    
    foreach ( member in array )
    {
        if ( !isalive( member ) )
        {
            continue;
        }
        
        if ( isai( member ) && var_d617f2628e8fa9d3 && ( member doinglongdeath() || member ent_flag( "death_engaged" ) ) )
        {
            continue;
        }
        
        newarray[ newarray.size ] = member;
    }
    
    return newarray;
}

// Namespace utility
// Params 2
// Checksum 0x59cb40dc, Offset: 0x11fbc
// Size: 0x12f
function function_8391781ea0784541( array, keepkeys )
{
    newarray = [];
    
    if ( keepkeys )
    {
        foreach ( i, member in array )
        {
            if ( !isalive( member ) || member.destroyed )
            {
                continue;
            }
            
            newarray[ i ] = member;
        }
    }
    else
    {
        foreach ( i, member in array )
        {
            if ( !isalive( member ) || member.destroyed )
            {
                continue;
            }
            
            newarray[ newarray.size ] = member;
        }
    }
    
    return newarray;
}

// Namespace utility
// Params 2
// Checksum 0x273ab31b, Offset: 0x120f4
// Size: 0x129
function function_6ecd4587ed2bf80c( array, keepkeys )
{
    newarray = [];
    
    if ( keepkeys )
    {
        foreach ( i, member in array )
        {
            if ( !isdefined( member ) || member.destroyed )
            {
                continue;
            }
            
            newarray[ i ] = member;
        }
    }
    else
    {
        foreach ( i, member in array )
        {
            if ( !isdefined( member ) || member.destroyed )
            {
                continue;
            }
            
            newarray[ newarray.size ] = member;
        }
    }
    
    return newarray;
}

// Namespace utility
// Params 3
// Checksum 0xdf2ddeb4, Offset: 0x12226
// Size: 0x9b
function array_slice( array, startindex, endindex )
{
    assert( isarray( array ) );
    assert( isdefined( startindex ) );
    
    if ( array.size <= 0 )
    {
        return [];
    }
    
    if ( !isdefined( endindex ) || endindex > array.size )
    {
        endindex = array.size;
    }
    
    if ( startindex == 0 && endindex == array.size )
    {
        return array;
    }
    
    slicedarray = [];
    
    for ( index = startindex; index < endindex ; index++ )
    {
        slicedarray[ slicedarray.size ] = array[ index ];
    }
    
    return slicedarray;
}

// Namespace utility
// Params 2
// Checksum 0xbcfc8258, Offset: 0x122ca
// Size: 0x68
function array_slice_random( array, var_129d621c51f58393 )
{
    array = arraycopy( array );
    
    for ( i = 0; i < var_129d621c51f58393 ; i++ )
    {
        if ( array.size > 0 )
        {
            indextoremove = randomint( array.size );
            array[ indextoremove ] = array[ array.size - 1 ];
            array[ array.size - 1 ] = undefined;
        }
    }
    
    return array;
}

// Namespace utility
// Params 1
// Checksum 0x8cb8d5be, Offset: 0x1233b
// Size: 0xcd
function array_sort_by_script_index( array )
{
    sortedarray = [];
    
    for ( index = 0; index < array.size ; index++ )
    {
        foreach ( item in array )
        {
            if ( item.script_index == index )
            {
                sortedarray[ sortedarray.size ] = item;
            }
        }
    }
    
    remainingitems = arrayremove( array, sortedarray );
    sortedarray = arraycombine( sortedarray, remainingitems );
    return sortedarray;
}

// Namespace utility
// Params 1
// Checksum 0xbe45dd0b, Offset: 0x12411
// Size: 0x88
function array_sum( array )
{
    sum = 0;
    
    foreach ( item in array )
    {
        sum += item;
    }
    
    return sum;
}

// Namespace utility
// Params 4, eflags: 0x40 variadic
// Checksum 0x4d745726, Offset: 0x124a2
// Size: 0x9a
function array_thread( entities, process, ... )
{
    foreach ( ent in entities )
    {
        ent thread [[ process ]]( flat_args( vararg, varargcount ) );
    }
}

// Namespace utility
// Params 5, eflags: 0x40 variadic
// Checksum 0xc79d7573, Offset: 0x12544
// Size: 0x3f
function array_thread_amortized( entities, process, var_b01eab2eb5e7d0ec, ... )
{
    thread array_thread_amortized_proc( entities, process, var_b01eab2eb5e7d0ec, flat_args( vararg, varargcount ) );
}

// Namespace utility
// Params 5, eflags: 0x40 variadic
// Checksum 0x6feb59c5, Offset: 0x1258b
// Size: 0xc5
function array_thread_amortized_proc( entities, process, var_b01eab2eb5e7d0ec, ... )
{
    foreach ( ent in entities )
    {
        if ( isai( ent ) && !isalive( ent ) || !isdefined( ent ) )
        {
            continue;
        }
        
        ent thread [[ process ]]( flat_args( vararg, varargcount ) );
        wait var_b01eab2eb5e7d0ec;
    }
}

// Namespace utility
// Params 3
// Checksum 0x6f71ea40, Offset: 0x12658
// Size: 0xf0
function array_wait( array, message, timeout )
{
    notifystruct = spawnstruct();
    
    if ( timeout )
    {
        thread array_wait_timeout_proc( notifystruct, timeout );
        notifystruct endon( #"array_wait_timeout" );
    }
    
    foreach ( element in array )
    {
        thread array_wait_proc( notifystruct, element, message );
    }
    
    for ( i = 0; i < array.size ; i++ )
    {
        notifystruct waittill( #"array_wait_proc" );
    }
    
    notifystruct notify( #"array_wait_success" );
}

// Namespace utility
// Params 3
// Checksum 0xb276b85f, Offset: 0x12750
// Size: 0x47
function array_wait_proc( notifystruct, element, message )
{
    notifystruct endon( #"array_wait_success" );
    element waittill_any( message, "death" );
    notifystruct notify( #"array_wait_proc" );
}

// Namespace utility
// Params 2
// Checksum 0x72f1f121, Offset: 0x1279f
// Size: 0x32
function array_wait_timeout_proc( notifystruct, timeout )
{
    notifystruct endon( #"array_wait_success" );
    wait timeout;
    notifystruct notify( #"array_wait_timeout" );
}

// Namespace utility
// Params 3, eflags: 0x4
// Checksum 0xe836343b, Offset: 0x127d9
// Size: 0x51, Type: bool
function private function_708833d1ec1325b6( var_5b0bb0673d0b1c7c, var_934a73038e70d1eb, disabledvalue )
{
    if ( is_player_gamepad_enabled() )
    {
        settingvalue = requestgamerprofile( var_5b0bb0673d0b1c7c );
    }
    else if ( var_934a73038e70d1eb )
    {
        settingvalue = requestgamerprofile( var_934a73038e70d1eb );
    }
    
    return settingvalue != disabledvalue;
}

// Namespace utility
// Params 1, eflags: 0x4
// Checksum 0xf648178a, Offset: 0x12833
// Size: 0x108
function private function_c8852ed0b886c6bd( var_e3ee05786f18e2c3 )
{
    var_3c04a2b892cbba04 = level.sharedfuncs[ #"weapons" ][ #"hash_591d84c60e3b7802" ];
    
    if ( !var_3c04a2b892cbba04 )
    {
        assertmsg( "<dev string:x13d9>" );
        return;
    }
    
    weaponnametobuild = level.weaponmapdata[ var_e3ee05786f18e2c3 ].assetname ?? var_e3ee05786f18e2c3;
    
    if ( issubstr( weaponnametobuild, "+" ) )
    {
        assertmsg( "<dev string:x1436>" );
        return;
    }
    
    weaponobj = [[ var_3c04a2b892cbba04 ]]( weaponnametobuild );
    
    if ( !isdefined( level.var_d53b344e2aeda06f ) )
    {
        level.var_d53b344e2aeda06f = [];
    }
    
    level.var_d53b344e2aeda06f[ var_e3ee05786f18e2c3 ] = weaponobj;
    
    /#
        if ( !isdefined( level.weaponnone ) )
        {
            level.weaponnone = makeweapon( "<dev string:x1063>" );
        }
        
        assert( weaponobj != level.weaponnone || var_e3ee05786f18e2c3 == "<dev string:x1527>", "<dev string:x152c>" + var_e3ee05786f18e2c3 );
    #/
    
    return weaponobj;
}

// Namespace utility
// Params 1, eflags: 0x4
// Checksum 0x9404abe5, Offset: 0x12944
// Size: 0x11b
function private function_ea577e55c7daf2b2( var_8ef80df233884b8e )
{
    var_3c04a2b892cbba04 = level.sharedfuncs[ #"weapons" ][ #"hash_e2adafa41f9e4a45" ];
    
    if ( !var_3c04a2b892cbba04 )
    {
        assertmsg( "<dev string:x154e>" );
        return;
    }
    
    if ( !isdefined( level.weaponnone ) )
    {
        level.weaponnone = makeweapon( "" );
    }
    
    weaponobj = function_7508ecd9410f7dfa( var_8ef80df233884b8e, var_3c04a2b892cbba04 );
    
    if ( weaponobj == level.weaponnone )
    {
        weaponobj = function_7508ecd9410f7dfa( hashcat( var_8ef80df233884b8e, "_mp" ), var_3c04a2b892cbba04 );
        
        if ( weaponobj == level.weaponnone )
        {
            weaponobj = function_7508ecd9410f7dfa( hashcat( var_8ef80df233884b8e, "_sp" ), var_3c04a2b892cbba04 );
        }
    }
    
    if ( !isdefined( level.var_8a2f4f6d7534396a ) )
    {
        level.var_8a2f4f6d7534396a = [];
    }
    
    level.var_8a2f4f6d7534396a[ var_8ef80df233884b8e ] = weaponobj;
    assert( weaponobj != level.weaponnone || var_8ef80df233884b8e == %"none", "<dev string:x152c>" + getxhashsourcename( var_8ef80df233884b8e ) );
    return weaponobj;
}

// Namespace utility
// Params 3
// Checksum 0xf8db4cc9, Offset: 0x12a68
// Size: 0x35
function function_e0618b428067bdd7( origin, viewpos, baseline )
{
    dist = distance( viewpos, origin );
    return dist / baseline;
}

// Namespace utility
// Params 1
// Checksum 0x4fc4789b, Offset: 0x12aa6
// Size: 0x2a, Type: bool
function isfiredamage( meansofdeath )
{
    if ( !isdefined( meansofdeath ) )
    {
        assertmsg( "<dev string:x15ae>" );
        return false;
    }
    
    return meansofdeath == "MOD_FIRE";
}

// Namespace utility
// Params 0
// Checksum 0x6f52d1ed, Offset: 0x12ad9
// Size: 0x20, Type: bool
function isflashed()
{
    if ( !isdefined( self.flashendtime ) )
    {
        return false;
    }
    
    return gettime() < self.flashendtime;
}

// Namespace utility
// Params 1
// Checksum 0xfbc39894, Offset: 0x12b02
// Size: 0x2a, Type: bool
function isimpactdamage( meansofdeath )
{
    if ( !isdefined( meansofdeath ) )
    {
        assertmsg( "<dev string:x15d1>" );
        return false;
    }
    
    return meansofdeath == "MOD_IMPACT";
}

// Namespace utility
// Params 3
// Checksum 0x4043d850, Offset: 0x12b35
// Size: 0x7a, Type: bool
function isleft2d( startpos, startforward, otherpos )
{
    startpos2d = ( startpos[ 0 ], startpos[ 1 ], 0 );
    otherpos2d = ( otherpos[ 0 ], otherpos[ 1 ], 0 );
    tootherpos = otherpos2d - startpos2d;
    forward2d = ( startforward[ 0 ], startforward[ 1 ], 0 );
    return tootherpos[ 0 ] * forward2d[ 1 ] - tootherpos[ 1 ] * forward2d[ 0 ] < 0;
}

// Namespace utility
// Params 3
// Checksum 0xc0c6aa29, Offset: 0x12bb8
// Size: 0x7b
function handlemeleedamage( objweapon, meansofdeath, damage )
{
    assert( isdefined( objweapon ) && isdefined( meansofdeath ) && isdefined( damage ) );
    
    if ( meansofdeath != "MOD_MELEE" )
    {
        return damage;
    }
    
    if ( isdefined( self.gs ) )
    {
        return ( damage * ( self.gs.basehealthdamagemultiplier ?? 1 ) );
    }
    
    return self.maxhealth + 1;
}

// Namespace utility
// Params 0
// Checksum 0x9a946249, Offset: 0x12c3c
// Size: 0x3f
function hidehudenable()
{
    if ( !isdefined( self.ui_hudhidden ) )
    {
        self.hidehudenabled = 0;
    }
    
    if ( self.hidehudenabled == 0 )
    {
        self setclientomnvar( "ui_hide_hud", 1 );
    }
    
    self.hidehudenabled++;
}

// Namespace utility
// Params 1
// Checksum 0xa4d34d7e, Offset: 0x12c83
// Size: 0x15
function hide_exploder_models( num )
{
    exploder::hide_exploder_models_proc( num );
}

// Namespace utility
// Params 0
// Checksum 0xa8eedbeb, Offset: 0x12ca0
// Size: 0x3f
function hidehuddisable()
{
    assert( self.hidehudenabled > 0, "<dev string:x15f6>" );
    
    if ( self.hidehudenabled == 1 )
    {
        self setclientomnvar( "ui_hide_hud", 0 );
    }
    
    self.hidehudenabled--;
}

// Namespace utility
// Params 0
// Checksum 0x54663bc8, Offset: 0x12ce7
// Size: 0x28
function setplayerstunned()
{
    if ( !isdefined( self.isstunned ) )
    {
        self.isstunned = 1;
        return;
    }
    
    self.isstunned++;
}

// Namespace utility
// Params 3
// Checksum 0x25513d10, Offset: 0x12d17
// Size: 0x94
function function_bd0b9675b52892fd( attackerentnum, var_4d6be7f39ac22259, objweapon )
{
    if ( !isdefined( self.isstunnedbyenemy ) )
    {
        self.isstunnedbyenemy = 1;
    }
    else
    {
        self.isstunnedbyenemy++;
    }
    
    if ( isdefined( attackerentnum ) && isdefined( var_4d6be7f39ac22259 ) )
    {
        if ( !isdefined( self.var_ce186c9e315d6ed3 ) )
        {
            self.var_ce186c9e315d6ed3 = {};
        }
        
        self.var_ce186c9e315d6ed3.objweapon = objweapon;
        self.var_ce186c9e315d6ed3.attackers[ var_4d6be7f39ac22259 ] = attackerentnum;
    }
}

// Namespace utility
// Params 0
// Checksum 0xe0a47367, Offset: 0x12db3
// Size: 0x3b
function setplayerunstunned()
{
    assert( isdefined( self.isstunned ), "<dev string:x1624>" );
    assert( self.isstunned > 0, "<dev string:x1673>" );
    self.isstunned--;
}

// Namespace utility
// Params 1
// Checksum 0x2e46849c, Offset: 0x12df6
// Size: 0x6e
function function_f6dbf59c1adea4c2( var_4d6be7f39ac22259 )
{
    assert( isdefined( self.isstunnedbyenemy ), "<dev string:x16f9>" );
    assert( self.isstunnedbyenemy > 0, "<dev string:x1765>" );
    self.isstunnedbyenemy--;
    
    if ( isdefined( self.var_ce186c9e315d6ed3 ) && isdefined( var_4d6be7f39ac22259 ) )
    {
        self.var_ce186c9e315d6ed3.attackers[ var_4d6be7f39ac22259 ] = undefined;
    }
}

/#

    // Namespace utility
    // Params 2
    // Checksum 0x6d0c1b85, Offset: 0x12e6c
    // Size: 0x2e, Type: dev
    function scriptbundlewarning( missingscriptbundle, fallbackscriptbundle )
    {
        println( "<dev string:x1803>" + missingscriptbundle + "<dev string:x181d>" + fallbackscriptbundle );
    }

#/

// Namespace utility
// Params 1
// Checksum 0xee86f71, Offset: 0x12ea2
// Size: 0x48, Type: bool
function is_dead_or_dying( guy )
{
    if ( !isdefined( guy ) )
    {
        return true;
    }
    
    if ( isai( guy ) )
    {
        return ( !isalive( guy ) || guy doinglongdeath() );
    }
    else if ( issentient( guy ) )
    {
        return !isalive( guy );
    }
    
    return false;
}

// Namespace utility
// Params 0
// Checksum 0x5b75ec21, Offset: 0x12ef3
// Size: 0x11, Type: bool
function is_dead_sentient()
{
    return issentient( self ) && !isalive( self );
}

// Namespace utility
// Params 0
// Checksum 0xd8bc4cdc, Offset: 0x12f0d
// Size: 0x17, Type: bool
function is_demo()
{
    if ( getdvarint( @"scr_demo", 0 ) )
    {
        return true;
    }
    
    return false;
}

// Namespace utility
// Params 1
// Checksum 0x632f3c29, Offset: 0x12f2d
// Size: 0x47, Type: bool
function damageflag( flag )
{
    return isdefined( self.damage ) && isdefined( self.damage.flags ) && self.damage.flags & flag;
}

// Namespace utility
// Params 2
// Checksum 0xf98484e0, Offset: 0x12f7d
// Size: 0x72
function setdamageflag( flag, boolean )
{
    if ( boolean )
    {
        self.damage.flags |= flag;
        return;
    }
    
    self.damage.flags &= ~flag;
}

// Namespace utility
// Params 2
// Checksum 0x78c2d141, Offset: 0x12ff7
// Size: 0x8e
function function_e16c621f95fe3acf( callback, gamerprofilearray )
{
    foreach ( gamerprofile in gamerprofilearray )
    {
        ui::lui_registercallback( gamerprofile + "_updated", callback );
    }
}

// Namespace utility
// Params 2, eflags: 0x40 variadic
// Checksum 0xe9d47ec, Offset: 0x1308d
// Size: 0x4f
function sum( ... )
{
    assert( varargcount >= 1 );
    
    if ( isarray( vararg[ 0 ] ) )
    {
        assert( varargcount == 1 );
        return array_sum( vararg[ 0 ] );
    }
    
    return array_sum( vararg );
}

// Namespace utility
// Params 8
// Checksum 0x59f6a5ce, Offset: 0x130e4
// Size: 0xda
function takecoverwarning( damage, attacker, direction, point, type, objweapon, inflictor, overkilldamage )
{
    if ( shouldshowcoverwarning() )
    {
        if ( self isswimming() )
        {
            self setclientomnvar( "ui_gettocover_text", "game/get_to_cover_swim" );
        }
        else
        {
            self setclientomnvar( "ui_gettocover_text", "game/get_to_cover" );
        }
        
        setdamageflag( 8, 1 );
        reducetakecoverwarnings();
        
        for ( i = 1; i <= 5 ; i++ )
        {
            self setclientomnvar( "ui_gettocover_state", i );
            wait 1;
        }
        
        self setclientomnvar( "ui_gettocover_state", 0 );
        delaythread( 60, &setdamageflag, 8, 0 );
    }
}

// Namespace utility
// Params 0
// Checksum 0x347e29d5, Offset: 0x131c6
// Size: 0x118, Type: bool
function shouldshowcoverwarning()
{
    /#
        if ( getdvarint( @"scr_debug_takecoverwarning" ) == 1 )
        {
            return true;
        }
    #/
    
    if ( issharedfuncdefined( #"player", #"isusingremotekillstreak" ) )
    {
        if ( self [[ getsharedfunc( #"player", #"isusingremotekillstreak" ) ]]() )
        {
            return false;
        }
    }
    
    if ( self islinked() )
    {
        return false;
    }
    
    if ( is_demo() )
    {
        return false;
    }
    
    if ( level.gameskill >= 2 )
    {
        return false;
    }
    
    if ( self.ignoreme )
    {
        return false;
    }
    
    if ( isdefined( level ) && level.missionfailed )
    {
        return false;
    }
    
    if ( self.forcetakecoverwarning )
    {
        return true;
    }
    
    if ( isdefined( self.vehicle ) )
    {
        return false;
    }
    
    if ( self getclientomnvar( "ui_gettocover_state" ) )
    {
        return false;
    }
    
    if ( !damageflag( 1 ) )
    {
        return false;
    }
    
    if ( damageflag( 8 ) )
    {
        return false;
    }
    
    if ( self [[ getsharedfunc( #"player", #"getTakeCoverWarnings" ) ]]() <= 0 )
    {
        return false;
    }
    
    if ( self.disabletakecoverwarning )
    {
        return false;
    }
    
    return true;
}

// Namespace utility
// Params 1
// Checksum 0x88e011f7, Offset: 0x132e7
// Size: 0x53
function setcoverwarningcount( count = 4 )
{
    if ( self [[ getsharedfunc( #"player", #"getTakeCoverWarnings" ) ]]() <= 0 )
    {
        self [[ getsharedfunc( #"player", #"setTakeCoverWarnings" ) ]]( count );
    }
}

// Namespace utility
// Params 0
// Checksum 0xa2066ca1, Offset: 0x13342
// Size: 0x5b
function reducetakecoverwarnings()
{
    takecoverwarnings = self [[ getsharedfunc( #"player", #"getTakeCoverWarnings" ) ]]();
    
    if ( takecoverwarnings > 0 )
    {
        takecoverwarnings--;
        self [[ getsharedfunc( #"player", #"setTakeCoverWarnings" ) ]]( takecoverwarnings );
        
        /#
            debugtakecoverwarnings();
        #/
    }
}

/#

    // Namespace utility
    // Params 0, eflags: 0x4
    // Checksum 0xbf1f924e, Offset: 0x133a5
    // Size: 0x4c, Type: dev
    function private debugtakecoverwarnings()
    {
        setdvarifuninitialized( @"scr_debugtakecover", 0 );
        
        if ( getdvarint( @"scr_debugtakecover" ) == 1 )
        {
            iprintlnbold( "<dev string:x183f>", self [[ getsharedfunc( #"player", #"getTakeCoverWarnings" ) ]]() );
        }
    }

#/

// Namespace utility
// Params 8
// Checksum 0xb9f6338c, Offset: 0x133f9
// Size: 0x183
function function_4cf0c9c46de1da7d( origin, var_c1d9f7f027611802, height, outer_radius, inner_radius, return_offsets, use_throttle, b_expensive )
{
    level endon( #"game_ended" );
    
    if ( !isdefined( origin ) )
    {
        return [];
    }
    
    return_offsets = istrue( return_offsets );
    use_throttle = istrue( use_throttle );
    b_expensive = istrue( b_expensive );
    throttle_index = 0;
    max_tries_per_frame = b_expensive ? 3 : 1;
    spawn_points = [];
    var_92b8811ed3fb7d79 = 5;
    
    for ( i = 0; i < var_c1d9f7f027611802 ; i++ )
    {
        var_36a6b72229a3b0a4 = 0;
        final_point = undefined;
        
        while ( !isdefined( final_point ) && var_36a6b72229a3b0a4 < var_92b8811ed3fb7d79 )
        {
            point = function_d1ad9c012835e383( origin, height, outer_radius, inner_radius );
            final_point = function_19e25589df379cd4( origin, point, outer_radius, inner_radius, !b_expensive );
            
            if ( isdefined( final_point ) )
            {
                if ( return_offsets )
                {
                    spawn_points[ spawn_points.size ] = final_point - origin;
                }
                else
                {
                    angles = vectortoangles( origin - final_point );
                    point = spawnstruct();
                    point.origin = final_point;
                    point.angles = ( 0, angles[ 1 ], 0 );
                    spawn_points[ spawn_points.size ] = point;
                }
            }
            else
            {
                var_36a6b72229a3b0a4++;
            }
            
            throttle_index++;
            
            if ( use_throttle && throttle_index % max_tries_per_frame == 0 )
            {
                waitframe();
            }
        }
    }
    
    return spawn_points;
}

// Namespace utility
// Params 1
// Checksum 0xc8f14d84, Offset: 0x13585
// Size: 0x19, Type: bool
function func_ref_exist( name )
{
    return isdefined( level.func[ name ] );
}

// Namespace utility
// Params 1
// Checksum 0x9774c3df, Offset: 0x135a7
// Size: 0x19, Type: bool
function fxexists( fx )
{
    return isdefined( level._effect[ fx ] );
}

// Namespace utility
// Params 0
// Checksum 0xead0cbe2, Offset: 0x135c9
// Size: 0x13, Type: bool
function function_86e14a9532d21558()
{
    return function_708833d1ec1325b6( "autogroundmantlegamepad", "autogroundmantlekeyboard", 0 );
}

// Namespace utility
// Params 0
// Checksum 0x6e5b5dc7, Offset: 0x135e5
// Size: 0x13, Type: bool
function function_e1726295b259f0f8()
{
    return function_708833d1ec1325b6( "autosprintgamepad", "autosprintkbm", 0 );
}

// Namespace utility
// Params 0
// Checksum 0xf076cc1d, Offset: 0x13601
// Size: 0x13, Type: bool
function function_5cf1306d427dcc14()
{
    return function_708833d1ec1325b6( "walljumpassistgamepad", "walljumpassistkbm", 0 );
}

// Namespace utility
// Params 4
// Checksum 0x9f3c86b, Offset: 0x1361d
// Size: 0xa5
function function_d1ad9c012835e383( origin, height, outer_radius, inner_radius )
{
    theta = randomfloatrange( 0, 360 );
    var_111e89d541a57106 = 0.2;
    
    if ( isdefined( inner_radius ) )
    {
        var_111e89d541a57106 = inner_radius / outer_radius;
    }
    
    x = sin( theta ) * outer_radius * randomfloatrange( var_111e89d541a57106, 1 );
    y = cos( theta ) * outer_radius * randomfloatrange( var_111e89d541a57106, 1 );
    z = height;
    return ( x, y, z );
}

// Namespace utility
// Params 0
// Checksum 0xe9360f9a, Offset: 0x136cb
// Size: 0x91
function fifo_dequeue()
{
    queue = self;
    
    while ( isdefined( queue.head ) )
    {
        object = queue.head.object;
        queue.head = queue.head.next;
        
        if ( !isdefined( queue.head ) )
        {
            queue.tail = undefined;
        }
        
        var_7237854e3be197ca = object;
        
        if ( isdefined( var_7237854e3be197ca ) )
        {
            return var_7237854e3be197ca;
        }
    }
}

// Namespace utility
// Params 1
// Checksum 0xd9a4d023, Offset: 0x13764
// Size: 0x89
function fifo_enqueue( object )
{
    queue = self;
    queueitem = spawnstruct();
    queueitem.object = object;
    
    if ( isdefined( queue.tail ) )
    {
        queue.tail.next = queueitem;
        queue.tail = queueitem;
        return;
    }
    
    queue.head = queueitem;
    queue.tail = queueitem;
}

// Namespace utility
// Params 1
// Checksum 0xc979fc3, Offset: 0x137f5
// Size: 0x57
function fileprint_launcher( string )
{
    assert( isdefined( level.fileprintlauncher_linecount ) );
    level.fileprintlauncher_linecount++;
    
    if ( level.fileprintlauncher_linecount > 200 )
    {
        wait 0.05;
        level.fileprintlauncher_linecount = 0;
    }
    
    println( "<dev string:x1854>" + string );
}

// Namespace utility
// Params 2
// Checksum 0x6cf4ccad, Offset: 0x13854
// Size: 0x18a, Type: bool
function fileprint_launcher_end_file( var_5756f07f5c4d9982, var_390f5c13316351df = 0 )
{
    /#
        setdevdvarifuninitialized( @"launcher_print_fail", "<dev string:x1865>" );
        setdevdvarifuninitialized( @"hash_afbeda0efab5bd5e", "<dev string:x1865>" );
    #/
    
    if ( var_390f5c13316351df )
    {
        fileprint_launcher( "GAMEPRINTENDFILE:GAMEPRINTP4ENABLED:" + var_5756f07f5c4d9982 );
    }
    else
    {
        fileprint_launcher( "GAMEPRINTENDFILE:" + var_5756f07f5c4d9982 );
    }
    
    timeout = gettime() + 4000;
    
    while ( getdvarint( @"hash_afbeda0efab5bd5e" ) == 0 && getdvar( @"launcher_print_fail" ) == "0" && gettime() < timeout )
    {
        wait 0.05;
    }
    
    if ( !( gettime() < timeout ) )
    {
        iprintlnbold( "LAUNCHER_PRINT_FAIL:( TIMEOUT ): launcherconflict? restart launcher and try again? " );
        
        /#
            setdevdvar( @"launcher_print_fail", "<dev string:x1865>" );
        #/
        
        level.fileprint_launcher = undefined;
        return false;
    }
    
    failvar = getdvar( @"launcher_print_fail" );
    
    if ( failvar != "0" )
    {
        iprintlnbold( "LAUNCHER_PRINT_FAIL:( " + failvar + " ): launcherconflict? restart launcher and try again? " );
        
        /#
            setdevdvar( @"launcher_print_fail", "<dev string:x1865>" );
        #/
        
        level.fileprint_launcher = undefined;
        return false;
    }
    
    /#
        setdevdvar( @"launcher_print_fail", "<dev string:x1865>" );
        setdevdvar( @"hash_afbeda0efab5bd5e", "<dev string:x1865>" );
    #/
    
    iprintlnbold( "Launcher write to file successful!" );
    level.fileprint_launcher = undefined;
    return true;
}

// Namespace utility
// Params 0
// Checksum 0x10e96690, Offset: 0x139e7
// Size: 0x3b
function fileprint_launcher_start_file()
{
    assert( !isdefined( level.fileprint_launcher ), "<dev string:x1867>" );
    level.fileprintlauncher_linecount = 0;
    level.fileprint_launcher = 1;
    fileprint_launcher( "GAMEPRINTSTARTFILE:" );
}

/#

    // Namespace utility
    // Params 0
    // Checksum 0x3111727b, Offset: 0x13a2a
    // Size: 0x1b, Type: dev
    function fileprint_map_entity_end()
    {
        fileprint_launcher( "<dev string:x18aa>" );
        level.fileprint_entitystart = undefined;
    }

    // Namespace utility
    // Params 0
    // Checksum 0xe572b9c4, Offset: 0x13a4d
    // Size: 0x66, Type: dev
    function fileprint_map_entity_start()
    {
        assert( isdefined( level.fileprint_mapentcount ), "<dev string:x18ac>" );
        assert( !isdefined( level.fileprint_entitystart ) );
        level.fileprint_entitystart = 1;
        fileprint_launcher( "<dev string:x18e1>" + level.fileprint_mapentcount );
        fileprint_launcher( "<dev string:x18e9>" );
        level.fileprint_mapentcount++;
    }

    // Namespace utility
    // Params 1
    // Checksum 0xf4dbb634, Offset: 0x13abb
    // Size: 0x61, Type: dev
    function fileprint_map_header( binclude_blank_worldspawn = 0 )
    {
        fileprint_launcher( "<dev string:x18eb>" );
        fileprint_launcher( "<dev string:x18f3>" );
        fileprint_launcher( "<dev string:x190e>" );
        
        if ( !binclude_blank_worldspawn )
        {
            return;
        }
        
        fileprint_map_entity_start();
        fileprint_map_keypairprint( "<dev string:x191e>", "<dev string:x1928>" );
        fileprint_map_entity_end();
    }

    // Namespace utility
    // Params 2
    // Checksum 0x4670239e, Offset: 0x13b24
    // Size: 0x36, Type: dev
    function fileprint_map_keypairprint( key1, key2 )
    {
        fileprint_launcher( "<dev string:x1933>" + key1 + "<dev string:x1935>" + key2 + "<dev string:x1933>" );
    }

    // Namespace utility
    // Params 0
    // Checksum 0xd57375a8, Offset: 0x13b62
    // Size: 0x18, Type: dev
    function fileprint_map_start()
    {
        level.fileprint_mapentcount = 0;
        fileprint_map_header( 1 );
    }

    // Namespace utility
    // Params 1
    // Checksum 0xcaff2e89, Offset: 0x13b82
    // Size: 0x43, Type: dev
    function fileprint_radiant_vec( vector )
    {
        string = "<dev string:x1063>" + vector[ 0 ] + "<dev string:x107b>" + vector[ 1 ] + "<dev string:x107b>" + vector[ 2 ] + "<dev string:x1063>";
        return string;
    }

#/

// Namespace utility
// Params 5, eflags: 0x4
// Checksum 0x48e5690a, Offset: 0x13bcd
// Size: 0x12f
function private function_19e25589df379cd4( origin, spawn_point_offset, outer_radius, inner_radius, var_772211e197d75217 )
{
    point_start = ( origin[ 0 ] + spawn_point_offset[ 0 ], origin[ 1 ] + spawn_point_offset[ 1 ], origin[ 2 ] + spawn_point_offset[ 2 ] );
    point_end = ( origin[ 0 ] + spawn_point_offset[ 0 ], origin[ 1 ] + spawn_point_offset[ 1 ], origin[ 2 ] - spawn_point_offset[ 2 ] );
    traceresult = trace::capsule_trace( point_start, point_end, 15, 72 );
    point_on_ground = traceresult[ "position" ];
    
    if ( var_772211e197d75217 )
    {
        waitframe();
    }
    
    final_point = origin;
    point_on_navmesh = undefined;
    
    if ( traceresult[ "fraction" ] > 0 && isdefined( point_on_ground ) )
    {
        point_on_navmesh = getclosestpointonnavmesh( point_on_ground );
    }
    
    if ( isdefined( point_on_navmesh ) && abs( point_on_ground[ 2 ] - point_on_navmesh[ 2 ] ) < 32 )
    {
        if ( distance2d( point_on_navmesh, origin ) <= outer_radius && ( !isdefined( inner_radius ) || distance2d( point_on_navmesh, origin ) >= inner_radius ) )
        {
            final_point = ( point_on_navmesh[ 0 ], point_on_navmesh[ 1 ], max( point_on_ground[ 2 ], point_on_navmesh[ 2 ] ) );
        }
    }
    
    return final_point;
}

// Namespace utility
// Params 0
// Checksum 0x86af20c0, Offset: 0x13d05
// Size: 0x20, Type: bool
function isstunned()
{
    if ( !isdefined( self.stunendtime ) )
    {
        return false;
    }
    
    return gettime() < self.stunendtime;
}

// Namespace utility
// Params 0
// Checksum 0x4f8661ed, Offset: 0x13d2e
// Size: 0xc, Type: bool
function isusingremote()
{
    return isdefined( self.usingremote );
}

// Namespace utility
// Params 3
// Checksum 0x411b8b70, Offset: 0x13d43
// Size: 0x176
function function_7c45b71b8e0d3cff( ignoreoverride, var_ea76c421240c97fc, var_e7c01d47a986ce99 )
{
    contents = trace::create_contents( 0, 1, 0, 1, 0, 1, 1, 0, 0 );
    ignorelist = [];
    
    if ( isdefined( ignoreoverride ) )
    {
        ignorelist = ignoreoverride;
    }
    
    caststart = self.origin + ( 0, 0, var_ea76c421240c97fc ?? 50 );
    castend = caststart + ( 0, 0, var_e7c01d47a986ce99 ?? -200 );
    traceresult = trace::ray_trace( caststart, castend, ignorelist, contents );
    
    if ( isdefined( traceresult[ "entity" ] ) )
    {
        groundent = traceresult[ "entity" ];
        
        if ( groundent ismovingplatform() )
        {
            movingplatforminfo = spawnstruct();
            worldorigin = traceresult[ "position" ] + ( 0, 0, 4 );
            localorigin = rotatevectorinverted( worldorigin - groundent.origin, groundent.angles );
            localangles = combineangles( invertangles( groundent.angles ), self.angles );
            movingplatforminfo.groundent = groundent;
            movingplatforminfo.worldorigin = worldorigin;
            movingplatforminfo.localorigin = localorigin;
            movingplatforminfo.localangles = localangles;
            return movingplatforminfo;
        }
    }
}

// Namespace utility
// Params 1
// Checksum 0x4c5e2b5b, Offset: 0x13ec2
// Size: 0x14
function function_6f5d2e1f1ff70482( milliseconds )
{
    return milliseconds * 0.001;
}

// Namespace utility
// Params 3
// Checksum 0xd6b9fb13, Offset: 0x13edf
// Size: 0x85
function missile_settargetandflightmode( target, mode, offset )
{
    assert( isdefined( target ) );
    assert( isdefined( mode ) );
    
    if ( !isdefined( offset ) )
    {
        offset = ( 0, 0, 0 );
    }
    
    self missile_settargetent( target, offset );
    
    switch ( mode )
    {
        case #"hash_da8b50286ccc05fc":
            self missile_setflightmodedirect();
            break;
        case #"hash_6d308d6c437ce11c":
            self missile_setflightmodetop();
            break;
    }
}

// Namespace utility
// Params 7
// Checksum 0xc83f28d, Offset: 0x13f6c
// Size: 0xd5
function motionwarpwithnotetracks( anime, targetpos, targetangles, notetrackstart, notetrackend, duration, updateanimrate )
{
    if ( isdefined( notetrackstart ) )
    {
        animstartfrac = getnotetracktimes( anime, notetrackstart )[ 0 ];
        
        if ( !isdefined( animstartfrac ) )
        {
            assertmsg( "<dev string:x1939>" + notetrackstart + "<dev string:x194c>" );
            animstartfrac = 0;
        }
    }
    else
    {
        animstartfrac = 0;
    }
    
    if ( isdefined( notetrackend ) )
    {
        animendfrac = getnotetracktimes( anime, notetrackend )[ 0 ];
        
        if ( !isdefined( animendfrac ) )
        {
            assertmsg( "<dev string:x196e>" + notetrackend + "<dev string:x194c>" );
            animendfrac = 1;
        }
    }
    else
    {
        animendfrac = 1;
    }
    
    motionwarpwithtimes( anime, targetpos, targetangles, animstartfrac, animendfrac, duration, updateanimrate );
}

// Namespace utility
// Params 9
// Checksum 0xa2471bad, Offset: 0x14049
// Size: 0x284
function function_1e0fdc2ddb427044( anime, parentent, tag, localtargetpos, var_82b26273be843388, animstartfrac, animendfrac, duration, updateanimrate )
{
    assert( isdefined( anime ) );
    assert( animstartfrac >= 0 );
    assert( animendfrac <= 1 );
    assert( isdefined( parentent ) );
    assert( isdefined( localtargetpos ) );
    assert( isdefined( var_82b26273be843388 ) );
    
    if ( !isdefined( updateanimrate ) )
    {
        updateanimrate = 1;
    }
    
    if ( isdefined( tag ) )
    {
        linkpos = parentent gettagorigin( tag );
        linkang = parentent gettagangles( tag );
    }
    else
    {
        linkpos = parentent.origin;
        linkang = parentent.angles;
        tag = "";
    }
    
    worldtargetpos = linkpos + rotatevector( localtargetpos, linkang );
    var_6bf8560b5195147d = combineangles( var_82b26273be843388, linkang );
    var_67ba0a3949a64d89 = getangledelta3d( anime, animstartfrac, animendfrac );
    animposdelta = getmovedelta( anime, animstartfrac, animendfrac );
    var_2ab9898ceeb10a7a = invertangles( var_67ba0a3949a64d89 );
    var_51e2c41e6b52bf9f = combineangles( var_6bf8560b5195147d, var_2ab9898ceeb10a7a );
    var_1ed21a6d35a9c58e = rotatevector( -1 * animposdelta, var_2ab9898ceeb10a7a );
    var_7401a6e768cf2cb1 = rotatevector( var_1ed21a6d35a9c58e, var_6bf8560b5195147d );
    worldanimstartpos = worldtargetpos + var_7401a6e768cf2cb1;
    var_ff32d80ea94a704a = self.origin - linkpos;
    invlinkang = invertangles( linkang );
    localtargetpos = rotatevector( var_ff32d80ea94a704a, invlinkang );
    var_82b26273be843388 = combineangles( self.angles, invlinkang );
    animrate = 1;
    var_620f711ebce0ce12 = length( worldtargetpos - self.origin );
    
    if ( updateanimrate && var_620f711ebce0ce12 > 0 )
    {
        animrate = length( animposdelta ) / var_620f711ebce0ce12;
        animrate = clamp( animrate, 0.5, 2 );
        self aisetanimrate( anime, animrate );
    }
    
    if ( !isdefined( duration ) )
    {
        animlength = getanimlength( anime ) / animrate;
        duration = int( ( animendfrac - animstartfrac ) * animlength * 1000 );
    }
    
    if ( duration < 50 )
    {
        duration = 50;
    }
    
    self linktomoveoffset( parentent, tag, localtargetpos, var_82b26273be843388 );
    self motionwarpwithanim( worldanimstartpos, var_51e2c41e6b52bf9f, worldtargetpos, var_6bf8560b5195147d, duration );
}

// Namespace utility
// Params 7
// Checksum 0x2de63a49, Offset: 0x142d5
// Size: 0x158
function motionwarpwithtimes( anime, targetpos, targetangles, animstartfrac, animendfrac, duration, updateanimrate = 1 )
{
    animyawdelta = getangledelta( anime, animstartfrac, animendfrac );
    animtranslationdelta = getmovedelta( anime, animstartfrac, animendfrac );
    animtranslationdelta = rotatevector( animtranslationdelta, ( 0, targetangles[ 1 ] - animyawdelta, 0 ) );
    animstartpos = targetpos - animtranslationdelta;
    animstartyaw = targetangles[ 1 ] - animyawdelta;
    animstartangles = ( targetangles[ 0 ], animstartyaw, targetangles[ 2 ] );
    animrate = 1;
    var_620f711ebce0ce12 = length( targetpos - self.origin );
    
    if ( updateanimrate && var_620f711ebce0ce12 > 0 )
    {
        animrate = length( animtranslationdelta ) / var_620f711ebce0ce12;
        animrate = clamp( animrate, 0.75, 1.25 );
        self aisetanimrate( anime, animrate );
    }
    
    if ( !isdefined( duration ) )
    {
        animlength = getanimlength( anime ) / animrate;
        duration = int( ( animendfrac - animstartfrac ) * animlength * 1000 );
    }
    
    if ( duration < 50 )
    {
        duration = 50;
    }
    
    self motionwarpwithanim( animstartpos, animstartangles, targetpos, targetangles, duration );
    return animrate;
}

// Namespace utility
// Params 1
// Checksum 0x69524c24, Offset: 0x14436
// Size: 0x14
function mph_to_ips( mph )
{
    return mph * 17.6;
}

// Namespace utility
// Params 2
// Checksum 0xdd7b692, Offset: 0x14453
// Size: 0x31
function mph_travel_time( speed, dist )
{
    speed = mph_to_ips( speed );
    time = dist / speed;
    return time;
}

// Namespace utility
// Params 3
// Checksum 0xc2e3f915, Offset: 0x1448d
// Size: 0xc1
function navrepulsorremoveondeath( radius, team = "all", timeout )
{
    assert( isent( self ), "<dev string:x197f>" );
    assert( isnumber( radius ), "<dev string:x19b3>" );
    
    if ( !isdefined( self.unique_id ) )
    {
        flags::assign_unique_id();
    }
    
    repulsor_id = "repulsor_id_" + self.unique_id;
    createnavrepulsor( repulsor_id, 0, self.origin, radius, 1, team );
    
    if ( isdefined( timeout ) )
    {
        waittill_notify_or_timeout( "death", timeout );
    }
    else
    {
        self waittill( #"death" );
    }
    
    destroynavrepulsor( repulsor_id );
}

// Namespace utility
// Params 3
// Checksum 0xc5ceb6bf, Offset: 0x14556
// Size: 0x6d
function function_8ae0ea62537eafc5( origin, radius, ignorenavmesh )
{
    theta = randomfloat( 360 );
    offset = ( radius * cos( theta ), radius * sin( theta ), 0 );
    randompoint = origin + offset;
    
    if ( !ignorenavmesh )
    {
        randompoint = getclosestpointonnavmesh( randompoint );
    }
    
    return randompoint;
}

// Namespace utility
// Params 5
// Checksum 0x7b3f32bf, Offset: 0x145cc
// Size: 0x142
function function_950fed9c7e18b522( origin, radius, num_points, var_d5e0ecfb96cb685e = 1, n_padding )
{
    var_e19764f251e4a496 = [];
    var_2ab9d26f67125bc8 = 360 / num_points;
    
    if ( !isdefined( n_padding ) )
    {
        n_padding = var_2ab9d26f67125bc8 / 2;
    }
    
    if ( n_padding > var_2ab9d26f67125bc8 / 2 )
    {
        n_padding = var_2ab9d26f67125bc8 / 2;
    }
    
    for ( i = 0; i < num_points ; i++ )
    {
        min_range = var_2ab9d26f67125bc8 * i + n_padding;
        max_range = var_2ab9d26f67125bc8 + var_2ab9d26f67125bc8 * i - n_padding;
        
        if ( min_range == max_range )
        {
            theta = min_range;
        }
        else
        {
            n_min = var_2ab9d26f67125bc8 * i + n_padding;
            n_max = var_2ab9d26f67125bc8 + var_2ab9d26f67125bc8 * i - n_padding;
            
            if ( n_min >= n_max )
            {
                theta = min_range;
            }
            else
            {
                theta = randomfloatrange( n_min, n_max );
            }
        }
        
        offset = ( radius * cos( theta ), radius * sin( theta ), 0 );
        randompoint = origin + offset;
        
        if ( var_d5e0ecfb96cb685e )
        {
            randompoint = getclosestpointonnavmesh( randompoint );
        }
        
        var_e19764f251e4a496[ var_e19764f251e4a496.size ] = randompoint;
    }
    
    return var_e19764f251e4a496;
}

// Namespace utility
// Params 2
// Checksum 0xad56efea, Offset: 0x14717
// Size: 0x7b
function getrandompointincircle( origin, radius )
{
    loopcount = 0;
    radiussquared = radius * radius;
    
    do
    {
        if ( loopcount >= 10 )
        {
            return origin;
        }
        
        offset = ( randomfloatrange( radius * -1, radius ), randomfloatrange( radius * -1, radius ), 0 );
        randompoint = origin + offset;
        loopcount++;
    }
    while ( distance2dsquared( origin, randompoint ) > radiussquared );
    
    return randompoint;
}

// Namespace utility
// Params 2
// Checksum 0x3a0b7b85, Offset: 0x1479b
// Size: 0x7f
function function_7afe366c29a77c34( origin, radius )
{
    loopcount = 0;
    radiussquared = radius * radius;
    
    do
    {
        if ( loopcount >= 10 )
        {
            return origin;
        }
        
        offset = ( randomfloatrange( radius * -1, radius ), randomfloatrange( radius * -1, radius ), 0 );
        randompoint = getclosestpointonnavmesh( origin + offset );
        loopcount++;
    }
    while ( distance2dsquared( origin, randompoint ) > radiussquared );
    
    return randompoint;
}

// Namespace utility
// Params 7
// Checksum 0x8990f114, Offset: 0x14823
// Size: 0x155
function function_724309a65022770f( origin, radius, angle, referenceyaw, refobj, var_108b577f30c53a02, var_15a1f14e933b00c5 )
{
    var_45492d81a7925646 = var_15a1f14e933b00c5 ?? 10;
    loopcount = 0;
    randomangle = randomfloatrange( referenceyaw - angle * 0.5, referenceyaw + angle * 0.5 );
    randomradius = randomfloatrange( 0, radius );
    randompoint = ( origin[ 0 ] + randomradius * cos( randomangle ), origin[ 1 ] + randomradius * sin( randomangle ), origin[ 2 ] );
    navmeshpoint = getclosestpointonnavmesh( randompoint, refobj );
    
    while ( distance2dsquared( origin, navmeshpoint ) > radius * radius || isdefined( var_108b577f30c53a02 ) && [[ var_108b577f30c53a02 ]]( navmeshpoint ) )
    {
        loopcount++;
        randomangle = math::degrees_to_radians( randomfloatrange( 0, angle ) );
        randomradius = randomfloatrange( 0, radius );
        randompoint = ( origin[ 0 ] + randomradius * cos( randomangle ), origin[ 1 ] + randomradius * sin( randomangle ), origin[ 2 ] );
        navmeshpoint = getclosestpointonnavmesh( randompoint, refobj );
        
        if ( loopcount > var_45492d81a7925646 )
        {
            return origin;
        }
    }
    
    point = drop_to_ground( navmeshpoint, 0 );
    return point;
}

// Namespace utility
// Params 1
// Checksum 0x3245db21, Offset: 0x14981
// Size: 0x28, Type: bool
function function_1fe82b95e465ee6c( threaduid )
{
    if ( !self.pendingdelaythread )
    {
        return false;
    }
    
    return istrue( self.pendingdelaythread[ threaduid ] );
}

// Namespace utility
// Params 3
// Checksum 0x8b7fdbcb, Offset: 0x149b2
// Size: 0x6f, Type: bool
function ispointinsidecircle( point, circlecenter, circleradius )
{
    assert( isvector( point ) );
    assert( isvector( circlecenter ) );
    assert( isnumber( circleradius ) );
    
    if ( squared( point[ 0 ] - circlecenter[ 0 ] ) + squared( point[ 1 ] - circlecenter[ 1 ] ) <= squared( circleradius ) )
    {
        return true;
    }
    
    return false;
}

// Namespace utility
// Params 5
// Checksum 0xe9bb3423, Offset: 0x14a2a
// Size: 0x1c8
function function_c801237e8eb2a51a( point, circle_origin, radius, angle, referenceyaw )
{
    var_121f54926e9910f7 = point - circle_origin;
    withinradius = distance2dsquared( point, circle_origin ) <= radius * radius;
    var_716511500a992abe = math::scalar_projection( var_121f54926e9910f7, ( cos( referenceyaw * 0.5 ), sin( referenceyaw * 0.5 ), 0 ) ) >= 0;
    var_3bf3a6486d5b4b74 = math::scalar_projection( var_121f54926e9910f7, ( cos( referenceyaw * 0.5 + angle ), sin( referenceyaw * 0.5 + angle ), 0 ) ) <= 0;
    
    /#
        var_f4559f052aa6ed4d = ( cos( referenceyaw * 0.5 ), sin( referenceyaw * 0.5 ), 0 );
        var_c396f1c953e0c8fb = ( cos( referenceyaw * 0.5 + angle ), sin( referenceyaw * 0.5 + angle ), 0 );
        circle( circle_origin, radius, ( 1, 1, 0 ) );
        line( circle_origin, circle_origin + var_f4559f052aa6ed4d * radius, ( 0, 0, 1 ) );
        line( circle_origin, circle_origin + var_c396f1c953e0c8fb * radius, ( 0, 0, 1 ) );
        line( circle_origin, circle_origin + vectornormalize( var_121f54926e9910f7 ) * length( var_121f54926e9910f7 ), var_716511500a992abe && var_3bf3a6486d5b4b74 && withinradius ? ( 0, 1, 0 ) : ( 1, 0, 0 ) );
    #/
    
    if ( var_716511500a992abe && var_3bf3a6486d5b4b74 && withinradius )
    {
        return 0;
    }
    
    if ( !var_716511500a992abe && var_3bf3a6486d5b4b74 )
    {
        return -1;
    }
    
    if ( var_716511500a992abe && !var_3bf3a6486d5b4b74 )
    {
        return 1;
    }
}

// Namespace utility
// Params 1
// Checksum 0x7e019a81, Offset: 0x14bfb
// Size: 0x14d
function function_76d5fd43ecf45e30( volume )
{
    local_x = randomfloatrange( volume.size_min[ 0 ] * -1, volume.size_max[ 0 ] );
    local_y = randomfloatrange( volume.size_min[ 1 ] * -1, volume.size_max[ 1 ] );
    local_z = randomfloatrange( volume.size_min[ 2 ] * -1, volume.size_max[ 2 ] );
    local_point = ( local_x, local_y, local_z );
    
    if ( volume.angles && volume.angles != ( 0, 0, 0 ) )
    {
        forward = anglestoforward( volume.angles );
        right = anglestoright( volume.angles );
        up = anglestoup( volume.angles );
        world_offset = forward * local_x + right * local_y + up * local_z;
        return ( volume.origin + world_offset );
    }
    
    return volume.origin + local_point;
}

// Namespace utility
// Params 3
// Checksum 0xdc5ebd76, Offset: 0x14d51
// Size: 0x5e
function histogram_create( minimums, maximums, weights )
{
    assert( minimums.size == maximums.size );
    assert( minimums.size == weights.size );
    return { #weights:weights, #maximums:maximums, #minimums:minimums };
}

// Namespace utility
// Params 0
// Checksum 0x48ac6e85, Offset: 0x14db8
// Size: 0x10b
function histogram_sample()
{
    totalweight = array_sum( self.weights );
    pivotvalue = randomfloat( totalweight );
    pivotlowerbound = 0;
    pivotupperbound = 0;
    
    for ( i = 0; i < self.weights.size ; i++ )
    {
        weight = self.weights[ i ];
        minimum = self.minimums[ i ];
        maximum = self.maximums[ i ];
        pivotupperbound += weight;
        
        if ( pivotlowerbound <= pivotvalue && pivotvalue < pivotupperbound )
        {
            return randomfloatrange( minimum, maximum );
        }
        
        pivotlowerbound = pivotupperbound;
    }
    
    throw( "histogramSample() did not select any range. This should not be possible." );
    return randomfloatrange( self.minimums[ self.minimums.size - 1 ], self.maximums[ self.maximums.size - 1 ] );
}

// Namespace utility
// Params 3
// Checksum 0x7ff905f, Offset: 0x14ecc
// Size: 0x54
function function_95db22f620602461( dvar, func, args )
{
    if ( getdvarint( dvar ) )
    {
        if ( isdefined( args ) )
        {
            if ( !isarray( args ) )
            {
                args = [ args ];
            }
            
            return single_func_argarray( self, func, args );
        }
        
        return self [[ func ]]();
    }
}

// Namespace utility
// Params 1
// Checksum 0x9ddf770d, Offset: 0x14f28
// Size: 0xc4
function igc_camera( bool )
{
    player = self;
    registered = "igc";
    
    if ( bool )
    {
        player setstance( "stand", 1, 1, 1 );
        player val::set( registered, "freezecontrols", 1 );
        player val::set( registered, "cinematic_motion", 0 );
        player val::set( registered, "weapon", 0 );
        player val::set( registered, "damage", 0 );
        player val::set( registered, "breath_system", 0 );
        player val::set( registered, "show_hud", 0 );
        player val::set( registered, "sp_backpack", 0 );
        player cleardamageindicators();
        return;
    }
    
    player val::reset_all( registered );
}

// Namespace utility
// Params 1
// Checksum 0x8dab35cd, Offset: 0x14ff4
// Size: 0x25
function launcher_write_clipboard( str )
{
    level.fileprintlauncher_linecount = 0;
    fileprint_launcher( "LAUNCHER_CLIP:" + str );
}

// Namespace utility
// Params 2
// Checksum 0xa5e89d27, Offset: 0x15021
// Size: 0xb3
function letterbox_enable( bool, time )
{
    player = self;
    
    if ( !isdefined( time ) )
    {
        time = 2;
    }
    
    wasenabled = player ent_flag_exist( "letterbox_enabled" ) && player ent_flag( "letterbox_enabled" );
    
    if ( bool && !wasenabled )
    {
        player ent_flag_set( "letterbox_enabled" );
        player lerpfovscalefactor( 0, time );
        showcinematicletterboxing( time, 0, player );
        return;
    }
    
    if ( !bool && wasenabled )
    {
        player ent_flag_clear( "letterbox_enabled" );
        player lerpfovscalefactor( 1, time );
        hidecinematicletterboxing( time, 0, player );
    }
}

// Namespace utility
// Params 3
// Checksum 0x552feeaa, Offset: 0x150dc
// Size: 0xb1
function function_c645601b82788c91( enable, duration, flag )
{
    level endon( #"game_ended" );
    
    foreach ( player in level.players )
    {
        player letterbox_enable( enable, duration );
    }
    
    wait duration;
    flag_set( flag );
}

// Namespace utility
// Params 1
// Checksum 0xa0a39953, Offset: 0x15195
// Size: 0x1c
function getyaw( org )
{
    return vectortoyaw( org - self.origin );
}

// Namespace utility
// Params 1
// Checksum 0x6683dce2, Offset: 0x151ba
// Size: 0x90
function getyawtospot( spot )
{
    if ( actor_is3d() )
    {
        forward = anglestoforward( self.angles );
        rotatedpos = rotatepointaroundvector( forward, spot - self.origin, self.angles[ 2 ] * -1 );
        spot = rotatedpos + self.origin;
    }
    
    yaw = getyaw( spot ) - self.angles[ 1 ];
    yaw = angleclamp180( yaw );
    return yaw;
}

// Namespace utility
// Params 1
// Checksum 0xa9a01e79, Offset: 0x15253
// Size: 0x5f
function getyawtospot3d( spot )
{
    var_40b69a03e72b5bb9 = spot - self.origin;
    var_a96e0316adc12c5f = rotatevectorinverted( var_40b69a03e72b5bb9, self.angles );
    yaw = vectortoyaw( var_a96e0316adc12c5f );
    yaw_clamped = angleclamp180( yaw );
    return yaw_clamped;
}

// Namespace utility
// Params 2
// Checksum 0x98d2bd95, Offset: 0x152bb
// Size: 0x3f
function giveachievement_wrapper( achievement, notused )
{
    if ( is_demo() )
    {
        return;
    }
    
    level.player giveachievement( achievement );
    println( "<dev string:x19fa>" + achievement );
}

// Namespace utility
// Params 1
// Checksum 0x2c17c63, Offset: 0x15302
// Size: 0x34, Type: bool
function ent_flag( message )
{
    assert( isdefined( message ), "<dev string:x5cd>" );
    return ent_flag_exist( message ) && self.ent_flag[ message ];
}

// Namespace utility
// Params 2
// Checksum 0xfaeec784, Offset: 0x1533f
// Size: 0xab
function ent_flag_clear( message, remove )
{
    /#
        assert( isdefined( self ), "<dev string:x1a08>" );
        
        if ( ent_flag_exist( message ) )
        {
            assert( self.ent_flag[ message ] == self.ent_flags_lock[ message ] );
        }
        
        self.ent_flags_lock[ message ] = 0;
    #/
    
    if ( ent_flag( message ) )
    {
        self.ent_flag[ message ] = 0;
        self notify( message );
    }
    
    if ( ent_flag_exist( message ) && remove )
    {
        self.ent_flag[ message ] = undefined;
        
        /#
            self.ent_flags_lock[ message ] = undefined;
        #/
    }
}

// Namespace utility
// Params 2
// Checksum 0x979ec05f, Offset: 0x153f2
// Size: 0x26
function ent_flag_clear_delayed( message, delay )
{
    wait delay;
    
    if ( isdefined( self ) )
    {
        ent_flag_clear( message );
    }
}

// Namespace utility
// Params 1
// Checksum 0x4fce56d0, Offset: 0x15420
// Size: 0x20, Type: bool
function ent_flag_exist( message )
{
    if ( isdefined( self.ent_flag[ message ] ) )
    {
        return true;
    }
    
    return false;
}

// Namespace utility
// Params 1
// Checksum 0x3589d622, Offset: 0x15449
// Size: 0x7e
function ent_flag_init( message )
{
    if ( !isdefined( self.ent_flag ) )
    {
        self.ent_flag = [];
        self.ent_flags_lock = [];
    }
    
    /#
        if ( level.first_frame == -1 )
        {
            assert( !ent_flag_exist( message ), "<dev string:x614>" + message + "<dev string:x1a3e>" );
        }
    #/
    
    self.ent_flag[ message ] = 0;
    
    /#
        self.ent_flags_lock[ message ] = 0;
    #/
}

// Namespace utility
// Params 1
// Checksum 0x72201125, Offset: 0x154cf
// Size: 0x8e
function ent_flag_set( message )
{
    assert( isdefined( self ), "<dev string:x1a4a>" );
    assert( isdefined( message ), "<dev string:x5cd>" );
    
    if ( !isdefined( self ) )
    {
        return;
    }
    
    if ( !ent_flag_exist( message ) )
    {
        ent_flag_init( message );
    }
    
    /#
        assert( self.ent_flag[ message ] == self.ent_flags_lock[ message ] );
        self.ent_flags_lock[ message ] = 1;
    #/
    
    self.ent_flag[ message ] = 1;
    self notify( message );
}

// Namespace utility
// Params 2
// Checksum 0x6c387613, Offset: 0x15565
// Size: 0x2d
function ent_flag_set_delayed( message, delay )
{
    self endon( #"death" );
    wait delay;
    ent_flag_set( message );
}

// Namespace utility
// Params 1
// Checksum 0xf8b9b7ea, Offset: 0x1559a
// Size: 0x36
function ent_flag_wait( msg )
{
    assert( isdefined( self ), "<dev string:x1a7e>" );
    
    while ( isdefined( self ) && !ent_flag( msg ) )
    {
        self waittill( msg );
    }
}

// Namespace utility
// Params 1
// Checksum 0x7e763e50, Offset: 0x155d8
// Size: 0x10c
function ent_flag_wait_all_array( flags )
{
    flags = function_5713d46873b29625( flags );
    
    for ( ;; )
    {
        foreach ( flagname in flags )
        {
            ent_flag_wait( flagname );
        }
        
        flagsetcount = 0;
        
        foreach ( flagname in flags )
        {
            if ( ent_flag( flagname ) )
            {
                flagsetcount++;
            }
        }
        
        if ( flagsetcount == flags.size )
        {
            break;
        }
    }
}

// Namespace utility
// Params 2, eflags: 0x40 variadic
// Checksum 0xb8be6ee1, Offset: 0x156ec
// Size: 0x1e
function ent_flag_wait_any( ... )
{
    ent_flag_wait_any_array( vararg );
}

// Namespace utility
// Params 1
// Checksum 0x8aadccce, Offset: 0x15712
// Size: 0xab
function ent_flag_wait_any_array( flags )
{
    flags = function_5713d46873b29625( flags );
    assert( isdefined( self ), "<dev string:x1a7e>" );
    
    while ( isdefined( self ) )
    {
        foreach ( flagname in flags )
        {
            if ( ent_flag( flagname ) )
            {
                return flagname;
            }
        }
        
        waittill_any_in_array( flags );
    }
}

// Namespace utility
// Params 1
// Checksum 0xd2cc2253, Offset: 0x157c5
// Size: 0x14
function function_e2baa5896d5756cc( flags )
{
    return ent_flag_wait_any_array( flags );
}

// Namespace utility
// Params 2
// Checksum 0x7a88703b, Offset: 0x157e2
// Size: 0x6a
function ent_flag_wait_or_timeout( flagname, timer )
{
    assert( isdefined( self ), "<dev string:x1a7e>" );
    start_time = gettime();
    
    while ( isdefined( self ) )
    {
        if ( ent_flag( flagname ) )
        {
            return flagname;
        }
        
        if ( gettime() >= start_time + timer * 1000 )
        {
            return "timeout";
        }
        
        ent_wait_for_flag_or_time_elapses( flagname, timer );
    }
}

// Namespace utility
// Params 1
// Checksum 0x57dbdb1b, Offset: 0x15854
// Size: 0x36
function ent_flag_wait_vehicle_node( msg )
{
    assert( isdefined( self ), "<dev string:x1aad>" );
    
    while ( isdefined( self ) && !ent_flag( msg ) )
    {
        self waittill( msg );
    }
}

// Namespace utility
// Params 1
// Checksum 0xb4150c42, Offset: 0x15892
// Size: 0x10d
function ent_flag_waitopen_all_array( flags )
{
    flags = function_5713d46873b29625( flags );
    
    for ( ;; )
    {
        foreach ( flagname in flags )
        {
            ent_flag_waitopen_any( flagname );
        }
        
        var_617a1ae12383b183 = 0;
        
        foreach ( flagname in flags )
        {
            if ( !ent_flag( flagname ) )
            {
                var_617a1ae12383b183++;
            }
        }
        
        if ( var_617a1ae12383b183 == flags.size )
        {
            break;
        }
    }
}

// Namespace utility
// Params 2, eflags: 0x40 variadic
// Checksum 0xcf125143, Offset: 0x159a7
// Size: 0xb6
function ent_flag_waitopen_any( ... )
{
    assert( isdefined( self ), "<dev string:x1a7e>" );
    
    if ( varargcount != vararg.size )
    {
        return;
    }
    
    while ( isdefined( self ) )
    {
        foreach ( varflag in vararg )
        {
            if ( !ent_flag( varflag ) )
            {
                return;
            }
        }
        
        waittill_any( flat_args( vararg, varargcount ) );
    }
}

// Namespace utility
// Params 1
// Checksum 0x10231acd, Offset: 0x15a65
// Size: 0xaa
function function_63726cf876765909( flags )
{
    flags = function_5713d46873b29625( flags );
    assert( isdefined( self ), "<dev string:x1a7e>" );
    
    while ( isdefined( self ) )
    {
        foreach ( flagname in flags )
        {
            if ( !ent_flag( flagname ) )
            {
                return;
            }
        }
        
        waittill_any_in_array_return( flags );
    }
}

// Namespace utility
// Params 2
// Checksum 0xbaba4a7e, Offset: 0x15b17
// Size: 0x6b
function ent_flag_waitopen_or_timeout( flagname, timer )
{
    assert( isdefined( self ), "<dev string:x1a7e>" );
    start_time = gettime();
    
    while ( isdefined( self ) )
    {
        if ( !ent_flag( flagname ) )
        {
            return flagname;
        }
        
        if ( gettime() >= start_time + timer * 1000 )
        {
            return "timeout";
        }
        
        ent_wait_for_flag_or_time_elapses( flagname, timer );
    }
}

// Namespace utility
// Params 2
// Checksum 0x8aaf65d, Offset: 0x15b8a
// Size: 0x1d
function ent_wait_for_flag_or_time_elapses( flagname, timer )
{
    self endon( flagname );
    wait timer;
}

// Namespace utility
// Params 2
// Checksum 0xa5242d6d, Offset: 0x15baf
// Size: 0x45, Type: bool
function function_92f6c5dd7f8b6166( equipment, attackerteam )
{
    if ( self.team == attackerteam )
    {
        if ( isdefined( self.var_1a61fee8c309f5f3 ) && self.var_1a61fee8c309f5f3[ equipment ] )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace utility
// Params 1
// Checksum 0x6d514ad3, Offset: 0x15bfd
// Size: 0x46
function getplayerpitch( player )
{
    assert( isplayer( player ) );
    playerangles = player getplayerangles();
    assert( isnumber( playerangles[ 0 ] ) );
    return ( playerangles[ 0 ] + 360 ) % 360;
}

// Namespace utility
// Params 0
// Checksum 0x2d9540d1, Offset: 0x15c4c
// Size: 0x8d
function function_68061c3d21a6d57a()
{
    if ( self getstance() == "crouch" )
    {
        center = self.origin + 0.5 * ( 0, 0, 48 );
    }
    else if ( self getstance() == "prone" )
    {
        center = self.origin + 0.5 * ( 0, 0, 20 );
    }
    else
    {
        center = self.origin + 0.5 * ( 0, 0, 64 );
    }
    
    return center;
}

// Namespace utility
// Params 1
// Checksum 0xfe236c76, Offset: 0x15ce2
// Size: 0x98
function function_f02ebab438642e16( stanceoverride )
{
    curstance = self getstance();
    
    if ( isdefined( stanceoverride ) )
    {
        curstance = stanceoverride;
    }
    
    if ( curstance == "crouch" )
    {
        top = self.origin + ( 0, 0, 48 );
    }
    else if ( curstance == "prone" )
    {
        top = self.origin + ( 0, 0, 20 );
    }
    else
    {
        top = self.origin + ( 0, 0, 64 );
    }
    
    return top;
}

// Namespace utility
// Params 1
// Checksum 0x3f89704, Offset: 0x15d83
// Size: 0x2f
function isweaponthrowingknife( weapon )
{
    if ( isdefined( weapon ) && weapon.classname == "throwingknife" )
    {
        return 1;
    }
    
    return 0;
}

// Namespace utility
// Params 4
// Checksum 0x15147f9a, Offset: 0x15dba
// Size: 0x36
function kill_exploder( num, players, radius, origin )
{
    exploder::stop_exploder_proc( num, players, 1, radius, origin );
}

// Namespace utility
// Params 2
// Checksum 0xd939819b, Offset: 0x15df8
// Size: 0xad
function knockback_flat( knockback_direction, knockback_magnitude )
{
    if ( !isdefined( self getgroundentity() ) )
    {
        knockback_magnitude *= 0.5;
        knockback_direction = ( knockback_direction[ 0 ], knockback_direction[ 1 ], 0 );
        
        if ( lengthsquared( knockback_direction ) > 0 )
        {
            knockback_direction = vectornormalize( knockback_direction );
            knockback_direction = ( knockback_direction[ 0 ], knockback_direction[ 1 ], 0.1 );
            self knockback( knockback_direction, knockback_magnitude );
        }
        
        return;
    }
    
    knockback_direction = ( knockback_direction[ 0 ], knockback_direction[ 1 ], max( knockback_direction[ 2 ], 0 ) );
    
    if ( lengthsquared( knockback_direction ) > 0 )
    {
        knockback_direction = vectornormalize( knockback_direction );
        
        if ( knockback_direction[ 2 ] < 0.1 )
        {
            knockback_direction = ( knockback_direction[ 0 ], knockback_direction[ 1 ], 0.1 );
        }
        
        self knockback( knockback_direction, knockback_magnitude );
    }
}

// Namespace utility
// Params 4
// Checksum 0x555ac506, Offset: 0x15ead
// Size: 0x118
function function_31522db4303bffeb( notename, endonnotify, custom_func, flagname )
{
    self endon( #"death" );
    
    if ( isdefined( endonnotify ) )
    {
        self endon( endonnotify );
    }
    
    if ( !isdefined( flagname ) )
    {
        flagname = self asmgetcurrentstate( self.asmname );
    }
    
    while ( true )
    {
        self waittill( flagname, notetracks );
        b_ended = 0;
        
        if ( isarray( notetracks ) )
        {
            foreach ( note in notetracks )
            {
                if ( notename == note )
                {
                    if ( isdefined( custom_func ) )
                    {
                        self [[ custom_func ]]();
                    }
                    else
                    {
                        return 1;
                    }
                }
                
                if ( note == "end" )
                {
                    b_ended = 1;
                }
            }
        }
        
        if ( b_ended )
        {
            return 1;
        }
    }
}

// Namespace utility
// Params 1
// Checksum 0xcacead33, Offset: 0x15fcd
// Size: 0x21
function flat_angle( angle )
{
    rangle = ( 0, angle[ 1 ], 0 );
    return rangle;
}

// Namespace utility
// Params 1
// Checksum 0xc3734836, Offset: 0x15ff7
// Size: 0x23
function flat_origin( org )
{
    rorg = ( org[ 0 ], org[ 1 ], 0 );
    return rorg;
}

// Namespace utility
// Params 2
// Checksum 0x4b6ee7da, Offset: 0x16023
// Size: 0x48
function flatten_vector( var_88d7b9388f725cee, up_vector = ( 0, 0, 1 ) )
{
    flat_vec = vectornormalize( var_88d7b9388f725cee - vectordot( up_vector, var_88d7b9388f725cee ) * up_vector );
    return flat_vec;
}

// Namespace utility
// Params 7
// Checksum 0x18cfdd37, Offset: 0x16074
// Size: 0x190
function function_8001268940441423( start_pos, end_pos, control_pos, time, b_draw_path = 0, var_1f8d817fb854c814 = 0, path_percent = 1 )
{
    self endon( #"death" );
    self endon( #"off_bezier_curve" );
    
    if ( !isdefined( b_draw_path ) )
    {
        b_draw_path = 0;
    }
    
    start_point = start_pos;
    end_point = end_pos;
    var_1f8d817fb854c814 = path_percent >= 1 ? var_1f8d817fb854c814 : 1;
    control_point = control_pos;
    t = 0;
    move_start = gettime();
    self notify( #"on_bezier_curve" );
    
    while ( true )
    {
        if ( !isdefined( self ) )
        {
            return;
        }
        
        t = ( gettime() - move_start ) / 1000 / time;
        
        if ( t <= path_percent )
        {
            /#
                oldpos = self.origin;
            #/
            
            position = get_bezier_position( t, start_point, end_point, control_point );
            self.origin = position;
            
            /#
                if ( b_draw_path )
                {
                    thread draw_line_for_time( self.origin, oldpos, 1, 1, 1, time * 10 );
                }
            #/
        }
        else if ( !var_1f8d817fb854c814 )
        {
            self moveto( end_point, 0.25 );
            wait 0.25;
            break;
        }
        else
        {
            break;
        }
        
        waitframe();
    }
    
    if ( isdefined( self ) )
    {
        self notify( #"off_bezier_curve" );
    }
}

// Namespace utility
// Params 1
// Checksum 0xe38d484e, Offset: 0x1620c
// Size: 0xa6
function function_27490c47d34088c8( vector )
{
    assert( is_partition(), "<dev string:x1ae4>" );
    assert( isdefined( vector ), "<dev string:x1b48>" );
    assert( isvector( vector ), "<dev string:x1b7e>" );
    [ x, y ] = function_890559684b1ecb60( vector );
    test_array_x = self.array[ x ];
    
    if ( isdefined( test_array_x ) )
    {
        var_1e8357156b843e8b = test_array_x[ y ];
        
        if ( isdefined( var_1e8357156b843e8b ) )
        {
            return var_1e8357156b843e8b;
        }
    }
    
    return [];
}

// Namespace utility
// Params 7
// Checksum 0x7d6fb7bb, Offset: 0x162bb
// Size: 0x228
function get_array_of_closest( org, array, excluders = [], max = array.size, maxdist, mindist, reversesort = 0 )
{
    maxdist2rd = undefined;
    
    if ( isdefined( maxdist ) )
    {
        maxdist2rd = maxdist * maxdist;
    }
    
    mindist2rd = 0;
    
    if ( isdefined( mindist ) )
    {
        mindist2rd = mindist * mindist;
    }
    
    if ( excluders.size == 0 && max >= array.size && mindist2rd == 0 && !isdefined( maxdist2rd ) )
    {
        return sortbydistance( array, org );
    }
    
    newarray = [];
    
    foreach ( ent in array )
    {
        excluded = 0;
        
        foreach ( excluder in excluders )
        {
            if ( ent == excluder )
            {
                excluded = 1;
                break;
            }
        }
        
        if ( excluded )
        {
            continue;
        }
        
        dist2rd = distancesquared( org, ent.origin );
        
        if ( dist2rd > maxdist2rd )
        {
            continue;
        }
        
        if ( dist2rd < mindist2rd )
        {
            continue;
        }
        
        newarray[ newarray.size ] = ent;
    }
    
    newarray = sortbydistance( newarray, org, reversesort );
    
    if ( max >= newarray.size )
    {
        return newarray;
    }
    
    finalarray = [];
    
    for ( i = 0; i < max ; i++ )
    {
        finalarray[ i ] = newarray[ i ];
    }
    
    return finalarray;
}

// Namespace utility
// Params 6
// Checksum 0x8f3db15c, Offset: 0x164ec
// Size: 0x5d
function get_array_of_farthest( org, array, excluders, max, maxdist, mindist )
{
    aarray = get_array_of_closest( org, array, excluders, max, maxdist, mindist );
    aarray = arrayreverse( aarray );
    return aarray;
}

// Namespace utility
// Params 6
// Checksum 0x28491064, Offset: 0x16552
// Size: 0x1f5
function get_average_ground_normal( pos, radius, updist, downdist, contents, ignore )
{
    if ( radius > 0 )
    {
        var_b68d1df76508aa6d = updist ?? radius * 1.5;
        var_88ff8c0db423fe86 = downdist ?? radius * 1.5;
        var_2ca03b238f7182e2 = get_ground_positions( pos, ( 1, 0, 0 ), radius, var_b68d1df76508aa6d, var_88ff8c0db423fe86, contents, ignore );
        
        if ( isdefined( var_2ca03b238f7182e2 ) && var_2ca03b238f7182e2.pos_a != var_2ca03b238f7182e2.pos_b )
        {
            var_c22efd30c9a0630d = get_ground_positions( pos, ( 0, 1, 0 ), radius, var_b68d1df76508aa6d, var_88ff8c0db423fe86, contents, ignore );
            
            if ( isdefined( var_c22efd30c9a0630d ) && var_c22efd30c9a0630d.pos_a != var_c22efd30c9a0630d.pos_b )
            {
                x_ground = var_2ca03b238f7182e2.pos_a - var_2ca03b238f7182e2.pos_b;
                y_ground = var_c22efd30c9a0630d.pos_a - var_c22efd30c9a0630d.pos_b;
                ground_normal = vectornormalize( vectorcross( x_ground, y_ground ) );
                min_dist_sqr = squared( radius );
                dist_sqr = distancesquared( pos, var_2ca03b238f7182e2.pos_a );
                
                if ( dist_sqr < min_dist_sqr )
                {
                    min_dist_sqr = dist_sqr;
                }
                
                dist_sqr = distancesquared( pos, var_2ca03b238f7182e2.pos_b );
                
                if ( dist_sqr < min_dist_sqr )
                {
                    min_dist_sqr = dist_sqr;
                }
                
                dist_sqr = distancesquared( pos, var_c22efd30c9a0630d.pos_a );
                
                if ( dist_sqr < min_dist_sqr )
                {
                    min_dist_sqr = dist_sqr;
                }
                
                dist_sqr = distancesquared( pos, var_c22efd30c9a0630d.pos_b );
                
                if ( dist_sqr < min_dist_sqr )
                {
                    min_dist_sqr = dist_sqr;
                }
                
                return ground_normal;
            }
        }
    }
    
    return ( 0, 0, 0 );
}

// Namespace utility
// Params 4
// Checksum 0xd65571ac, Offset: 0x16750
// Size: 0xca
function get_bezier_position( t, start_point, end_point, control_point )
{
    op1 = pow( 1 - t, 2 );
    op2 = 2 * ( 1 - t ) * t;
    op3 = pow( t, 2 );
    xdest = op1 * start_point[ 0 ] + op2 * control_point[ 0 ] + op3 * end_point[ 0 ];
    ydest = op1 * start_point[ 1 ] + op2 * control_point[ 1 ] + op3 * end_point[ 1 ];
    zdest = op1 * start_point[ 2 ] + op2 * control_point[ 2 ] + op3 * end_point[ 2 ];
    return ( xdest, ydest, zdest );
}

// Namespace utility
// Params 8
// Checksum 0x7e685a96, Offset: 0x16823
// Size: 0x2e3
function function_2159dd4196ff4b81( path_array, time_s, b_update_angles = 0, var_360d3f0890420a2 = 0, var_dde09f95e982c945 = 0, smoothness = 0.5, path_accuracy = 0.5, b_draw_path = 0 )
{
    self endon( #"death" );
    self endon( #"stop_curve" );
    
    if ( path_array.size < 4 )
    {
        if ( var_dde09f95e982c945 )
        {
            if ( path_array.size == 3 )
            {
                function_8001268940441423( path_array[ 0 ], path_array[ 2 ], path_array[ 1 ], time_s, b_draw_path, 1 );
            }
            else if ( path_array.size == 2 )
            {
                function_8001268940441423( path_array[ 0 ], path_array[ 1 ], averagepoint( path_array ), time_s, b_draw_path, 1 );
            }
        }
        
        assert( var_dde09f95e982c945, "<dev string:x1bc6>" + path_array.size + "<dev string:x1c0b>" );
        return;
    }
    
    total_dist = 0;
    point_i = 1;
    
    while ( point_i < path_array.size )
    {
        total_dist += distance( path_array[ point_i - 1 ], path_array[ point_i ] );
        point_i += 1;
    }
    
    times = [];
    point_i = 1;
    
    while ( point_i < path_array.size )
    {
        times[ times.size ] = max( distance( path_array[ point_i - 1 ], path_array[ point_i ] ) / total_dist * time_s, 0.005 );
        point_i += 1;
    }
    
    times[ times.size ] = level.framedurationseconds;
    tension = clamp( 1 - smoothness, 0.01, 1 );
    alpha = clamp( path_accuracy, 0, 1 );
    splineid = function_53253e8ea222ed60( path_array, times, 0, tension, alpha, 1 );
    total_dist = function_176ae9ba12543764( splineid );
    var_c6b13c5ef8b9d064 = total_dist / time_s * level.framedurationseconds;
    thread function_8f5da7eab375e74a( splineid );
    
    if ( b_draw_path )
    {
        childthread function_9f777c9a7fffb9fc( splineid, time_s, "stop_curve" );
    }
    
    self notify( #"catmull_rom_spline_info", times );
    current_time = 0;
    
    while ( current_time < time_s )
    {
        self.origin = function_2bf2352736fc6ac8( splineid, current_time );
        
        if ( b_update_angles )
        {
            self.angles = function_7062a9ae37ef4c8b( splineid, current_time );
        }
        
        if ( self.var_b5c0b70f2fd5945d )
        {
            waitframe();
            continue;
        }
        
        var_7caa456cd0d56d85 = 1;
        
        if ( isdefined( self.var_3b0701f0112a13fe ) )
        {
            var_7caa456cd0d56d85 = self.var_3b0701f0112a13fe;
        }
        
        if ( !var_360d3f0890420a2 )
        {
            delta = function_b9f720559b798d98( splineid, current_time, var_c6b13c5ef8b9d064 * var_7caa456cd0d56d85 );
            current_time += delta;
        }
        else
        {
            current_time += level.framedurationseconds * var_7caa456cd0d56d85;
        }
        
        current_time = max( current_time, 0 );
        waitframe();
    }
    
    self notify( #"stop_curve" );
}

// Namespace utility
// Params 1, eflags: 0x4
// Checksum 0xdf89b2da, Offset: 0x16b0e
// Size: 0x24
function private function_8f5da7eab375e74a( splineid )
{
    waittill_any( "stop_curve", "death" );
    spline_destroy( splineid );
}

// Namespace utility
// Params 12
// Checksum 0xdcc68674, Offset: 0x16b3a
// Size: 0x44d
function follow_spiral( n_radius_start, n_radius_end, v_direction, var_173cd3809239740b, time, center_or_ent, n_circles = 1, var_d9c29a33943ff7f4, f_starting_offset, var_dd6a0bb33e7b5b39, f_accel_time = 0, f_decel_time = 0 )
{
    level endon( #"game_ended" );
    self endon( #"death" );
    self endon( #"hash_2da5abc0d9cf41ac" );
    assert( time > 0, "<dev string:x1c46>" );
    assert( isdefined( center_or_ent ), "<dev string:x1c5e>" );
    assert( f_accel_time >= 0 && f_decel_time >= 0, "<dev string:x1c7f>" );
    assert( f_accel_time <= time && f_decel_time <= time, "<dev string:x1cb3>" );
    assert( f_accel_time + f_decel_time <= time, "<dev string:x1ce4>" );
    
    if ( var_d9c29a33943ff7f4 )
    {
        var_3149dd17ad5bfa89 = n_radius_start >= 0 && n_radius_end >= 0 || n_radius_start <= 0 && n_radius_end <= 0;
        assert( var_3149dd17ad5bfa89, "<dev string:x1d1c>" );
        n_radius_start *= -1;
        n_radius_end *= -1;
    }
    
    t = 0;
    
    if ( !isdefined( n_radius_end ) )
    {
        n_radius_end = n_radius_start;
    }
    
    move_start = gettime() / 1000;
    start_origin = self.origin;
    var_eaae957b57dffaf9 = f_accel_time > 0 || f_decel_time > 0;
    ease_speed_factor = var_eaae957b57dffaf9 ? 1 / ( 1 - 0.5 * f_accel_time / time - 0.5 * f_decel_time / time ) : 1;
    var_b88c722483fe7ee0 = time - f_decel_time;
    var_42425954b634f66f = 0;
    prev_t = 0;
    
    if ( !var_dd6a0bb33e7b5b39 )
    {
        self notify( #"hash_63c37028d5d0eecc" );
    }
    
    radius = n_radius_start;
    new_origin = start_origin;
    
    if ( !isvector( center_or_ent ) )
    {
        center_or_ent endon( #"death" );
        center = center_or_ent.origin;
        var_84d3d4a079c414ef = 1;
    }
    else
    {
        center = center_or_ent;
    }
    
    if ( !isdefined( f_starting_offset ) )
    {
        f_starting_offset = vectortoangles( self.origin - center )[ 1 ];
    }
    else
    {
        self dontinterpolate();
    }
    
    t = 0;
    
    while ( t < 1 )
    {
        if ( !isdefined( center_or_ent ) )
        {
            break;
        }
        
        if ( var_84d3d4a079c414ef )
        {
            center = center_or_ent.origin;
        }
        
        current_time = gettime() / 1000;
        
        if ( var_dd6a0bb33e7b5b39 )
        {
            current_time = gettime() + getframeduration();
            current_time /= 1000;
        }
        
        time_elapsed = current_time - move_start;
        t = time_elapsed / time;
        
        if ( var_eaae957b57dffaf9 )
        {
            if ( f_accel_time > 0 && time_elapsed <= f_accel_time )
            {
                speed_scalar = time_elapsed / f_accel_time;
            }
            else if ( f_decel_time > 0 && time_elapsed >= var_b88c722483fe7ee0 )
            {
                speed_scalar = 1 - ( time_elapsed - var_b88c722483fe7ee0 ) / f_decel_time;
            }
            else
            {
                speed_scalar = 1;
            }
            
            delta_t = t - prev_t;
            var_42425954b634f66f += speed_scalar * ease_speed_factor * delta_t;
            var_42425954b634f66f = var_42425954b634f66f > 1 ? 1 : var_42425954b634f66f;
            prev_t = t;
        }
        else
        {
            var_42425954b634f66f = t;
        }
        
        theta = n_circles * 360 * var_42425954b634f66f + f_starting_offset;
        radius = ( n_radius_end - n_radius_start ) * var_42425954b634f66f + n_radius_start;
        dist_offset = var_173cd3809239740b * var_42425954b634f66f;
        xdest = center[ 0 ] + cos( theta ) * radius;
        ydest = center[ 1 ] + sin( theta ) * radius;
        new_origin = ( xdest, ydest, start_origin[ 2 ] ) + v_direction * dist_offset;
        
        if ( var_dd6a0bb33e7b5b39 )
        {
            return { #start_angles:( 0, vectortoyaw( center - new_origin ), 0 ), #start_origin:new_origin };
        }
        
        self.origin = new_origin;
        self.angles = ( 0, vectortoyaw( center - new_origin ), 0 );
        waitframe();
    }
    
    if ( isdefined( self ) )
    {
        self notify( #"hash_9c0549daadae126" );
    }
}

// Namespace utility
// Params 9
// Checksum 0x1a03a981, Offset: 0x16f8f
// Size: 0x71
function function_77b600fb391fda42( n_radius_start, n_radius_end, v_direction, var_173cd3809239740b, time, center_or_ent, n_circles = 1, var_d9c29a33943ff7f4, f_starting_offset )
{
    return follow_spiral( n_radius_start, n_radius_end, v_direction, var_173cd3809239740b, time, center_or_ent, n_circles, var_d9c29a33943ff7f4, f_starting_offset, 1 );
}

// Namespace utility
// Params 5
// Checksum 0xe2656183, Offset: 0x17009
// Size: 0x356
function function_24215250530eaebc( start_position, end_position, effect_trail, effect_impact, soundstruct )
{
    level endon( #"game_ended" );
    assert( isdefined( effect_trail ), "<dev string:x1d68>" );
    vfx_root = spawn_model( "tag_origin", start_position, vectortoangles( end_position - start_position ) );
    vfx_end = spawn_model( "tag_origin", end_position );
    playfxontag( effect_trail, vfx_root, "tag_origin" );
    
    if ( soundstruct.var_deac89db5aa6990a )
    {
        vfx_root playsoundonmovingent( soundstruct.var_deac89db5aa6990a );
    }
    
    if ( soundstruct.var_8bee59e397c66fa0 )
    {
        vfx_root playloopsound( soundstruct.var_8bee59e397c66fa0 );
    }
    
    vfx_root endon( #"death" );
    vfx_root endon( #"entitydeleted" );
    var_4f58ae3108177d2c = distance( start_position, end_position );
    var_36340753cb0e64d5 = var_4f58ae3108177d2c / 10;
    speed = 150 * var_36340753cb0e64d5 + 100;
    speed += randomfloatrange( -1 * speed * 0.2 / 2, speed * 0.2 / 2 );
    speed = clamp( speed, 100, 250 );
    duration = var_4f58ae3108177d2c / speed;
    vfx_root thread delete_after_delay( duration + level.framedurationseconds );
    vfx_end thread delete_after_delay( duration + level.framedurationseconds );
    start_timestamp = gettime();
    current_timestamp = start_timestamp;
    spiral_seed = randomint( 360 );
    spiral_frequency = randomfloatrange( 3, 4 );
    spiral_magnitude = randomintrange( 25, 35 );
    var_37b66bef2ccb4209 = start_position[ 2 ] - end_position[ 2 ];
    
    if ( var_37b66bef2ccb4209 < 12 )
    {
        target_z_offset = randomintrange( 4, 12 ) + var_37b66bef2ccb4209 / 2;
    }
    else if ( var_37b66bef2ccb4209 < 24 )
    {
        target_z_offset = randomintrange( 0, 4 ) + var_37b66bef2ccb4209 / 2;
    }
    else
    {
        target_z_offset = randomintrange( -4, 0 ) + var_37b66bef2ccb4209 / 2;
    }
    
    lerp_value = 0;
    
    while ( lerp_value < 1 )
    {
        current_timestamp = gettime();
        lerp_spiral_magnitude = sin( lerp_value * 180 ) * spiral_magnitude;
        spiral_angle = spiral_seed + spiral_frequency * lerp_value * 180;
        var_83b5f6ccc840848e = rotatepointaroundvector( anglestoforward( vfx_root.angles ), lerp_spiral_magnitude * anglestoright( vfx_root.angles ), spiral_angle );
        v_z_offset = ( 0, 0, target_z_offset * sin( lerp_value * 180 + sin( lerp_value * 180 ) / -1 ) );
        target_position = vectorlerp( start_position, end_position, lerp_value ) + v_z_offset + var_83b5f6ccc840848e;
        vfx_root.origin = target_position;
        lerp_value = pow( ( current_timestamp - start_timestamp ) / 1000 / duration, 1.25 );
        waitframe();
    }
    
    if ( soundstruct.endalias )
    {
        playworldsound( vfx_end.origin, soundstruct.endalias );
    }
    
    if ( effect_impact )
    {
        playfxontag( effect_impact, vfx_end, "tag_origin" );
    }
    
    vfx_root delete();
    vfx_end delete();
}

// Namespace utility
// Params 8
// Checksum 0xf15df8a4, Offset: 0x17367
// Size: 0x21a
function follow_circle( radius, time, center_or_ent, n_circles = 1, angle_rotation = undefined, b_drop_to_ground = 0, v_ground_offset = ( 0, 0, 0 ), var_8e2930b290631731 )
{
    self endon( #"death" );
    self endon( #"interrupt_circle_move" );
    assert( isdefined( center_or_ent ), "<dev string:x1c5e>" );
    t = 0;
    move_start = gettime();
    new_origin = self.origin;
    self notify( #"on_circle_move" );
    
    if ( !isvector( center_or_ent ) )
    {
        center_or_ent endon( #"death" );
        center = center_or_ent.origin;
        var_84d3d4a079c414ef = 1;
    }
    else
    {
        center = center_or_ent;
    }
    
    if ( !isdefined( var_8e2930b290631731 ) )
    {
        var_8e2930b290631731 = vectortoangles( self.origin - center )[ 1 ];
    }
    else
    {
        self dontinterpolate();
    }
    
    while ( true )
    {
        t = ( gettime() - move_start ) / 1000 / time;
        
        if ( t <= 1 )
        {
            theta = n_circles * 360 * t + var_8e2930b290631731;
            
            if ( !isdefined( center_or_ent ) )
            {
                break;
            }
            
            if ( var_84d3d4a079c414ef )
            {
                center = center_or_ent.origin;
            }
            
            xdest = center[ 0 ] + cos( theta ) * radius;
            ydest = center[ 1 ] + sin( theta ) * radius;
            new_origin = ( xdest, ydest, center[ 2 ] );
            
            if ( isdefined( angle_rotation ) )
            {
                offset_horizontal = new_origin - center;
                new_origin = coordtransform( offset_horizontal, center, angle_rotation );
            }
            
            if ( b_drop_to_ground )
            {
                new_origin = getgroundposition( new_origin, 1 ) + v_ground_offset;
            }
            
            self.origin = new_origin;
        }
        else
        {
            break;
        }
        
        t = undefined;
        waitframe();
    }
    
    self notify( #"off_circle_move" );
}

// Namespace utility
// Params 2
// Checksum 0x89af4ad5, Offset: 0x17589
// Size: 0x7b
function do_earthquake( name, origin )
{
    eq = level.earthquake[ name ];
    earthquake( eq[ "magnitude" ], eq[ "duration" ], origin, eq[ "radius" ] );
    
    if ( isdefined( level.var_2d9450b396fc7d4d ) )
    {
        level thread [[ level.var_2d9450b396fc7d4d ]]( name, origin, eq[ "magnitude" ], eq[ "duration" ], eq[ "radius" ] );
    }
}

// Namespace utility
// Params 5
// Checksum 0x57fe920e, Offset: 0x1760c
// Size: 0x20d
function do_jitter( jitter_strength, time, ease_in_time = 0, ease_out_time = 0, var_ac383f6cb16b057e = 1 )
{
    self notify( #"hash_f9af0a6cab2a0700" );
    self endon( #"hash_f9af0a6cab2a0700" );
    assert( isent( self ), "<dev string:x1d97>" );
    assert( jitter_strength, "<dev string:x1dbc>" );
    assert( time, "<dev string:x1de7>" );
    assert( ease_in_time >= 0 && ease_out_time >= 0, "<dev string:x1e07>" );
    assert( ease_in_time <= time && ease_out_time <= time, "<dev string:x1e44>" );
    assert( ease_in_time + ease_out_time <= time, "<dev string:x1e80>" );
    self endon( #"death" );
    starting_pos = self.origin;
    time_elapsed = 0;
    start_time = gettime();
    
    if ( ease_out_time )
    {
        var_1857b3565a469497 = time - ease_out_time;
    }
    
    while ( time_elapsed <= time )
    {
        if ( ease_in_time && time_elapsed <= ease_in_time )
        {
            pct = time_elapsed / ease_in_time;
            jitter_scalar = pct * jitter_strength;
        }
        else if ( ease_out_time && time_elapsed >= time - ease_out_time )
        {
            pct = 1 - ( time_elapsed - var_1857b3565a469497 ) / ease_out_time;
            jitter_scalar = pct * jitter_strength;
        }
        else
        {
            jitter_scalar = jitter_strength;
        }
        
        new_pos = starting_pos + ( randomfloatrange( -1, 1 ) * jitter_scalar, randomfloatrange( -1, 1 ) * jitter_scalar, randomfloatrange( -1, 1 ) * jitter_scalar );
        self moveto( new_pos, level.framedurationseconds );
        self waittill( #"movedone" );
        time_elapsed = function_6f5d2e1f1ff70482( gettime() - start_time );
    }
    
    if ( var_ac383f6cb16b057e )
    {
        self moveto( starting_pos, level.framedurationseconds );
        self waittill( #"movedone" );
    }
    
    self notify( #"jitterdone" );
}

// Namespace utility
// Params 1
// Checksum 0x72d534bf, Offset: 0x17821
// Size: 0x1e
function function_bed40b09860f8227( enabled )
{
    function_d5a54acde3e473ca( enabled );
    function_232160414793eaa0( enabled );
}

// Namespace utility
// Params 1
// Checksum 0x59896c78, Offset: 0x17847
// Size: 0x30
function function_d5a54acde3e473ca( enabled )
{
    self allowmovement( !enabled );
    self allowprone( !enabled );
    self allowjump( !enabled );
    self allowmelee( !enabled );
}

// Namespace utility
// Params 1
// Checksum 0xc9f1db91, Offset: 0x1787f
// Size: 0x33
function function_c13d09bc414864cb( enabled )
{
    self allowfire( !enabled );
    self allowads( !enabled );
    
    if ( !enabled )
    {
        self enableoffhandweapons();
        return;
    }
    
    self disableoffhandweapons();
}

// Namespace utility
// Params 1
// Checksum 0x9c35b025, Offset: 0x178ba
// Size: 0x1c
function function_232160414793eaa0( enabled )
{
    self freezecontrols( enabled );
    self freezelookcontrols( enabled );
}

// Namespace utility
// Params 2
// Checksum 0xb0bc3873, Offset: 0x178de
// Size: 0x50
function get_bit_flag( storage_int, flag_index )
{
    assert( flag_index >= 0 && flag_index <= 30, "<dev string:x76e>" );
    flag = ( storage_int & 1 << flag_index ) > 0 ? 1 : 0;
    return flag;
}

// Namespace utility
// Params 1
// Checksum 0x20176c6e, Offset: 0x17937
// Size: 0x53
function function_c73b75a176f26cf6( flag_index )
{
    assert( isint( flag_index ), "<dev string:x1ebf>" );
    storageindex = function_9ab002313e87d84c( flag_index );
    
    if ( !isdefined( storageindex ) )
    {
        return;
    }
    
    index = flag_index - 30 * storageindex;
    return int( index );
}

// Namespace utility
// Params 1
// Checksum 0x31e56bb8, Offset: 0x17993
// Size: 0x56
function function_9ab002313e87d84c( flag_index )
{
    assert( isint( flag_index ), "<dev string:x1ebf>" );
    b_max_index = flag_index % 30 == 0;
    
    if ( b_max_index )
    {
        storageindex = flag_index / 30;
    }
    else
    {
        storageindex = int( flag_index / 30 );
    }
    
    return storageindex;
}

// Namespace utility
// Params 4
// Checksum 0x80a000e7, Offset: 0x179f2
// Size: 0x10f
function get_closest_filtered( org, array, max_dist, filter )
{
    closest_ent = undefined;
    closest_dist_sqr = isdefined( max_dist ) ? squared( max_dist ) : undefined;
    
    foreach ( ent in array )
    {
        if ( !isdefined( ent.origin ) )
        {
            continue;
        }
        
        if ( isdefined( filter ) && ![[ filter ]]( ent ) )
        {
            continue;
        }
        
        dist_sqr = distancesquared( ent.origin, org );
        
        if ( !isdefined( closest_dist_sqr ) || dist_sqr < closest_dist_sqr )
        {
            closest_ent = ent;
            closest_dist_sqr = dist_sqr;
        }
    }
    
    return closest_ent;
}

// Namespace utility
// Params 1
// Checksum 0x678574d6, Offset: 0x17b0a
// Size: 0x1d8
function function_93d8eea713f8560d( vector )
{
    assert( is_partition(), "<dev string:x1edf>" );
    assert( isdefined( vector ), "<dev string:x1f54>" );
    assert( isvector( vector ), "<dev string:x1f9a>" );
    [ x, y ] = function_890559684b1ecb60( vector );
    closest_object = undefined;
    closest_distance_squared = undefined;
    
    for ( x_offset = -1; x_offset <= 1 ; x_offset++ )
    {
        x_test = x + x_offset;
        
        if ( x_test < 0 )
        {
            continue;
        }
        
        test_array_x = self.array[ x_test ];
        
        if ( !isdefined( test_array_x ) )
        {
            continue;
        }
        
        for ( y_offset = -1; y_offset <= 1 ; y_offset++ )
        {
            y_test = y + y_offset;
            
            if ( y_test < 0 )
            {
                continue;
            }
            
            var_1e8357156b843e8b = test_array_x[ y_test ];
            
            if ( !isdefined( var_1e8357156b843e8b ) )
            {
                continue;
            }
            
            foreach ( object in var_1e8357156b843e8b )
            {
                if ( !( isdefined( object ) && isdefined( object.origin ) ) )
                {
                    continue;
                }
                
                distance_squared = distancesquared( object.origin, vector );
                
                if ( !isdefined( closest_distance_squared ) || distance_squared < closest_distance_squared )
                {
                    closest_distance_squared = distance_squared;
                    closest_object = object;
                }
            }
        }
    }
    
    return closest_object;
}

// Namespace utility
// Params 1
// Checksum 0x734507e0, Offset: 0x17ceb
// Size: 0x10f
function get_closest_player( needenemyplayer = 0 )
{
    closestplayer = undefined;
    closestdistsq = undefined;
    
    foreach ( player in level.players )
    {
        if ( player == self || !isalive( player ) )
        {
            continue;
        }
        
        if ( needenemyplayer && !isenemyteam( self.team, player.team ) )
        {
            continue;
        }
        
        distsq = distancesquared( self.origin, player.origin );
        
        if ( !isdefined( closestdistsq ) || distsq < closestdistsq )
        {
            closestdistsq = distsq;
            closestplayer = player;
        }
    }
    
    return closestplayer;
}

// Namespace utility
// Params 2
// Checksum 0x9f2d2bc7, Offset: 0x17e03
// Size: 0x33
function get_create_script_prefix( expected_string, compare )
{
    if ( isdefined( compare ) && isdefined( expected_string ) )
    {
        if ( issubstr( compare, expected_string ) )
        {
            return removesubstr( compare, expected_string );
        }
    }
}

// Namespace utility
// Params 1
// Checksum 0xd65142b3, Offset: 0x17e3e
// Size: 0xd1
function get_scripted_weapon_name( basenamehash )
{
    if ( !isdefined( level.var_363840efc0e8a5a0 ) )
    {
        if ( isdefined( level.gamemodebundle ) )
        {
            bundlename = level.gamemodebundle.scriptedweapon_list;
            assert( isdefined( bundlename ) );
            bundle = getscriptbundle( bundlename );
            level.var_363840efc0e8a5a0 = bundle.scriptedweapon_list;
        }
    }
    
    if ( isdefined( level.sharedfuncs[ basenamehash ][ #"overrideweaponname" ] ) )
    {
        overrideweaponname = self [[ level.sharedfuncs[ basenamehash ][ #"overrideweaponname" ] ]]();
        
        if ( isdefined( overrideweaponname ) )
        {
            return overrideweaponname;
        }
    }
    
    return level.var_363840efc0e8a5a0[ basenamehash ].weaponref;
}

// Namespace utility
// Params 2
// Checksum 0x50989f66, Offset: 0x17f18
// Size: 0xaf, Type: bool
function function_73b3c68eaac7c8ff( string, a_substr )
{
    if ( !( isdefined( string ) && isdefined( a_substr ) ) )
    {
        return false;
    }
    
    if ( !isarray( a_substr ) )
    {
        a_substr = [ a_substr ];
    }
    
    foreach ( substr in a_substr )
    {
        if ( !issubstr( string, substr ) )
        {
            return false;
        }
    }
    
    return true;
}

// Namespace utility
// Params 3
// Checksum 0xe7e9b091, Offset: 0x17fd0
// Size: 0x255, Type: bool
function function_acf9ef4af2fd3dea( origin, radius, usesphere = 1 )
{
    assert( is_partition(), "<dev string:x1ff3>" );
    assert( isdefined( origin ), "<dev string:x205b>" );
    assert( isvector( origin ), "<dev string:x2094>" );
    assert( isdefined( radius ), "<dev string:x20ed>" );
    assert( isnumber( radius ), "<dev string:x2126>" );
    assert( !isdefined( usesphere ) || isnumber( usesphere ) && usesphere == 1 || usesphere == 0, "<dev string:x217e>" );
    var_25a0fba0031a1a69 = int( ceil( radius / self.cell_size ) );
    [ x, y ] = function_890559684b1ecb60( origin );
    radius_squared = radius * radius;
    
    for ( x_offset = var_25a0fba0031a1a69 * -1; x_offset <= var_25a0fba0031a1a69 ; x_offset++ )
    {
        x_test = x + x_offset;
        
        if ( x_test < 0 )
        {
            continue;
        }
        
        x_array = self.array[ x_test ];
        
        if ( !isdefined( x_array ) )
        {
            continue;
        }
        
        for ( y_offset = var_25a0fba0031a1a69 * -1; y_offset <= var_25a0fba0031a1a69 ; y_offset++ )
        {
            y_test = y + y_offset;
            
            if ( y_test < 0 )
            {
                continue;
            }
            
            x_y_array = x_array[ y_test ];
            
            if ( !isdefined( x_y_array ) )
            {
                continue;
            }
            
            foreach ( object in x_y_array )
            {
                if ( usesphere && distancesquared( object.origin, origin ) < radius_squared )
                {
                    return true;
                }
                
                if ( usesphere == 0 && distance2dsquared( object.origin, origin ) < radius_squared )
                {
                    return true;
                }
            }
        }
    }
    
    return false;
}

// Namespace utility
// Params 2
// Checksum 0xb5578c2b, Offset: 0x1822e
// Size: 0xae, Type: bool
function function_630b286cb07bd032( string, a_substr )
{
    if ( !( isdefined( string ) && isdefined( a_substr ) ) )
    {
        return false;
    }
    
    if ( !isarray( a_substr ) )
    {
        a_substr = [ a_substr ];
    }
    
    foreach ( substr in a_substr )
    {
        if ( issubstr( string, substr ) )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace utility
// Params 3
// Checksum 0x5edf55a2, Offset: 0x182e5
// Size: 0x8d, Type: bool
function function_af749a6c1f8241f0( ent, lookatpoint, anglethreshold = 90 )
{
    entforward = anglestoforward( ent.angles );
    
    if ( isplayer( ent ) )
    {
        entforward = anglestoforward( ent getplayerangles() );
    }
    
    enttopoint = lookatpoint - ent.origin;
    anglediff = math::anglebetweenvectors( entforward, enttopoint );
    
    if ( anglediff <= anglethreshold )
    {
        return true;
    }
    
    return false;
}

// Namespace utility
// Params 5
// Checksum 0x99729452, Offset: 0x1837b
// Size: 0xab, Type: bool
function function_476c996eed246db( ent, lookatpoint, duration, anglethreshold = 90, waitinterval = 0.5 )
{
    level endon( #"game_ended" );
    ent endon( #"death" );
    numloops = floor( duration / waitinterval );
    
    for ( i = 0; i < numloops ; i++ )
    {
        lookingatpoint = function_af749a6c1f8241f0( ent, lookatpoint, anglethreshold );
        
        if ( !lookingatpoint )
        {
            return false;
        }
        
        wait waitinterval;
    }
    
    return true;
}

// Namespace utility
// Params 3
// Checksum 0x84a6c57f, Offset: 0x1842f
// Size: 0x49
function getent_or_struct( name, key, ignore_spawners )
{
    var_7237854e3be197ca = getent( name, key, ignore_spawners ?? 0 );
    
    if ( isdefined( var_7237854e3be197ca ) )
    {
        return var_7237854e3be197ca;
    }
    
    return getstruct( name, key );
}

// Namespace utility
// Params 3
// Checksum 0x7b87216c, Offset: 0x18481
// Size: 0x57
function getent_or_struct_array( name, key, ignore_spawners )
{
    ents = getentarray( name, key, ignore_spawners ?? 0 );
    
    if ( isdefined( level.struct_class_names ) )
    {
        ents = arraycombine( ents, getstructarray( name, key ) );
    }
    
    return ents;
}

// Namespace utility
// Params 1
// Checksum 0x41159b1c, Offset: 0x184e1
// Size: 0x54
function getfx( fx )
{
    /#
        if ( !isdefined( level._effect[ fx ] ) )
        {
            assertmsg( "<dev string:x21d9>" + ( isxhash( fx ) ? getxhashsourcename( fx ) : fx ) + "<dev string:x21dd>" );
        }
    #/
    
    return level._effect[ fx ];
}

// Namespace utility
// Params 0
// Checksum 0x1e5632e0, Offset: 0x1853e
// Size: 0x45
function function_7158911332c109bb()
{
    groundlocation = getgroundposition( self.origin, 1 );
    waterheight = getwaterheightatlocation( groundlocation );
    
    if ( groundlocation[ 2 ] < waterheight )
    {
        groundlocation = ( groundlocation[ 0 ], groundlocation[ 1 ], waterheight );
    }
    
    return groundlocation;
}

// Namespace utility
// Params 1
// Checksum 0x9ae1d969, Offset: 0x1858c
// Size: 0x87
function function_c5d9978d36c9459e( hdrcolor )
{
    var_76a96cf84b1772ad = strtok( hdrcolor, " " );
    assert( var_76a96cf84b1772ad.size == 4 || var_76a96cf84b1772ad.size == 3, "<dev string:x21ff>" + hdrcolor + "<dev string:x220a>" );
    rgbcolor = [];
    
    for ( i = 0; i < 3 ; i++ )
    {
        rgbcolor[ i ] = int( ceil( float( var_76a96cf84b1772ad[ i ] ) * 255 ) );
    }
    
    return rgbcolor;
}

// Namespace utility
// Params 0
// Checksum 0xd641694f, Offset: 0x1861c
// Size: 0x5c
function deck_draw()
{
    assert( isstruct( self ) && isdefined( self.items ) && isdefined( self.index ), "<dev string:x2238>" );
    deck = self;
    drawn_item = deck deck_top();
    deck.index++;
    return drawn_item;
}

// Namespace utility
// Params 0
// Checksum 0xf9905490, Offset: 0x18681
// Size: 0x1ad
function deck_shuffle()
{
    assert( isstruct( self ) && isdefined( self.items ) && isdefined( self.index ), "<dev string:x2271>" );
    deck = self;
    
    if ( deck.index == 0 || !deck.prevent_redraw || deck.items.size <= 1 )
    {
        deck.items = arrayrandomize( deck.items );
        deck.index = 0;
        deck.cycle++;
        return;
    }
    
    j = randomintrange( 0, deck.items.size - 1 );
    
    if ( j == deck.index - 1 )
    {
        j++;
    }
    
    temp = deck.items[ 0 ];
    deck.items[ 0 ] = deck.items[ j ];
    deck.items[ j ] = temp;
    
    for ( i = 1; i < deck.items.size - 1 ; i++ )
    {
        j = randomintrange( i, deck.items.size );
        temp = deck.items[ i ];
        deck.items[ i ] = deck.items[ j ];
        deck.items[ j ] = temp;
    }
    
    deck.index = 0;
    deck.cycle++;
}

// Namespace utility
// Params 0
// Checksum 0xd3bbe2d5, Offset: 0x18836
// Size: 0xb3
function deck_top()
{
    assert( isstruct( self ) && isdefined( self.items ) && isdefined( self.index ), "<dev string:x22ad>" );
    deck = self;
    
    if ( deck.items.size == 0 )
    {
        return;
    }
    
    if ( deck.index >= deck.items.size )
    {
        if ( deck.autoshuffle )
        {
            deck deck_shuffle();
        }
        else
        {
            deck.index = 0;
            deck.cycle++;
        }
    }
    
    return deck.items[ deck.index ];
}

// Namespace utility
// Params 3
// Checksum 0xb8fa979a, Offset: 0x188f2
// Size: 0x3a
function function_e153375527829ec3( value, default_value, err_msg )
{
    if ( !isdefined( value ) )
    {
        if ( isdefined( err_msg ) )
        {
            assertmsg( err_msg );
        }
        
        return default_value;
    }
    
    return value;
}

// Namespace utility
// Params 3
// Checksum 0x7b85350f, Offset: 0x18935
// Size: 0x36
function delay_notify( n_delay, str_notify, str_endon )
{
    if ( isdefined( str_endon ) )
    {
        self endon( str_endon );
    }
    
    wait n_delay;
    
    if ( isdefined( self ) )
    {
        self notify( str_notify );
    }
}

// Namespace utility
// Params 2, eflags: 0x40 variadic
// Checksum 0xa7bd6c7f, Offset: 0x18973
// Size: 0xa7
function damagelocationisany( ... )
{
    if ( isdefined( self.damagelocation ) )
    {
        foreach ( damagelocation in vararg )
        {
            if ( self.damagelocation == damagelocation )
            {
                return 1;
            }
        }
    }
    
    return damagesubpartlocationisany( flat_args( vararg, varargcount ) );
}

// Namespace utility
// Params 2, eflags: 0x40 variadic
// Checksum 0xf970df24, Offset: 0x18a23
// Size: 0xa1, Type: bool
function damagesubpartlocationisany( ... )
{
    if ( !isdefined( self.damagedsubpart ) )
    {
        return false;
    }
    
    foreach ( damagelocation in vararg )
    {
        if ( self.damagedsubpart == damagelocation )
        {
            return true;
        }
    }
    
    return false;
}

/#

    // Namespace utility
    // Params 6
    // Checksum 0x2e5b54d5, Offset: 0x18acd
    // Size: 0xa8, Type: dev
    function debugprinttoscreen( message, time, coordx, coordy, color, size )
    {
        if ( !isdefined( time ) )
        {
            time = 2;
        }
        
        if ( !isdefined( coordx ) )
        {
            coordx = 10;
        }
        
        if ( !isdefined( coordy ) )
        {
            coordy = 200;
        }
        
        if ( !isdefined( color ) )
        {
            color = ( 1, 1, 1 );
        }
        
        if ( isdefined( message ) )
        {
            starttime = gettime();
            
            while ( gettime() - starttime <= time * 1000 )
            {
                printtoscreen2d( coordx, coordy, message, color, size ?? 2 );
                waitframe();
            }
        }
    }

    // Namespace utility
    // Params 5
    // Checksum 0xe1ed5ab0, Offset: 0x18b7d
    // Size: 0xf7, Type: dev
    function function_72ef0ebf3a428eb9( message, time, coordx, coordy, color )
    {
        if ( !isdefined( level.debugmessages ) )
        {
            thread function_3011e0b88a32d9f();
        }
        
        if ( isdefined( message ) )
        {
            if ( !isdefined( time ) )
            {
                time = 2;
            }
            
            if ( !isdefined( coordx ) )
            {
                coordx = 10;
            }
            
            if ( !isdefined( coordy ) )
            {
                coordy = 200;
            }
            
            if ( !isdefined( color ) )
            {
                color = ( 1, 1, 1 );
            }
            
            debugmessage = spawnstruct();
            debugmessage.message = message;
            debugmessage.coordx = coordx;
            debugmessage.coordy = coordy;
            debugmessage.color = color;
            level.debugmessages[ level.debugmessages.size ] = debugmessage;
            wait time;
            level.debugmessages = arrayremove( level.debugmessages, debugmessage );
        }
    }

    // Namespace utility
    // Params 0, eflags: 0x4
    // Checksum 0xc6d77c60, Offset: 0x18c7c
    // Size: 0xda, Type: dev
    function private function_3011e0b88a32d9f()
    {
        level.debugmessages = [];
        
        while ( true )
        {
            for ( i = 0; i < level.debugmessages.size ; i++ )
            {
                message = level.debugmessages[ i ].message;
                coordx = level.debugmessages[ i ].coordx;
                coordy = level.debugmessages[ i ].coordy;
                color = level.debugmessages[ i ].color;
                offsety = i * 20;
                printtoscreen2d( coordx, coordy + offsety, message, color, 2 );
            }
            
            waitframe();
        }
    }

#/

// Namespace utility
// Params 2
// Checksum 0x22d61ce, Offset: 0x18d5e
// Size: 0x36
function playsoundonentity( alias, op_notify_string )
{
    assert( isdefined( level.fnplaysoundonentity ) );
    [[ level.fnplaysoundonentity ]]( alias, op_notify_string );
}

// Namespace utility
// Params 5
// Checksum 0x93b673d5, Offset: 0x18d9c
// Size: 0x55
function playsoundontag( alias, tag, ends_on_death, op_notify_string, radio_dialog )
{
    assert( isdefined( level.fnplaysoundontag ) );
    [[ level.fnplaysoundontag ]]( alias, tag, ends_on_death, op_notify_string, radio_dialog );
}

// Namespace utility
// Params 5
// Checksum 0x6c6801e4, Offset: 0x18df9
// Size: 0x98
function plot_points( plotpoints, r, g, b, timer )
{
    lastpoint = plotpoints[ 0 ];
    
    if ( !isdefined( r ) )
    {
        r = 1;
    }
    
    if ( !isdefined( g ) )
    {
        g = 1;
    }
    
    if ( !isdefined( b ) )
    {
        b = 1;
    }
    
    if ( !isdefined( timer ) )
    {
        timer = 0.05;
    }
    
    for ( i = 1; i < plotpoints.size ; i++ )
    {
        thread draw_line_for_time( lastpoint, plotpoints[ i ], r, g, b, timer );
        lastpoint = plotpoints[ i ];
    }
}

/#

    // Namespace utility
    // Params 8
    // Checksum 0xa6cb7c40, Offset: 0x18e99
    // Size: 0xac, Type: dev
    function function_95445a6684f51c52( text, origin, color, alpha, scale, duration, var_5bf65afe54040850, endonevent )
    {
        if ( !isdefined( var_5bf65afe54040850 ) )
        {
            var_5bf65afe54040850 = 1;
        }
        
        if ( isdefined( endonevent ) )
        {
            level endon( endonevent );
        }
        
        endtime = gettime() + duration * 1000;
        
        while ( gettime() < endtime )
        {
            print3d( origin, text, color, alpha, scale, var_5bf65afe54040850 );
            timesec = var_5bf65afe54040850 * level.framedurationseconds;
            wait timesec;
        }
    }

#/

// Namespace utility
// Params 0
// Checksum 0xb04002bd, Offset: 0x18f4d
// Size: 0x8a
function process_frame_events()
{
    while ( true )
    {
        if ( !isdefined( self ) )
        {
            break;
        }
        
        foreach ( event in self.frame_events )
        {
            self thread [[ event ]]();
        }
        
        waitframe();
    }
}

// Namespace utility
// Params 1
// Checksum 0x29913fd7, Offset: 0x18fdf
// Size: 0x282
function function_806a048c738da163( ent )
{
    if ( isdefined( self.script_flag_set ) )
    {
        flags = create_flags_and_return_tokens( self.script_flag_set );
        
        foreach ( flag in flags )
        {
            flag_set( flag );
        }
    }
    
    if ( isdefined( self.script_flag_clear ) )
    {
        flags = create_flags_and_return_tokens( self.script_flag_clear );
        
        foreach ( flag in flags )
        {
            flag_clear( flag );
        }
    }
    
    if ( isdefined( self.script_ent_flag_set ) )
    {
        if ( !isdefined( ent ) )
        {
            assertmsg( "<dev string:x22e5>" + self.script_ent_flag_set + "<dev string:xaa9>" );
            return;
        }
        
        flags = create_flags_and_return_tokens( self.script_ent_flag_set );
        
        foreach ( flag in flags )
        {
            ent ent_flag_set( flag );
        }
    }
    
    if ( isdefined( self.script_ent_flag_clear ) )
    {
        if ( !isdefined( ent ) )
        {
            assertmsg( "<dev string:x2310>" + self.script_ent_flag_clear + "<dev string:xaa9>" );
            return;
        }
        
        flags = create_flags_and_return_tokens( self.script_ent_flag_clear );
        
        foreach ( flag in flags )
        {
            ent ent_flag_clear( flag );
        }
    }
}

// Namespace utility
// Params 2
// Checksum 0xea0123a8, Offset: 0x19269
// Size: 0x6d
function production_map_assert( value, message = "production_map_assert" )
{
    if ( !value )
    {
        if ( level.mapinfobundle.productionmap || getdvarint( @"production_map_assert", 0 ) )
        {
            assertmsg( message );
            return;
        }
        
        /#
            iprintlnbold( message );
            logstring( message );
        #/
    }
}

// Namespace utility
// Params 1
// Checksum 0xd3477ff0, Offset: 0x192de
// Size: 0x40
function queue_clear( queue )
{
    queue.array = [];
    queue.front = 0;
    queue.rear = -1;
    return queue.array.size;
}

// Namespace utility
// Params 1
// Checksum 0x8289881, Offset: 0x19327
// Size: 0x54
function queue_create( capacity )
{
    queue = spawnstruct();
    queue.capacity = capacity;
    queue.array = [];
    queue.front = 0;
    queue.rear = -1;
    return queue;
}

// Namespace utility
// Params 1
// Checksum 0x8b57850d, Offset: 0x19384
// Size: 0xbe
function queue_dequeue( queue )
{
    if ( queue.array.size == 0 )
    {
        assert( 0, "<dev string:x233d>" );
        return queue;
    }
    
    queue.array[ queue.front ] = undefined;
    
    if ( queue.array.size > 0 && queue.front + 1 >= queue.capacity )
    {
        queue.front = 0;
    }
    else
    {
        queue.front++;
    }
    
    if ( queue.array.size == 0 )
    {
        queue.front = 0;
        queue.rear = -1;
    }
    
    return queue;
}

// Namespace utility
// Params 2
// Checksum 0xf49186e8, Offset: 0x1944b
// Size: 0xb2
function queue_enqueue( queue, object )
{
    if ( queue.array.size == queue.capacity )
    {
        assert( 0, "<dev string:x236f>" );
        return queue;
    }
    
    if ( queue.array.size != queue.capacity && queue.rear + 1 >= queue.capacity )
    {
        queue.rear = 0;
    }
    else
    {
        queue.rear++;
    }
    
    queue.array[ queue.rear ] = object;
    return queue;
}

// Namespace utility
// Params 2
// Checksum 0x6551d9a1, Offset: 0x19506
// Size: 0xa9, Type: bool
function function_9dac7ef683ed0e52( queue, object )
{
    if ( !( isdefined( queue ) && isdefined( object ) ) )
    {
        return false;
    }
    
    tempcount = 0;
    i = queue.front;
    
    while ( tempcount < queue.array.size )
    {
        if ( !isdefined( queue.array[ i ] ) )
        {
        }
        else
        {
            if ( queue.array[ i ] == object )
            {
                return true;
            }
            
            if ( i + 1 >= queue.capacity )
            {
                i = 0;
            }
            else
            {
                i++;
            }
        }
        
        tempcount++;
    }
    
    return false;
}

// Namespace utility
// Params 1
// Checksum 0x52a9a6d2, Offset: 0x195b8
// Size: 0x1a, Type: bool
function queue_isempty( queue )
{
    return queue.array.size == 0;
}

// Namespace utility
// Params 1
// Checksum 0x604d547b, Offset: 0x195db
// Size: 0x24, Type: bool
function queue_isfull( queue )
{
    return queue.array.size == queue.capacity;
}

// Namespace utility
// Params 1
// Checksum 0x2fef1c6e, Offset: 0x19608
// Size: 0x43
function queue_peek( queue )
{
    if ( queue.array.size == 0 )
    {
        assert( 0, "<dev string:x23a0>" );
        return;
    }
    
    return queue.array[ queue.front ];
}

// Namespace utility
// Params 1
// Checksum 0x836b1ded, Offset: 0x19654
// Size: 0x18
function queue_size( queue )
{
    return queue.array.size;
}

// Namespace utility
// Params 1
// Checksum 0x83fcccb6, Offset: 0x19675
// Size: 0x2f
function random_key( array )
{
    size = array.size;
    
    if ( size > 0 )
    {
        return getarraykey( array, randomint( size ) );
    }
}

// Namespace utility
// Params 1
// Checksum 0xf01d8053, Offset: 0x196ac
// Size: 0xb7
function random_weight_sorted( array )
{
    newarray = [];
    
    foreach ( value in array )
    {
        newarray[ newarray.size ] = value;
    }
    
    if ( !newarray.size )
    {
        return;
    }
    
    var_d23377414f51df8b = randomint( newarray.size * newarray.size );
    return newarray[ newarray.size - 1 - int( sqrt( var_d23377414f51df8b ) ) ];
}

// Namespace utility
// Params 2
// Checksum 0x3c1a7afc, Offset: 0x1976c
// Size: 0x142
function random_weighted( array, weights )
{
    assert( array.size == weights.size, "<dev string:x23ce>" );
    totalweight = 0;
    
    foreach ( value in weights )
    {
        totalweight += value;
    }
    
    if ( totalweight == 0 )
    {
        return;
    }
    
    weight = randomint( totalweight );
    chosenvalue = undefined;
    
    foreach ( i, value in array )
    {
        if ( weight < weights[ i ] )
        {
            chosenvalue = value;
            break;
        }
        
        weight -= weights[ i ];
    }
    
    return chosenvalue;
}

// Namespace utility
// Params 1
// Checksum 0x4b21770, Offset: 0x198b7
// Size: 0x13d
function random_weighted_struct( struct_array )
{
    totalweight = 0;
    
    foreach ( struct in struct_array )
    {
        totalweight += struct.weight;
    }
    
    if ( totalweight == 0 )
    {
        return;
    }
    
    choosenweight = randomint( totalweight );
    cumulativeweight = 0;
    selectedstruct = undefined;
    
    foreach ( struct in struct_array )
    {
        cumulativeweight += struct.weight;
        
        if ( cumulativeweight > choosenweight )
        {
            selectedstruct = struct;
            break;
        }
    }
    
    return selectedstruct;
}

// Namespace utility
// Params 0
// Checksum 0x142dbce4, Offset: 0x199fd
// Size: 0x50
function function_9e0df7b136ab833c()
{
    angle = randomfloat( 360 );
    dist = randomfloat( 1 );
    x = cos( angle ) * dist;
    y = sin( angle ) * dist;
    return ( x, y, 0 );
}

// Namespace utility
// Params 0
// Checksum 0x34a92158, Offset: 0x19a56
// Size: 0x68
function randomonunitsphere()
{
    theta = randomfloat( 180 );
    phi = randomfloat( 360 );
    x = cos( phi ) * cos( theta );
    y = cos( phi ) * sin( theta );
    z = sin( phi );
    return ( x, y, z );
}

// Namespace utility
// Params 1
// Checksum 0xb0c3cd20, Offset: 0x19ac7
// Size: 0x3a
function randomvector( num )
{
    return ( randomfloat( num ) - num * 0.5, randomfloat( num ) - num * 0.5, randomfloat( num ) - num * 0.5 );
}

// Namespace utility
// Params 2
// Checksum 0x3a8f25c5, Offset: 0x19b0a
// Size: 0x9b
function randomvectorrange( num_min, num_max )
{
    assert( isdefined( num_min ) );
    assert( isdefined( num_max ) );
    x = randomfloatrange( num_min, num_max );
    
    if ( randomint( 2 ) == 0 )
    {
        x *= -1;
    }
    
    y = randomfloatrange( num_min, num_max );
    
    if ( randomint( 2 ) == 0 )
    {
        y *= -1;
    }
    
    z = randomfloatrange( num_min, num_max );
    
    if ( randomint( 2 ) == 0 )
    {
        z *= -1;
    }
    
    return ( x, y, z );
}

// Namespace utility
// Params 2
// Checksum 0x60e6d4ab, Offset: 0x19bae
// Size: 0x62
function randomvectorrangeflat( num_min, num_max )
{
    x = randomfloatrange( num_min, num_max );
    
    if ( randomint( 2 ) == 0 )
    {
        x *= -1;
    }
    
    y = randomfloatrange( num_min, num_max );
    
    if ( randomint( 2 ) == 0 )
    {
        y *= -1;
    }
    
    return ( x, y, 0 );
}

// Namespace utility
// Params 2
// Checksum 0x5c4e000c, Offset: 0x19c19
// Size: 0x78
function function_45361634b6ee16ea( vec_min, vec_max )
{
    assert( isvector( vec_min ) );
    assert( isvector( vec_max ) );
    x = randomfloatrange( vec_min[ 0 ], vec_max[ 0 ] );
    y = randomfloatrange( vec_min[ 1 ], vec_max[ 1 ] );
    z = randomfloatrange( vec_min[ 2 ], vec_max[ 2 ] );
    return ( x, y, z );
}

// Namespace utility
// Params 0
// Checksum 0x1c2b86fc, Offset: 0x19c9a
// Size: 0x9a
function function_e00e472b5a03f8f1()
{
    mapinfo = level.mapinfobundle;
    
    if ( !isdefined( mapinfo ) )
    {
        mapinfo = getmapscriptbundle();
    }
    
    if ( isdefined( mapinfo ) )
    {
        level.isnightmap = istrue( mapinfo.nightmap );
        
        if ( level.isnightmap )
        {
            visionsetkillcamthirdpersonnight( "killcam_night" );
        }
        
        level.var_e54aa9fc8f17d734 = istrue( mapinfo.usenvgs );
        return;
    }
    
    println( "<dev string:x23fa>" + getdvar( @"g_mapname" ) );
    level.isnightmap = 0;
    level.var_e54aa9fc8f17d734 = 0;
}

// Namespace utility
// Params 0
// Checksum 0xc9fba060, Offset: 0x19d3c
// Size: 0x21, Type: bool
function isnightmap()
{
    if ( !isdefined( level.isnightmap ) )
    {
        function_e00e472b5a03f8f1();
    }
    
    return istrue( level.isnightmap );
}

// Namespace utility
// Params 1
// Checksum 0xa7fbb03e, Offset: 0x19d66
// Size: 0x20, Type: bool
function isnode3d( node )
{
    return isnodecover3d( node ) || isnodeexposed3d( node );
}

// Namespace utility
// Params 1
// Checksum 0xfb6a9998, Offset: 0x19d8f
// Size: 0x4c, Type: bool
function isnodecover3d( node )
{
    assert( isdefined( node ) && isdefined( node.type ) );
    return node.type == "Cover Stand 3D" || node.type == "Cover 3D";
}

// Namespace utility
// Params 1
// Checksum 0x88851aa2, Offset: 0x19de4
// Size: 0x61, Type: bool
function isnodecovercrouch( node )
{
    assert( isdefined( node ) && isdefined( node.type ) );
    return node.type == "Cover Crouch" || node.type == "Cover Crouch Window" || node.type == "Conceal Crouch";
}

// Namespace utility
// Params 2
// Checksum 0x61257753, Offset: 0x19e4e
// Size: 0x64, Type: bool
function isnodecovercrouchtype( node, type )
{
    assert( isdefined( node ) );
    
    if ( node.type == "Cover Crouch" && isdefined( self._blackboard.croucharrivaltype ) )
    {
        return ( self._blackboard.croucharrivaltype == type );
    }
    
    return false;
}

// Namespace utility
// Params 1
// Checksum 0x1ef37d70, Offset: 0x19ebb
// Size: 0x37, Type: bool
function isnodecoverleft( node )
{
    assert( isdefined( node ) && isdefined( node.type ) );
    return node.type == "Cover Left";
}

// Namespace utility
// Params 1
// Checksum 0x730440ff, Offset: 0x19efb
// Size: 0x37, Type: bool
function isnodecoverright( node )
{
    assert( isdefined( node ) && isdefined( node.type ) );
    return node.type == "Cover Right";
}

// Namespace utility
// Params 1
// Checksum 0xec9b2650, Offset: 0x19f3b
// Size: 0x4c, Type: bool
function isnodeexposed3d( node )
{
    assert( isdefined( node ) && isdefined( node.type ) );
    return node.type == "Exposed 3D" || node.type == "Path 3D";
}

// Namespace utility
// Params 0
// Checksum 0x1b9c219, Offset: 0x19f90
// Size: 0x21, Type: bool
function function_2a082dafe6f4bd5b()
{
    if ( !isdefined( level.var_e54aa9fc8f17d734 ) )
    {
        function_e00e472b5a03f8f1();
    }
    
    return istrue( level.var_e54aa9fc8f17d734 );
}

// Namespace utility
// Params 1
// Checksum 0x17557eaa, Offset: 0x19fba
// Size: 0x5f
function getpitchtospot3d( spot )
{
    var_40b69a03e72b5bb9 = spot - self.origin;
    var_a96e0316adc12c5f = rotatevectorinverted( var_40b69a03e72b5bb9, self.angles );
    pitch = vectortopitch( var_a96e0316adc12c5f );
    pitch_clamped = angleclamp180( pitch );
    return pitch_clamped;
}

// Namespace utility
// Params 1
// Checksum 0x5dbadc67, Offset: 0x1a022
// Size: 0x12a
function function_21371fd45f8bcf8a( guid )
{
    if ( !isdefined( level.playerguidmap ) )
    {
        level.playerguidmap = [];
        
        if ( isdefined( level.player ) )
        {
            playerarray = [ level.player ];
        }
        else
        {
            playerarray = level.players;
        }
        
        foreach ( player in playerarray )
        {
            playerguid = callsharedfunc( #"player", #"getPlayerGuid", player );
            level.playerguidmap[ playerguid ] = player;
        }
        
        level callback::add( #"player_connect", &function_e75f63af976d85c2 );
        level callback::add( #"player_disconnect", &function_263891ca905d979e );
    }
    
    return level.playerguidmap[ guid ];
}

// Namespace utility
// Params 1, eflags: 0x4
// Checksum 0x98887c7, Offset: 0x1a155
// Size: 0x4b
function private function_e75f63af976d85c2( params )
{
    player = self;
    playerguid = callsharedfunc( #"player", #"getPlayerGuid", player );
    level.playerguidmap[ playerguid ] = player;
}

// Namespace utility
// Params 1, eflags: 0x4
// Checksum 0x94a551e9, Offset: 0x1a1a8
// Size: 0x49
function private function_263891ca905d979e( params )
{
    player = self;
    playerguid = callsharedfunc( #"player", #"getPlayerGuid", player );
    level.playerguidmap[ playerguid ] = undefined;
}

// Namespace utility
// Params 3
// Checksum 0xb4313854, Offset: 0x1a1f9
// Size: 0x79
function function_ce86ddbb7d60e9bd( position, shockwaveref, owner )
{
    if ( function_9e8f69121ec4b65d( #"hash_c45110e705f31620" ) )
    {
        return;
    }
    
    if ( !isdefined( shockwaveref ) )
    {
        return;
    }
    
    newshockwave = spawnshockwave( position, shockwaveref );
    
    if ( isdefined( owner ) && isdefined( newshockwave ) )
    {
        newshockwave setentityowner( owner );
        return;
    }
    
    if ( !newshockwave )
    {
        /#
            iprintlnbold( "<dev string:x2416>" + shockwaveref );
        #/
    }
}

// Namespace utility
// Params 3
// Checksum 0xf5c43b77, Offset: 0x1a27a
// Size: 0x225
function function_54fdde0a73217354( a_ents, var_7fdb5e6b2d9f73ec = 1, var_e4980e9f328c26c1 = 0 )
{
    var_ceca05bdac98ef87 = ( 0, 0, 0 );
    
    if ( !isarray( a_ents ) || a_ents.size == 0 )
    {
        assertmsg( "<dev string:x244c>" );
        return;
    }
    
    foreach ( ent in a_ents )
    {
        if ( !isdefined( ent.origin ) )
        {
            assertmsg( ent + "<dev string:x2472>" );
            return;
        }
    }
    
    if ( a_ents.size == 1 )
    {
        key = getfirstarraykey( a_ents );
        origin = a_ents[ key ].origin;
        var_ceca05bdac98ef87 = var_e4980e9f328c26c1 ? origin : ( origin[ 0 ], origin[ 1 ], 0 );
    }
    else
    {
        var_cd3cf2cf3b927430 = int( floor( a_ents.size / 2 ) );
        var_3a67fb50b33f1198 = arraysort( a_ents, undefined, &function_4655f27e948750f );
        var_876dbb769104e061 = arraysort( a_ents, undefined, &function_738731a22093b89e );
        var_49c5e579cf6c93c4 = var_3a67fb50b33f1198[ var_cd3cf2cf3b927430 ].origin[ 0 ];
        mediany = var_876dbb769104e061[ var_cd3cf2cf3b927430 ].origin[ 1 ];
        var_49c5e779cf6c982a = 0;
        
        if ( var_e4980e9f328c26c1 )
        {
            var_d0ad176824cdaa5e = arraysort( a_ents, undefined, &function_6796b0d93dde2c29 );
            var_49c5e779cf6c982a = var_d0ad176824cdaa5e[ var_cd3cf2cf3b927430 ].origin[ 2 ];
        }
        
        var_ceca05bdac98ef87 = ( var_49c5e579cf6c93c4, mediany, var_49c5e779cf6c982a );
        
        if ( a_ents.size % 2 == 0 && var_7fdb5e6b2d9f73ec )
        {
            var_ceca05bdac98ef87 += a_ents[ var_cd3cf2cf3b927430 + 1 ].origin;
            var_ceca05bdac98ef87 *= 0.5;
        }
    }
    
    return var_ceca05bdac98ef87;
}

// Namespace utility
// Params 1
// Checksum 0x686140a6, Offset: 0x1a4a8
// Size: 0x64
function getaimpitchtopoint3d( point )
{
    pitch = getpitchtospot3d( point );
    dist = distance( self.origin, point );
    
    if ( dist > 3 )
    {
        anglefudge = asin( -3 / dist );
        pitch -= anglefudge;
    }
    
    pitch = angleclamp180( pitch );
    return pitch;
}

// Namespace utility
// Params 1
// Checksum 0xa02e0095, Offset: 0x1a515
// Size: 0x64
function getaimyawtopoint( point )
{
    yaw = getyawtospot( point );
    dist = distance( self.origin, point );
    
    if ( dist > 3 )
    {
        anglefudge = asin( -3 / dist );
        yaw -= anglefudge;
    }
    
    yaw = angleclamp180( yaw );
    return yaw;
}

// Namespace utility
// Params 1
// Checksum 0xc97884df, Offset: 0x1a582
// Size: 0x64
function getaimyawtopoint3d( point )
{
    yaw = getyawtospot3d( point );
    dist = distance( self.origin, point );
    
    if ( dist > 3 )
    {
        anglefudge = asin( -3 / dist );
        yaw -= anglefudge;
    }
    
    yaw = angleclamp180( yaw );
    return yaw;
}

// Namespace utility
// Params 1
// Checksum 0x31de0cbe, Offset: 0x1a5ef
// Size: 0x5d
function getanim( anime )
{
    assert( isdefined( self.animname ), "<dev string:x2492>" );
    assert( isdefined( level.scr_anim[ self.animname ][ anime ] ), "<dev string:x24bb>" );
    return level.scr_anim[ self.animname ][ anime ];
}

// Namespace utility
// Params 2
// Checksum 0x7693d984, Offset: 0x1a655
// Size: 0x4f
function getanim_from_animname( anime, animname )
{
    assert( isdefined( animname ), "<dev string:x24e0>" );
    assert( isdefined( level.scr_anim[ animname ][ anime ] ), "<dev string:x24f8>" );
    return level.scr_anim[ animname ][ anime ];
}

// Namespace utility
// Params 1
// Checksum 0xfdf36a44, Offset: 0x1a6ad
// Size: 0x3e
function getanim_generic( anime )
{
    assert( isdefined( level.scr_anim[ "<dev string:xc88>" ][ anime ] ), "<dev string:x252b>" );
    return level.scr_anim[ "generic" ][ anime ];
}

// Namespace utility
// Params 2
// Checksum 0xdcd7ff8e, Offset: 0x1a6f4
// Size: 0x104
function getanim_starts( anime, ent )
{
    startpositions = [];
    
    if ( animation::function_b8e0e318104693fb( anime ) )
    {
        foreach ( animation in level.scr_anim[ ent.animname ][ anime ] )
        {
            newanime = animation::function_179fdcb8d53829fe( anime, ent.animname, animation );
            animation::anim_first_frame_solo( ent, newanime );
            startpositions[ startpositions.size ] = ent.origin;
        }
    }
    else
    {
        animation::anim_first_frame_solo( ent, anime );
        startpositions[ startpositions.size ] = ent.origin;
    }
    
    return startpositions;
}

// Namespace utility
// Params 2
// Checksum 0x34a6e690, Offset: 0x1a801
// Size: 0x165
function function_11a2ebb045201379( a_ents, var_e4980e9f328c26c1 = 0 )
{
    averageposition = ( 0, 0, 0 );
    
    if ( !isarray( a_ents ) || a_ents.size == 0 )
    {
        assertmsg( "<dev string:x244c>" );
        return;
    }
    
    if ( a_ents.size == 1 )
    {
        key = getfirstarraykey( a_ents );
        origin = a_ents[ key ].origin;
        averageposition = var_e4980e9f328c26c1 ? origin : ( origin[ 0 ], origin[ 1 ], 0 );
    }
    else
    {
        foreach ( ent in a_ents )
        {
            if ( !isdefined( ent.origin ) )
            {
                assertmsg( ent + "<dev string:x2472>" );
                return;
            }
            
            averageposition += ent.origin;
        }
    }
    
    z_val = var_e4980e9f328c26c1 ? averageposition[ 2 ] / a_ents.size : 0;
    return ( averageposition[ 0 ] / a_ents.size, averageposition[ 1 ] / a_ents.size, z_val );
}

// Namespace utility
// Params 4, eflags: 0x44 variadic
// Checksum 0xd679a3f9, Offset: 0x1a96f
// Size: 0x5d
function private function_df28a485be61386e( time_seconds, func, ... )
{
    level endon( #"game_ended" );
    
    if ( isplayer( self ) )
    {
        self endon( #"disconnect" );
    }
    
    wait max( int( time_seconds ), 0 );
    self thread [[ func ]]( flat_args( vararg, varargcount ) );
}

// Namespace utility
// Params 3, eflags: 0x4
// Checksum 0x51aafaa9, Offset: 0x1a9d4
// Size: 0x58
function private function_f847fdaebc753c59( ent, func, arg_array )
{
    single_func_argarray( ent, func, arg_array );
    self.pendingcount -= 1;
    
    if ( self.pendingcount == 0 )
    {
        self notify( self.alldonenotify );
    }
}

// Namespace utility
// Params 2, eflags: 0x4
// Checksum 0x64f7d1e4, Offset: 0x1aa34
// Size: 0x30, Type: bool
function private function_4655f27e948750f( ent1, ent2 )
{
    return ent1.origin[ 0 ] > ent2.origin[ 0 ];
}

// Namespace utility
// Params 2, eflags: 0x4
// Checksum 0xca9f4075, Offset: 0x1aa6d
// Size: 0x32, Type: bool
function private function_738731a22093b89e( ent1, ent2 )
{
    return ent1.origin[ 1 ] > ent2.origin[ 1 ];
}

// Namespace utility
// Params 2, eflags: 0x4
// Checksum 0xe357f487, Offset: 0x1aaa8
// Size: 0x32, Type: bool
function private function_6796b0d93dde2c29( ent1, ent2 )
{
    return ent1.origin[ 2 ] > ent2.origin[ 2 ];
}

// Namespace utility
// Params 1
// Checksum 0x92358ee5, Offset: 0x1aae3
// Size: 0x14
function get_exploder_array( msg )
{
    return exploder::get_exploder_array_proc( msg );
}

// Namespace utility
// Params 1
// Checksum 0x8fd1b00a, Offset: 0x1ab00
// Size: 0xfc
function function_6e6f301423539d40( needenemyplayer = 0 )
{
    farthestdistsq = 0;
    
    foreach ( player in level.players )
    {
        if ( player == self || !isalive( player ) )
        {
            continue;
        }
        
        if ( needenemyplayer && !isenemyteam( self.team, player.team ) )
        {
            continue;
        }
        
        distsq = distancesquared( self.origin, player.origin );
        
        if ( distsq > farthestdistsq )
        {
            farthestdistsq = distsq;
        }
    }
    
    return farthestdistsq;
}

// Namespace utility
// Params 1
// Checksum 0x56514b9f, Offset: 0x1ac05
// Size: 0x65
function function_3d02f6af6042aa67( fallbacksuit = "sat_defaultsuit_mp" )
{
    if ( isdvardefined( @"scr_test_suit" ) && getdvar( @"scr_test_suit" ) != "" )
    {
        return getdvar( @"scr_test_suit" );
    }
    
    return level.gamemodebundle.playerdefaultsuit ?? fallbacksuit;
}

// Namespace utility
// Params 1
// Checksum 0x8c10212, Offset: 0x1ac73
// Size: 0x36, Type: bool
function function_f825237e0eda5adf( fallbacksuit = "sat_defaultsuit_mp" )
{
    return level.gametypebundle.var_12615da89e5810d6 ?? function_3d02f6af6042aa67( fallbacksuit );
}

// Namespace utility
// Params 1
// Checksum 0x34d5bf71, Offset: 0x1acb2
// Size: 0x32, Type: bool
function function_cfcadadaf7557e6b( player )
{
    if ( isdefined( player.prop ) )
    {
        return true;
    }
    
    return isdefined( level.gametypebundle.var_12615da89e5810d6 );
}

// Namespace utility
// Params 1
// Checksum 0xfb9b83d9, Offset: 0x1aced
// Size: 0x122
function function_92fef8fe5211a388( vector )
{
    assert( is_partition(), "<dev string:x2558>" );
    assert( isdefined( vector ), "<dev string:x25c6>" );
    assert( isvector( vector ), "<dev string:x2605>" );
    [ x, y ] = function_890559684b1ecb60( vector );
    adjacent_arrays = [];
    
    for ( x_offset = -1; x_offset <= 1 ; x_offset++ )
    {
        x_test = x + x_offset;
        
        if ( x_test < 0 )
        {
            continue;
        }
        
        test_array_x = self.array[ x_test ];
        
        if ( !isdefined( test_array_x ) )
        {
            continue;
        }
        
        for ( y_offset = -1; y_offset <= 1 ; y_offset++ )
        {
            y_test = y + y_offset;
            
            if ( y_test < 0 )
            {
                continue;
            }
            
            var_1e8357156b843e8b = test_array_x[ y_test ];
            
            if ( !isdefined( var_1e8357156b843e8b ) )
            {
                continue;
            }
            
            adjacent_arrays[ adjacent_arrays.size ] = var_1e8357156b843e8b;
        }
    }
    
    return adjacent_arrays;
}

// Namespace utility
// Params 0
// Checksum 0x50b704fa, Offset: 0x1ae18
// Size: 0x3e
function function_e02da4fab371fbcf()
{
    return isdvardefined( @"hash_23522f85d648456d" ) ? getdvar( @"hash_23522f85d648456d" ) : level.adrenalinesettings.speedsuit ?? function_f825237e0eda5adf();
}

// Namespace utility
// Params 2
// Checksum 0xb615e0d3, Offset: 0x1ae5f
// Size: 0x57
function get_linked_ent( name, type = #targetname )
{
    array = get_linked_ents( name, type );
    assert( array.size == 1 );
    assert( isdefined( array[ 0 ] ) );
    return array[ 0 ];
}

// Namespace utility
// Params 2
// Checksum 0xd66d67d, Offset: 0x1aebf
// Size: 0xad
function function_e1bb0bf82dab729e( name, type = "targetname" )
{
    array = [];
    
    if ( isdefined( self.script_linkto ) )
    {
        linknames = get_links();
        
        for ( i = 0; i < linknames.size ; i++ )
        {
            scriptables = getentitylessscriptablearray( linknames[ i ], "script_linkname" );
            
            if ( scriptables.size > 0 )
            {
                array = arraycombine( array, scriptables );
            }
        }
    }
    
    if ( name )
    {
        filter = getentitylessscriptablearray( name, type );
        array = arrayintersection( array, filter );
    }
    
    return array;
}

// Namespace utility
// Params 2
// Checksum 0xc00c8933, Offset: 0x1af75
// Size: 0xa8
function get_linked_ents( name, type = #targetname )
{
    array = [];
    
    if ( isdefined( self.script_linkto ) )
    {
        linknames = get_links();
        
        if ( linknames.size == 1 )
        {
            array = getentarray( linknames[ 0 ], #script_linkname );
        }
        else if ( linknames.size > 1 )
        {
            array = function_92805cf2b0baa4ca( linknames, #script_linkname );
        }
    }
    
    if ( name )
    {
        filter = getentarray( name, type );
        array = arrayintersection( array, filter );
    }
    
    return array;
}

// Namespace utility
// Params 2
// Checksum 0xf8fa064d, Offset: 0x1b026
// Size: 0x5f
function get_linked_node( name, type = #targetname )
{
    array = get_linked_nodes( name, type );
    
    if ( !array.size )
    {
        return;
    }
    
    assert( array.size == 1 );
    assert( isdefined( array[ 0 ] ) );
    return array[ 0 ];
}

// Namespace utility
// Params 2
// Checksum 0x9ad33f29, Offset: 0x1b08e
// Size: 0xa8
function get_linked_nodes( name, type = #targetname )
{
    array = [];
    
    if ( isdefined( self.script_linkto ) )
    {
        linknames = get_links();
        
        if ( linknames.size == 1 )
        {
            array = getnodearray( linknames[ 0 ], #script_linkname );
        }
        else if ( linknames.size > 1 )
        {
            array = getnodesfromvalues( linknames, #script_linkname );
        }
    }
    
    if ( name )
    {
        filter = getnodearray( name, type );
        array = arrayintersection( array, filter );
    }
    
    return array;
}

// Namespace utility
// Params 2
// Checksum 0x24a45334, Offset: 0x1b13f
// Size: 0xb6
function get_linked_structs( name, type = "targetname" )
{
    array = [];
    
    if ( isdefined( self.script_linkto ) )
    {
        linknames = get_links();
        
        for ( i = 0; i < linknames.size ; i++ )
        {
            structs = getstructarray( linknames[ i ], "script_linkname" );
            
            if ( structs.size > 0 )
            {
                array = arraycombine( array, structs );
            }
        }
    }
    
    if ( name )
    {
        filter = level.struct_class_names[ type ][ name ];
        array = arrayintersection( array, filter );
    }
    
    return array;
}

// Namespace utility
// Params 0
// Checksum 0xf7d701fb, Offset: 0x1b1fe
// Size: 0x14
function get_links()
{
    return strtok( self.script_linkto, " " );
}

// Namespace utility
// Params 2
// Checksum 0x6091b968, Offset: 0x1b21b
// Size: 0x69
function get_max_stock_ammo( weapon, var_9242df1bd50fa5f6 = 0 )
{
    if ( level.gamemodebundle.var_1976506fada1193b )
    {
        if ( var_9242df1bd50fa5f6 )
        {
            max_stock_ammo = weaponmaxammo( weapon );
            return max_stock_ammo;
        }
        else
        {
            max_stock_ammo = weaponstartammo( weapon );
            return max_stock_ammo;
        }
        
        return;
    }
    
    max_stock_ammo = weaponmaxammo( weapon );
    return max_stock_ammo;
}

// Namespace utility
// Params 1
// Checksum 0xe5b15c9, Offset: 0x1b28c
// Size: 0x5f
function stringtovec3( input )
{
    output = ( 0, 0, 0 );
    values = strtok( input, " " );
    
    if ( values.size == 3 )
    {
        output = ( float( values[ 0 ] ), float( values[ 1 ] ), float( values[ 2 ] ) );
    }
    
    return output;
}

// Namespace utility
// Params 3
// Checksum 0x8e07014a, Offset: 0x1b2f4
// Size: 0x65
function function_d2db822aceef856a( string, delim, var_a4f640302ae7e692 )
{
    strings = strtok( string, delim, var_a4f640302ae7e692 );
    floats = [];
    
    for ( i = 0; i < strings.size ; i++ )
    {
        floats[ i ] = float( strings[ i ] );
    }
    
    return floats;
}

// Namespace utility
// Params 3
// Checksum 0x13c7ca7e, Offset: 0x1b362
// Size: 0x65
function function_b104528d84ca3561( string, delim, var_a4f640302ae7e692 )
{
    strings = strtok( string, delim, var_a4f640302ae7e692 );
    ints = [];
    
    for ( i = 0; i < strings.size ; i++ )
    {
        ints[ i ] = int( strings[ i ] );
    }
    
    return ints;
}

// Namespace utility
// Params 1
// Checksum 0xdd508190, Offset: 0x1b3d0
// Size: 0x2e
function function_b73ecb08dfaa1bc5( structvector )
{
    return ( structvector.x, structvector.y, structvector.z );
}

// Namespace utility
// Params 1
// Checksum 0xc3336e17, Offset: 0x1b407
// Size: 0x3d
function get_random_variant_id( var_25d99aafdc05f3ba )
{
    variantids = strtok( var_25d99aafdc05f3ba, " ", 1 );
    
    if ( variantids.size > 0 )
    {
        return int( variantids[ randomint( variantids.size ) ] );
    }
    
    return -1;
}

// Namespace utility
// Params 1
// Checksum 0xd9dac233, Offset: 0x1b44d
// Size: 0x48
function getplayeryaw( player )
{
    assert( isplayer( player ) );
    playerangles = player getplayerangles();
    assert( isnumber( playerangles[ 1 ] ) );
    return ( playerangles[ 1 ] + 360 ) % 360;
}

// Namespace utility
// Params 2
// Checksum 0xdc5bcada, Offset: 0x1b49e
// Size: 0xd1
function function_eecfd867c5d343ba( patharray, var_6197e3bd24981847 )
{
    assert( patharray.size > 0, "<dev string:x2657>" );
    
    if ( !isdefined( patharray ) || patharray.size == 0 )
    {
        return;
    }
    
    remainingdistance = var_6197e3bd24981847;
    var_ccecacbfba397018 = patharray[ 0 ];
    
    for ( i = 1; i < patharray.size ; i++ )
    {
        nextnodeorigin = patharray[ i ];
        var_ae10f81cd6e347b5 = distance( var_ccecacbfba397018, nextnodeorigin );
        
        if ( remainingdistance < var_ae10f81cd6e347b5 )
        {
            targetnode = vectorlerp( var_ccecacbfba397018, nextnodeorigin, remainingdistance / var_ae10f81cd6e347b5 );
            return [ targetnode, i ];
        }
        
        remainingdistance -= var_ae10f81cd6e347b5;
        var_ccecacbfba397018 = nextnodeorigin;
    }
    
    return [ var_ccecacbfba397018, patharray.size - 1 ];
}

// Namespace utility
// Params 2
// Checksum 0xec283069, Offset: 0x1b578
// Size: 0x56
function clearsharedfunc( category, funcname )
{
    /#
        if ( isstring( funcname ) )
        {
            assertmsg( "<dev string:x24>" + funcname + "<dev string:x2e>" );
        }
    #/
    
    if ( isstring( category ) )
    {
        category = getxhash( category );
    }
    
    level.sharedfuncs[ category ][ funcname ] = undefined;
}

// Namespace utility
// Params 1
// Checksum 0x701fe900, Offset: 0x1b5d6
// Size: 0x1ab
function function_4113d68e8e0a401f( array )
{
    assert( isdefined( self.origin ) && isdefined( self.angles ) );
    closest_dot = -1;
    closest_object = undefined;
    
    if ( isplayer( self ) )
    {
        forward = anglestoforward( self getplayerangles() );
        
        foreach ( object in array )
        {
            dir = vectornormalize( object.origin - self geteye() );
            dot = vectordot( forward, dir );
            
            if ( dot >= closest_dot )
            {
                closest_dot = dot;
                closest_object = object;
            }
        }
    }
    else
    {
        forward = anglestoforward( self.angles );
        
        foreach ( object in array )
        {
            dir = vectornormalize( object.origin - self.origin );
            dot = vectordot( forward, dir );
            
            if ( dot >= closest_dot )
            {
                closest_dot = dot;
                closest_object = object;
            }
        }
    }
    
    return closest_object;
}

// Namespace utility
// Params 4
// Checksum 0x829b14db, Offset: 0x1b78a
// Size: 0x211
function closestdistancebetweenlines( p1, p2, p3, p4 )
{
    p13 = p1 - p3;
    p43 = p4 - p3;
    
    if ( abs( p43[ 0 ] ) < 1e-06 && abs( p43[ 1 ] ) < 1e-06 && abs( p43[ 2 ] ) < 1e-06 )
    {
        return;
    }
    
    p21 = p2 - p1;
    
    if ( abs( p21[ 0 ] ) < 1e-06 && abs( p21[ 1 ] ) < 1e-06 && abs( p21[ 2 ] ) < 1e-06 )
    {
        return;
    }
    
    d1343 = p13[ 0 ] * p43[ 0 ] + p13[ 1 ] * p43[ 1 ] + p13[ 2 ] * p43[ 2 ];
    d4321 = p43[ 0 ] * p21[ 0 ] + p43[ 1 ] * p21[ 1 ] + p43[ 2 ] * p21[ 2 ];
    d1321 = p13[ 0 ] * p21[ 0 ] + p13[ 1 ] * p21[ 1 ] + p13[ 2 ] * p21[ 2 ];
    d4343 = p43[ 0 ] * p43[ 0 ] + p43[ 1 ] * p43[ 1 ] + p43[ 2 ] * p43[ 2 ];
    d2121 = p21[ 0 ] * p21[ 0 ] + p21[ 1 ] * p21[ 1 ] + p21[ 2 ] * p21[ 2 ];
    denom = d2121 * d4343 - d4321 * d4321;
    
    if ( abs( denom ) < 1e-06 )
    {
        return;
    }
    
    numer = d1343 * d4321 - d1321 * d4343;
    mua = numer / denom;
    mub = ( d1343 + d4321 * mua ) / d4343;
    pa = p1 + mua * p21;
    pb = p3 + mub * p43;
    var_152611eabe5a5256 = [ pa, pb, distance( pa, pb ) ];
    return var_152611eabe5a5256;
}

// Namespace utility
// Params 4
// Checksum 0xbb7628ed, Offset: 0x1b9a4
// Size: 0x251
function closestdistancebetweensegments( p1, p2, p3, p4 )
{
    pdir = p2 - p1;
    qdir = p4 - p3;
    segdelta = p1 - p3;
    pdp = vectordot( pdir, pdir );
    pdq = vectordot( pdir, qdir );
    qdq = vectordot( qdir, qdir );
    pdw = vectordot( pdir, segdelta );
    qdw = vectordot( qdir, segdelta );
    commondenominator = pdp * qdq - pdq * pdq;
    denominatorp = commondenominator;
    denominatorq = commondenominator;
    scalarp = 0;
    numeratorp = 0;
    scalarq = 0;
    numeratorq = 0;
    
    if ( commondenominator < 1e-08 )
    {
        numeratorp = 0;
        denominatorp = 1;
        numeratorq = qdw;
        denominatorq = qdq;
    }
    else
    {
        numeratorp = pdq * qdw - qdq * pdw;
        numeratorq = pdp * qdw - pdq * pdw;
        
        if ( numeratorp < 0 )
        {
            numeratorp = 0;
            numeratorq = qdw;
            denominatorq = qdq;
        }
        else if ( numeratorp > denominatorp )
        {
            numeratorp = denominatorp;
            numeratorq = qdw + pdq;
            denominatorq = qdq;
        }
    }
    
    if ( numeratorq < 0 )
    {
        numeratorq = 0;
        
        if ( pdw * -1 < 0 )
        {
            numeratorp = 0;
        }
        else if ( pdw * -1 > pdp )
        {
            numeratorp = denominatorp;
        }
        else
        {
            numeratorp = pdw * -1;
            denominatorp = pdp;
        }
    }
    else if ( numeratorq > denominatorq )
    {
        numeratorq = denominatorq;
        
        if ( pdq - pdw < 0 )
        {
            numeratorp = 0;
        }
        else if ( pdq - pdw > pdp )
        {
            numeratorp = denominatorp;
        }
        else
        {
            numeratorp = pdq - pdw;
            denominatorp = pdp;
        }
    }
    
    if ( abs( numeratorp ) > 1e-08 )
    {
        scalarp = numeratorp / denominatorp;
    }
    
    if ( abs( numeratorq ) > 1e-08 )
    {
        scalarq = numeratorq / denominatorq;
    }
    
    pa = p1 + scalarp * pdir;
    pb = p3 + scalarq * qdir;
    var_152611eabe5a5256 = [ pa, pb, distance( pa, pb ) ];
    return var_152611eabe5a5256;
}

// Namespace utility
// Params 0
// Checksum 0x7360a3ad, Offset: 0x1bbfe
// Size: 0xb, Type: bool
function cointoss()
{
    return randomint( 100 ) >= 50;
}

// Namespace utility
// Params 2
// Checksum 0xf6ecaa0f, Offset: 0x1bc12
// Size: 0x3a
function consume_dvar( dvar_name, default_value )
{
    value = getdvar( dvar_name, default_value );
    
    if ( value == default_value )
    {
        return;
    }
    
    setdvar( dvar_name, default_value );
    return value;
}

// Namespace utility
// Params 2
// Checksum 0x4a608f5b, Offset: 0x1bc55
// Size: 0x3a
function consume_dvar_int( dvar_name, default_value )
{
    value = getdvarint( dvar_name, default_value );
    
    if ( value == default_value )
    {
        return;
    }
    
    setdvar( dvar_name, default_value );
    return value;
}

// Namespace utility
// Params 4
// Checksum 0x17c39df8, Offset: 0x1bc98
// Size: 0x13c
function create_deck( item_array, autoshuffle, var_4a5b8543826fe61b, prevent_redraw )
{
    if ( !isdefined( item_array ) )
    {
        item_array = [];
    }
    else if ( !isarray( item_array ) )
    {
        item_array = [ item_array ];
    }
    
    deck = spawnstruct();
    deck.items = [];
    deck.index = 0;
    deck.cycle = 0;
    deck.autoshuffle = !isdefined( autoshuffle ) || autoshuffle;
    deck.prevent_redraw = !isdefined( prevent_redraw ) || prevent_redraw;
    
    foreach ( item in item_array )
    {
        deck.items[ deck.items.size ] = item;
    }
    
    if ( var_4a5b8543826fe61b )
    {
        deck deck_shuffle();
    }
    
    return deck;
}

// Namespace utility
// Params 1
// Checksum 0x794a22bf, Offset: 0x1bddd
// Size: 0x41
function create_empty_func_ref( name )
{
    if ( !isdefined( level.func ) )
    {
        level.func = [];
    }
    
    if ( !isdefined( level.func[ name ] ) )
    {
        create_func_ref( name, &empty_init_func );
    }
}

// Namespace utility
// Params 1
// Checksum 0x93d13d7a, Offset: 0x1be26
// Size: 0x5c
function create_flags_and_return_tokens( flags )
{
    tokens = strtok( flags, " " );
    
    for ( i = 0; i < tokens.size ; i++ )
    {
        if ( !isdefined( level.flag[ tokens[ i ] ] ) )
        {
            flag_init( tokens[ i ] );
        }
    }
    
    return tokens;
}

// Namespace utility
// Params 2
// Checksum 0xb76b20a9, Offset: 0x1be8b
// Size: 0x39
function create_func_ref( name, func )
{
    if ( !isdefined( level.func ) )
    {
        level.func = [];
    }
    
    level.func[ name ] = func;
}

// Namespace utility
// Params 2
// Checksum 0x5e268025, Offset: 0x1becc
// Size: 0x78
function create_lock( msg, count = 1 )
{
    assert( isdefined( msg ) );
    
    if ( !isdefined( level.lock ) )
    {
        level.lock = [];
    }
    
    lock_struct = spawnstruct();
    lock_struct.max_count = count;
    lock_struct.count = 0;
    level.lock[ msg ] = lock_struct;
}

// Namespace utility
// Params 3
// Checksum 0x30615c6a, Offset: 0x1bf4c
// Size: 0xd9
function create_partition( array, cell_size, optimized )
{
    assert( isdefined( array ), "<dev string:x267a>" );
    assert( isarray( array ), "<dev string:x26a6>" );
    assert( isdefined( cell_size ), "<dev string:x26e6>" );
    assert( isfloat( cell_size ) || isint( cell_size ), "<dev string:x2716>" );
    partition = { #coordinate_add:int( 150000 / 2 * cell_size ), #cell_size:cell_size, #array:[] };
    
    if ( !optimized || getdvarint( @"hash_b2f246425a6afd15", 0 ) > 0 )
    {
        create_partition_fallback( partition, array );
    }
    else
    {
        function_aa703f04592736d7( partition, array );
    }
    
    return partition;
}

// Namespace utility
// Params 2, eflags: 0x4
// Checksum 0x5ea08289, Offset: 0x1c02e
// Size: 0x8a
function private create_partition_fallback( partition, array )
{
    foreach ( object in array )
    {
        partition add_to_partition( object );
    }
    
    return partition;
}

// Namespace utility
// Params 2
// Checksum 0x90a0fa52, Offset: 0x1c0c1
// Size: 0x60
function createexploder( fxid, islevelexploder )
{
    ent = createfx::createeffect( "exploder", fxid, islevelexploder );
    ent.v[ "delay" ] = createfx::getexploderdelaydefault();
    ent.v[ "exploder_type" ] = "normal";
    return ent;
}

// Namespace utility
// Params 1
// Checksum 0xe6cc38ae, Offset: 0x1c12a
// Size: 0x3f
function createloopeffect( fxid )
{
    ent = createfx::createeffect( "loopfx", fxid );
    ent.v[ "delay" ] = createfx::getloopeffectdelaydefault();
    return ent;
}

// Namespace utility
// Params 1
// Checksum 0xfafd6507, Offset: 0x1c172
// Size: 0x3f
function createoneshoteffect( fxid )
{
    ent = createfx::createeffect( "oneshotfx", fxid );
    ent.v[ "delay" ] = createfx::getoneshoteffectdelaydefault();
    return ent;
}

// Namespace utility
// Params 2
// Checksum 0xa8093cd2, Offset: 0x1c1ba
// Size: 0x4d
function function_969f9f5596dba07a( ent, callbackfunction )
{
    if ( isdefined( level.var_ff28e0c14ba90179 ) )
    {
        [[ getsharedfunc( #"game", #"registerentincrushzones" ) ]]( ent );
        ent.var_a21f47f6f7811618 = callbackfunction;
    }
}

// Namespace utility
// Params 1
// Checksum 0x55cec61b, Offset: 0x1c20f
// Size: 0x5d
function function_a605d1fb62b31e70( ent )
{
    if ( isdefined( level.var_ff28e0c14ba90179 ) )
    {
        if ( issharedfuncdefined( #"game", #"unregisterentfromcrushzones", 0 ) )
        {
            [[ getsharedfunc( #"game", #"unregisterentfromcrushzones" ) ]]( ent );
        }
        
        ent.var_a21f47f6f7811618 = undefined;
    }
}

// Namespace utility
// Params 2
// Checksum 0x409a78a8, Offset: 0x1c274
// Size: 0x250
function players_stream_wait( players, var_e2c2d28710fbe79c = 0 )
{
    if ( !isarray( players ) )
    {
        players = [ players ];
    }
    
    allstreamed = 0;
    starttime = gettime();
    waitorigins = [];
    
    while ( !allstreamed )
    {
        now = gettime();
        allstreamed = 1;
        
        foreach ( player in players )
        {
            if ( !isplayer( player ) )
            {
                continue;
            }
            
            if ( player.sessionstate != "playing" )
            {
                continue;
            }
            
            playerkey = player.guid;
            var_4ac3be8ede222857 = starttime + player function_8088d408510470b8();
            
            if ( !isdefined( waitorigins[ playerkey ] ) || distancesquared( waitorigins[ playerkey ], player.origin ) > 400 )
            {
                player ent_flag_set( "player_additional_stream_pos_waiting" );
                player setadditionalstreamposuntilcleared( player.origin );
                waitorigins[ playerkey ] = player.origin;
            }
            
            if ( !player isadditionalstreamposready() && now < var_4ac3be8ede222857 )
            {
                allstreamed = 0;
                continue;
            }
            
            player ent_flag_clear( "player_additional_stream_pos_waiting", 1 );
        }
        
        if ( allstreamed )
        {
            break;
        }
        
        wait 0.25;
    }
    
    foreach ( player in players )
    {
        if ( !isplayer( player ) )
        {
            continue;
        }
        
        player clearadditionalstreampos();
    }
    
    totaltimesec = ( gettime() - starttime ) / 1000;
    var_99d58402e9064bbb = var_e2c2d28710fbe79c - totaltimesec;
    
    if ( var_99d58402e9064bbb > 0 )
    {
        wait var_99d58402e9064bbb;
    }
}

// Namespace utility
// Params 4, eflags: 0x40 variadic
// Checksum 0x6092dc33, Offset: 0x1c4cc
// Size: 0x9a
function noself_array_call( entities, process, ... )
{
    foreach ( ent in entities )
    {
        builtin [[ process ]]( ent, flat_args( vararg, varargcount ) );
    }
}

// Namespace utility
// Params 4, eflags: 0x40 variadic
// Checksum 0xf15b93d5, Offset: 0x1c56e
// Size: 0x34
function noself_delaycall( timer, func, ... )
{
    thread noself_delaycall_proc( func, timer, varargcount, vararg );
}

// Namespace utility
// Params 4, eflags: 0x4
// Checksum 0x1441163f, Offset: 0x1c5aa
// Size: 0x33
function private noself_delaycall_proc( func, timer, varargcount, vararg )
{
    wait timer;
    builtin [[ func ]]( flat_args( vararg, varargcount ) );
}

// Namespace utility
// Params 3, eflags: 0x40 variadic
// Checksum 0x61a7d0fd, Offset: 0x1c5e5
// Size: 0x43
function noself_func( func, ... )
{
    if ( !isdefined( level.func[ func ] ) )
    {
        return;
    }
    
    builtin [[ level.func[ func ] ]]( flat_args( vararg, varargcount ) );
}

// Namespace utility
// Params 3, eflags: 0x40 variadic
// Checksum 0x7e588f66, Offset: 0x1c630
// Size: 0x42
function noself_func_return( func, ... )
{
    if ( !isdefined( level.func[ func ] ) )
    {
        return;
    }
    
    return builtin [[ level.func[ func ] ]]( flat_args( vararg, varargcount ) );
}

// Namespace utility
// Params 0
// Checksum 0x31a7c6, Offset: 0x1c67b
// Size: 0x17
function function_a56cf359233cf85b()
{
    level.var_13b70b3b5724494f = 1;
    level.struct_class_names = undefined;
}

// Namespace utility
// Params 1
// Checksum 0x565c8077, Offset: 0x1c69a
// Size: 0x1e, Type: bool
function function_bf6b797c73abc9df( object )
{
    return object_is_valid_player( object ) && isalive( object );
}

// Namespace utility
// Params 1
// Checksum 0xd8484cc1, Offset: 0x1c6c1
// Size: 0x12
function object_is_valid_player( object )
{
    return isplayer( object );
}

// Namespace utility
// Params 1, eflags: 0x4
// Checksum 0x9388e900, Offset: 0x1c6dc
// Size: 0x20
function private function_7ce86f1f9971b24a( val )
{
    self notify( self.requestinggamerprofile + "_received", val );
}

// Namespace utility
// Params 0
// Checksum 0x40cd6676, Offset: 0x1c704
// Size: 0x9
function pauseeffect()
{
    createfx::stop_fx_looper();
}

// Namespace utility
// Params 1
// Checksum 0x817b38c, Offset: 0x1c715
// Size: 0x25, Type: bool
function percent_chance( probability )
{
    assert( isdefined( probability ), "<dev string:x275f>" );
    return randomfloat( 100 ) < probability;
}

// Namespace utility
// Params 2
// Checksum 0xd4bc1715, Offset: 0x1c743
// Size: 0xf1
function play_loop_sound_on_entity( alias, offset )
{
    org = spawn( "script_origin", ( 0, 0, 0 ) );
    org.targetname = "loop_sound_on_entity";
    org endon( #"death" );
    thread delete_on_death( org );
    
    if ( isdefined( offset ) )
    {
        org.origin = self.origin + offset;
        org.angles = self.angles;
        org linkto( self );
    }
    else
    {
        org.origin = self.origin;
        org.angles = self.angles;
        org linkto( self );
    }
    
    org playloopsound( alias );
    self waittill( "stop sound" + alias );
    org stoploopsound( alias );
    org delete();
}

// Namespace utility
// Params 5
// Checksum 0x1065ec8a, Offset: 0x1c83c
// Size: 0x15d
function play_loop_sound_on_tag( alias, tag, bstopsoundondeath, var_af7c308ffd7e030e, release_sound )
{
    org = spawn( "script_origin", ( 0, 0, 0 ) );
    org.targetname = "play_loop_soun_on_tag";
    org endon( #"death" );
    
    if ( !isdefined( bstopsoundondeath ) )
    {
        bstopsoundondeath = 1;
    }
    
    if ( bstopsoundondeath )
    {
        thread delete_on_death( org );
    }
    
    if ( !isdefined( var_af7c308ffd7e030e ) )
    {
        var_af7c308ffd7e030e = 0;
    }
    
    if ( var_af7c308ffd7e030e )
    {
        thread delete_on_removed( org );
    }
    
    if ( isdefined( tag ) )
    {
        org linkto( self, tag, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    }
    else
    {
        org.origin = self.origin;
        org.angles = self.angles;
        org linkto( self );
    }
    
    org playloopsound( alias );
    self waittill( "stop sound" + alias );
    
    if ( isdefined( release_sound ) )
    {
        org playsound( release_sound, "sounddone" );
        org delaycall( 0.15, &stoploopsound, alias );
        org waittill( #"sounddone" );
        org delete();
        return;
    }
    
    org stoploopsound( alias );
    org delete();
}

// Namespace utility
// Params 2
// Checksum 0xd65ade9d, Offset: 0x1c9a1
// Size: 0x70
function play_loopsound_in_space( alias, origin )
{
    org = spawn( "script_origin", ( 0, 0, 0 ) );
    org.targetname = "play_loopsound_in_space";
    
    if ( !isdefined( origin ) )
    {
        origin = self.origin;
    }
    
    org.origin = origin;
    org playloopsound( alias );
    return org;
}

// Namespace utility
// Params 3
// Checksum 0xcc54f81b, Offset: 0x1ca1a
// Size: 0x37
function play_sound_in_space( alias, origin, parent )
{
    play_sound_in_space_with_angles( alias, origin, ( 0, 0, 0 ), parent );
}

// Namespace utility
// Params 4
// Checksum 0xfc840aaa, Offset: 0x1ca59
// Size: 0xe4
function play_sound_in_space_with_angles( alias, origin, angles, parent )
{
    org = spawn( "script_origin", ( 0, 0, 1 ) );
    org.targetname = "play_sound_in_space_with_angles";
    org.origin = origin ?? self.origin;
    org.angles = angles;
    
    if ( isdefined( parent ) )
    {
        org linkto( parent );
    }
    
    /#
        if ( isdefined( self.v ) )
        {
            org.createfx_ent = 1;
        }
    #/
    
    if ( issp() )
    {
        org playsound( alias, "sounddone" );
        org waittill( #"sounddone" );
    }
    else
    {
        org playsound( alias );
    }
    
    org delete();
}

// Namespace utility
// Params 5
// Checksum 0x65ed29c, Offset: 0x1cb45
// Size: 0x9e
function player_drop_to_ground( pos, radius, updist = 1500, downdist = -12000, upvector )
{
    contents = trace::create_solid_ai_contents( 1 );
    
    if ( isdefined( upvector ) )
    {
        return trace::sphere_trace( pos + updist * upvector, pos + downdist * upvector, radius, undefined, contents )[ "position" ];
    }
    
    return trace::sphere_trace( pos + ( 0, 0, updist ), pos + ( 0, 0, downdist ), radius, undefined, contents )[ "position" ];
}

// Namespace utility
// Params 0
// Checksum 0xbf793e3c, Offset: 0x1cbeb
// Size: 0x24, Type: bool
function function_9a642b48e5d7a5af()
{
    assert( isplayer( self ) );
    
    if ( self isps4player() || self isxb3player() )
    {
        return true;
    }
    
    return false;
}

// Namespace utility
// Params 0
// Checksum 0xa9c9d303, Offset: 0x1cc18
// Size: 0x3, Type: bool
function player_is_in_jackal()
{
    return false;
}

// Namespace utility
// Params 5
// Checksum 0x8ae41778, Offset: 0x1cc24
// Size: 0x101
function player_prestream_assets( category, assettype, assets, distances, duration = 5 )
{
    assert( isstring( category ), "<dev string:x2783>" );
    
    if ( !isarray( assets ) )
    {
        assets = [ assets ];
    }
    
    if ( !isdefined( distances ) )
    {
        distances = [];
        
        foreach ( asset in assets )
        {
            distances[ distances.size ] = 50;
        }
    }
    else if ( !isarray( distances ) )
    {
        distances = [ distances ];
    }
    
    thread player_prestream_assets_thread( category, assettype, assets, distances, duration );
}

// Namespace utility
// Params 5, eflags: 0x4
// Checksum 0xef720eb7, Offset: 0x1cd2d
// Size: 0x2fb
function private player_prestream_assets_thread( category, assettype, assets, distances, duration )
{
    assert( isplayer( self ) );
    player = self;
    notifykey = "player_prestream_" + category + "_" + assettype;
    player notify( notifykey );
    player endon( notifykey );
    player endon( #"disconnect" );
    player function_5dce852387d152c4( category, assettype );
    
    if ( duration != 0 )
    {
        if ( !isdefined( player.prestream ) )
        {
            player.prestream = {};
        }
        
        if ( !isdefined( player.prestream.categories ) )
        {
            player.prestream.categories = [];
        }
        
        if ( !isdefined( player.prestream.categories[ category ] ) )
        {
            player.prestream.categories[ category ] = [];
        }
        
        assetdistances = [];
        
        foreach ( idx, asset in assets )
        {
            if ( isdefined( asset ) )
            {
                key = asset;
                
                if ( assettype == "entity" )
                {
                    key = "#ent" + asset getentitynumber();
                    
                    if ( !isdefined( player.prestream.entity_refs ) )
                    {
                        player.prestream.entity_refs = [];
                    }
                    
                    player.prestream.entity_refs[ key ] = asset;
                }
                
                assetdistances[ key ] = distances[ idx ];
            }
        }
        
        player.prestream.categories[ category ][ assettype ] = assetdistances;
        
        foreach ( key, dist in assetdistances )
        {
            if ( player function_72b767355af09ad8() >= 32 )
            {
                /#
                    iprintln( "<dev string:x27b6>" + category + "<dev string:x27db>" + 32 );
                #/
                
                break;
            }
            
            assetref = assettype == "entity" ? player.prestream.entity_refs[ key ] : key;
            player prestreamasset( assettype, assetref, dist );
        }
        
        if ( duration < 0 )
        {
            return;
        }
        
        wait duration;
        
        if ( isplayer( player ) )
        {
            player function_5dce852387d152c4( category, assettype );
        }
    }
}

// Namespace utility
// Params 2, eflags: 0x4
// Checksum 0x4ddfe54c, Offset: 0x1d030
// Size: 0x244
function private function_5dce852387d152c4( category, assettype )
{
    assetdistances = self.prestream.categories[ category ][ assettype ];
    
    if ( !isdefined( assetdistances ) )
    {
        return;
    }
    
    foreach ( key, dist in assetdistances )
    {
        otherdist = undefined;
        
        foreach ( othercat, var_ef59eeb7112f34e8 in self.prestream.categories )
        {
            if ( othercat == category )
            {
                continue;
            }
            
            d = var_ef59eeb7112f34e8[ assettype ][ key ];
            
            if ( isdefined( d ) )
            {
                if ( !isdefined( otherdist ) || d < otherdist )
                {
                    otherdist = d;
                }
            }
        }
        
        assetref = assettype == "entity" ? self.prestream.entity_refs[ key ] : key;
        
        if ( isdefined( otherdist ) )
        {
            if ( isdefined( assetref ) )
            {
                self prestreamasset( assettype, assetref, otherdist );
            }
            
            continue;
        }
        
        if ( isdefined( assetref ) )
        {
            self prestreamasset( assettype, assetref, -1 );
        }
        
        if ( assettype == "entity" )
        {
            self.prestream.entity_refs[ key ] = undefined;
        }
    }
    
    self.prestream.categories[ category ][ assettype ] = undefined;
    
    if ( !self.prestream.categories[ category ].size )
    {
        self.prestream.categories[ category ] = undefined;
        
        if ( !self.prestream.categories.size )
        {
            self.prestream = undefined;
        }
    }
}

// Namespace utility
// Params 1
// Checksum 0x85ba6eab, Offset: 0x1d27c
// Size: 0x1c0
function player_prestream_clear( category )
{
    assert( isplayer( self ) );
    
    if ( isdefined( category ) )
    {
        foreach ( assettype, typedata in self.prestream.categories[ category ] )
        {
            self notify( "player_prestream_" + category + "_" + assettype );
            function_5dce852387d152c4( category, assettype );
        }
        
        return;
    }
    
    foreach ( cat, catdata in self.prestream.categories )
    {
        foreach ( assettype, typedata in catdata )
        {
            self notify( "player_prestream_" + cat + "_" + assettype );
        }
    }
    
    self.prestream = undefined;
    self prestreamclear( "model" );
    self prestreamclear( "entity" );
}

// Namespace utility
// Params 3
// Checksum 0xf478cfe2, Offset: 0x1d444
// Size: 0x3d
function player_prestream_camera( position, duration = 5, altposition = undefined )
{
    thread player_prestream_camera_thread( position, duration, altposition );
}

// Namespace utility
// Params 3, eflags: 0x4
// Checksum 0x1ed4c9a1, Offset: 0x1d489
// Size: 0xb3
function private player_prestream_camera_thread( position, duration = 5, altposition = undefined )
{
    assert( isplayer( self ) );
    player = self;
    player notify( #"player_prestream_camera" );
    player endon( #"player_prestream_camera" );
    player endon( #"death_or_disconnect" );
    player clearadditionalstreampos();
    
    if ( isdefined( altposition ) )
    {
        player setadditionalstreamposuntilcleared( altposition );
    }
    
    player predictstreamposuntilcleared( position );
    
    if ( duration > 0 )
    {
        wait duration;
    }
    else if ( duration < 0 )
    {
        return;
    }
    
    player clearadditionalstreampos();
    player clearpredictedstreampos();
}

// Namespace utility
// Params 2
// Checksum 0x12f145fb, Offset: 0x1d544
// Size: 0x8d
function player_prestream_camera_wait( position, timeoutsec = 2 )
{
    assert( isplayer( self ) );
    player = self;
    player clearadditionalstreampos();
    player predictstreamposuntilcleared( position );
    endtime = gettime() + timeoutsec * 1000;
    
    while ( isdefined( player ) && gettime() < endtime )
    {
        waitframe();
        
        if ( player ispredictedstreamposready() )
        {
            break;
        }
    }
    
    if ( isdefined( player ) )
    {
        player clearpredictedstreampos();
    }
}

// Namespace utility
// Params 3
// Checksum 0x3686400b, Offset: 0x1d5d9
// Size: 0x32
function player_prestream_touch( assettype, asset, dist = 50 )
{
    thread function_f23e597bf8ac79da( assettype, asset, dist );
}

// Namespace utility
// Params 3, eflags: 0xc
// Checksum 0x51b05668, Offset: 0x1d613
// Size: 0x233
function private function_f23e597bf8ac79da( assettype, asset, dist )
{
    self notify( #"hash_785b9d0e69f37e8e" );
    self endon( #"hash_785b9d0e69f37e8e" );
    player = self;
    player endon( #"disconnect" );
    
    if ( !isdefined( player.prestreamtouch ) )
    {
        player.prestreamtouch = [];
    }
    
    if ( !isdefined( player.prestreamtouch[ assettype ] ) )
    {
        player.prestreamtouch[ assettype ] = [];
    }
    
    if ( isdefined( player.prestreamtouch[ assettype ][ asset ] ) )
    {
        player.prestreamtouch[ assettype ][ asset ] = min( player.prestreamtouch[ assettype ][ asset ], dist );
    }
    else
    {
        player.prestreamtouch[ assettype ][ asset ] = dist;
    }
    
    waittillframeend();
    cleartypes = [];
    
    foreach ( assettype, assets in player.prestreamtouch )
    {
        cleartypes[ cleartypes.size ] = assettype;
        player prestreamclear( assettype );
        
        foreach ( asset, dist in assets )
        {
            player prestreamasset( assettype, asset, dist );
        }
    }
    
    player.prestreamtouch = undefined;
    waitframe();
    
    foreach ( assettype in cleartypes )
    {
        player prestreamclear( assettype );
    }
}

// Namespace utility
// Params 0
// Checksum 0x98763674, Offset: 0x1d84e
// Size: 0x31
function function_8088d408510470b8()
{
    assert( isplayer( self ) );
    
    if ( function_9a642b48e5d7a5af() )
    {
        timeout = 30000;
    }
    else
    {
        timeout = 7000;
    }
    
    return timeout;
}

// Namespace utility
// Params 1
// Checksum 0x752f11c1, Offset: 0x1d888
// Size: 0x42, Type: bool
function isexplosivedamage( smeansofdeath )
{
    if ( !isdefined( smeansofdeath ) )
    {
        assertmsg( "<dev string:x27f0>" );
        return false;
    }
    
    return smeansofdeath == "MOD_EXPLOSIVE" || smeansofdeath == "MOD_GRENADE_SPLASH" || smeansofdeath == "MOD_PROJECTILE_SPLASH";
}

// Namespace utility
// Params 0, eflags: 0x4
// Checksum 0xb1a7c79e, Offset: 0x1d8d3
// Size: 0xc, Type: bool
function private function_f322c0f9fb3b8580()
{
    return istrue( self.var_3948c60099a64112 );
}

// Namespace utility
// Params 5
// Checksum 0x4a3559f4, Offset: 0x1d8e8
// Size: 0x185
function fadetoblackforplayerkeepui( player, fadetoblack, fadetime, var_a8c80c8156ac9bef, valuesid = "fadeToBlackForPlayerKeepUI" )
{
    if ( getdvarint( @"scr_disable_fade_to_black", 0 ) )
    {
        return;
    }
    
    if ( player function_f322c0f9fb3b8580() )
    {
        return;
    }
    
    player notify( "start_fade_to_black_keep_ui_" + valuesid );
    player endon( "start_fade_to_black_keep_ui_" + valuesid );
    player endon( #"disconnect" );
    level endon( #"game_ended" );
    
    if ( var_a8c80c8156ac9bef )
    {
        player endon( #"last_stand_exit" );
    }
    
    assert( !isdefined( fadetime ) || fadetime >= 0, "<dev string:x2818>" );
    fadealpha = 0;
    
    if ( fadetoblack )
    {
        fadealpha = 1;
    }
    
    if ( !isdefined( fadetime ) || fadetime == 0 )
    {
        player val::set( valuesid, "world_fade", fadealpha );
        return;
    }
    
    finalalpha = fadealpha;
    fadealpha = 0;
    fadetimecounter = int( fadetime / level.framedurationseconds );
    fadechange = 1 / fadetimecounter;
    
    if ( !fadetoblack )
    {
        fadechange *= -1;
        fadealpha = 1;
    }
    
    while ( fadetimecounter > 0 )
    {
        fadealpha += fadechange;
        player val::set( valuesid, "world_fade", fadealpha );
        fadetimecounter--;
        waitframe();
    }
    
    if ( finalalpha > 0 )
    {
        player val::set( valuesid, "world_fade", finalalpha );
        return;
    }
    
    player val::reset( valuesid, "world_fade" );
}

/#

    // Namespace utility
    // Params 1
    // Checksum 0xd2969acb, Offset: 0x1da75
    // Size: 0x3e, Type: dev
    function error( msg )
    {
        println( "<dev string:x2852>", msg );
        
        if ( getdvarint( @"scr_debug" ) != 1 )
        {
            assertmsg( "<dev string:x2860>" + msg );
        }
    }

#/

// Namespace utility
// Params 5
// Checksum 0xf87cdcdf, Offset: 0x1dabb
// Size: 0x8c
function exploder( num, players, starttime, radius, origin )
{
    if ( level.var_630c046b7e8fcc54 == gettime() )
    {
        delaythread( level.framedurationseconds, level._fx.exploderfunction, num, players, starttime, radius, origin );
        return;
    }
    
    self [[ level._fx.exploderfunction ]]( num, players, starttime, radius, origin );
}

// Namespace utility
// Params 6
// Checksum 0x1aef0b1e, Offset: 0x1db4f
// Size: 0x1bc
function fadetoblackforplayer( player, fadetoblack, fadetime, var_951f14d75c38443d, var_a8c80c8156ac9bef, valuesid = "fadeToBlackForPlayer" )
{
    if ( getdvarint( @"scr_disable_fade_to_black", 0 ) )
    {
        return;
    }
    
    if ( player function_f322c0f9fb3b8580() )
    {
        return;
    }
    
    player notify( "start_fade_to_black_" + valuesid );
    player endon( "start_fade_to_black_" + valuesid );
    player endon( #"disconnect" );
    
    if ( !var_951f14d75c38443d )
    {
        level endon( #"game_ended" );
    }
    
    if ( var_a8c80c8156ac9bef )
    {
        player endon( #"last_stand_exit" );
    }
    
    assert( !isdefined( fadetime ) || fadetime >= 0, "<dev string:x2890>" );
    fadealpha = 0;
    
    if ( fadetoblack )
    {
        fadealpha = 1;
    }
    
    if ( !isdefined( fadetime ) || fadetime == 0 )
    {
        player val::set( valuesid, "total_fade", fadealpha );
        return;
    }
    
    finalalpha = fadealpha;
    fadealpha = 0;
    fadetimecounter = int( fadetime / level.framedurationseconds );
    fadechange = 1 / fadetimecounter;
    
    if ( !fadetoblack )
    {
        fadechange *= -1;
        fadealpha = 1;
    }
    
    while ( fadetimecounter > 0 )
    {
        fadealpha += fadechange;
        
        if ( !isdefined( player ) || !player isconnected() )
        {
            return;
        }
        
        player val::set( valuesid, "total_fade", fadealpha );
        fadetimecounter--;
        waitframe();
    }
    
    if ( !isdefined( player ) )
    {
        return;
    }
    
    if ( finalalpha > 0 )
    {
        player val::set( valuesid, "total_fade", finalalpha );
    }
    else
    {
        player val::reset( valuesid, "total_fade" );
    }
    
    player notify( #"finish_fade_to_black" );
}

// Namespace utility
// Params 2
// Checksum 0xd907ae0, Offset: 0x1dd13
// Size: 0x3e
function get_notetrack_time( animation, notetrack )
{
    notetracktimes = getnotetracktimes( animation, notetrack );
    animlength = getanimlength( animation );
    return notetracktimes[ 0 ] * animlength;
}

// Namespace utility
// Params 1
// Checksum 0xeb6acdd9, Offset: 0x1dd5a
// Size: 0xc7
function get_noteworthy_array( noteworthy )
{
    assert( isdefined( noteworthy ), "<dev string:x28c4>" );
    ents = getentarray( noteworthy, #script_noteworthy );
    
    if ( ents.size > 0 )
    {
        return ents;
    }
    
    if ( issp() )
    {
        ents = builtin [[ level.getnodearrayfunction ]]( noteworthy, #script_noteworthy );
        
        if ( ents.size > 0 )
        {
            return ents;
        }
    }
    
    if ( isdefined( level.struct_class_names ) )
    {
        ents = getstructarray( noteworthy, "script_noteworthy" );
        
        if ( ents.size > 0 )
        {
            return ents;
        }
    }
    
    ents = getvehiclenodearray( noteworthy, #script_noteworthy );
    
    if ( ents.size > 0 )
    {
        return ents;
    }
    
    assert( "<dev string:x28e3>" + noteworthy + "<dev string:x2905>" );
}

// Namespace utility
// Params 1
// Checksum 0x1d741c93, Offset: 0x1de29
// Size: 0xba
function function_890559684b1ecb60( vector )
{
    assert( is_partition(), "<dev string:x291c>" );
    assert( isdefined( vector ), "<dev string:x2986>" );
    assert( isvector( vector ), "<dev string:x29c1>" );
    cell_size = self.cell_size;
    coordinate_add = self.coordinate_add;
    x = int( vector[ 0 ] / cell_size ) + coordinate_add;
    
    if ( x < 0 )
    {
        x = 0;
    }
    
    y = int( vector[ 1 ] / cell_size ) + coordinate_add;
    
    if ( y < 0 )
    {
        y = 0;
    }
    
    return [ x, y ];
}

// Namespace utility
// Params 1
// Checksum 0x7c7ac624, Offset: 0x1deec
// Size: 0xc8
function function_3bc2c606a1c39e2f( clientnum )
{
    client = getentbynum( clientnum );
    client = isplayer( client ) ? client : undefined;
    
    if ( !client )
    {
        foreach ( player in level.players )
        {
            if ( player callsharedfunc( #"player", #"getplayerclientnum" ) == clientnum )
            {
                return player;
            }
        }
    }
    
    return client;
}

// Namespace utility
// Params 0
// Checksum 0x19efa795, Offset: 0x1dfbd
// Size: 0x2b
function get_player_camera_origin()
{
    assert( isplayer( self ), "<dev string:x2a0f>" );
    
    if ( self getcamerathirdperson() )
    {
        return self getcamerathirdpersonorigin();
    }
    
    return self getvieworigin();
}

// Namespace utility
// Params 1
// Checksum 0x32e2b60a, Offset: 0x1dff0
// Size: 0x24
function function_9e8f69121ec4b65d( descriptionstring )
{
    if ( !isxhash( descriptionstring ) )
    {
        descriptionstring = getxhash( descriptionstring );
    }
    
    return function_4042d2fbe6237835( descriptionstring );
}

// Namespace utility
// Params 1
// Checksum 0xc1d4f947, Offset: 0x1e01d
// Size: 0x33, Type: bool
function function_1e6de0f4874e10be( variable )
{
    if ( !isdefined( variable ) )
    {
        return true;
    }
    
    if ( isxhashasset( variable ) && variable == %"" )
    {
        return true;
    }
    
    return false;
}

// Namespace utility
// Params 0
// Checksum 0x179c582c, Offset: 0x1e059
// Size: 0x80
function function_645a77750f1850b5()
{
    assert( flag( "<dev string:x2a41>" ), "<dev string:x2a5e>" );
    var_ef057d6ea73e1a53 = level.sharedfuncs[ #"engine" ][ #"hash_ff8355771dcc2c20" ];
    
    if ( !isdefined( var_ef057d6ea73e1a53 ) )
    {
        assert( !issp(), "<dev string:x2aba>" );
        level.var_f8f564d5b2b09e05 = 0;
        return 0;
    }
    
    level.var_f8f564d5b2b09e05 = builtin [[ var_ef057d6ea73e1a53 ]]();
    return level.var_f8f564d5b2b09e05;
}

// Namespace utility
// Params 1
// Checksum 0x6cc852f1, Offset: 0x1e0e2
// Size: 0x52, Type: bool
function is_valid_weapon_name( weapon_name )
{
    if ( !isstring( weapon_name ) )
    {
        return false;
    }
    
    weapon = makeweaponfromstring( weapon_name );
    
    if ( !isweapon( weapon ) || isnullweapon( weapon ) )
    {
        assertmsg( weapon_name + "<dev string:x2adf>" );
        return false;
    }
    
    return true;
}

// Namespace utility
// Params 7, eflags: 0x4
// Checksum 0x404f931f, Offset: 0x1e13d
// Size: 0x1cc
function private get_ground_positions( pos, direction, dist, updist, downdist, contents, ignore )
{
    var_d1fce691f687d31a = squared( 5 );
    offset = direction * dist;
    pos_a = pos + offset;
    pos_b = pos - offset;
    nav_trace_results = navtrace( pos, pos_a, undefined, 1 );
    
    if ( isdefined( nav_trace_results[ "position" ] ) && nav_trace_results[ "fraction" ] < 1 )
    {
        pos_a = nav_trace_results[ "position" ];
    }
    
    nav_trace_results = navtrace( pos, pos_b, undefined, 1 );
    
    if ( isdefined( nav_trace_results[ "position" ] ) && nav_trace_results[ "fraction" ] < 1 )
    {
        pos_b = nav_trace_results[ "position" ];
    }
    
    if ( distancesquared( pos_a, pos_b ) >= var_d1fce691f687d31a )
    {
        up_vertical_offset = ( 0, 0, updist );
        down_vertical_offset = ( 0, 0, downdist ?? updist * -1 );
        ray_contents = contents ?? trace::create_solid_ai_contents( 1 );
        ray_trace_a = trace::ray_trace( pos_a + up_vertical_offset, pos_a + down_vertical_offset, ignore, ray_contents );
        ray_trace_b = trace::ray_trace( pos_b + up_vertical_offset, pos_b + down_vertical_offset, ignore, ray_contents );
        pos_a_ground = ray_trace_a[ "hittype" ] != "hittype_none" ? ray_trace_a[ "position" ] : pos;
        pos_b_ground = ray_trace_b[ "hittype" ] != "hittype_none" ? ray_trace_b[ "position" ] : pos;
        return { #pos_b:pos_b_ground, #pos_a:pos_a_ground };
    }
}

// Namespace utility
// Params 3
// Checksum 0xa9a10e8a, Offset: 0x1e312
// Size: 0x269
function function_822c5feaca90abc1( origin, radius, usesphere = 1 )
{
    assert( is_partition(), "<dev string:x1ff3>" );
    assert( isdefined( origin ), "<dev string:x205b>" );
    assert( isvector( origin ), "<dev string:x2094>" );
    assert( isdefined( radius ), "<dev string:x20ed>" );
    assert( isnumber( radius ), "<dev string:x2126>" );
    assert( !isdefined( usesphere ) || isnumber( usesphere ) && usesphere == 1 || usesphere == 0, "<dev string:x217e>" );
    var_25a0fba0031a1a69 = int( ceil( radius / self.cell_size ) );
    [ x, y ] = function_890559684b1ecb60( origin );
    radius_squared = radius * radius;
    returned = [];
    
    for ( x_offset = var_25a0fba0031a1a69 * -1; x_offset <= var_25a0fba0031a1a69 ; x_offset++ )
    {
        x_test = x + x_offset;
        
        if ( x_test < 0 )
        {
            continue;
        }
        
        x_array = self.array[ x_test ];
        
        if ( !isdefined( x_array ) )
        {
            continue;
        }
        
        for ( y_offset = var_25a0fba0031a1a69 * -1; y_offset <= var_25a0fba0031a1a69 ; y_offset++ )
        {
            y_test = y + y_offset;
            
            if ( y_test < 0 )
            {
                continue;
            }
            
            x_y_array = x_array[ y_test ];
            
            if ( !isdefined( x_y_array ) )
            {
                continue;
            }
            
            foreach ( object in x_y_array )
            {
                if ( usesphere && distancesquared( object.origin, origin ) < radius_squared )
                {
                    returned[ returned.size ] = object;
                    continue;
                }
                
                if ( usesphere == 0 && distance2dsquared( object.origin, origin ) < radius_squared )
                {
                    returned[ returned.size ] = object;
                }
            }
        }
    }
    
    return returned;
}

// Namespace utility
// Params 1
// Checksum 0x4fc2c953, Offset: 0x1e584
// Size: 0x1b
function get_int_or_0( value )
{
    if ( !isdefined( value ) )
    {
        return 0;
    }
    
    return int( value );
}

// Namespace utility
// Params 2
// Checksum 0xc3a95efc, Offset: 0x1e5a8
// Size: 0x75
function function_abd2746ec6da48fa( index, should_uppercase = 0 )
{
    alphabet = "abcdefghijklmnopqrstuvwxyz";
    
    if ( index < 0 || index >= alphabet.size )
    {
        assertmsg( "<dev string:x2b26>" + index + "<dev string:x2b3d>" + alphabet.size - 1 );
        return "a";
    }
    
    return should_uppercase ? toupper( alphabet[ index ] ) : alphabet[ index ];
}

// Namespace utility
// Params 0
// Checksum 0x6885e19c, Offset: 0x1e626
// Size: 0x2b, Type: bool
function is_partition()
{
    return isdefined( self ) && isdefined( self.array ) && isdefined( self.cell_size ) && isdefined( self.coordinate_add );
}

// Namespace utility
// Params 0
// Checksum 0xf2584554, Offset: 0x1e65a
// Size: 0x36
function is_player_gamepad_enabled()
{
    if ( !isplayer( self ) )
    {
        return 0;
    }
    
    player_gpad_enabled = self usinggamepad();
    
    if ( isdefined( player_gpad_enabled ) )
    {
        return player_gpad_enabled;
    }
    else if ( self ispcplayer() )
    {
        return 0;
    }
    
    return 1;
}

// Namespace utility
// Params 1
// Checksum 0xe3532df8, Offset: 0x1e699
// Size: 0xa9, Type: bool
function function_143713a7a54c776e( model_name )
{
    category_strings = [ "special", "elite", "boss" ];
    
    foreach ( string in category_strings )
    {
        if ( issubstr( model_name, string ) )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace utility
// Params 2
// Checksum 0x11b752bb, Offset: 0x1e74b
// Size: 0x3e, Type: bool
function function_f77200072cabe8bc( ent, parent )
{
    for ( checkent = parent; checkent ; checkent = checkent getlinkedparent() )
    {
        if ( checkent == ent )
        {
            return false;
        }
    }
    
    return true;
}

// Namespace utility
// Params 1
// Checksum 0x14a7a354, Offset: 0x1e792
// Size: 0x39
function spin_entity( time )
{
    level endon( #"game_end" );
    
    while ( isdefined( 1 ) )
    {
        self rotateby( ( 0, 360, 0 ), time );
        wait time;
    }
}

