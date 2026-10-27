// scripts\mp\common\perks\perk_regen_aura.gsc  (hash_376ce337c638222a.gscc) (size: 3023 Bytes / 0xbcf / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x22b6a7f7 (582395895)
// size ...... 3023 (0xbcf)
// includes .. 2   (offset: 0xb63)
// strings ... 4   (offset: 0xb73)
// dev strs .. 3   (offset: 0xbab)
// exports ... 10  (offset: 0x6df)
// cseg ...... 0x90 + 0x64f (0x6df)
// imports ... 26  (offset: 0x86f)
// animtree1 . 0   (offset: 0xbcf)
// animtree2 . 0   (offset: 0xbcf)
#using scripts\common\callbacks;
#using scripts\mp\armor;

#namespace perk_regen_aura;

// Namespace perk_regen_aura
// Params 0, eflags: 0x1
// Checksum 0x5fedd9f3, Offset: 0xae
// Size: 0x18
function autoexec main()
{
    level callback::add( #"register_perk", &perk_register );
}

// Namespace perk_regen_aura
// Params 1
// Checksum 0x44adb0b6, Offset: 0xce
// Size: 0x5d
function perk_register( params )
{
    bundle = level.perkbundles[ "specialty_regen_aura" ];
    
    if ( !isdefined( bundle ) )
    {
        return;
    }
    
    if ( isdefined( params.var_bf34439fc0ca3cec ) )
    {
        level [[ params.var_bf34439fc0ca3cec ]]( "specialty_regen_aura", &perk_set, &perk_unset, [] );
    }
}

// Namespace perk_regen_aura
// Params 0
// Checksum 0xd756b725, Offset: 0x133
// Size: 0x1b
function perk_set()
{
    self.var_72be328d494d2003 = 1;
    aura_apply_effect();
    thread aura_watcher();
}

// Namespace perk_regen_aura
// Params 0
// Checksum 0xf329a955, Offset: 0x156
// Size: 0xa2
function perk_unset()
{
    self notify( #"regen_aura_unset" );
    self.var_72be328d494d2003 = undefined;
    function_2bd6419e62f788e6();
    
    foreach ( member in self.regen_aura_members )
    {
        member function_2bd6419e62f788e6();
    }
    
    self.regen_aura_members = undefined;
}

// Namespace perk_regen_aura
// Params 0
// Checksum 0x934384aa, Offset: 0x200
// Size: 0x266
function aura_watcher()
{
    self endon( #"regen_aura_unset" );
    self endon( #"death_or_disconnect" );
    self.regen_aura_members = [];
    
    for ( ;; )
    {
        var_fc34ba2af1bf33a4 = getplayersinradius( self.origin, 150, 150, 0, [ self ], self.team );
        
        foreach ( number, member in self.regen_aura_members )
        {
            if ( !arraycontains( var_fc34ba2af1bf33a4, member ) )
            {
                member function_2bd6419e62f788e6();
                self.regen_aura_members[ number ] = undefined;
            }
        }
        
        foreach ( player in var_fc34ba2af1bf33a4 )
        {
            ent_num = player getentitynumber();
            
            if ( !self.regen_aura_members[ ent_num ] )
            {
                self.regen_aura_members[ ent_num ] = player;
                player aura_apply_effect();
            }
        }
        
        /#
            if ( getdvarint( @"hash_999454baf3c5b831", 0 ) )
            {
                sphere( self.origin, 150, ( 0, 1, 0 ), 1, 20 );
                
                foreach ( member in self.regen_aura_members )
                {
                    line( self.origin + ( 0, 0, 20 ), member.origin + ( 0, 0, 20 ), ( 0, 1, 0 ), 1, 1, 20 );
                }
            }
        #/
        
        wait 1;
    }
}

// Namespace perk_regen_aura
// Params 1
// Checksum 0x266f67ab, Offset: 0x46e
// Size: 0x57
function aura_apply_effect( use_fx = 1 )
{
    if ( !self.regen_aura_count )
    {
        self.regen_aura_count = 1;
        thread function_c8b2458e72165dc0();
        
        if ( use_fx )
        {
            self setscriptablepartstate( "perk_regen_aura", "on", 0 );
        }
        
        return;
    }
    
    self.regen_aura_count++;
}

// Namespace perk_regen_aura
// Params 0
// Checksum 0x79aea4c3, Offset: 0x4cd
// Size: 0x4d
function function_2bd6419e62f788e6()
{
    if ( self.regen_aura_count )
    {
        self.regen_aura_count--;
        
        if ( self.regen_aura_count <= 0 )
        {
            self.regen_aura_count = undefined;
            self notify( #"hash_7668238d27ba9b6d" );
            self setscriptablepartstate( "perk_regen_aura", "off", 0 );
        }
    }
}

// Namespace perk_regen_aura
// Params 0, eflags: 0x4
// Checksum 0xb3246bc7, Offset: 0x522
// Size: 0xcb
function private function_c8b2458e72165dc0()
{
    self endon( #"death_or_disconnect" );
    self endon( #"hash_7668238d27ba9b6d" );
    pulse_percent = getdvarfloat( @"hash_435de911bdb99a29", 0.1 );
    
    /#
        if ( getdvarint( @"hash_999454baf3c5b831", 0 ) )
        {
            thread function_716c2428ce55da55();
        }
    #/
    
    while ( self.regen_aura_count )
    {
        if ( !armor::has_full_armor() )
        {
            armor::repair_armor( self.maxarmorhealth * pulse_percent );
        }
        
        if ( self.health < self.maxhealth )
        {
            self.health = minint( self.health + int( self.maxhealth * pulse_percent ), self.maxhealth );
        }
        
        wait 0.5;
    }
}

/#

    // Namespace perk_regen_aura
    // Params 0
    // Checksum 0x55df84bd, Offset: 0x5f5
    // Size: 0xea, Type: dev
    function function_716c2428ce55da55()
    {
        self endon( #"death_or_disconnect" );
        self endon( #"hash_7668238d27ba9b6d" );
        
        for ( ;; )
        {
            print3d( self.origin + ( 0, 0, 70 ), "<dev string:x24>" + self.health, ( 1, 1, 1 ), 1, 0.25, 1, 1 );
            print3d( self.origin + ( 0, 0, 65 ), "<dev string:x2d>" + self.armorhealth, ( 1, 1, 1 ), 1, 0.25, 1, 1 );
            print3d( self.origin + ( 0, 0, 60 ), "<dev string:x35>" + self.regen_aura_count, ( 1, 1, 1 ), 1, 0.25, 1, 1 );
            waitframe();
        }
    }

#/
