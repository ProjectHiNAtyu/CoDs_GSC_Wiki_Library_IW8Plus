// scripts\mp\interaction.gsc  (hash_27623f7ac600060c.gscc) (size: 9042 Bytes / 0x2352 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xe0633c88 (3764599944)
// size ...... 9042 (0x2352)
// includes .. 4   (offset: 0x215a)
// strings ... 13  (offset: 0x217a)
// dev strs .. 21  (offset: 0x224e)
// exports ... 31  (offset: 0x13da)
// cseg ...... 0x128 + 0x12b2 (0x13da)
// imports ... 71  (offset: 0x18b2)
// animtree1 . 0   (offset: 0x2352)
// animtree2 . 0   (offset: 0x2352)
#using scripts\common\devgui;
#using scripts\common\scriptable;
#using scripts\common\utility;
#using scripts\common\weapon;

#namespace interaction;

// Namespace interaction
// Params 0
// Checksum 0xe925edc6, Offset: 0x146
// Size: 0x3a
function init_interaction()
{
    level.interacts = [];
    scriptable::scriptable_addusedcallback( &on_scriptable_use );
    scriptable::scriptable_addautousecallback( &function_69474ee493f041c3 );
    scriptable::function_9a667ada3074523a( &function_8d8ac2d64f7ebbc1 );
    
    /#
        thread debug_interacts();
    #/
}

// Namespace interaction
// Params 6
// Checksum 0x52104988, Offset: 0x188
// Size: 0x130
function register_scriptable_interact( scriptable, on_use_function, var_aa860069b9a5fc3c, var_eacc7d96bf73810e, on_hint_callback, rumble = 0 )
{
    assert( !isent( scriptable ) && scriptable isscriptableinstance(), "<dev string:x24>" );
    assert( !arraycontains( level.interacts, scriptable ) );
    scriptable.var_d8e3b07237845727 = [];
    scriptable.var_ac8ffcf4a10f3e6d = [];
    scriptable.var_9718e0be9c5d54dd = [];
    scriptable.rumble = rumble;
    
    if ( isdefined( on_use_function ) )
    {
        scriptable set_interact_use_callback( on_use_function );
    }
    
    if ( isdefined( var_aa860069b9a5fc3c ) )
    {
        scriptable.var_ac8ffcf4a10f3e6d[ scriptable.var_ac8ffcf4a10f3e6d.size ] = var_aa860069b9a5fc3c;
    }
    
    if ( isdefined( var_eacc7d96bf73810e ) )
    {
        scriptable.var_9718e0be9c5d54dd[ scriptable.var_9718e0be9c5d54dd.size ] = var_eacc7d96bf73810e;
    }
    
    if ( isdefined( on_hint_callback ) )
    {
        scriptable set_interact_hint_callback( on_hint_callback );
    }
    
    scriptable thread function_7c26a0a669792cbe();
    level.interacts[ level.interacts.size ] = scriptable;
    return scriptable;
}

// Namespace interaction
// Params 9
// Checksum 0x75ec60a1, Offset: 0x2c1
// Size: 0x21a
function register_interact( org_or_ent, radius, use_callback, var_b2107da793be51f7, hint_string_arg, var_8371966544a3925c, var_6449a2acc5169b28, var_baf60cfe582e3a78, rumble = 0 )
{
    ent = undefined;
    
    if ( isvector( org_or_ent ) )
    {
        ent = spawn( "script_origin", org_or_ent );
        ent.targetname = "register_interact";
        
        if ( !isdefined( ent ) )
        {
            print( "<dev string:xa5>" );
            return;
        }
    }
    else
    {
        ent = org_or_ent;
    }
    
    assert( isent( ent ) );
    assert( !isdefined( use_callback ) || isfunction( use_callback ) );
    ent.rumble = rumble;
    ent makeusable();
    
    if ( isvalidmissile( ent ) )
    {
        ent enablemissilehint( 1 );
    }
    
    if ( isdefined( var_b2107da793be51f7 ) )
    {
        if ( !isfunction( var_b2107da793be51f7 ) )
        {
            ent sethintstring( var_b2107da793be51f7 );
        }
        else
        {
            ent set_interact_hint_callback( var_b2107da793be51f7 );
        }
    }
    
    ent sethintstringparams( hint_string_arg, var_8371966544a3925c );
    
    if ( !isdefined( radius ) )
    {
        radius = 64;
    }
    
    ent setuserange( radius );
    ent.interact_use_range = radius;
    ent.b_rumble = var_6449a2acc5169b28 ? 0 : 1;
    ent set_interact_use_callback( use_callback );
    ent thread function_3149976002d296c8();
    ent thread function_7c26a0a669792cbe();
    ent setusefov( 360 );
    
    if ( isdefined( var_baf60cfe582e3a78 ) )
    {
        ent setcursorhint( var_baf60cfe582e3a78 );
    }
    else if ( isdefined( level.gamemodebundle.var_da7da5cf9889933d ) && getdvarint( @"hash_dcbb04e69339acca", 0 ) != 1 )
    {
        ent setcursorhint( level.gamemodebundle.var_da7da5cf9889933d );
    }
    else
    {
        ent setcursorhint( "HINT_NOICON" );
    }
    
    assert( isarray( level.interacts ), "<dev string:xd1>" );
    level.interacts[ level.interacts.size ] = ent;
    return ent;
}

