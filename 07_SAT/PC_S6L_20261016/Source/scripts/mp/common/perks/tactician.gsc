// scripts\mp\common\perks\tactician.gsc  (hash_5953be79f3e36fe6.gscc) (size: 3609 Bytes / 0xe19 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xb1e4fadb (2984573659)
// size ...... 3609 (0xe19)
// includes .. 2   (offset: 0xda1)
// strings ... 5   (offset: 0xdb1)
// dev strs .. 0   (offset: 0xe19)
// exports ... 11  (offset: 0xa19)
// cseg ...... 0xe8 + 0x931 (0xa19)
// imports ... 16  (offset: 0xbd1)
// animtree1 . 0   (offset: 0xe19)
// animtree2 . 0   (offset: 0xe19)
#using scripts\common\callbacks;
#using scripts\common\values;

#namespace tactician;

// Namespace tactician
// Params 0, eflags: 0x5
// Checksum 0xa2c74fbe, Offset: 0x106
// Size: 0x18
function private autoexec preinit()
{
    level callback::add( #"register_perk", &function_d94f504691e3f6dd );
}

// Namespace tactician
// Params 1
// Checksum 0x91b85989, Offset: 0x126
// Size: 0x74
function function_d94f504691e3f6dd( params )
{
    bundle = level.perkbundles[ "specialty_tactician" ];
    
    if ( !isdefined( bundle ) )
    {
        return;
    }
    
    if ( isdefined( params.var_a2358848c4408242 ) )
    {
        level [[ params.var_a2358848c4408242 ]]( "specialty_tactician", &settactician, &unsettactician, [ "specialty_fastoffhand", "specialty_outline_killstreak_distance_limited" ], &inittactician );
    }
}

// Namespace tactician
// Params 0
// Checksum 0xf0d61836, Offset: 0x1a2
// Size: 0x20
function inittactician()
{
    level function_961fba9844490fd3();
    level callback::add( #"hash_d06b059fdd983fc3", &function_3e14b8c7f73dfa26 );
}

// Namespace tactician
// Params 0, eflags: 0x4
// Checksum 0x2d14e98, Offset: 0x1ca
// Size: 0x57
function private settactician()
{
    bundle = level.perkbundles[ "specialty_tactician" ];
    dist = bundle.var_3789c49615bbd1c4 ?? 0;
    val::set( "specialty_tactician", "entity_mark_equipment", dist );
    thread watchequipmentuse();
    thread function_f1cdb2a510c6334b();
}

// Namespace tactician
// Params 0
// Checksum 0x1227138f, Offset: 0x229
// Size: 0xe2
function watchequipmentuse()
{
    self endon( #"death_or_disconnect" );
    self endon( #"unset_tactician" );
    level endon( #"game_ended" );
    bundle = level.perkbundles[ "specialty_tactician" ];
    var_2c124e2ccc1e8842 = level.sharedfuncs[ #"perk" ][ #"notifyperkbuffactive" ];
    iskillstreakweaponfunc = level.sharedfuncs[ #"killstreak" ][ #"iskillstreakweapon" ];
    
    while ( isdefined( var_2c124e2ccc1e8842 ) )
    {
        self waittill( #"grenade_fire", grenade, objweapon );
        
        if ( isdefined( objweapon ) && isdefined( iskillstreakweaponfunc ) && [[ iskillstreakweaponfunc ]]( objweapon ) )
        {
            continue;
        }
        
        self [[ var_2c124e2ccc1e8842 ]]( bundle, %"hash_d8be7b0061f29ec" );
    }
}

// Namespace tactician
// Params 0
// Checksum 0x1d1f778d, Offset: 0x313
// Size: 0x115
function function_f1cdb2a510c6334b()
{
    self endon( #"death_or_disconnect" );
    self endon( #"unset_tactician" );
    level endon( #"game_ended" );
    bundle = level.perkbundles[ "specialty_tactician" ];
    var_73f2be6e9a6bb5db = level.sharedfuncs[ #"perk" ][ #"setperkbuffactive" ];
    fov = 0.7071;
    
    while ( isdefined( var_73f2be6e9a6bb5db ) )
    {
        equipmentmarked = self function_8a4f55cad2293038( self.origin, self.angles, fov, #"equipment" );
        
        if ( equipmentmarked && !self.equipmentmarked )
        {
            self [[ var_73f2be6e9a6bb5db ]]( bundle, %"hash_4e8dd24c2f9f03ea", 1 );
            self.equipmentmarked = 1;
        }
        else if ( !equipmentmarked && self.equipmentmarked )
        {
            self [[ var_73f2be6e9a6bb5db ]]( bundle, %"hash_4e8dd24c2f9f03ea", 0 );
            self.equipmentmarked = 0;
        }
        
        wait 0.1;
    }
}

// Namespace tactician
// Params 0, eflags: 0x4
// Checksum 0xe36dcdf9, Offset: 0x430
// Size: 0x8d
function private unsettactician()
{
    if ( !isdefined( self.perks[ "specialty_engineer" ] ) )
    {
        val::reset( "specialty_tactician", "entity_mark_equipment" );
    }
    
    bundle = level.perkbundles[ "specialty_tactician" ];
    var_73f2be6e9a6bb5db = level.sharedfuncs[ #"perk" ][ #"setperkbuffactive" ];
    
    if ( isdefined( var_73f2be6e9a6bb5db ) )
    {
        self [[ var_73f2be6e9a6bb5db ]]( bundle, %"hash_4e8dd24c2f9f03ea", 0 );
    }
    
    self notify( #"unset_tactician" );
}

// Namespace tactician
// Params 1
// Checksum 0xe34a51c6, Offset: 0x4c5
// Size: 0x276
function function_3e14b8c7f73dfa26( params )
{
    bonusevent = level.var_713a05c7848f2dc8[ params.event ];
    
    if ( !isdefined( bonusevent ) )
    {
        return;
    }
    
    if ( !isdefined( self.perks[ "specialty_tactician" ] ) )
    {
        return;
    }
    
    killstreakref = level.killstreakweaponmap[ params.objweapon.basename ];
    
    if ( killstreakref && level.var_e1391c1f91f3f13e[ getxhash( killstreakref ) ] )
    {
        var_c18f3a9461352f34 = params.victim.streakinfo;
        
        if ( var_c18f3a9461352f34 )
        {
            var_fdd3d7b3999e00d2 = level.var_e3d8dcd9cc7f7eb7[ params.event ];
            
            if ( var_fdd3d7b3999e00d2 )
            {
                thread function_6de045b20b490e8();
                givencount = self.var_944db34ecd21154e[ var_c18f3a9461352f34.id ] ?? 0;
                
                if ( givencount >= var_fdd3d7b3999e00d2 )
                {
                    return;
                }
                
                givencount++;
                self.var_944db34ecd21154e[ var_c18f3a9461352f34.id ] = givencount;
            }
        }
        else if ( params.victim.issuper && params.victim.superref )
        {
            if ( params.victim.var_e463b0a79e72711f )
            {
                var_717655ca033263f1 = level.var_e3d8dcd9cc7f7eb7[ params.event ];
                
                if ( var_717655ca033263f1 )
                {
                    thread function_6de045b20b490e8();
                    givencount = self.var_5f11f92307696835[ params.victim.var_e463b0a79e72711f ] ?? 0;
                    
                    if ( givencount >= var_717655ca033263f1 )
                    {
                        return;
                    }
                    
                    givencount++;
                    self.var_5f11f92307696835[ params.victim.var_e463b0a79e72711f ] = givencount;
                }
            }
        }
    }
    
    var_dbd43a8b925f566f = level.sharedfuncs[ #"player" ][ #"doScoreEvent" ];
    
    if ( isdefined( var_dbd43a8b925f566f ) )
    {
        self thread [[ var_dbd43a8b925f566f ]]( bonusevent );
    }
    
    var_2c124e2ccc1e8842 = level.sharedfuncs[ #"perk" ][ #"notifyperkbuffactive" ];
    
    if ( isdefined( var_2c124e2ccc1e8842 ) )
    {
        bundle = level.perkbundles[ "specialty_tactician" ];
        self [[ var_2c124e2ccc1e8842 ]]( bundle, %"hash_34f2dff3b625beef" );
    }
}

// Namespace tactician
// Params 0, eflags: 0xc
// Checksum 0xc0f5fac6, Offset: 0x743
// Size: 0x4c
function private function_6de045b20b490e8()
{
    self notify( #"hash_2546524b7b914c1c" );
    self endon( #"hash_2546524b7b914c1c" );
    self endon( #"disconnect" );
    level endon( #"game_ended" );
    wait 2;
    self.var_944db34ecd21154e = undefined;
    self.var_5f11f92307696835 = undefined;
}

// Namespace tactician
// Params 0
// Checksum 0xde8dc402, Offset: 0x797
// Size: 0x282
function function_961fba9844490fd3()
{
    if ( isdefined( level.var_713a05c7848f2dc8 ) )
    {
        return;
    }
    
    bundle = level.perkbundles[ "specialty_tactician" ];
    assert( isdefined( bundle ) );
    level.var_713a05c7848f2dc8 = [];
    level.var_a3b1bee5c437e5ee = [];
    var_5590c45c6536fe8d = bundle.var_5590c45c6536fe8d;
    
    foreach ( var_a4fde6ff362f4b88 in var_5590c45c6536fe8d )
    {
        scoreevent = var_a4fde6ff362f4b88.scoreevent;
        
        if ( !isdefined( scoreevent ) )
        {
            continue;
        }
        
        bonusscoreevent = var_a4fde6ff362f4b88.bonusscoreevent;
        
        if ( !isdefined( bonusscoreevent ) )
        {
            continue;
        }
        
        level.var_713a05c7848f2dc8[ scoreevent ] = bonusscoreevent;
        var_31da078c1d497670 = var_a4fde6ff362f4b88.var_31da078c1d497670;
        
        if ( var_31da078c1d497670 )
        {
            level.var_e3d8dcd9cc7f7eb7[ scoreevent ] = var_31da078c1d497670;
        }
    }
    
    level.var_e1391c1f91f3f13e = [];
    
    foreach ( var_41fea73f4b83495d in bundle.var_448a266dfb7bac57 )
    {
        if ( !var_41fea73f4b83495d.streakref )
        {
            continue;
        }
        
        level.var_e1391c1f91f3f13e[ var_41fea73f4b83495d.streakref ] = 1;
    }
    
    level.var_1a59cdb6e817fc2f = [];
    
    foreach ( var_ae398b2f9e8afbce in bundle.var_b7bc5406cbffe54 )
    {
        if ( !var_ae398b2f9e8afbce.superref )
        {
            continue;
        }
        
        level.var_1a59cdb6e817fc2f[ var_ae398b2f9e8afbce.superref ] = 1;
    }
}

