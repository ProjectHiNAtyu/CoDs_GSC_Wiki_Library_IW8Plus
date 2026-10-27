// script_2de83d6261680959  (hash_2de83d6261680959.gscc) (size: 14841 Bytes / 0x39f9 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x1793bd45 (395558213)
// size ...... 14841 (0x39f9)
// includes .. 10  (offset: 0x3645)
// strings ... 37  (offset: 0x3695)
// dev strs .. 14  (offset: 0x394d)
// exports ... 29  (offset: 0x2729)
// cseg ...... 0x348 + 0x23e1 (0x2729)
// imports ... 80  (offset: 0x2bb1)
// animtree1 . 0   (offset: 0x39f9)
// animtree2 . 0   (offset: 0x39f9)
#using script_4fb7a9021a570c8a;
#using script_6d4c5bf7d72d6d4a;
#using script_79edb4ed1f52fb62;
#using scripts\asm\asm;
#using scripts\common\ai\aitypes\shared\zombie\zombie_utils;
#using scripts\common\callbacks;
#using scripts\common\devgui;
#using scripts\common\math;
#using scripts\common\metabone;
#using scripts\common\utility;

#namespace zombie_diana_metabones;

// Namespace zombie_diana_metabones
// Params 0, eflags: 0x1
// Checksum 0x3d5950b0, Offset: 0x366
// Size: 0x2f
function autoexec main()
{
    var_fb56e56d94279338 = "zombie_diana";
    metabone::function_7b57cab1f2311c7b( var_fb56e56d94279338, &function_7af73e5c3e2c4b17 );
    metabone::function_cd947f1a3391c065( var_fb56e56d94279338, &on_metabone_destroyed );
}

// Namespace zombie_diana_metabones
// Params 0
// Checksum 0xafae382e, Offset: 0x39d
// Size: 0x2c
function function_380db743947ddada()
{
    callback::get_template( self.animsetname ) callback::add( "on_zombie_ai_killed", &function_99c318ec735167a1 );
    
    /#
        metabones_devgui();
    #/
}