// Namespace interaction
// Params 1
// Checksum 0xccd7a84f, Offset: 0x4e4
// Size: 0x2f
function set_interact_use_callback( use_callback )
{
    assert( isfunction( use_callback ), "<dev string:x14b>" );
    self.var_d8e3b07237845727 = [ use_callback ];
}

// Namespace interaction
// Params 1
// Checksum 0x35ddedc2, Offset: 0x51b
// Size: 0xa9
function function_f79442a47b0daabe( use_callbacks )
{
    assert( isarray( use_callbacks ), "<dev string:x16d>" );
    
    /#
        foreach ( use_callback in use_callbacks )
        {
            assert( isfunction( use_callback ), "<dev string:x14b>" );
        }
    #/
    
    self.var_d8e3b07237845727 = use_callbacks;
}

// Namespace interaction
// Params 1
// Checksum 0x293f83d, Offset: 0x5cc
// Size: 0x4d
function function_91a222c02d62113e( use_callback )
{
    assert( isfunction( use_callback ), "<dev string:x14b>" );
    assert( isdefined( self.var_d8e3b07237845727 ), "<dev string:x191>" );
    self.var_d8e3b07237845727[ self.var_d8e3b07237845727.size ] = use_callback;
}

// Namespace interaction
// Params 1
// Checksum 0x877089f4, Offset: 0x621
// Size: 0x38
function set_interact_hint_callback( hint_callback )
{
    if ( isdefined( hint_callback ) )
    {
        assert( isfunction( hint_callback ) );
        self.interact_hint_callback = hint_callback;
        return;
    }
    
    self.interact_hint_callback = undefined;
}

// Namespace interaction
// Params 1
// Checksum 0xa568c6d8, Offset: 0x661
// Size: 0x38
function function_303bcca6287d3d71( var_3f6e1d654b8e3cb5 )
{
    if ( isdefined( var_3f6e1d654b8e3cb5 ) )
    {
        assert( isfunction( var_3f6e1d654b8e3cb5 ) );
        self.var_1e6940caec363c36 = var_3f6e1d654b8e3cb5;
        return;
    }
    
    self.var_1e6940caec363c36 = undefined;
}

// Namespace interaction
// Params 3
// Checksum 0xb3f17f5, Offset: 0x6a1
// Size: 0x42
function set_interact_hint_string( hint_string, hint_string_arg, var_8371966544a3925c )
{
    assert( self isusable() );
    
    if ( isdefined( hint_string ) )
    {
        self sethintstring( hint_string );
    }
    
    self sethintstringparams( hint_string_arg, var_8371966544a3925c );
}

// Namespace interaction
// Params 1
// Checksum 0xde98227c, Offset: 0x6eb
// Size: 0x32
function set_interact_use_range( radius )
{
    assert( self isusable() );
    
    if ( isdefined( radius ) )
    {
        self setuserange( radius );
        self.interact_use_range = radius;
    }
}

// Namespace interaction
// Params 0
// Checksum 0x62311de5, Offset: 0x725
// Size: 0xd
function function_3d5329c553924b3()
{
    self.var_bb46d5a7ea3aae62 = 1;
}

