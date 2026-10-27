// scripts\common\focus.gsc  (hash_597273a17e42cbdc.gscc) (size: 2392 Bytes / 0x958 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x5d17a286 (1561830022)
// size ...... 2392 (0x958)
// includes .. 2   (offset: 0x918)
// strings ... 4   (offset: 0x928)
// dev strs .. 0   (offset: 0x958)
// exports ... 12  (offset: 0x534)
// cseg ...... 0xdd + 0x457 (0x534)
// imports ... 18  (offset: 0x714)
// animtree1 . 0   (offset: 0x958)
// animtree2 . 0   (offset: 0x958)
#using scripts\common\callbacks;
#using scripts\common\weapon;

#namespace focus;

// Namespace focus
// Params 0
// Checksum 0xe83e0e43, Offset: 0xfb
// Size: 0x9d
function init()
{
    callback::add( #"player_spawned", &onplayerspawned );
    
    if ( isdefined( level.players ) )
    {
        foreach ( player in level.players )
        {
            player thread onplayerspawned();
        }
    }
}

// Namespace focus
// Params 1
// Checksum 0x7ee4b78c, Offset: 0x1a0
// Size: 0x89
function onplayerspawned( params )
{
    self.focusbreath = 0;
    self.var_c06462955efc0a91 = -99999;
    self.var_1395863480400423 = -99999;
    
    if ( level.gamemodebundle.var_86a77e21b7811845 == #"disabled" )
    {
        self setclientomnvar( "ui_hide_focus_hide", 1 );
        return;
    }
    
    if ( level.gamemodebundle.var_86a77e21b7811845 == #"dynamic" )
    {
        thread function_f516f14a40f561b8();
    }
}

// Namespace focus/event_2805f0483f252c54
// Params 0, eflags: 0x24
// Checksum 0x48d98624, Offset: 0x231
// Size: 0x1b
function private event_handler[event_2805f0483f252c54] function_2805f0483f252c54()
{
    if ( self isholdingbreath() )
    {
        startfocus();
        return;
    }
    
    stopfocus();
}

// Namespace focus
// Params 0
// Checksum 0xae02b172, Offset: 0x254
// Size: 0x60
function startfocus()
{
    if ( !self.focusbreath )
    {
        thread watchfordeath();
        thread watchforfire();
        var_43ca78b5a58bea42 = !level.wpinprogress;
        
        if ( var_43ca78b5a58bea42 )
        {
            focusvision();
        }
        
        self.focusbreath = 1;
        self playlocalsound( "plr_focusmode_in" );
        self playlocalsound( "plr_focusmode_hold" );
    }
}

// Namespace focus
// Params 0
// Checksum 0xb043ff61, Offset: 0x2bc
// Size: 0x6c
function stopfocus()
{
    if ( self.focusbreath )
    {
        self notify( #"hash_825847bbe62d8e34" );
        self.var_c06462955efc0a91 = gettime();
        self.focusbreath = 0;
        self playlocalsound( "plr_focusmode_out" );
        
        if ( isdefined( level.gamemodebundle.pbgpostfxbundle_focus ) )
        {
            pbgpostfxbundleend( self, level.gamemodebundle.pbgpostfxbundle_focus );
        }
    }
}

// Namespace focus
// Params 0
// Checksum 0xb1324221, Offset: 0x330
// Size: 0x71
function watchforfire()
{
    self notify( #"hash_af11f32f8f4cf5f3" );
    self endon( #"hash_af11f32f8f4cf5f3" );
    level endon( #"game_ended" );
    self endon( #"death_or_disconnect" );
    
    while ( true )
    {
        self waittill( #"weapon_fired" );
        currtime = gettime();
        
        if ( function_5f61a257be5ed024( currtime ) )
        {
            self.var_1395863480400423 = currtime;
            continue;
        }
        
        return;
    }
}

// Namespace focus
// Params 1
// Checksum 0x5562da3c, Offset: 0x3a9
// Size: 0x1b, Type: bool
function function_5f61a257be5ed024( currtime )
{
    return currtime - self.var_c06462955efc0a91 < 50;
}

// Namespace focus
// Params 0
// Checksum 0xf733248, Offset: 0x3cd
// Size: 0x55
function watchfordeath()
{
    self notify( #"hash_1b19879ecf454284" );
    self endon( #"hash_1b19879ecf454284" );
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    self endon( #"hash_825847bbe62d8e34" );
    self waittill( #"death" );
    self.focusbreath = 0;
}

// Namespace focus
// Params 0, eflags: 0x4
// Checksum 0x134569d4, Offset: 0x42a
// Size: 0xa2
function private function_5a20a9b7cae18ee9()
{
    weapontype = weapon::getweaponclasstoken( self.currentweapon.basename );
    
    switch ( weapontype )
    {
        case #"hash_fa0ed9f6bd4f4e9a":
        case #"hash_fa18d2f6bd57925a":
        case #"hash_fa21c4f6bd5e3815":
        case #"hash_fa27b9f6bd62a3f2":
        case #"hash_fa4dbdf6bd80bf52":
        case #"hash_fa50b4f6bd82efbe":
        case #"hash_fa50b6f6bd82f2e4":
        case #"hash_fa50b9f6bd82f79d":
            return 1;
        default:
            return 0;
    }
}

// Namespace focus
// Params 0, eflags: 0x4
// Checksum 0x78be023a, Offset: 0x4d4
// Size: 0x32
function private focusvision()
{
    if ( isdefined( level.gamemodebundle.pbgpostfxbundle_focus ) )
    {
        pbgpostfxbundlestart( self, level.gamemodebundle.pbgpostfxbundle_focus );
    }
}

// Namespace focus
// Params 0, eflags: 0xc
// Checksum 0x5a93d643, Offset: 0x50e
// Size: 0x26
function private function_f516f14a40f561b8()
{
    self notify( #"hash_6dd91500a77ee47" );
    self endon( #"hash_6dd91500a77ee47" );
    self endon( #"death_or_disconnect" );
}