// Namespace zombie_diana_metabones
// Params 0
// Checksum 0x989effa6, Offset: 0x3d1
// Size: 0x160
function init_zombie_diana_metabones()
{
    metabone::function_b68bd9932f284448( &function_b31215cb1ebba807 );
    self.metabonedetails = [];
    self.var_dd5923317ef414fb = [];
    self.var_204d3dbbe1801350 = [];
    self.var_d1ce161ba454368f = 0;
    metabonesdef = metabone::get_metabones_def( self.metabones.bundle_name );
    
    foreach ( metabone in metabonesdef.metabones )
    {
        if ( issubstr( metabone.name, "eye" ) )
        {
            continue;
        }
        
        details = { #state:"default" };
        
        if ( metabone.tags && metabone.tags.size > 0 )
        {
            details.tagname = metabone.tags[ 0 ].tagname;
        }
        
        self.metabonedetails[ metabone.name ] = details;
    }
    
    thread function_7925a3d7192404f3();
}

// Namespace zombie_diana_metabones
// Params 0
// Checksum 0x6e60a7cd, Offset: 0x539
// Size: 0x82
function turn_off_metabones()
{
    var_fb56e56d94279338 = "zombie_diana";
    metabone::function_18cd355aaa8fb938( var_fb56e56d94279338, &function_7af73e5c3e2c4b17 );
    metabone::function_1024597ed2932aba( var_fb56e56d94279338, &on_metabone_destroyed );
    metabone::function_b68bd9932f284448( undefined );
    self.var_d1ce161ba454368f = 0;
    self notify( #"hash_2defb0488eb77181" );
    utility::ent_flag_wait_or_timeout( "zombie_diana_armor_ent_init_complete", 3 );
    function_99c318ec735167a1();
    callback::get_template( self.animsetname ) callback::remove( "on_zombie_ai_killed", &function_99c318ec735167a1 );
}

// Namespace zombie_diana_metabones
// Params 1
// Checksum 0x4a7172c0, Offset: 0x5c3
// Size: 0x17
function function_324024ba7d02c81c( enabled )
{
    self.var_d1ce161ba454368f = enabled;
}

// Namespace zombie_diana_metabones
// Params 2
// Checksum 0x559b36a8, Offset: 0x5e2
// Size: 0x378
function function_c6fe3062616ddd88( var_22eb0b5daf4cd404, var_b8a198f4acbcb8a4 )
{
    preferredspots = [];
    wingspots = [];
    
    foreach ( name, details in self.metabonedetails )
    {
        if ( details.state == "scarred" )
        {
            continue;
        }
        
        if ( name == "wing_left" || name == "wing_right" )
        {
            wingspots = arraycombineunique( wingspots, [ name ] );
            continue;
        }
        
        preferredspots = arraycombineunique( preferredspots, [ name ] );
    }
    
    keepspots = [];
    var_a3abf00000d46a67 = preferredspots.size < var_22eb0b5daf4cd404 ? preferredspots.size : var_22eb0b5daf4cd404;
    
    for ( i = 0; i < var_a3abf00000d46a67 ; i++ )
    {
        keepspots = arraycombineunique( keepspots, [ preferredspots[ i ] ] );
    }
    
    var_56a078c6c72ffeca = var_22eb0b5daf4cd404 - var_a3abf00000d46a67;
    var_56a078c6c72ffeca = wingspots.size < var_56a078c6c72ffeca ? wingspots.size : var_56a078c6c72ffeca;
    
    for ( i = 0; i < var_56a078c6c72ffeca ; i++ )
    {
        keepspots = arraycombineunique( keepspots, [ wingspots[ i ] ] );
    }
    
    weakspotstate = self.var_47d084561e9513ca || var_b8a198f4acbcb8a4 ? "destroyed_during_flight" : "destroyed";
    
    foreach ( name, details in self.metabonedetails )
    {
        if ( details.state == "scarred" )
        {
            continue;
        }
        
        var_7f7fc1dc3fb8991a = 0;
        
        foreach ( keepname in keepspots )
        {
            if ( keepname == name )
            {
                var_7f7fc1dc3fb8991a = 1;
                break;
            }
        }
        
        if ( !var_7f7fc1dc3fb8991a )
        {
            metabone::set_metabone_state( name, "scarred" );
            self.metabonedetails[ name ].state = "scarred";
            metabone::set_metabone_active( name, 1 );
            utility::function_7c10ea82c1e305b8( name, "off" );
            
            if ( isdefined( self.armorents[ name ] ) )
            {
                self.armorents[ name ] delete();
                self.armorents[ name ] = undefined;
            }
            
            continue;
        }
        
        metabone::set_metabone_state( name, weakspotstate );
        self.metabonedetails[ name ].state = weakspotstate;
        metabone::set_metabone_active( name, 1 );
        utility::function_32b24db3127bff40( name, "destroyed_shifted_to" );
        
        if ( isdefined( self.armorents[ name ] ) )
        {
            self.armorents[ name ] setscriptablepartstate( "armor", "destroyed" );
        }
    }
}

// Namespace zombie_diana_metabones
// Params 1
// Checksum 0xe0449668, Offset: 0x962
// Size: 0x3da
function function_258cc64099d507fc( targetspots )
{
    if ( !self.var_d1ce161ba454368f )
    {
        return;
    }
    
    foreach ( targetname in targetspots )
    {
        if ( self.metabonedetails[ targetname ] && self.metabonedetails[ targetname ].state == "scarred" )
        {
            shiftdestination = targetname;
            break;
        }
    }
    
    if ( !shiftdestination )
    {
        return;
    }
    
    foreach ( name, details in self.metabonedetails )
    {
        if ( details.state != "destroyed" && details.state != "destroyed_during_flight" )
        {
            continue;
        }
        
        istarget = 0;
        
        foreach ( targetname in targetspots )
        {
            if ( name == targetname )
            {
                istarget = 1;
                break;
            }
        }
        
        if ( !istarget )
        {
            sourcespot = name;
            var_fbb582fedb7dc8ac = details.state;
            break;
        }
    }
    
    if ( !sourcespot )
    {
        return;
    }
    
    var_5ca210e58833f44b = metabone::get_metabone_health( sourcespot );
    metabone::set_metabone_state( sourcespot, "scarred" );
    self.metabonedetails[ sourcespot ].state = "scarred";
    metabone::set_metabone_active( sourcespot, 1 );
    utility::function_7c10ea82c1e305b8( sourcespot, "off" );
    
    if ( isdefined( self.armorents[ sourcespot ] ) )
    {
        self.armorents[ sourcespot ] delete();
        self.armorents[ sourcespot ] = undefined;
    }
    
    metabone::set_metabone_state( shiftdestination, var_fbb582fedb7dc8ac );
    self.metabonedetails[ shiftdestination ].state = var_fbb582fedb7dc8ac;
    metabone::set_metabone_active( shiftdestination, 1 );
    utility::function_7c10ea82c1e305b8( shiftdestination, "destroyed_shifted_to" );
    metabone::set_metabone_health( shiftdestination, var_5ca210e58833f44b );
    tagname = self.metabonedetails[ shiftdestination ].tagname;
    tagorigin = self gettagorigin( tagname );
    boneent = utility::spawn_model( self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.var_35d4d2204f8cf1c4, tagorigin, self.angles );
    boneent setscriptablepartstate( "armor", "destroyed" );
    boneent linkto( self, tagname, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    boneent.tagname = tagname;
    boneent enableaimassist();
    self.armorents[ shiftdestination ] = boneent;
    self.var_204d3dbbe1801350[ shiftdestination ] = undefined;
    self.var_5b2e5d869a66b0ce = sourcespot;
    self.var_c9e6fc3340c7b73 = var_fbb582fedb7dc8ac;
    self.var_7ac3216aade0bcb5 = shiftdestination;
    self.var_93cfbff487c22c71 = targetspots;
    self notify( #"hash_9c092781280007b3", sourcespot, shiftdestination );
}

// Namespace zombie_diana_metabones
// Params 0
// Checksum 0xccbffc79, Offset: 0xd44
// Size: 0x478
function function_7be0540f93d9f77f()
{
    if ( !self.var_5b2e5d869a66b0ce || !self.var_7ac3216aade0bcb5 )
    {
        return;
    }
    
    tospot = self.var_5b2e5d869a66b0ce;
    tostate = self.var_c9e6fc3340c7b73;
    fromspot = self.var_7ac3216aade0bcb5;
    targetspots = self.var_93cfbff487c22c71;
    self.var_5b2e5d869a66b0ce = undefined;
    self.var_c9e6fc3340c7b73 = undefined;
    self.var_7ac3216aade0bcb5 = undefined;
    self.var_93cfbff487c22c71 = undefined;
    deststate = self.metabonedetails[ fromspot ].state;
    
    if ( deststate != "destroyed" && deststate != "destroyed_during_flight" )
    {
        return;
    }
    
    if ( self.metabonedetails[ tospot ].state != "scarred" )
    {
        alternatespot = undefined;
        
        foreach ( name, details in self.metabonedetails )
        {
            if ( details.state != "scarred" )
            {
                continue;
            }
            
            istarget = 0;
            
            foreach ( targetname in targetspots )
            {
                if ( name == targetname )
                {
                    istarget = 1;
                    break;
                }
            }
            
            if ( !istarget )
            {
                alternatespot = name;
                break;
            }
        }
        
        if ( !alternatespot )
        {
            foreach ( targetname in targetspots )
            {
                if ( targetname != fromspot && isdefined( self.metabonedetails[ targetname ] ) && self.metabonedetails[ targetname ].state == "scarred" )
                {
                    alternatespot = targetname;
                    break;
                }
            }
        }
        
        if ( !alternatespot )
        {
            return;
        }
        
        tospot = alternatespot;
        tostate = self.metabonedetails[ fromspot ].state;
    }
    
    var_5ca210e58833f44b = metabone::get_metabone_health( fromspot );
    metabone::set_metabone_state( fromspot, "scarred" );
    self.metabonedetails[ fromspot ].state = "scarred";
    metabone::set_metabone_active( fromspot, 1 );
    utility::function_7c10ea82c1e305b8( fromspot, "off" );
    
    if ( isdefined( self.armorents[ fromspot ] ) )
    {
        self.armorents[ fromspot ] delete();
        self.armorents[ fromspot ] = undefined;
    }
    
    metabone::set_metabone_state( tospot, tostate );
    self.metabonedetails[ tospot ].state = tostate;
    metabone::set_metabone_active( tospot, 1 );
    utility::function_7c10ea82c1e305b8( tospot, "destroyed_shifted_to" );
    metabone::set_metabone_health( tospot, var_5ca210e58833f44b );
    tagname = self.metabonedetails[ tospot ].tagname;
    tagorigin = self gettagorigin( tagname );
    boneent = utility::spawn_model( self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.var_35d4d2204f8cf1c4, tagorigin, self.angles );
    boneent setscriptablepartstate( "armor", "destroyed" );
    boneent linkto( self, tagname, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    boneent.tagname = tagname;
    boneent enableaimassist();
    self.armorents[ tospot ] = boneent;
    self.var_204d3dbbe1801350[ tospot ] = undefined;
    self notify( #"hash_9c092781280007b3" );
    thread function_290de70b76b55754( tospot );
}

// Namespace zombie_diana_metabones
// Params 0
// Checksum 0x384fabfa, Offset: 0x11c4
// Size: 0x83
function function_18dadfe96dbc0e42()
{
    foreach ( ent in self.armorents )
    {
        ent setscriptablepartstate( "armor", "armored" );
    }
}

// Namespace zombie_diana_metabones
// Params 0, eflags: 0x4
// Checksum 0x8fb280b9, Offset: 0x124f
// Size: 0x29d
function private function_7925a3d7192404f3()
{
    self endon( #"death" );
    utility::ent_flag_wait_or_timeout( "zombie_asm_init_finished", 1 );
    var_35e27aaa3934f43c = [];
    metabonesdef = metabone::get_metabones_def( self.metabones.bundle_name );
    
    /#
        var_865421e311a1b382 = getdvarint( @"hash_fa5ceebc80902f57", 0 );
    #/
    
    foreach ( metabone in metabonesdef.metabones )
    {
        metabonename = metabone.name;
        
        if ( metabone.tags )
        {
            foreach ( tag in metabone.tags )
            {
                tagorigin = self gettagorigin( tag.tagname );
                
                if ( issubstr( metabonename, "eye" ) )
                {
                    boneent = utility::spawn_model( self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.var_9c51a44148abb7de, tagorigin, self.angles );
                }
                else
                {
                    boneent = utility::spawn_model( self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.var_35d4d2204f8cf1c4, tagorigin, self.angles );
                    boneent setscriptablepartstate( "armor", "off" );
                    var_35e27aaa3934f43c[ metabone.name ] = boneent;
                }
                
                /#
                    if ( var_865421e311a1b382 )
                    {
                        boneent thread function_543e4811689c99e6( boneent, tag.radius );
                    }
                #/
                
                boneent linkto( self, tag.tagname, ( 0, 0, 0 ), ( 0, 0, 0 ) );
                boneent.tagname = tag.tagname;
                boneent enableaimassist();
            }
        }
    }
    
    self.armorents = var_35e27aaa3934f43c;
    utility::ent_flag_set( "zombie_diana_armor_ent_init_complete" );
}

// Namespace zombie_diana_metabones
// Params 1, eflags: 0x4
// Checksum 0x174bf952, Offset: 0x14f4
// Size: 0x340
function private function_b31215cb1ebba807( dmgstruct )
{
    if ( self.var_382b3e1f72536e3c )
    {
        return;
    }
    
    if ( !( isdefined( dmgstruct.shitloc ) && isdefined( dmgstruct.vpoint ) ) || !( isdefined( self.metabones ) && isdefined( self.metabones.info ) ) )
    {
        return;
    }
    
    if ( dmgstruct.vpoint == self.origin )
    {
        return;
    }
    
    var_4dd08761c0225cab = undefined;
    
    if ( dmgstruct.sweapon.ismelee || dmgstruct.sweapon.classname == "rocketlauncher" || dmgstruct.sweapon.classname == "beam" )
    {
        var_16023fbab228140e = 5;
        metabonesdef = metabone::get_metabones_def( self.metabones.bundle_name );
        
        if ( !issentient( dmgstruct.eattacker ) )
        {
            return;
        }
        
        eyepos = dmgstruct.eattacker geteye();
        
        foreach ( metabone in metabonesdef.metabones )
        {
            attackdir = vectornormalize( dmgstruct.vpoint - eyepos );
            
            if ( isdefined( metabone.tags ) )
            {
                foreach ( tag in metabone.tags )
                {
                    tagorigin = self gettagorigin( tag.tagname );
                    penetrationdisplacement = attackdir * var_16023fbab228140e;
                    
                    if ( !math::segmentvssphere( dmgstruct.vpoint, dmgstruct.vpoint + penetrationdisplacement, tagorigin, tag.radius ) )
                    {
                        continue;
                    }
                    
                    if ( !isdefined( var_4dd08761c0225cab ) )
                    {
                        var_4dd08761c0225cab = metabone.name;
                        var_4cecce0b1dc714da = tagorigin;
                        continue;
                    }
                    
                    if ( isdefined( tagorigin ) && isdefined( var_4cecce0b1dc714da ) && distancesquared( dmgstruct.vpoint, tagorigin ) < distancesquared( dmgstruct.vpoint, var_4cecce0b1dc714da ) )
                    {
                        var_4dd08761c0225cab = metabone.name;
                        var_4cecce0b1dc714da = tagorigin;
                    }
                }
            }
        }
    }
    else
    {
        var_4dd08761c0225cab = metabone::get_metabone_name( dmgstruct.shitloc, dmgstruct.partname, dmgstruct.vpoint, dmgstruct.vdir );
    }
    
    return var_4dd08761c0225cab;
}

// Namespace zombie_diana_metabones
// Params 1, eflags: 0x4
// Checksum 0xfc6d37f7, Offset: 0x183d
// Size: 0x1df
function private function_7af73e5c3e2c4b17( params )
{
    if ( ( self.var_7daf7e8bd9f744b4 || self getaiblackboarddynamic( "in_hibernation_phase" ) || self getaiblackboarddynamic( "in_move" ) || self getaiblackboarddynamic( "in_summon_agni_zombies" ) || self getaiblackboarddynamic( "in_necrotic_beam" ) || self getaiblackboarddynamic( "in_necrotic_fan" ) || self getaiblackboarddynamic( "in_winged_tornado_attack" ) ) && params.damage >= params.health )
    {
        metabonename = params.metabone_name;
        
        if ( metabone::is_metabone_armor( metabonename ) )
        {
            var_202a8c9c54c5086f = "default_during_flight";
        }
        else
        {
            var_202a8c9c54c5086f = "destroyed_during_flight";
        }
        
        metabone::set_metabone_state( params.metabone_name, var_202a8c9c54c5086f );
        self.metabonedetails[ params.metabone_name ].state = var_202a8c9c54c5086f;
        thread function_d4fd180e90f079c3( metabonename, var_202a8c9c54c5086f );
    }
    
    if ( !metabone::is_metabone_armor( params.metabone_name ) && params.health > 0 && self.metabonedetails[ params.metabone_name ].state == "destroyed" )
    {
        if ( !self.var_204d3dbbe1801350[ params.metabone_name ] )
        {
            self.var_204d3dbbe1801350[ params.metabone_name ] = params.health + params.damage;
        }
        
        initialhealth = self.var_204d3dbbe1801350[ params.metabone_name ];
        
        if ( params.health <= initialhealth * 0.3 )
        {
            shift_weakspot( params.metabone_name );
        }
    }
}

// Namespace zombie_diana_metabones
// Params 2, eflags: 0x4
// Checksum 0x1a944d1e, Offset: 0x1a24
// Size: 0x103
function private function_d4fd180e90f079c3( metabonename, var_202a8c9c54c5086f )
{
    self endon( #"death" );
    utility::waittill_any_in_array_or_timeout( [ "diana_move_end", "no_armor_break_during_projectile_end", "summon_agnis_end", "necrotic_beam_anim_end", "necrotic_fan_end", "winged_tornado_attack_end", "idle_loop_end" ], 25 );
    
    if ( self.inflyover )
    {
        utility::waittill_notify_or_timeout( "move_fly_over_complete", 5.5 );
    }
    
    switch ( var_202a8c9c54c5086f )
    {
        case #"hash_b9f8efe12f3aabc5":
            metabone::set_metabone_state( metabonename, "default" );
            self.metabonedetails[ metabonename ].state = "default";
            break;
        case #"hash_24ea42bda0ae4df7":
            metabone::set_metabone_state( metabonename, "destroyed" );
            self.metabonedetails[ metabonename ].state = "destroyed";
            break;
    }
}

// Namespace zombie_diana_metabones
// Params 1, eflags: 0x4
// Checksum 0xce150b10, Offset: 0x1b2f
// Size: 0x287
function private on_metabone_destroyed( params )
{
    metabonename = params.metabone_name;
    
    if ( metabone::is_metabone_armor( metabonename ) )
    {
        if ( !self.var_47d084561e9513ca )
        {
            metabone::set_metabone_state( metabonename, "destroyed" );
            self.metabonedetails[ metabonename ].state = "destroyed";
        }
        else
        {
            metabone::set_metabone_state( metabonename, "destroyed_during_flight" );
            self.metabonedetails[ metabonename ].state = "destroyed_during_flight";
        }
        
        metabone::set_metabone_active( metabonename, 1 );
        armorent = self.armorents[ metabonename ];
        armorent setscriptablepartstate( "armor", "destroyed" );
        utility::function_32b24db3127bff40( metabonename, "destroyed" );
        level callback::callback( "on_hornet_boss_weakpoint_damaged", { #player:params.eattacker } );
        thread function_290de70b76b55754( metabonename );
    }
    else
    {
        metabone::set_metabone_state( metabonename, "scarred" );
        self.metabonedetails[ metabonename ].state = "scarred";
        metabone::set_metabone_active( metabonename, 1 );
        utility::function_32b24db3127bff40( metabonename, "scarred" );
        armorent = self.armorents[ metabonename ];
        armorent delete();
        self.armorents[ metabonename ] = undefined;
    }
    
    if ( !self.var_47d084561e9513ca && self.bossfightphase <= 2 && function_df84ce0861cf66e() <= 2 )
    {
        foreach ( var_eb08429b9a811997 in function_c8f45b7834363f2d() )
        {
            metabone::set_metabone_state( var_eb08429b9a811997, "destroyed_during_flight" );
            self.metabonedetails[ var_eb08429b9a811997 ].state = "destroyed_during_flight";
        }
        
        self.var_47d084561e9513ca = 1;
    }
    
    if ( isalive( self ) && !self.var_fbd2b9707b5bd16f && ( !isdefined( self.var_80521f0adf3a76b9 ) || utility::time_has_passed( self.var_80521f0adf3a76b9, 12 ) ) )
    {
        thread function_f825ed7eaf3ddeee( params.eattacker );
        self.var_80521f0adf3a76b9 = gettime();
    }
}

// Namespace zombie_diana_metabones
// Params 1, eflags: 0x4
// Checksum 0x34a25c1d, Offset: 0x1dbe
// Size: 0x96
function private function_f825ed7eaf3ddeee( var_e216086757da7be6 )
{
    self endon( #"death" );
    var_1553510b4417cdff = 10;
    asm::function_7256f5ba459c840b( "special_pain_in" );
    utility::waittill_notify_or_timeout( "special_pain_end", 5 );
    thread function_5bf7cdfdb618d11d( self.var_d07837715994c833, self.var_5dec4cc95b2ae8a3 );
    zombie_diana_necrotic_beam::set_necrotic_beam_cooldown( 1 );
    zombie_diana_necrotic_projectile::set_necrotic_projectile_cooldown( self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.var_d07837715994c833 );
    zombie_diana_targeting::set_armor_breaker_target( var_e216086757da7be6, var_1553510b4417cdff );
}

// Namespace zombie_diana_metabones
// Params 2, eflags: 0x4
// Checksum 0x91a6374, Offset: 0x1e5c
// Size: 0x52
function private function_5bf7cdfdb618d11d( var_80fc43ccfb926bd1, var_8866d878aea9295 )
{
    self endon( #"death" );
    utility::waittill_any_in_array_or_timeout( [ "necrotic_projectile_end", "necrotic_beam_end" ], 6 );
    zombie_diana_necrotic_projectile::set_necrotic_projectile_cooldown( var_80fc43ccfb926bd1 );
    zombie_diana_necrotic_beam::set_necrotic_beam_cooldown( var_8866d878aea9295 );
}

// Namespace zombie_diana_metabones
// Params 1, eflags: 0x4
// Checksum 0xd9fd96f1, Offset: 0x1eb6
// Size: 0x139
function private function_99c318ec735167a1( params )
{
    metabonesdef = metabone::get_metabones_def( self.metabones.bundle_name );
    
    foreach ( metabone in metabonesdef.metabones )
    {
        metabonename = metabone.name;
        utility::function_32b24db3127bff40( metabonename, "off" );
    }
    
    foreach ( armorent in self.armorents )
    {
        armorent delete();
    }
}

// Namespace zombie_diana_metabones
// Params 0, eflags: 0x4
// Checksum 0xe45bbe88, Offset: 0x1ff7
// Size: 0xa2
function private function_735d0570f84c112a()
{
    result = [];
    
    foreach ( name, details in self.metabonedetails )
    {
        if ( details.state == "scarred" )
        {
            result = arraycombineunique( result, [ name ] );
        }
    }
    
    return result;
}

// Namespace zombie_diana_metabones
// Params 0, eflags: 0x4
// Checksum 0xba8d2194, Offset: 0x20a2
// Size: 0xa2
function private function_c8f45b7834363f2d()
{
    result = [];
    
    foreach ( name, details in self.metabonedetails )
    {
        if ( details.state == "destroyed" )
        {
            result = arraycombineunique( result, [ name ] );
        }
    }
    
    return result;
}

// Namespace zombie_diana_metabones
// Params 0, eflags: 0x4
// Checksum 0xa90203d6, Offset: 0x214d
// Size: 0x96
function private function_df84ce0861cf66e()
{
    count = 0;
    
    foreach ( details in self.metabonedetails )
    {
        if ( details.state != "scarred" )
        {
            count++;
        }
    }
    
    return count;
}

// Namespace zombie_diana_metabones
// Params 1, eflags: 0x4
// Checksum 0xe0ffd4f4, Offset: 0x21ec
// Size: 0x5e, Type: bool
function private function_83efcd29c36d45d6( metabonename )
{
    if ( !self.var_d1ce161ba454368f )
    {
        return false;
    }
    
    if ( isdefined( self.var_dd5923317ef414fb[ metabonename ] ) && gettime() - self.var_dd5923317ef414fb[ metabonename ] <= utility::function_4b74c15943231980( 8 ) )
    {
        return false;
    }
    
    if ( function_735d0570f84c112a().size == 0 )
    {
        return false;
    }
    
    return true;
}

// Namespace zombie_diana_metabones
// Params 1, eflags: 0x4
// Checksum 0x4d01ea2a, Offset: 0x2253
// Size: 0x20f, Type: bool
function private shift_weakspot( var_2accd3d673badee2 )
{
    if ( !function_83efcd29c36d45d6( var_2accd3d673badee2 ) )
    {
        return false;
    }
    
    destinations = function_735d0570f84c112a();
    
    if ( destinations.size == 0 )
    {
        return false;
    }
    
    var_3e799658694d229b = utility::array_random( destinations );
    var_5ca210e58833f44b = metabone::get_metabone_health( var_2accd3d673badee2 );
    metabone::set_metabone_state( var_2accd3d673badee2, "scarred" );
    self.metabonedetails[ var_2accd3d673badee2 ].state = "scarred";
    metabone::set_metabone_active( var_2accd3d673badee2, 1 );
    utility::function_7c10ea82c1e305b8( var_2accd3d673badee2, "off" );
    
    if ( isdefined( self.armorents[ var_2accd3d673badee2 ] ) )
    {
        self.armorents[ var_2accd3d673badee2 ] delete();
        self.armorents[ var_2accd3d673badee2 ] = undefined;
    }
    
    metabone::set_metabone_state( var_3e799658694d229b, "destroyed" );
    self.metabonedetails[ var_3e799658694d229b ].state = "destroyed";
    metabone::set_metabone_active( var_3e799658694d229b, 1 );
    utility::function_7c10ea82c1e305b8( var_3e799658694d229b, "destroyed_shifted_to" );
    metabone::set_metabone_health( var_3e799658694d229b, var_5ca210e58833f44b );
    tagname = self.metabonedetails[ var_3e799658694d229b ].tagname;
    tagorigin = self gettagorigin( tagname );
    boneent = utility::spawn_model( self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.var_35d4d2204f8cf1c4, tagorigin, self.angles );
    boneent setscriptablepartstate( "armor", "destroyed" );
    boneent linkto( self, tagname, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    boneent.tagname = tagname;
    boneent enableaimassist();
    self.armorents[ var_3e799658694d229b ] = boneent;
    self.var_204d3dbbe1801350[ var_3e799658694d229b ] = undefined;
    self.var_dd5923317ef414fb[ var_3e799658694d229b ] = gettime();
    self notify( #"hash_9c092781280007b3", var_2accd3d673badee2, var_3e799658694d229b );
    thread function_290de70b76b55754( var_3e799658694d229b );
    return true;
}

// Namespace zombie_diana_metabones
// Params 1, eflags: 0x4
// Checksum 0x7b52870f, Offset: 0x246b
// Size: 0x96
function private function_290de70b76b55754( metabonename )
{
    self endon( #"death" );
    self endon( #"hash_2defb0488eb77181" );
    self endon( #"hash_9c092781280007b3" );
    
    while ( true )
    {
        wait 15;
        
        if ( self.metabonedetails[ metabonename ].state != "destroyed" && self.metabonedetails[ metabonename ].state != "destroyed_during_flight" )
        {
            return;
        }
        
        if ( !function_83efcd29c36d45d6( metabonename ) )
        {
            continue;
        }
        
        thread shift_weakspot( metabonename );
    }
}

/#

    // Namespace zombie_diana_metabones
    // Params 0
    // Checksum 0xc0d599e8, Offset: 0x2509
    // Size: 0x44, Type: dev
    function metabones_devgui()
    {
        devgui::function_9082edeb5db93280( "<dev string:x24>" );
        devgui::add_devgui_func( "<dev string:x3b>", "<dev string:x4e>", &function_546edbce196e451d );
        devgui::add_devgui_func( "<dev string:x61>", "<dev string:x77>", &function_4c6b7f9fa83020bd );
        devgui::function_77df7fe7dd273e10();
    }

    // Namespace zombie_diana_metabones
    // Params 1
    // Checksum 0x7f1ade0, Offset: 0x2555
    // Size: 0x8a, Type: dev
    function function_546edbce196e451d( params )
    {
        diana = zombie_utils::get_closest_zombie( level.players[ 0 ].origin, undefined, "<dev string:x8d>" );
        
        if ( isalive( diana ) )
        {
            var_5c3a7e312d2b5b27 = randomint( 6 );
            metabonename = get_random_metabone_name( var_5c3a7e312d2b5b27 );
            diana thread function_f825ed7eaf3ddeee( level.players[ 0 ] );
            diana utility::function_32b24db3127bff40( metabonename, "<dev string:x9a>" );
        }
    }

    // Namespace zombie_diana_metabones
    // Params 1, eflags: 0x4
    // Checksum 0xa2083669, Offset: 0x25e7
    // Size: 0x77, Type: dev
    function private get_random_metabone_name( randomint )
    {
        if ( randomint == 0 )
        {
            return "<dev string:xa4>";
        }
        else if ( randomint == 1 )
        {
            return "<dev string:xb5>";
        }
        else if ( randomint == 2 )
        {
            return "<dev string:xc7>";
        }
        else if ( randomint == 3 )
        {
            return "<dev string:xd7>";
        }
        else if ( randomint == 4 )
        {
            return "<dev string:xe8>";
        }
        else if ( randomint == 5 )
        {
            return "<dev string:xf2>";
        }
        
        return "<dev string:xfd>";
    }

    // Namespace zombie_diana_metabones
    // Params 1
    // Checksum 0xa511c96d, Offset: 0x2666
    // Size: 0x7c, Type: dev
    function function_4c6b7f9fa83020bd( params )
    {
        diana = zombie_utils::get_closest_zombie( level.players[ 0 ].origin, undefined, "<dev string:x8d>" );
        
        if ( isalive( diana ) )
        {
            var_aeb05d8c6aff31dd = diana function_c8f45b7834363f2d();
            
            if ( var_aeb05d8c6aff31dd.size == 0 )
            {
                return;
            }
            
            randomweakspot = utility::array_random( var_aeb05d8c6aff31dd );
            diana shift_weakspot( randomweakspot );
        }
    }

    // Namespace zombie_diana_metabones
    // Params 2, eflags: 0x4
    // Checksum 0x63cc5b23, Offset: 0x26ea
    // Size: 0x3f, Type: dev
    function private function_543e4811689c99e6( armorent, radius )
    {
        self endon( #"death" );
        
        while ( true )
        {
            sphere( armorent.origin, radius );
            waitframe();
        }
    }

#/