// Namespace interaction
// Params 0
// Checksum 0xd95fa6be, Offset: 0x73a
// Size: 0xd
function function_e4a4753e6eac02d7()
{
    self.var_69c82d94dce882a5 = 1;
}

// Namespace interaction
// Params 0
// Checksum 0x1ad62a26, Offset: 0x74f
// Size: 0xd
function function_351e9c92dc1c6b4d()
{
    self.var_84e0ce18864454a8 = 1;
}

// Namespace interaction
// Params 0
// Checksum 0x765df7ba, Offset: 0x764
// Size: 0xd
function function_c20d98995f855f91()
{
    self.var_ded8391a8299262 = 1;
}

// Namespace interaction
// Params 1
// Checksum 0x3d5e38e7, Offset: 0x779
// Size: 0x9e, Type: bool
function function_221183d25494e417( player )
{
    if ( !isplayer( player ) )
    {
        return true;
    }
    
    if ( !self.var_69c82d94dce882a5 && player.interactions_disabled )
    {
        return false;
    }
    
    if ( !self.var_bb46d5a7ea3aae62 )
    {
        return true;
    }
    
    if ( !self.var_84e0ce18864454a8 && player.insertingarmorplate || !self.var_ded8391a8299262 && player isswitchingweapon() )
    {
        return false;
    }
    
    currentweapon = player getcurrentweapon();
    
    if ( weapon::iskillstreakweapon( currentweapon ) )
    {
        return false;
    }
    
    return true;
}

// Namespace interaction
// Params 1, eflags: 0x4
// Checksum 0x4eda5710, Offset: 0x820
// Size: 0x21
function private function_5c54b42cc8a81a6e( player )
{
    if ( isplayer( player ) )
    {
        player playrumbleonentity( "use_interact" );
    }
}

