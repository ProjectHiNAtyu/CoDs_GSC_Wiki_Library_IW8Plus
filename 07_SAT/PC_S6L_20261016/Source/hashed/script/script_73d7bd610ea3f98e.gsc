// script_73d7bd610ea3f98e  (hash_73d7bd610ea3f98e.gscc) (size: 1753 Bytes / 0x6d9 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xaa07454d (2852603213)
// size ...... 1753 (0x6d9)
// includes .. 1   (offset: 0x6b9)
// strings ... 0   (offset: 0x6c1)
// dev strs .. 2   (offset: 0x6c1)
// exports ... 7   (offset: 0x4f9)
// cseg ...... 0x58 + 0x4a1 (0x4f9)
// imports ... 6   (offset: 0x611)
// animtree1 . 0   (offset: 0x6d9)
// animtree2 . 0   (offset: 0x6d9)
#using scripts\common\callbacks;

#namespace effect_accumulate;

// Namespace effect_accumulate
// Params 6
// Checksum 0x17724cbc, Offset: 0x76
// Size: 0xca
function function_40685dcb08461e57( type, var_3ff07e6eae94c01f, var_303968efeee35d49, var_da44a1b46cc4167c, var_c2360f247b85895d, var_2c24f5a4b1707e53 )
{
    if ( !isdefined( self.var_215ad33f5a816e72 ) )
    {
        self.var_215ad33f5a816e72 = [];
    }
    
    if ( !isdefined( self.var_215ad33f5a816e72[ type ] ) )
    {
        self.var_215ad33f5a816e72[ type ] = {};
    }
    
    var_993fdb0c8d5f906d = self.var_215ad33f5a816e72[ type ];
    var_993fdb0c8d5f906d.var_3ff07e6eae94c01f = var_3ff07e6eae94c01f;
    var_993fdb0c8d5f906d.var_303968efeee35d49 = var_303968efeee35d49;
    var_993fdb0c8d5f906d.var_da44a1b46cc4167c = var_da44a1b46cc4167c;
    var_993fdb0c8d5f906d.var_c2360f247b85895d = var_c2360f247b85895d;
    var_993fdb0c8d5f906d.var_2c24f5a4b1707e53 = var_2c24f5a4b1707e53;
}

// Namespace effect_accumulate
// Params 5
// Checksum 0x12eab4dc, Offset: 0x148
// Size: 0xc2
function function_cf20746494aeaca8( type, threshold, decay_delay, decay_amount, decay_tick )
{
    if ( !isdefined( self.var_215ad33f5a816e72 ) )
    {
        self.var_215ad33f5a816e72 = [];
    }
    
    if ( !isdefined( self.var_215ad33f5a816e72[ type ] ) )
    {
        self.var_215ad33f5a816e72[ type ] = {};
    }
    
    var_993fdb0c8d5f906d = self.var_215ad33f5a816e72[ type ];
    var_993fdb0c8d5f906d.amount = 0;
    var_993fdb0c8d5f906d.threshold = threshold;
    var_993fdb0c8d5f906d.decay_delay = decay_delay;
    var_993fdb0c8d5f906d.decay_amount = decay_amount;
    var_993fdb0c8d5f906d.decay_tick = decay_tick;
    return var_993fdb0c8d5f906d;
}

// Namespace effect_accumulate
// Params 1
// Checksum 0x50490d45, Offset: 0x213
// Size: 0x19, Type: bool
function function_f6eb20ef6c541dc7( type )
{
    return isdefined( self.var_215ad33f5a816e72[ type ] );
}

// Namespace effect_accumulate
// Params 6
// Checksum 0xeb8d7d03, Offset: 0x235
// Size: 0x189, Type: bool
function accumulate( type, amount, einflictor, eattacker, meansofdeath, weaponobj )
{
    assert( isdefined( self.var_215ad33f5a816e72[ type ] ), "<dev string:x24>" + type + "<dev string:x38>" );
    var_70a52c3829fee74b = self.var_215ad33f5a816e72[ type ];
    var_70a52c3829fee74b.amount += amount;
    
    if ( var_70a52c3829fee74b.var_303968efeee35d49 )
    {
        self thread [[ var_70a52c3829fee74b.var_303968efeee35d49 ]]( var_70a52c3829fee74b, eattacker, meansofdeath, weaponobj );
    }
    
    if ( var_70a52c3829fee74b.amount >= var_70a52c3829fee74b.threshold )
    {
        var_70a52c3829fee74b.amount = 0;
        
        if ( var_70a52c3829fee74b.var_3ff07e6eae94c01f )
        {
            self thread [[ var_70a52c3829fee74b.var_3ff07e6eae94c01f ]]( var_70a52c3829fee74b, einflictor, eattacker, meansofdeath, weaponobj );
        }
        
        self notify( #"hash_af02a8499da1c3c0" );
        params = spawnstruct();
        params.var_70a52c3829fee74b = var_70a52c3829fee74b;
        params.eattacker = eattacker;
        params.einflictor = einflictor;
        params.meansofdeath = meansofdeath;
        params.weaponobj = weaponobj;
        params.victim = self;
        level callback::callback( #"hash_3ced7872b9720907", params );
        return true;
    }
    
    thread function_bb0609e45d1c8760( var_70a52c3829fee74b );
    return false;
}

// Namespace effect_accumulate
// Params 1, eflags: 0xc
// Checksum 0x978e2cfd, Offset: 0x3c7
// Size: 0x62
function private function_bb0609e45d1c8760( var_70a52c3829fee74b )
{
    self notify( #"hash_d8fc4514b2cb89cc" );
    self endon( #"hash_d8fc4514b2cb89cc" );
    self endon( #"hash_af02a8499da1c3c0" );
    self endon( #"death" );
    
    if ( var_70a52c3829fee74b.decay_delay < 0 )
    {
        return;
    }
    
    wait var_70a52c3829fee74b.decay_delay;
    childthread function_47567e409da2f26d( var_70a52c3829fee74b );
}

// Namespace effect_accumulate
// Params 1, eflags: 0xc
// Checksum 0x31eee41c, Offset: 0x431
// Size: 0xc8
function private function_47567e409da2f26d( var_70a52c3829fee74b )
{
    self notify( #"hash_2cc5c1a729049c62" );
    self endon( #"hash_2cc5c1a729049c62" );
    
    if ( var_70a52c3829fee74b.var_da44a1b46cc4167c )
    {
        self thread [[ var_70a52c3829fee74b.var_da44a1b46cc4167c ]]( var_70a52c3829fee74b );
    }
    
    while ( var_70a52c3829fee74b.amount > 0 )
    {
        wait var_70a52c3829fee74b.decay_tick;
        
        if ( var_70a52c3829fee74b.var_c2360f247b85895d )
        {
            self thread [[ var_70a52c3829fee74b.var_c2360f247b85895d ]]( var_70a52c3829fee74b );
        }
        
        var_70a52c3829fee74b.amount = max( 0, var_70a52c3829fee74b.amount - var_70a52c3829fee74b.decay_amount );
    }
    
    if ( var_70a52c3829fee74b.var_2c24f5a4b1707e53 )
    {
        self thread [[ var_70a52c3829fee74b.var_2c24f5a4b1707e53 ]]( var_70a52c3829fee74b );
    }
}

