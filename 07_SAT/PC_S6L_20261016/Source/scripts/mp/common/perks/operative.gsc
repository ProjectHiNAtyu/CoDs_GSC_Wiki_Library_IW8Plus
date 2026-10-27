// scripts\mp\common\perks\operative.gsc  (hash_2171dafc57184eb7.gscc) (size: 2496 Bytes / 0x9c0 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x24d477d1 (617904081)
// size ...... 2496 (0x9c0)
// includes .. 1   (offset: 0x960)
// strings ... 6   (offset: 0x968)
// dev strs .. 0   (offset: 0x9c0)
// exports ... 9   (offset: 0x67c)
// cseg ...... 0xdb + 0x5a1 (0x67c)
// imports ... 13  (offset: 0x7e4)
// animtree1 . 0   (offset: 0x9c0)
// animtree2 . 0   (offset: 0x9c0)
#using scripts\common\callbacks;

#namespace operative;

// Namespace operative
// Params 0, eflags: 0x5
// Checksum 0xb33662ea, Offset: 0xf9
// Size: 0x18
function private autoexec preinit()
{
    level callback::add( #"register_perk", &function_170395bfa77c95f0 );
}

// Namespace operative
// Params 1
// Checksum 0x9053b0ac, Offset: 0x119
// Size: 0x78
function function_170395bfa77c95f0( params )
{
    bundle = level.perkbundles[ "specialty_operative" ];
    
    if ( !isdefined( bundle ) )
    {
        return;
    }
    
    if ( isdefined( params.var_a2358848c4408242 ) )
    {
        level [[ params.var_a2358848c4408242 ]]( "specialty_operative", &setoperative, &unsetoperative, [ "specialty_sixth_sense", "specialty_nodeathicon", "specialty_silentkill" ] );
    }
}

// Namespace operative
// Params 0
// Checksum 0xae5a633f, Offset: 0x199
// Size: 0x125
function setoperative()
{
    self.var_e3b3191ad394eb0d = &function_4ad95061f1e97681;
    
    if ( !self.spawninginprogress )
    {
        return;
    }
    
    bundle = self.var_9842326056fd7207 ?? level.perkbundles[ "specialty_operative" ];
    
    if ( bundle.var_21d58f249be8cb70 )
    {
        return;
    }
    
    if ( !isdefined( self.var_67976ffe7c8ef90b ) )
    {
        self.var_67976ffe7c8ef90b = 0;
        return;
    }
    
    if ( self.var_67976ffe7c8ef90b )
    {
        return;
    }
    
    thread function_fb7a67dca23944ef();
    self notify( #"setoperative_outlines" );
    
    if ( self.gettingloadout )
    {
        self endon( #"setoperative_outlines" );
        self endon( #"death_or_disconnect" );
        self waittill( #"giveloadout" );
    }
    
    setoperativeoutlines();
    var_2c124e2ccc1e8842 = level.sharedfuncs[ #"perk" ][ #"notifyperkbuffactive" ];
    
    if ( isdefined( var_2c124e2ccc1e8842 ) )
    {
        self [[ var_2c124e2ccc1e8842 ]]( bundle, %"hash_229e9f030260552d" );
    }
    
    buffduration = bundle.var_ceaad80aac12f9e3 ?? 0;
    function_b0064754af8ab8e7( buffduration );
}

// Namespace operative
// Params 0, eflags: 0x4
// Checksum 0x6f403037, Offset: 0x2c6
// Size: 0x3d
function private function_fb7a67dca23944ef()
{
    self notify( #"hash_f1c4aee6498ae6d2" );
    self endon( #"hash_f1c4aee6498ae6d2" );
    self endon( #"disconnect" );
    self waittill( #"death" );
    self.var_67976ffe7c8ef90b = 0;
}

// Namespace operative
// Params 0
// Checksum 0x9c71df57, Offset: 0x30b
// Size: 0x133
function setoperativeoutlines()
{
    self.var_67976ffe7c8ef90b = 1;
    
    if ( !isdefined( self.operativeoutlineids ) )
    {
        self.operativeoutlineids = [];
    }
    
    var_6865fca5966be685 = level.sharedfuncs[ #"player" ][ #"isenemy" ];
    
    if ( !isdefined( var_6865fca5966be685 ) )
    {
        return;
    }
    
    var_3e58eb1d414b2ec3 = level.sharedfuncs[ #"outline" ][ #"outlineenableforplayer" ];
    
    if ( !isdefined( var_3e58eb1d414b2ec3 ) )
    {
        return;
    }
    
    self function_cae29f205142cbb();
    
    foreach ( enemy in level.players )
    {
        if ( !isplayer( enemy ) )
        {
            continue;
        }
        
        if ( !self [[ var_6865fca5966be685 ]]( enemy ) )
        {
            continue;
        }
        
        self.operativeoutlineids[ enemy getentitynumber() ] = [[ var_3e58eb1d414b2ec3 ]]( enemy, self, "operative_perk", "level_script" );
    }
}

// Namespace operative
// Params 1
// Checksum 0x138ed700, Offset: 0x446
// Size: 0x15d
function function_b0064754af8ab8e7( delaytime )
{
    if ( !isarray( self.operativeoutlineids ) )
    {
        return;
    }
    
    if ( delaytime )
    {
        self endon( #"setoperative_outlines" );
        self endon( #"death_or_disconnect" );
        wait delaytime;
    }
    
    var_6865fca5966be685 = level.sharedfuncs[ #"player" ][ #"isenemy" ];
    
    if ( !isdefined( var_6865fca5966be685 ) )
    {
        return;
    }
    
    outlinedisablefunc = level.sharedfuncs[ #"outline" ][ #"outlinedisable" ];
    
    if ( !isdefined( outlinedisablefunc ) )
    {
        return;
    }
    
    foreach ( enemy in level.players )
    {
        if ( !isplayer( enemy ) )
        {
            continue;
        }
        
        if ( !self [[ var_6865fca5966be685 ]]( enemy ) )
        {
            continue;
        }
        
        enemyentnum = enemy getentitynumber();
        
        if ( !isdefined( self.operativeoutlineids[ enemyentnum ] ) )
        {
            continue;
        }
        
        [[ outlinedisablefunc ]]( self.operativeoutlineids[ enemyentnum ], enemy );
    }
}

// Namespace operative
// Params 0
// Checksum 0x49a8ba9b, Offset: 0x5ab
// Size: 0x6e
function unsetoperative()
{
    function_b0064754af8ab8e7( 0 );
    var_73f2be6e9a6bb5db = level.sharedfuncs[ #"perk" ][ #"setperkbuffactive" ];
    
    if ( isdefined( var_73f2be6e9a6bb5db ) )
    {
        bundle = level.perkbundles[ "specialty_operative" ];
        self [[ var_73f2be6e9a6bb5db ]]( bundle, %"hash_31735a8f602d9c32", 0 );
    }
    
    self.var_e3b3191ad394eb0d = undefined;
}

// Namespace operative
// Params 0, eflags: 0x4
// Checksum 0x983a6ce6, Offset: 0x621
// Size: 0x5b
function private function_4ad95061f1e97681()
{
    var_7e23a6ccf4cd709 = level.sharedfuncs[ #"perk" ][ #"notifyperkbuffactive" ];
    
    if ( isdefined( var_7e23a6ccf4cd709 ) )
    {
        bundle = level.perkbundles[ "specialty_operative" ];
        self [[ var_7e23a6ccf4cd709 ]]( bundle, %"hash_3a2eafa27caa2162" );
    }
}