// Namespace interaction
// Params 0, eflags: 0x4
// Checksum 0x29e4e691, Offset: 0x849
// Size: 0x25e
function private function_3149976002d296c8()
{
    self endon( #"death" );
    
    while ( isdefined( self ) )
    {
        self waittill( #"trigger", player );
        
        if ( function_221183d25494e417( player ) )
        {
            regiondifficulty = "none";
            poiname = "none";
            usetype = "none";
            
            if ( isfunction( level.var_bb131187d6741752 ) )
            {
                regiondifficulty = [[ level.var_bb131187d6741752 ]]( self.origin );
            }
            
            if ( utility::issharedfuncdefined( #"poi", #"get_poi_name_from_origin" ) )
            {
                poiname = utility::callsharedfunc( #"poi", #"get_poi_name_from_origin", self.origin );
            }
            
            if ( isdefined( self.model ) )
            {
                usetype = self.model;
            }
            
            if ( ( !isdefined( usetype ) || usetype == "" || usetype == "none" ) && isdefined( self.var_5a1a15178b1060b3 ) )
            {
                usetype = self.var_5a1a15178b1060b3;
            }
            
            if ( isdefined( usetype ) && isdefined( poiname ) && isdefined( regiondifficulty ) && isdefined( self ) && isdefined( self.origin ) && isdefined( player ) )
            {
                player dlog_recordplayerevent( "dlog_event_player_interaction", [ "interaction_x", self.origin[ 0 ], "interaction_y", self.origin[ 1 ], "interaction_z", self.origin[ 2 ], "interaction_poi", poiname, "threat_level", regiondifficulty, "type", usetype ] );
            }
            
            foreach ( callback in self.var_d8e3b07237845727 )
            {
                if ( isfunction( callback ) )
                {
                    if ( self.rumble )
                    {
                        function_5c54b42cc8a81a6e( player );
                    }
                    
                    self thread [[ callback ]]( player );
                }
            }
        }
        
        waitframe();
    }
}

// Namespace interaction
// Params 0, eflags: 0x4
// Checksum 0x677f6e06, Offset: 0xaaf
// Size: 0x26
function private function_7c26a0a669792cbe()
{
    self waittill( #"death" );
    level.interacts = arrayremove( level.interacts, self );
}

// Namespace interaction
// Params 6, eflags: 0x4
// Checksum 0x6615117e, Offset: 0xadd
// Size: 0x296
function private on_scriptable_use( instance, part, state, player, bautouse, usestring )
{
    e_container = undefined;
    
    if ( isdefined( instance ) && arraycontains( level.interacts, instance ) )
    {
        e_container = instance;
    }
    else if ( isdefined( instance ) && isdefined( instance.entity ) && arraycontains( level.interacts, instance.entity ) )
    {
        e_container = instance.entity;
    }
    
    if ( !isdefined( e_container ) )
    {
        return;
    }
    
    if ( e_container function_221183d25494e417( player ) )
    {
        regiondifficulty = "none";
        poiname = "none";
        
        if ( !isdefined( usestring ) )
        {
            usestring = "none";
        }
        
        if ( usestring == "none" && isstring( e_container.var_746b2f5b32febd08 ) )
        {
            usestring = e_container.var_746b2f5b32febd08;
        }
        
        if ( isfunction( level.var_bb131187d6741752 ) )
        {
            regiondifficulty = [[ level.var_bb131187d6741752 ]]( e_container.origin );
        }
        
        if ( utility::issharedfuncdefined( #"poi", #"get_poi_name_from_origin" ) )
        {
            poiname = utility::callsharedfunc( #"poi", #"get_poi_name_from_origin", e_container.origin );
        }
        
        player dlog_recordplayerevent( "dlog_event_player_interaction", [ "interaction_x", e_container.origin[ 0 ], "interaction_y", e_container.origin[ 1 ], "interaction_z", e_container.origin[ 2 ], "interaction_poi", poiname, "threat_level", regiondifficulty, "type", usestring ] );
        
        foreach ( callback in e_container.var_d8e3b07237845727 )
        {
            if ( isfunction( callback ) )
            {
                if ( e_container.rumble )
                {
                    function_5c54b42cc8a81a6e( player );
                }
                
                e_container thread [[ callback ]]( player );
            }
        }
    }
}

// Namespace interaction
// Params 6, eflags: 0x4
// Checksum 0x8073e42, Offset: 0xd7b
// Size: 0x143
function private function_69474ee493f041c3( instance, part, state, player, bautouse, usestring )
{
    e_container = undefined;
    
    if ( isdefined( instance ) && arraycontains( level.interacts, instance ) )
    {
        e_container = instance;
    }
    else if ( isdefined( instance ) && isdefined( instance.entity ) && arraycontains( level.interacts, instance.entity ) )
    {
        e_container = instance.entity;
    }
    
    if ( !isdefined( e_container ) )
    {
        return;
    }
    
    foreach ( callback in e_container.var_ac8ffcf4a10f3e6d )
    {
        if ( isfunction( callback ) )
        {
            if ( e_container.rumble )
            {
                function_5c54b42cc8a81a6e( player );
            }
            
            e_container [[ callback ]]( player );
        }
    }
}

// Namespace interaction
// Params 5, eflags: 0x4
// Checksum 0x2771e507, Offset: 0xec6
// Size: 0x132
function private function_8d8ac2d64f7ebbc1( instance, part, state, player, useduration )
{
    e_container = undefined;
    
    if ( isdefined( instance ) && arraycontains( level.interacts, instance ) )
    {
        e_container = instance;
    }
    else if ( isdefined( instance ) && isdefined( instance.entity ) && arraycontains( level.interacts, instance.entity ) )
    {
        e_container = instance.entity;
    }
    
    if ( !( isdefined( e_container ) && isdefined( e_container.var_9718e0be9c5d54dd ) ) )
    {
        return;
    }
    
    foreach ( callback in e_container.var_9718e0be9c5d54dd )
    {
        if ( isfunction( callback ) )
        {
            e_container [[ callback ]]( player );
        }
    }
}

/#

    // Namespace interaction
    // Params 0, eflags: 0x4
    // Checksum 0xb41a7120, Offset: 0x1000
    // Size: 0x72, Type: dev
    function private debug_interacts()
    {
        devgui::function_9082edeb5db93280( "<dev string:x1b8>" );
        devgui::add_devgui_func( "<dev string:x1c9>", "<dev string:x1db>", &function_4ee872f05b396315, 1 );
        devgui::add_devgui_func( "<dev string:x1ed>", "<dev string:x20a>", &function_3e5dbd1d13df8717 );
        devgui::add_devgui_func( "<dev string:x227>", "<dev string:x244>", &function_ce8472659925091e );
        devgui::add_devgui_func( "<dev string:x260>", "<dev string:x27e>", &debug_draw_interacts );
        devgui::function_77df7fe7dd273e10();
    }

    // Namespace interaction
    // Params 0, eflags: 0x4
    // Checksum 0xc1146703, Offset: 0x107a
    // Size: 0x46, Type: dev
    function private function_4ee872f05b396315()
    {
        pos = devgui::function_97024c0a6d1256a6();
        interact = register_interact( pos );
        interact set_interact_hint_string( &"cp_zmb_interactions/purchase_area", &"cp_zmb_interactions/enter_this_area", 100 );
    }

    // Namespace interaction
    // Params 0, eflags: 0x4
    // Checksum 0xb37f4d7f, Offset: 0x10c8
    // Size: 0x51, Type: dev
    function private function_3e5dbd1d13df8717()
    {
        pos = devgui::function_97024c0a6d1256a6();
        item = spawnscriptable( "<dev string:x28f>", pos, ( 0, 0, 0 ) );
        register_scriptable_interact( item, &function_6186857a9e3a6cc8, &function_fcf66c3c1dc29370, &function_7ec974a0ad7ae83a );
    }

    // Namespace interaction
    // Params 1, eflags: 0x4
    // Checksum 0x648dbdbe, Offset: 0x1121
    // Size: 0x15, Type: dev
    function private function_6186857a9e3a6cc8( player )
    {
        self freescriptable();
    }

    // Namespace interaction
    // Params 1, eflags: 0x4
    // Checksum 0x8a18a0c8, Offset: 0x113e
    // Size: 0x55, Type: dev
    function private function_fcf66c3c1dc29370( player )
    {
        recordline( self.origin, self.origin + ( 0, 0, 72 ) );
        record3dtext( "<dev string:x29d>", self.origin + ( 0, 0, 72 ) );
    }

    // Namespace interaction
    // Params 1, eflags: 0x4
    // Checksum 0xbf8b8a5c, Offset: 0x119b
    // Size: 0x55, Type: dev
    function private function_7ec974a0ad7ae83a( player )
    {
        recordline( self.origin, self.origin + ( 0, 0, 72 ) );
        record3dtext( "<dev string:x2ab>", self.origin + ( 0, 0, 72 ) );
    }

    // Namespace interaction
    // Params 0, eflags: 0x4
    // Checksum 0xc850a0b9, Offset: 0x11f8
    // Size: 0x37, Type: dev
    function private function_ce8472659925091e()
    {
        pos = devgui::function_97024c0a6d1256a6();
        interact = register_interact( pos );
        interact set_interact_hint_callback( &function_8dfee84c254e7fe0 );
    }

    // Namespace interaction
    // Params 2, eflags: 0x4
    // Checksum 0xeceba7fe, Offset: 0x1237
    // Size: 0x94, Type: dev
    function private function_8dfee84c254e7fe0( usable, player )
    {
        current_weapon = player getcurrentweapon();
        
        if ( current_weapon.ismelee )
        {
            return { #string:&"cp_zmb_interactions/upgrade_weapon_fail", #type:"<dev string:x2bc>" };
        }
        
        return { #params:[ 0, 100 ], #string:&"cp_zmb_interactions/upgrade_weapon_generic", #type:"<dev string:x2ca>" };
    }

    // Namespace interaction
    // Params 0, eflags: 0x4
    // Checksum 0x305fec30, Offset: 0x12d3
    // Size: 0x107, Type: dev
    function private debug_draw_interacts()
    {
        level endon( #"game_ended" );
        
        while ( true )
        {
            waitframe();
            
            if ( !isdefined( level.interacts ) )
            {
                continue;
            }
            
            foreach ( interact_ent in level.interacts )
            {
                if ( !isdefined( interact_ent ) )
                {
                    continue;
                }
                
                if ( isdefined( interact_ent.interact_use_range ) )
                {
                    utility::draw_circle( interact_ent.origin, interact_ent.interact_use_range, ( 1, 0, 0 ), 1, 1, 1 );
                }
                
                record3dtext( "<dev string:x2d6>", interact_ent.origin + ( 0, 0, 32 ) );
            }
        }
    }

#/
