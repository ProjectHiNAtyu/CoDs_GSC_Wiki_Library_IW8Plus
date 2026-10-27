// scripts\common\ai\aitypes\zombie_neptune\zombie_neptune_melee.gsc  (hash_11d7fbb29c23868d.gscc) (size: 6981 Bytes / 0x1b45 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xdadb7f0 (229488624)
// size ...... 6981 (0x1b45)
// includes .. 7   (offset: 0x1a29)
// strings ... 16  (offset: 0x1a61)
// dev strs .. 1   (offset: 0x1b39)
// exports ... 13  (offset: 0x112d)
// cseg ...... 0x1cb + 0xf62 (0x112d)
// imports ... 60  (offset: 0x1335)
// animtree1 . 0   (offset: 0x1b45)
// animtree2 . 0   (offset: 0x1b45)
#using script_68af0df7ea34684e;
#using scripts\asm\asm;
#using scripts\common\ai\aitypes\shared\zombie\zombie_knockdown;
#using scripts\common\callbacks;
#using scripts\common\shellshock_utility;
#using scripts\common\throttle;
#using scripts\common\utility;

#namespace zombie_neptune_melee;

// Namespace zombie_neptune_melee
// Params 0
// Checksum 0x25e62b32, Offset: 0x1e9
// Size: 0x34
function function_a38858e4f5328064()
{
    template = callback::get_template( self.animsetname );
    template callback::add( #"hash_696b6f168d1d9c5c", &on_phase_change );
}

// Namespace zombie_neptune_melee
// Params 0
// Checksum 0x99db3ea3, Offset: 0x225
// Size: 0x68
function init_zombie_neptune_melee()
{
    self.var_abf0b408c96a796 = self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.var_764168232ab816a3;
    self.var_94e31772fab0c17b = self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.var_ccbb8bb8fff02ac;
    utility::ent_flag_set( "melee_range_defined" );
    thread function_f98058533d9911cf();
    thread function_78ad55988f9e7883();
}

// Namespace zombie_neptune_melee
// Params 1, eflags: 0x4
// Checksum 0xd423a849, Offset: 0x295
// Size: 0x8c
function private on_phase_change( params )
{
    switch ( self.n_fight_phase )
    {
        case 2:
            self.var_abf0b408c96a796 += 5;
            self.var_94e31772fab0c17b += 5;
            break;
        case 3:
            self.var_abf0b408c96a796 += 10;
            self.var_94e31772fab0c17b += 10;
            break;
    }
}

// Namespace zombie_neptune_melee
// Params 0, eflags: 0xc
// Checksum 0x1815dacf, Offset: 0x329
// Size: 0x1f6
function private function_f98058533d9911cf()
{
    self notify( #"hash_ec619dc875d06d73" );
    self endon( #"hash_ec619dc875d06d73" );
    self endon( #"death" );
    assert( isdefined( self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb ), "<dev string:x24>" );
    var_1d04b54708274076 = 0.8;
    var_1ba4cc80626327ba = -75;
    var_dec8e3862d11b1a6 = 25;
    var_8853bc68534d69f8 = 100;
    
    while ( true )
    {
        self waittill( #"neptune_melee_start" );
        namespace_45591fb25244d549::function_cede8b4d4a5ae444( self.var_5c63f9b326faec9a ?? self.enemy );
        
        if ( isdefined( self.var_5c63f9b326faec9a ) )
        {
            targetpos = self.var_5c63f9b326faec9a.origin;
        }
        else
        {
            targetpos = self.enemy.origin;
        }
        
        var_239a850bce63f141 = utility::drop_to_ground( self.origin + anglestoforward( self.angles ) * 100, 300, undefined, undefined, undefined, undefined, 1 );
        var_a935245ee6a2bc39 = var_239a850bce63f141[ 0 ];
        var_731742aa115cc182 = var_239a850bce63f141[ 1 ];
        
        if ( targetpos && var_a935245ee6a2bc39[ 2 ] - targetpos[ 2 ] >= var_8853bc68534d69f8 )
        {
            var_a935245ee6a2bc39 = ( var_a935245ee6a2bc39[ 0 ], var_a935245ee6a2bc39[ 1 ], targetpos[ 2 ] );
        }
        
        var_2124c9ed490b8c33 = clamp( angleclamp180( vectortopitch( var_a935245ee6a2bc39 - self.origin ) * -1 ), -45, 45 );
        
        if ( vectordot( var_731742aa115cc182, anglestoup( self.angles ) ) >= var_1d04b54708274076 && var_a935245ee6a2bc39[ 2 ] - self.origin[ 2 ] <= var_1ba4cc80626327ba )
        {
            var_2124c9ed490b8c33 += var_dec8e3862d11b1a6;
        }
        
        self function_a8fe8d86843b9cee( var_2124c9ed490b8c33 );
        self function_786bb6aa1b76c7ee( "in_neptune_melee", 1 );
        thread handle_melee_swipe();
        thread function_fb84666ad0a080b4();
        self waittill( #"bmeleeended" );
    }
}

// Namespace zombie_neptune_melee
// Params 0, eflags: 0xc
// Checksum 0xe312ba0b, Offset: 0x527
// Size: 0x340
function private function_78ad55988f9e7883()
{
    self notify( #"hash_26b85c4a01c0b100" );
    self endon( #"hash_26b85c4a01c0b100" );
    self endon( #"death" );
    
    if ( !isdefined( level.search_for_nearby_enemy_to_melee_throttle ) )
    {
        level.search_for_nearby_enemy_to_melee_throttle = throttle::throttle_initialize( "search_for_nearby_enemy_to_melee_throttle" );
    }
    
    utility::ent_flag_wait_or_timeout( "melee_range_defined", 3 );
    self.var_d0cca345699efde6 = 1;
    self.var_c84676ea34e98cd0 = gettime();
    self.var_2051661dc9d1c736 = utility::function_4b74c15943231980( self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.var_2051661dc9d1c736 );
    var_3d227516f4835444 = squared( self.var_abf0b408c96a796 );
    
    while ( true )
    {
        throttle::throttle_wait_in_queue( level.search_for_nearby_enemy_to_melee_throttle, self );
        
        if ( level.players.size <= 1 )
        {
            if ( !level callback::exists( #"player_connect", &onspawnconnected ) )
            {
                level callback::add( #"player_connect", &onspawnconnected );
            }
            
            self waittill( #"hash_9657448ad066b23d" );
            continue;
        }
        
        if ( gettime() - self.var_c84676ea34e98cd0 <= self.var_2051661dc9d1c736 )
        {
            wait utility::function_6f5d2e1f1ff70482( self.var_2051661dc9d1c736 - gettime() - self.var_c84676ea34e98cd0 );
            continue;
        }
        
        if ( self getaiblackboarddynamic( "in_neptune_melee" ) || self getaiblackboarddynamic( "neptune_melee_non_main_enemy" ) || self getaiblackboarddynamic( "in_ground_slam" ) || self._blackboard.var_65f32caa86b87a2 || self getaiblackboarddynamic( "in_weakspot_break" ) )
        {
            utility::waittill_any_in_array_or_timeout( [ "bmeleeended", "ground_slam_end", "terminate_ranged_attack", "special_pain_end" ], 10 );
            continue;
        }
        
        if ( !self.var_d0cca345699efde6 )
        {
            continue;
        }
        
        if ( !isdefined( self.enemy ) )
        {
            continue;
        }
        
        var_a55df8993943a22e = distance2dsquared( self.origin, self.enemy.origin );
        
        if ( var_a55df8993943a22e > var_3d227516f4835444 )
        {
            moving_melee = namespace_45591fb25244d549::calculate_is_moving_melee( self.enemy );
            
            if ( moving_melee )
            {
                var_cf162c2cdbdd9498 = self.var_94e31772fab0c17b;
            }
            else
            {
                var_cf162c2cdbdd9498 = self.var_abf0b408c96a796;
            }
            
            var_e65616d02ef8f372 = self function_f017e352a29a57a1( self.origin, var_cf162c2cdbdd9498, 1 );
            
            foreach ( var_b639a50cb94dcc87 in var_e65616d02ef8f372 )
            {
                if ( !isalive( var_b639a50cb94dcc87 ) || self.enemy == var_b639a50cb94dcc87 || var_b639a50cb94dcc87.inlaststand )
                {
                    continue;
                }
                
                self function_786bb6aa1b76c7ee( "neptune_melee_non_main_enemy", 1 );
                self.var_5c63f9b326faec9a = var_b639a50cb94dcc87;
                self.var_c84676ea34e98cd0 = gettime();
                break;
            }
        }
    }
}

// Namespace zombie_neptune_melee
// Params 0, eflags: 0xc
// Checksum 0x5b4c17dc, Offset: 0x86f
// Size: 0x13c
function private handle_melee_swipe()
{
    self notify( #"hash_d4e9c1ac3b5b3754" );
    self endon( #"hash_d4e9c1ac3b5b3754" );
    self endon( #"death" );
    self endon( #"bmeleeended" );
    self endon( #"neptune_melee_swipe_end" );
    asm::function_7256f5ba459c840b( "melee_in" );
    self waittill( #"neptune_melee_swipe_start", var_c9ce387bec7fbd9a, var_f952a2efb2e7e3c2 );
    self.var_68823ab149edc966 = [];
    
    while ( true )
    {
        if ( isdefined( self.enemy ) )
        {
            var_1d8f9951cad1673b = vectortoyaw( isdefined( self.var_5c63f9b326faec9a ) ? self.var_5c63f9b326faec9a.origin - self.origin : self.enemy.origin - self.origin );
            self orientmode( "face angle", var_1d8f9951cad1673b, 1 );
        }
        
        /#
            if ( getdvarfloat( @"neptune_melee_debug", 0 ) )
            {
                sphere( self.enemy.origin, 10, ( 1, 1, 1 ), 0, 10 );
            }
        #/
        
        swipe_melee( var_c9ce387bec7fbd9a, var_f952a2efb2e7e3c2 );
        waitframe();
    }
}

// Namespace zombie_neptune_melee
// Params 0, eflags: 0xc
// Checksum 0x9e3e70f0, Offset: 0x9b3
// Size: 0x62
function private function_fb84666ad0a080b4()
{
    self notify( #"hash_825861acff8339a3" );
    self endon( #"hash_825861acff8339a3" );
    self endon( #"death" );
    self waittill( #"bmeleeended" );
    self function_786bb6aa1b76c7ee( "in_neptune_melee", 0 );
    
    if ( self getaiblackboarddynamic( "neptune_melee_non_main_enemy" ) )
    {
        self function_786bb6aa1b76c7ee( "neptune_melee_non_main_enemy", 0 );
        self.var_5c63f9b326faec9a = undefined;
    }
}

// Namespace zombie_neptune_melee
// Params 2
// Checksum 0x222ce99f, Offset: 0xa1d
// Size: 0x395
function swipe_melee( var_c9ce387bec7fbd9a, var_f952a2efb2e7e3c2 )
{
    var_320638c4d536a69b = 50;
    var_d8b3986ad2141972 = 300;
    var_2b568c23530c62d8 = 25;
    
    switch ( self.n_fight_phase )
    {
        case 1:
            var_a6f30fb8e34febc1 = 100;
            break;
        case 2:
            var_a6f30fb8e34febc1 = 150;
            break;
        case 3:
            var_a6f30fb8e34febc1 = 170;
            break;
    }
    
    var_bd49255cc5540b84 = self gettagorigin( var_c9ce387bec7fbd9a );
    var_bf2f73af3187e876 = getplayersandaiarrayinradius( var_bd49255cc5540b84, var_a6f30fb8e34febc1 );
    
    /#
        if ( getdvarfloat( @"neptune_melee_debug", 0 ) )
        {
            sphere( var_bd49255cc5540b84, var_a6f30fb8e34febc1, ( 1, 0, 0 ), 0, 10 );
        }
    #/
    
    if ( var_bf2f73af3187e876.size > 0 )
    {
        foreach ( potentialtarget in var_bf2f73af3187e876 )
        {
            if ( potentialtarget == self || !isalive( potentialtarget ) || potentialtarget.inlaststand )
            {
                continue;
            }
            
            if ( arraycontains( self.var_68823ab149edc966, potentialtarget ) )
            {
                continue;
            }
            
            if ( isplayer( potentialtarget ) )
            {
                switch ( self.n_fight_phase )
                {
                    case 1:
                        var_3377604748bdb2d9 = self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.var_3f3464bd27e1fca5;
                        break;
                    case 2:
                        var_3377604748bdb2d9 = self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.var_fd30fc2c42eaf0d2;
                        break;
                    case 3:
                        var_3377604748bdb2d9 = self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.var_3f736ab24483c153;
                        break;
                }
                
                shockasset = self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.var_ca1496163801594a;
                
                if ( shockasset )
                {
                    potentialtarget shellshock_utility::_shellshock( shockasset, #"damage", 1.5 );
                }
                
                potentialtarget knockback_player( self );
                callback::callback( #"hash_a8c190693150f3fb" );
            }
            else if ( isai( potentialtarget ) )
            {
                var_3377604748bdb2d9 = function_e7b2933ee390e524( potentialtarget.aicategory, potentialtarget.maxhealth );
                
                if ( var_3377604748bdb2d9 < potentialtarget.health )
                {
                    switch ( var_f952a2efb2e7e3c2 )
                    {
                        case #"hash_c9b3133a17a3b2d0":
                            var_4875c4a245b82147 = anglestoright( self.angles );
                            break;
                        case #"hash_96815ce4f2a3dbc5":
                            var_4875c4a245b82147 = anglestoleft( self.angles );
                            break;
                    }
                    
                    potentialtarget zombie_knockdown::function_6fc167d4a3590991( var_bd49255cc5540b84 + var_4875c4a245b82147 * var_320638c4d536a69b, var_d8b3986ad2141972, var_2b568c23530c62d8 );
                }
                else if ( !potentialtarget.noragdoll && !potentialtarget.script_noragdoll )
                {
                    potentialtarget function_79dcf35067f0aa4a( self, var_f952a2efb2e7e3c2 );
                }
            }
            
            potentialtarget dodamage( var_3377604748bdb2d9, self.origin, self, self, "MOD_MELEE", undefined, "torso_upper", undefined, 1073741824 );
            self.var_68823ab149edc966[ self.var_68823ab149edc966.size ] = potentialtarget;
        }
    }
}

// Namespace zombie_neptune_melee
// Params 1, eflags: 0x4
// Checksum 0xf551160, Offset: 0xdba
// Size: 0x187
function private knockback_player( neptune )
{
    var_380469c1e29dcfd6 = 3500;
    var_d3fceea4b8e08870 = 30;
    
    switch ( neptune.n_fight_phase )
    {
        case 1:
            meleeknockbackstrength = neptune.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.var_2e41253028cb114a;
            break;
        case 2:
            meleeknockbackstrength = neptune.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.var_78d5e3304052de6b;
            break;
        case 3:
            meleeknockbackstrength = neptune.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.var_1717d8f060087598;
            break;
    }
    
    var_4875c4a245b82147 = anglestoforward( neptune.angles );
    var_49942a609994af62 = vectorcross( var_4875c4a245b82147, ( 0, 0, 1 ) );
    impactvector = rotatepointaroundvector( var_49942a609994af62, var_4875c4a245b82147, var_d3fceea4b8e08870 );
    
    if ( isdefined( self.var_391c438e89316bba ) && gettime() - self.var_391c438e89316bba < var_380469c1e29dcfd6 )
    {
        var_bccf9a2ba34d4a8e = getdvarfloat( @"hash_52d57844961adcd", 1.4 );
        meleeknockbackstrength *= var_bccf9a2ba34d4a8e;
    }
    
    self.var_391c438e89316bba = gettime();
    self knockback( impactvector, getdvarfloat( @"hash_901e6b56b44bf5f0", meleeknockbackstrength ), 1 );
}

// Namespace zombie_neptune_melee
// Params 2, eflags: 0x4
// Checksum 0xa4bd25cb, Offset: 0xf49
// Size: 0xc8
function private function_e7b2933ee390e524( aicategory, aimaxhealth )
{
    if ( !aicategory )
    {
        aicategory = "normal";
    }
    
    var_a6ff3d88679a65b9 = 0.5;
    var_e89f5b8f9b15078f = 0.1;
    var_6cdfd9a7c8d3500b = 0.01;
    var_bfceb7e76d6cc067 = 0;
    
    switch ( aicategory )
    {
        case #"hash_84fcf5e68d7230b2":
            return ( aimaxhealth * var_a6ff3d88679a65b9 );
        case #"hash_8c089e813083e510":
            return ( aimaxhealth * var_e89f5b8f9b15078f );
        case #"hash_7b0e2f2ed84f34":
        case #"hash_4e47eb6c32f5b165":
            return ( aimaxhealth * var_6cdfd9a7c8d3500b );
        case #"hash_7e8a002ed096276c":
            return ( aimaxhealth * var_bfceb7e76d6cc067 );
        default:
            return 0;
    }
}

// Namespace zombie_neptune_melee
// Params 2, eflags: 0x4
// Checksum 0xea2b6ec2, Offset: 0x1019
// Size: 0xde
function private function_79dcf35067f0aa4a( neptune, var_f952a2efb2e7e3c2 )
{
    var_4631da19f0c93052 = 7000;
    var_c31dc26c108992f8 = 20;
    
    switch ( var_f952a2efb2e7e3c2 )
    {
        case #"hash_c9b3133a17a3b2d0":
            var_4875c4a245b82147 = anglestoleft( neptune.angles );
            break;
        case #"hash_96815ce4f2a3dbc5":
            var_4875c4a245b82147 = anglestoright( neptune.angles );
            break;
    }
    
    var_49942a609994af62 = vectorcross( var_4875c4a245b82147, ( 0, 0, 1 ) );
    impactvector = rotatepointaroundvector( var_49942a609994af62, var_4875c4a245b82147, var_c31dc26c108992f8 );
    impactvector = var_4631da19f0c93052 * impactvector;
    self.ragdollimpactvector = impactvector;
    self.ragdollhitloc = "torso_lower";
    self.forceragdollimmediate = 1;
}

// Namespace zombie_neptune_melee
// Params 1, eflags: 0x4
// Checksum 0x4835afdf, Offset: 0x10ff
// Size: 0x2e
function private onspawnconnected( params )
{
    self notify( #"hash_9657448ad066b23d" );
    level callback::remove( #"player_connect", &onspawnconnected );
}

