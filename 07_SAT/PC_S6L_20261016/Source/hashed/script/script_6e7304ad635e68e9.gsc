// script_6e7304ad635e68e9  (hash_6e7304ad635e68e9.gscc) (size: 2504 Bytes / 0x9c8 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x76c0f7e7 (1992357863)
// size ...... 2504 (0x9c8)
// includes .. 4   (offset: 0x924)
// strings ... 8   (offset: 0x944)
// dev strs .. 0   (offset: 0x9c8)
// exports ... 13  (offset: 0x4ec)
// cseg ...... 0x123 + 0x3c9 (0x4ec)
// imports ... 19  (offset: 0x6f4)
// animtree1 . 0   (offset: 0x9c8)
// animtree2 . 0   (offset: 0x9c8)
#using scripts\common\callbacks;
#using scripts\mp\common\perks\perks;
#using scripts\mp\common\utility\perk;
#using scripts\mp\damagefeedback;

#namespace specialty_flak_jacket;

// Namespace specialty_flak_jacket
// Params 0, eflags: 0x1
// Checksum 0xfb8c4995, Offset: 0x141
// Size: 0x18
function autoexec preinit()
{
    level callback::add( #"register_perk", &function_94bce66f9189e7f );
}

// Namespace specialty_flak_jacket
// Params 1
// Checksum 0xcba183fe, Offset: 0x161
// Size: 0x74
function function_94bce66f9189e7f( params )
{
    bundle = level.perkbundles[ "specialty_flak_jacket" ];
    
    if ( !isdefined( bundle ) )
    {
        return;
    }
    
    if ( isdefined( params.var_bf34439fc0ca3cec ) )
    {
        level [[ params.var_bf34439fc0ca3cec ]]( "specialty_flak_jacket", &setflakjacket, &unsetflakjacket, [ "specialty_shrapnel_resist", "specialty_reduce_explosion_damage" ], &initflakjacket );
    }
}

// Namespace specialty_flak_jacket
// Params 0
// Checksum 0x767824bb, Offset: 0x1dd
// Size: 0x10
function initflakjacket()
{
    damagefeedback::function_df1b63a8a4a2a089( "hitFlakJacket", 20 );
}

// Namespace specialty_flak_jacket
// Params 0
// Checksum 0x5f669ec1, Offset: 0x1f5
// Size: 0xdf
function setflakjacket()
{
    bundle = level.perkbundles[ "specialty_flak_jacket" ];
    
    if ( !isdefined( bundle ) && isdefined( self.perks[ "specialty_flak_jacket" ] ) )
    {
        perks::_unsetperk( "specialty_flak_jacket" );
        return;
    }
    
    if ( isdefined( self.var_11734fe9e9882f0c ) )
    {
        return;
    }
    
    self.var_a81cc8dd26229958 = bundle.var_a81cc8dd26229958 ?? 50;
    self.var_11734fe9e9882f0c = bundle.var_9ea3018ebd570e91 ?? 0;
    self.var_94867890f56871bb = bundle.var_22e12c7111e42b0c ?? 0;
    self.var_fd5a6b40b5a293da = &breakflakjacket;
    
    if ( isdefined( bundle.var_a7ab801febea2222 ) )
    {
        self.flakjackethealth = 0;
        function_b8ace260302a9ccd( bundle.var_a7ab801febea2222 );
        return;
    }
    
    function_24d1c4f939a397d0();
}

// Namespace specialty_flak_jacket
// Params 0
// Checksum 0xfd095524, Offset: 0x2dc
// Size: 0x73
function unsetflakjacket()
{
    infinitehealth = !isdefined( self.flakjackethealth );
    
    if ( infinitehealth || self.flakjackethealth > 0 )
    {
        function_bdb6e0582074f24f();
    }
    
    self.flakjackethealth = undefined;
    self.var_a81cc8dd26229958 = undefined;
    self.var_11734fe9e9882f0c = undefined;
    self.var_94867890f56871bb = undefined;
    self.var_fd5a6b40b5a293da = undefined;
    
    if ( !infinitehealth )
    {
        function_6fa4fd5924a93578();
    }
}

// Namespace specialty_flak_jacket
// Params 1
// Checksum 0x864cf545, Offset: 0x357
// Size: 0x69
function function_b8ace260302a9ccd( amount )
{
    if ( !isdefined( self.flakjackethealth ) )
    {
        return;
    }
    
    startinghealth = self.flakjackethealth;
    self.flakjackethealth += amount;
    
    if ( startinghealth <= 0 && self.flakjackethealth > 0 )
    {
        function_24d1c4f939a397d0();
        function_c488d70cd8b4b403();
    }
}

// Namespace specialty_flak_jacket
// Params 0
// Checksum 0x9ebb5be4, Offset: 0x3c8
// Size: 0x43
function function_c488d70cd8b4b403()
{
    self notify( #"flakjacket_singleton" );
    self endon( #"flakjacket_singleton" );
    self setclientomnvar( "ui_flakJacket", 1 );
    thread function_1a21baf5c314f2d4();
    self notify( #"blast_shield_damaged", self.flakjackethealth );
}

// Namespace specialty_flak_jacket
// Params 0
// Checksum 0x23e236cc, Offset: 0x413
// Size: 0x1a
function function_6fa4fd5924a93578()
{
    self setclientomnvar( "ui_flakJacket", 0 );
    self notify( #"hash_af43a14e80b48994" );
}

// Namespace specialty_flak_jacket
// Params 0
// Checksum 0xf3c77700, Offset: 0x435
// Size: 0x51
function function_1a21baf5c314f2d4()
{
    self endon( #"death_or_disconnect" );
    self endon( #"hash_af43a14e80b48994" );
    
    while ( true )
    {
        self waittill( #"blast_shield_damaged", remaining );
        self setclientomnvar( "ui_flakJacket_health", int( max( remaining, 0 ) ) );
    }
}

// Namespace specialty_flak_jacket
// Params 0
// Checksum 0x10f849ea, Offset: 0x48e
// Size: 0x10
function breakflakjacket()
{
    function_bdb6e0582074f24f();
    function_6fa4fd5924a93578();
}

// Namespace specialty_flak_jacket
// Params 0
// Checksum 0xd00939f1, Offset: 0x4a6
// Size: 0x24
function function_24d1c4f939a397d0()
{
    perk::giveperk( "specialty_blastshield", "specialty_flak_jacket" );
    perk::giveperk( "specialty_fire_resistance", "specialty_flak_jacket" );
}

// Namespace specialty_flak_jacket
// Params 0
// Checksum 0x4222553b, Offset: 0x4d2
// Size: 0x1a
function function_bdb6e0582074f24f()
{
    perk::removeperk( "specialty_blastshield" );
    perk::removeperk( "specialty_fire_resistance" );
}

