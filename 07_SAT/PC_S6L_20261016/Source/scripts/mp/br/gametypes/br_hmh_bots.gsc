// scripts\mp\br\gametypes\br_hmh_bots.gsc  (hash_27eff8a0f8eb1edc.gscc) (size: 3379 Bytes / 0xd33 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xd78b17d4 (3616217044)
// size ...... 3379 (0xd33)
// includes .. 4   (offset: 0xc83)
// strings ... 7   (offset: 0xca3)
// dev strs .. 2   (offset: 0xd0f)
// exports ... 11  (offset: 0x63f)
// cseg ...... 0xed + 0x552 (0x63f)
// imports ... 41  (offset: 0x7f7)
// animtree1 . 0   (offset: 0xd33)
// animtree2 . 0   (offset: 0xd33)
#using scripts\common\throttle;
#using scripts\common\utility;
#using scripts\mp\common\supers\teleport;
#using scripts\mp\equipment;

#namespace br_hmh_bots;

// Namespace br_hmh_bots
// Params 0
// Checksum 0x8a8956f7, Offset: 0x10b
// Size: 0x3c
function init()
{
    level.var_ad9026a8009e6ed6 = getdvarint( @"hash_6e83119daaf2da12", 1 );
    
    if ( level.var_ad9026a8009e6ed6 )
    {
        level.var_b2fd9620014e6ca2 = throttle::throttle_initialize_gate( "hmh_bot_teleport_prediction", 3 );
    }
}

// Namespace br_hmh_bots
// Params 0
// Checksum 0x8c0e05fd, Offset: 0x14f
// Size: 0x28
function onspawnplayer()
{
    if ( level.var_ad9026a8009e6ed6 && isbot( self ) )
    {
        thread function_303035bfd287d16();
        
        /#
            thread function_e3888c45b1bfe557();
        #/
    }
}

