// scripts\mp\common\weapons\sat_sl_nembus.gsc  (hash_10d84a2959f61ddf.gscc) (size: 4521 Bytes / 0x11a9 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x58526c40 (1481796672)
// size ...... 4521 (0x11a9)
// includes .. 4   (offset: 0x1111)
// strings ... 9   (offset: 0x1131)
// dev strs .. 0   (offset: 0x11a9)
// exports ... 15  (offset: 0x9f9)
// cseg ...... 0x113 + 0x8e6 (0x9f9)
// imports ... 42  (offset: 0xc51)
// animtree1 . 0   (offset: 0x11a9)
// animtree2 . 0   (offset: 0x11a9)
#using scripts\common\callbacks;
#using scripts\common\throttle;
#using scripts\common\utility;
#using scripts\mp\entityheadicons;

#namespace sat_sl_nembus;

// Namespace sat_sl_nembus
// Params 0, eflags: 0x1
// Checksum 0xa1fd24a7, Offset: 0x131
// Size: 0x70
function autoexec init_sat_sl_nembus()
{
    nembusweaponname = utility::get_scripted_weapon_name( #"nembus" );
    
    if ( !isdefined( nembusweaponname ) )
    {
        return;
    }
    
    level.nembusweaponname = nembusweaponname;
    level callback::add( #"grenade_fire", &nembus_used );
    level callback::add( #"player_weapon_change", &nembus_on_weapon_change );
    level.var_a177b2baa36179c9 = throttle::throttle_initialize( "nembus_detonation" );
}

// Namespace sat_sl_nembus
// Params 1
// Checksum 0xa2620d35, Offset: 0x1a9
// Size: 0x1b2
function nembus_used( grenadedata )
{
    grenade = grenadedata.grenade;
    
    if ( grenade.weapon_name != level.nembusweaponname )
    {
        return;
    }
    
    if ( !isdefined( self.nembusgrenades ) )
    {
        self.nembusgrenades = [];
    }
    
    grenade.var_808ece62b3a01215 = 0;
    grenade.var_4f49e9e8607f622e = 0;
    self.nembusgrenades[ self.nembusgrenades.size ] = grenade;
    
    if ( self.nembusgrenades.size > 4 )
    {
        var_614ccd4a0ccc1b4b = self.nembusgrenades[ 0 ];
        self.nembusgrenades[ 0 ] = undefined;
        function_cdc669dbc8ea2101( self.nembusgrenades );
        
        if ( !var_614ccd4a0ccc1b4b.var_4f49e9e8607f622e && !var_614ccd4a0ccc1b4b.var_808ece62b3a01215 )
        {
            var_614ccd4a0ccc1b4b thread function_c24b05c041748215();
        }
    }
    
    grenade.headiconid = grenade entityheadicons::setheadicon_factionimage( 0, 5, 1, 10000, 0, 0, 0, 0, undefined, 0, undefined, "icon_small" );
    
    if ( level.var_ccae9ce6e34ea885 )
    {
        entityheadicons::function_57b1edf6f2986e84( grenade.headiconid, self.team );
        entityheadicons::setheadicon_addclienttomask( grenade.headiconid, self );
    }
    
    grenade setcandamage( 1 );
    grenade.health = 9999;
    grenade thread function_4d62503f21de901b();
    grenade thread function_4999b5cdb6213c7a();
    grenade thread function_a0b7889caf9a48ad();
    
    if ( !self.nembusused )
    {
        thread watch_nembus_detonation();
        thread function_10a4b0435dae6e63();
        self.nembusused = 1;
    }
    
    utility::function_969f9f5596dba07a( grenade, &function_8c62fe50ce0d0541 );
}

// Namespace sat_sl_nembus
// Params 1, eflags: 0x4
// Checksum 0xaa1b3d8b, Offset: 0x363
// Size: 0x3a
function private nembus_on_weapon_change( params )
{
    if ( params.weapon.basename == level.nembusweaponname )
    {
        function_9bfd433507cf0531( "nembus_tutorial_equip_has_displayed" );
    }
}

// Namespace sat_sl_nembus
// Params 1, eflags: 0x4
// Checksum 0xfc353c02, Offset: 0x3a5
// Size: 0x66
function private function_9bfd433507cf0531( key )
{
    if ( !utility::ent_flag( key ) )
    {
        utility::ent_flag_set( key );
        
        if ( utility::issharedfuncdefined( #"ww_shared", #"show_hud_tutorial_message" ) )
        {
            self thread [[ utility::getsharedfunc( #"ww_shared", #"show_hud_tutorial_message" ) ]]( &"hash_7d5a6922db505383", 4 );
        }
    }
}

// Namespace sat_sl_nembus
// Params 0, eflags: 0x4
// Checksum 0x52791179, Offset: 0x413
// Size: 0x260
function private watch_nembus_detonation()
{
    self endon( #"nembus_cleanup" );
    self endon( #"death_or_disconnect" );
    self notifyonplayercommand( "nembus_detonation", "+speed_throw" );
    
    while ( true )
    {
        self waittill( #"nembus_detonation" );
        
        if ( self.currentweapon.basename != level.nembusweaponname )
        {
            continue;
        }
        
        if ( self.currentweapon hasattachment( "sat_mag_extmag_sl_nembus" ) )
        {
            activationdelay = 30;
            var_7c700a4f4609375d = 0;
        }
        else
        {
            activationdelay = 300;
            var_7c700a4f4609375d = 1;
        }
        
        self playsoundtoplayer( "wpn_sl_nembus_fcg_detonate_plr", self );
        detonatedgrenades = [];
        self.nembusgrenades = function_5713d46873b29625( self.nembusgrenades );
        
        foreach ( grenade in self.nembusgrenades )
        {
            if ( grenade.var_808ece62b3a01215 || grenade.var_4f49e9e8607f622e )
            {
                continue;
            }
            
            shoulddetonate = 0;
            
            if ( var_7c700a4f4609375d )
            {
                if ( isdefined( grenade.stucktime ) && gettime() >= grenade.stucktime + activationdelay )
                {
                    shoulddetonate = 1;
                }
            }
            else if ( isdefined( grenade.birthtime ) && gettime() >= grenade.birthtime + activationdelay )
            {
                shoulddetonate = 1;
            }
            
            if ( shoulddetonate )
            {
                detonatedgrenades[ detonatedgrenades.size ] = grenade;
            }
        }
        
        foreach ( grenade in detonatedgrenades )
        {
            self.nembusgrenades = arrayremove( self.nembusgrenades, grenade );
            grenade thread function_d4d714c62bee024();
        }
        
        if ( !self.nembusgrenades.size )
        {
            cleanup_nembus_tracking();
            return;
        }
    }
}

// Namespace sat_sl_nembus
// Params 0, eflags: 0x4
// Checksum 0x5751c6aa, Offset: 0x67b
// Size: 0x40
function private function_4999b5cdb6213c7a()
{
    self endon( #"death" );
    self endon( #"hash_619b485845417ba4" );
    self endon( #"hash_1d7fbf737f3e8a63" );
    self waittill( #"missile_stuck" );
    self.stucktime = gettime();
}

// Namespace sat_sl_nembus
// Params 0, eflags: 0x4
// Checksum 0xedea098f, Offset: 0x6c3
// Size: 0xa1
function private function_10a4b0435dae6e63()
{
    self endon( #"nembus_cleanup" );
    self waittill( #"death_or_disconnect" );
    
    foreach ( grenade in self.nembusgrenades )
    {
        if ( isdefined( grenade ) )
        {
            grenade thread function_c24b05c041748215();
        }
    }
    
    cleanup_nembus_tracking();
}

// Namespace sat_sl_nembus
// Params 0, eflags: 0x4
// Checksum 0x7c35a42e, Offset: 0x76c
// Size: 0xe3
function private function_4d62503f21de901b()
{
    self endon( #"hash_619b485845417ba4" );
    self endon( #"hash_1d7fbf737f3e8a63" );
    
    while ( true )
    {
        self waittill( #"damage", amount, attacker, direction, point, damage_type, modelname, tagname, partname, idflags, objweapon );
        
        if ( self.owner == attacker && self.weapon_object == objweapon )
        {
            if ( damage_type == "MOD_IMPACT" )
            {
                continue;
            }
            
            self.var_808ece62b3a01215 = 1;
            function_9d90cb0617580f5c();
            thread function_d4d714c62bee024();
            return;
        }
        
        thread function_8c62fe50ce0d0541();
    }
}

// Namespace sat_sl_nembus
// Params 0, eflags: 0x4
// Checksum 0x42f8bc98, Offset: 0x857
// Size: 0x2e
function private function_a0b7889caf9a48ad()
{
    self endon( #"hash_619b485845417ba4" );
    self endon( #"hash_1d7fbf737f3e8a63" );
    self waittill( #"death" );
    function_9d90cb0617580f5c();
}

// Namespace sat_sl_nembus
// Params 0, eflags: 0x4
// Checksum 0xe3cb4388, Offset: 0x88d
// Size: 0x48
function private function_d4d714c62bee024()
{
    self endon( #"death" );
    self notify( #"hash_1d7fbf737f3e8a63" );
    self.var_808ece62b3a01215 = 1;
    throttle::throttle_wait_in_queue( level.var_a177b2baa36179c9, self );
    self notify( #"hash_619b485845417ba4" );
    self detonate();
}

// Namespace sat_sl_nembus
// Params 0, eflags: 0x4
// Checksum 0xc5d08b10, Offset: 0x8dd
// Size: 0x10
function private function_8c62fe50ce0d0541()
{
    function_9d90cb0617580f5c();
    thread function_c24b05c041748215();
}

// Namespace sat_sl_nembus
// Params 0, eflags: 0x4
// Checksum 0xbdee0961, Offset: 0x8f5
// Size: 0x6d
function private function_9d90cb0617580f5c()
{
    if ( isdefined( self.owner.nembusgrenades ) )
    {
        self.owner.nembusgrenades = arrayremove( self.owner.nembusgrenades, self );
        
        if ( !self.owner.nembusgrenades.size )
        {
            self.owner cleanup_nembus_tracking();
        }
    }
}

// Namespace sat_sl_nembus
// Params 0, eflags: 0x4
// Checksum 0xbc0a567a, Offset: 0x96a
// Size: 0x39
function private cleanup_nembus_tracking()
{
    if ( !isdefined( self ) )
    {
        return;
    }
    
    self.nembusused = undefined;
    self.nembusgrenades = [];
    self notifyonplayercommandremove( "nembus_detonation", "+speed_throw" );
    self notify( #"nembus_cleanup" );
}

// Namespace sat_sl_nembus
// Params 0, eflags: 0x4
// Checksum 0x79deb2e8, Offset: 0x9ab
// Size: 0x4e
function private function_c24b05c041748215()
{
    if ( !self )
    {
        return;
    }
    
    if ( self.var_4f49e9e8607f622e )
    {
        return;
    }
    
    self.var_4f49e9e8607f622e = 1;
    self notify( #"hash_619b485845417ba4" );
    self setscriptablepartstate( "destroy", "active", 0 );
    wait 0.1;
    
    if ( isdefined( self ) )
    {
        self delete();
    }
}

