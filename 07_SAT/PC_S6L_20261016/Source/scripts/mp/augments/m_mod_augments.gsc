// scripts\mp\augments\m_mod_augments.gsc  (hash_3ad325bda1b20084.gscc) (size: 7470 Bytes / 0x1d2e / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x1ee416ee (518264558)
// size ...... 7470 (0x1d2e)
// includes .. 10  (offset: 0x1b62)
// strings ... 22  (offset: 0x1bb2)
// dev strs .. 1   (offset: 0x1d22)
// exports ... 20  (offset: 0xfde)
// cseg ...... 0x1f4 + 0xdea (0xfde)
// imports ... 69  (offset: 0x12fe)
// animtree1 . 0   (offset: 0x1d2e)
// animtree2 . 0   (offset: 0x1d2e)
#using scripts\common\ai\aitypes\shared\zombie\zombie_utils;
#using scripts\common\callbacks;
#using scripts\common\system;
#using scripts\common\throttle;
#using scripts\common\utility;
#using scripts\common\weapon;
#using scripts\mp\common\perks\zombie\zombie_perks;
#using scripts\mp\common\utility\perk;
#using scripts\mp\gametypes\common;
#using scripts\mp\weapons;

#namespace m_mod_augments;

// Namespace m_mod_augments
// Params 0, eflags: 0x5
// Checksum 0x55cf10df, Offset: 0x212
// Size: 0x1d
function private autoexec __init__system__()
{
    system::register( #"m_mod_augments", undefined, &init_m_mod_augments, &function_8b28390583b77ba9 );
}

// Namespace m_mod_augments
// Params 0
// Checksum 0x31cc4e90, Offset: 0x237
// Size: 0xbd
function init_m_mod_augments()
{
    if ( !level.zombie_augments_in_use )
    {
        return;
    }
    
    callback::add( "zm_perk_obtained", &function_288f120db5b6defb );
    callback::add( "zm_perk_lost", &function_9e09844df6bf44c7 );
    callback::add( "on_m_mod_punch", &on_m_mod_punch );
    callback::add( #"on_ai_killed", &function_130d94f631c12aa6 );
    callback::add( #"player_weapon_change", &function_37e477f7860343b4 );
    level.m_mod_backdepal_check_throttle = throttle::throttle_initialize( "m_mod_backdepal_check_throttle", 1, level.framedurationseconds );
    var_89416b56bf7116f = utility::get_scripted_weapon_name( #"necrofluid_gauntlet" );
    level.var_37cff8154b47b497 = [ 1:"sat_ww_hornet_zm", 0:var_89416b56bf7116f ];
}

// Namespace m_mod_augments
// Params 1
// Checksum 0x9fe0fca7, Offset: 0x2fc
// Size: 0x169
function function_37e477f7860343b4( params )
{
    var_37b7231b77171a34 = 0;
    
    foreach ( weapon_name in level.var_37cff8154b47b497 )
    {
        if ( params.weapon.basename == weapon_name )
        {
            var_37b7231b77171a34 = 1;
            break;
        }
    }
    
    if ( !var_37b7231b77171a34 && function_dc2626f05ee229f9( params.weapon ) )
    {
        var_37b7231b77171a34 = 1;
    }
    
    if ( var_37b7231b77171a34 )
    {
        if ( utility::callsharedfunc( #"zombie", #"hash_3930894d8d2f0ee6", "specialty_m_mod", #"m_mod_panic_knife" ) )
        {
            if ( self hasperk( "specialty_melee_without_swap" ) )
            {
                perk::removeperk( "specialty_melee_without_swap" );
            }
        }
    }
    else if ( utility::callsharedfunc( #"zombie", #"hash_3930894d8d2f0ee6", "specialty_m_mod", #"m_mod_panic_knife" ) )
    {
        if ( !self hasperk( "specialty_melee_without_swap" ) )
        {
            perk::giveperk( "specialty_melee_without_swap" );
        }
    }
    
    self.last_weapon = params.lastweapon;
}

// Namespace m_mod_augments
// Params 1
// Checksum 0x410cd514, Offset: 0x46d
// Size: 0x58, Type: bool
function function_dc2626f05ee229f9( weapon )
{
    return weapon.basename == "sat_ar_falcon_mp" && weapon hasattachmenthash( %"sat_bar_spear_ar_falcon" ) || weapon.basename == "sat_sm_serval_mp" && weapon hasattachmenthash( %"hash_6867e986d0f605d2" );
}

// Namespace m_mod_augments
// Params 0
// Checksum 0x13cea763, Offset: 0x4ce
// Size: 0x10
function function_8b28390583b77ba9()
{
    if ( !level.zombie_augments_in_use )
    {
        return;
    }
}

// Namespace m_mod_augments
// Params 1
// Checksum 0x1033faa9, Offset: 0x4e6
// Size: 0x52
function function_73390820bc67afd8( augmentname )
{
    funccategory = #"zombie";
    funcname = #"hash_3930894d8d2f0ee6";
    
    if ( utility::issharedfuncdefined( funccategory, funcname ) )
    {
        return utility::callsharedfunc( funccategory, funcname, "specialty_m_mod", augmentname );
    }
    
    return 0;
}

// Namespace m_mod_augments
// Params 1, eflags: 0x4
// Checksum 0x1e23d2d1, Offset: 0x541
// Size: 0x96
function private m_mod_vampirism_on_ai_damage( sparams )
{
    assert( isplayer( sparams.eattacker ) );
    assert( sparams.eattacker function_73390820bc67afd8( #"m_mod_vampirism" ) );
    
    if ( sparams.smeansofdeath == "MOD_MELEE" )
    {
        var_8c264c27a289206 = sparams.idflags == 1;
        
        if ( !var_8c264c27a289206 )
        {
            sparams.eattacker function_a751792209728af9();
        }
    }
    
    return sparams.idamage;
}

// Namespace m_mod_augments
// Params 1, eflags: 0x4
// Checksum 0xbde4fbdd, Offset: 0x5e0
// Size: 0x7b
function private m_mod_backpedal_on_ai_damage( sparams )
{
    if ( !isplayer( sparams.eattacker ) || !sparams.eattacker function_73390820bc67afd8( #"m_mod_backpedal" ) )
    {
        return sparams.idamage;
    }
    
    if ( sparams.smeansofdeath == "MOD_MELEE" )
    {
        sparams.eattacker thread m_mod_backpedal_speed_up();
    }
    
    return sparams.idamage;
}

// Namespace m_mod_augments
// Params 1, eflags: 0x4
// Checksum 0x230ccc72, Offset: 0x664
// Size: 0xa4
function private function_a8d693f6f022aafb( sparams )
{
    assert( isplayer( sparams.eattacker ) );
    assert( sparams.eattacker function_73390820bc67afd8( #"hash_eec1bbf388eb13fd" ) );
    damage = sparams.idamage ?? 0;
    
    if ( sparams.objweapon === sparams.eattacker.var_cc1262e66dbb1c79 && self.aicategory == "normal" )
    {
        damage = self.maxhealth;
    }
    
    return damage;
}

// Namespace m_mod_augments
// Params 1
// Checksum 0xe6ab85f2, Offset: 0x711
// Size: 0x37
function on_m_mod_punch( sparams )
{
    if ( !isdefined( level.var_c97c7a39a88c295a ) )
    {
        level.var_c97c7a39a88c295a = throttle::throttle_initialize( "m_mod_punch_aoe", 1, level.framedurationseconds );
    }
}

// Namespace m_mod_augments
// Params 1
// Checksum 0x92c82a0c, Offset: 0x750
// Size: 0x1b3
function function_130d94f631c12aa6( sparams )
{
    if ( isplayer( sparams.eattacker ) )
    {
        player = sparams.eattacker;
        
        if ( sparams.smeansofdeath === "MOD_MELEE" )
        {
            if ( player utility::callsharedfunc( #"zombie", #"hash_3930894d8d2f0ee6", "specialty_m_mod", #"m_mod_hidden_impact" ) )
            {
                currentweapon = player getcurrentweapon();
                
                if ( currentweapon.ismelee || currentweapon == player.var_cc1262e66dbb1c79 )
                {
                    if ( isdefined( player.last_weapon ) && player hasweapon( player.last_weapon ) )
                    {
                        player m_mod_reload( player.last_weapon );
                    }
                    else
                    {
                        player m_mod_reload( currentweapon );
                    }
                }
                else
                {
                    player m_mod_reload( currentweapon );
                }
            }
            
            if ( player utility::callsharedfunc( #"zombie", #"hash_3930894d8d2f0ee6", "specialty_m_mod", #"m_mod_overwhelming_force" ) )
            {
                if ( utility::issharedfuncdefined( #"medal", #"track_rapid_kill", 0 ) )
                {
                    player utility::callsharedfunc( #"medal", #"track_rapid_kill", "m_mod_augment_o" );
                }
            }
            
            if ( player zombie_perks::has_perk( "specialty_m_mod" ) )
            {
                if ( self.aicategory == "special" || self.aicategory == "elite" || self.aicategory == "hvt" )
                {
                    player playsoundtoplayer( "evt_m_mod_augment_bell", player );
                }
            }
        }
    }
}

// Namespace m_mod_augments
// Params 1
// Checksum 0x58a35949, Offset: 0x90b
// Size: 0x97
function function_db9bff24cf45b955( postfxbundlename )
{
    self endon( #"death_or_disconnect" );
    self endon( #"hash_64cc3f937cac4c95" );
    
    while ( true )
    {
        currentweapon = self getcurrentweapon();
        
        if ( self ismeleeing() && currentweapon === self.var_cc1262e66dbb1c79 )
        {
            if ( !self.var_5e772a319f7bd0c0 )
            {
                pbgpostfxbundlestart( self, postfxbundlename );
                self.var_5e772a319f7bd0c0 = 1;
            }
        }
        else if ( self.var_5e772a319f7bd0c0 )
        {
            self.var_5e772a319f7bd0c0 = undefined;
            pbgpostfxbundleend( self, postfxbundlename );
        }
        
        waitframe();
    }
}

// Namespace m_mod_augments
// Params 1
// Checksum 0xa2d3d605, Offset: 0x9aa
// Size: 0x124
function function_288f120db5b6defb( sparams )
{
    if ( sparams.var_ffc1674def575bfa == "specialty_m_mod" )
    {
        if ( function_1041fb1a5bdc72f1( #"hash_eec1bbf388eb13fd" ) )
        {
            postfxbundlename = level.zombie_augments[ #"hash_eec1bbf388eb13fd" ].var_b71ce5b94d3be9e4;
            thread function_db9bff24cf45b955( postfxbundlename );
        }
        
        if ( function_1041fb1a5bdc72f1( #"m_mod_faster_melee" ) )
        {
            perk::giveperk( "specialty_fastermelee" );
        }
        
        m_mod_vampirism_name = #"m_mod_vampirism";
        m_mod_backpedal_name = #"m_mod_backpedal";
        var_bcd8ae92213f45d0 = #"hash_eec1bbf388eb13fd";
        var_d79fe1637c2c4cc6 = function_73390820bc67afd8( m_mod_vampirism_name );
        var_a50db56b751d4541 = function_73390820bc67afd8( m_mod_backpedal_name );
        var_10e9592603df8db5 = function_73390820bc67afd8( var_bcd8ae92213f45d0 );
        
        if ( var_d79fe1637c2c4cc6 )
        {
            zombie_utils::function_dfae6a5bd222c586( &m_mod_vampirism_on_ai_damage );
        }
        
        if ( var_a50db56b751d4541 )
        {
            zombie_utils::function_dfae6a5bd222c586( &m_mod_backpedal_on_ai_damage );
        }
        
        if ( var_10e9592603df8db5 )
        {
            zombie_utils::function_dfae6a5bd222c586( &function_a8d693f6f022aafb );
        }
    }
}

// Namespace m_mod_augments
// Params 1
// Checksum 0x73866775, Offset: 0xad6
// Size: 0xb5
function function_9e09844df6bf44c7( sparams )
{
    if ( sparams.var_ffc1674def575bfa == "specialty_m_mod" )
    {
        self notify( #"hash_64cc3f937cac4c95" );
        
        if ( self.var_5e772a319f7bd0c0 )
        {
            postfxbundlename = level.zombie_augments[ #"hash_eec1bbf388eb13fd" ].var_b71ce5b94d3be9e4;
            pbgpostfxbundleend( self, postfxbundlename );
            self.var_5e772a319f7bd0c0 = undefined;
        }
        
        if ( function_1041fb1a5bdc72f1( #"m_mod_faster_melee" ) )
        {
            perk::removeperk( "specialty_fastermelee" );
        }
        
        zombie_utils::function_10c0c35c21e3ed9d( &m_mod_vampirism_on_ai_damage );
        zombie_utils::function_10c0c35c21e3ed9d( &m_mod_backpedal_on_ai_damage );
        zombie_utils::function_10c0c35c21e3ed9d( &function_a8d693f6f022aafb );
    }
}

// Namespace m_mod_augments
// Params 1
// Checksum 0xcd8f1787, Offset: 0xb93
// Size: 0x42, Type: bool
function function_1041fb1a5bdc72f1( augmentname )
{
    return utility::issharedfuncdefined( #"zombie", #"player_has_augment" ) && utility::callsharedfunc( #"zombie", #"player_has_augment", augmentname );
}

// Namespace m_mod_augments
// Params 0, eflags: 0x4
// Checksum 0x30fd7400, Offset: 0xbde
// Size: 0x7d
function private function_a751792209728af9()
{
    if ( utility::ent_flag( "disable_player_heal_items" ) )
    {
        return;
    }
    
    var_7306b73201c61041 = level.zombie_augments[ #"m_mod_vampirism" ].var_fe5ffdb3ae1b8b69 ?? 10;
    new_health = self.health + var_7306b73201c61041;
    self.health = int( clamp( float( new_health ), 0, float( self.maxhealth ) ) );
}

// Namespace m_mod_augments
// Params 0, eflags: 0xc
// Checksum 0x7ba92c4a, Offset: 0xc63
// Size: 0x1a7
function private m_mod_backpedal_speed_up()
{
    self notify( #"hash_172310b6360c985c" );
    self endon( #"hash_172310b6360c985c" );
    level endon( #"game_ended" );
    self endon( #"death_or_disconnect" );
    start_time = gettime();
    speed_up_percentage = level.zombie_augments[ #"m_mod_backpedal" ].var_5b5a21532e206156 ?? 1;
    speed_up_time = level.zombie_augments[ #"m_mod_backpedal" ].var_2b6550f2d44d6f2f ?? 1;
    
    while ( true )
    {
        if ( utility::function_6f5d2e1f1ff70482( gettime() - start_time ) >= speed_up_time )
        {
            break;
        }
        
        movement = self getnormalizedmovement();
        
        if ( movement[ 0 ] < 0 )
        {
            /#
                iprintlnbold( "<dev string:x24>" );
            #/
            
            if ( !function_38a96272ca6a7e9b( "m_mod_backpedal_speed_up" ) )
            {
                weapons::function_4512b7715789e4cf( "m_mod_backpedal_speed_up", speed_up_percentage );
                
                if ( !common::function_8ff835bf23198a0( "m_mod_backpedal_speed_up" ) )
                {
                    common::function_6f182a842ea5e2f1( "m_mod_backpedal_speed_up", speed_up_percentage );
                }
                
                weapons::updatemovespeedscale();
            }
        }
        else if ( function_38a96272ca6a7e9b( "m_mod_backpedal_speed_up" ) )
        {
            weapons::function_986fc44dada307f4( "m_mod_backpedal_speed_up" );
            
            if ( common::function_8ff835bf23198a0( "m_mod_backpedal_speed_up" ) )
            {
                common::function_d85a92c557ea5a52( "m_mod_backpedal_speed_up" );
            }
            
            weapons::updatemovespeedscale();
        }
        
        throttle::throttle_wait_in_queue( level.m_mod_backdepal_check_throttle, self );
    }
    
    if ( function_38a96272ca6a7e9b( "m_mod_backpedal_speed_up" ) )
    {
        weapons::function_986fc44dada307f4( "m_mod_backpedal_speed_up" );
        
        if ( common::function_8ff835bf23198a0( "m_mod_backpedal_speed_up" ) )
        {
            common::function_d85a92c557ea5a52( "m_mod_backpedal_speed_up" );
        }
        
        weapons::updatemovespeedscale();
    }
}

// Namespace m_mod_augments
// Params 1
// Checksum 0x188c826d, Offset: 0xe12
// Size: 0x29, Type: bool
function function_38a96272ca6a7e9b( str_id )
{
    if ( !isdefined( self.var_e5996377e9a13e32 ) )
    {
        return false;
    }
    
    return isdefined( self.var_e5996377e9a13e32[ str_id ] );
}

// Namespace m_mod_augments
// Params 1, eflags: 0x4
// Checksum 0x919dd1a6, Offset: 0xe44
// Size: 0x19a
function private m_mod_reload( weapon )
{
    if ( weapon.ismelee || weapon::iskillstreakweapon( weapon ) )
    {
        return;
    }
    
    percentage_reload = level.zombie_augments[ #"m_mod_hidden_impact" ].var_5595db4beeba2428 ?? 0.1;
    var_b11feea92c35d08e = weaponclipsize( weapon );
    var_e682469cfc660b81 = int( percentage_reload * var_b11feea92c35d08e );
    
    if ( weapon.isdualwield )
    {
        var_2ff8bc69e51dd380 = self getweaponammoclip( weapon, "left" );
        var_ebf003e5260e315 = self getweaponammoclip( weapon, "right" );
        
        if ( var_e682469cfc660b81 <= 0 )
        {
            var_e682469cfc660b81 = 1;
        }
        
        var_8827394d7702b374 = 0;
        
        if ( var_2ff8bc69e51dd380 < var_b11feea92c35d08e )
        {
            var_ac63e3ae2739754f = var_2ff8bc69e51dd380 + var_e682469cfc660b81;
            var_ac63e3ae2739754f = int( clamp( var_ac63e3ae2739754f, var_2ff8bc69e51dd380, var_b11feea92c35d08e ) );
            self setweaponammoclip( weapon, var_ac63e3ae2739754f, "left" );
        }
        
        if ( var_ebf003e5260e315 < var_b11feea92c35d08e )
        {
            var_43952bae6d47e8c0 = var_ebf003e5260e315 + var_e682469cfc660b81;
            var_43952bae6d47e8c0 = int( clamp( var_43952bae6d47e8c0, var_ebf003e5260e315, var_b11feea92c35d08e ) );
            self setweaponammoclip( weapon, var_43952bae6d47e8c0, "right" );
        }
        
        if ( var_8827394d7702b374 )
        {
            self playlocalsound( #"hash_d58572e6d21da758" );
        }
        
        return;
    }
    
    n_current_clip_ammo = self getweaponammoclip( weapon );
    
    if ( var_e682469cfc660b81 <= 0 )
    {
        var_e682469cfc660b81 = 1;
    }
    
    if ( n_current_clip_ammo < var_b11feea92c35d08e )
    {
        var_48a8f7224c85ab09 = n_current_clip_ammo + var_e682469cfc660b81;
        var_48a8f7224c85ab09 = int( clamp( var_48a8f7224c85ab09, n_current_clip_ammo, var_b11feea92c35d08e ) );
        self setweaponammoclip( weapon, var_48a8f7224c85ab09 );
        self playlocalsound( #"hash_d58572e6d21da758" );
    }
}