// Namespace br_hmh_bots
// Params 0, eflags: 0xc
// Checksum 0xdc69b0dc, Offset: 0x17f
// Size: 0x17b
function private function_303035bfd287d16()
{
    self notify( #"hash_6ad741522eaa140e" );
    self endon( #"hash_6ad741522eaa140e" );
    self endon( #"death_or_disconnect" );
    level endon( #"game_ended" );
    self.var_4f327cb5e0bc352f = squared( getdvarfloat( @"hash_5a273ab891ca72a5", 50 ) );
    self.var_16e25ae8fafa9edd = 0;
    
    while ( true )
    {
        wait 1;
        currenttime = gettime();
        
        if ( currenttime < self.var_16e25ae8fafa9edd )
        {
            continue;
        }
        
        tacticalref = equipment_mp::getcurrentequipment( "secondary" );
        
        if ( ( tacticalref == "equip_super_mega_jump" || tacticalref == "equip_super_teleport" ) && equipment_mp::getequipmentammo( tacticalref ) > 0 && ( self.scriptenemy || self.enemy ) )
        {
            if ( tacticalref == "equip_super_mega_jump" && !function_71ca709b574403e0() )
            {
                continue;
            }
            
            if ( tacticalref == "equip_super_teleport" && !function_9c64415543cd6e17() )
            {
                continue;
            }
            
            if ( tacticalref == "equip_super_mega_jump" )
            {
                thread function_ae9a642462ec412b();
            }
            
            self botpressbutton( "tactical" );
            
            if ( tacticalref == "equip_super_teleport" )
            {
                mindelay = 2;
                maxdelay = 5;
            }
            else
            {
                mindelay = 5;
                maxdelay = 10;
            }
            
            self.var_16e25ae8fafa9edd = currenttime + utility::function_4b74c15943231980( randomfloatrange( mindelay, maxdelay ) );
        }
    }
}

// Namespace br_hmh_bots
// Params 0, eflags: 0x4
// Checksum 0x51770917, Offset: 0x302
// Size: 0x15, Type: bool
function private function_71ca709b574403e0()
{
    return lengthsquared( self getvelocity() ) > self.var_4f327cb5e0bc352f;
}

// Namespace br_hmh_bots
// Params 0, eflags: 0xc
// Checksum 0xc5a30f9b, Offset: 0x320
// Size: 0x8b
function private function_ae9a642462ec412b()
{
    self notify( #"hash_18c01281e9ec7e06" );
    self endon( #"hash_18c01281e9ec7e06" );
    self endon( #"death_or_disconnect" );
    level endon( #"game_ended" );
    var_ed8a4d10547d554a = getdvarfloat( @"hash_b88533a1c528c3be", 6 );
    var_6a5b27f1a19806c2 = self function_aaad5ae04c1e5224( "enable_deploy_parachute" );
    self botsetflag( "enable_deploy_parachute", 0 );
    utility::waittill_notify_or_timeout( "superJump_end", var_ed8a4d10547d554a );
    self botsetflag( "enable_deploy_parachute", var_6a5b27f1a19806c2 );
}

// Namespace br_hmh_bots
// Params 0, eflags: 0x4
// Checksum 0x960ba0f0, Offset: 0x3b3
// Size: 0x87, Type: bool
function private function_9c64415543cd6e17()
{
    originalangles = self.angles;
    
    for ( attempt = 0; attempt < 6 ; attempt++ )
    {
        throttle::throttle_wait_gate( level.var_b2fd9620014e6ca2 );
        candidateangles = function_1a09905b139b2eb6( originalangles );
        self setplayerangles( candidateangles );
        var_483bcacc1b629852 = teleport::function_bc9af6778b159eb();
        
        if ( var_483bcacc1b629852 && function_93a45cfd694e565a( var_483bcacc1b629852 ) )
        {
            return true;
        }
    }
    
    self setplayerangles( originalangles );
    return false;
}

// Namespace br_hmh_bots
// Params 1, eflags: 0x4
// Checksum 0x4adcffbf, Offset: 0x443
// Size: 0x86
function private function_1a09905b139b2eb6( angles )
{
    yawoffset = randomintrange( -60, 61 );
    pitchoffset = randomintrange( -10, 11 );
    var_55d24c5acb570422 = clamp( angles[ 0 ] + pitchoffset, -85, 85 );
    var_9c3e5f01815e7a47 = angles[ 1 ] + yawoffset;
    
    if ( var_9c3e5f01815e7a47 < 0 )
    {
        var_9c3e5f01815e7a47 += 360;
    }
    else if ( var_9c3e5f01815e7a47 >= 360 )
    {
        var_9c3e5f01815e7a47 -= 360;
    }
    
    return ( var_55d24c5acb570422, var_9c3e5f01815e7a47, angles[ 2 ] );
}

// Namespace br_hmh_bots
// Params 1, eflags: 0x4
// Checksum 0x44f88e67, Offset: 0x4d2
// Size: 0x49, Type: bool
function private function_93a45cfd694e565a( var_483bcacc1b629852 )
{
    return utility::function_d9f2bbbeb0e054b8( var_483bcacc1b629852 + ( 0, 0, 50 ) ) && !utility::ispointinwater( var_483bcacc1b629852 - ( 0, 0, 32 ) ) && function_cc9f3e6c7d8006ea( var_483bcacc1b629852 );
}

// Namespace br_hmh_bots
// Params 1, eflags: 0x4
// Checksum 0xd596ad2b, Offset: 0x524
// Size: 0x58, Type: bool
function private function_cc9f3e6c7d8006ea( var_483bcacc1b629852 )
{
    if ( !isnavmeshloaded() )
    {
        return true;
    }
    
    closestnavmeshpoint = getclosestpointonnavmesh( var_483bcacc1b629852, self, 0, 0, 1, 1 );
    
    if ( !isdefined( closestnavmeshpoint ) )
    {
        return false;
    }
    
    return distance2dsquared( closestnavmeshpoint, var_483bcacc1b629852 ) <= 1024 && abs( closestnavmeshpoint[ 2 ] - var_483bcacc1b629852[ 2 ] ) <= 48;
}

/#

    // Namespace br_hmh_bots
    // Params 0, eflags: 0xc
    // Checksum 0x453cf9cf, Offset: 0x585
    // Size: 0xba, Type: dev
    function private function_e3888c45b1bfe557()
    {
        self notify( #"hash_a98a9e0d4606a3d2" );
        self endon( #"hash_a98a9e0d4606a3d2" );
        self endon( #"death_or_disconnect" );
        level endon( #"game_ended" );
        
        while ( true )
        {
            waitframe();
            devtactical = getdvar( @"hash_21ab254b34efe60a", "<dev string:x24>" );
            
            if ( devtactical != "<dev string:x24>" )
            {
                equipment_mp::giveequipment( devtactical, "<dev string:x25>" );
                secondary_equip_ref = equipment_mp::getcurrentequipment( "<dev string:x25>" );
                var_f9720a7bbc3dc8a5 = equipment_mp::getequipmentmaxammo( secondary_equip_ref );
                equipment_mp::setequipmentammo( secondary_equip_ref, var_f9720a7bbc3dc8a5, var_f9720a7bbc3dc8a5 );
                setdvar( @"hash_21ab254b34efe60a", "<dev string:x24>" );
            }
        }
    }

#/
