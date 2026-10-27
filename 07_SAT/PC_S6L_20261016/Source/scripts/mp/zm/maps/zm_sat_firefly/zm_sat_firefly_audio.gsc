// scripts\mp\zm\maps\zm_sat_firefly\zm_sat_firefly_audio.gsc  (hash_428d31ccf36d1596.gscc) (size: 1048 Bytes / 0x418 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x93d5c757 (2480260951)
// size ...... 1048 (0x418)
// includes .. 3   (offset: 0x3e4)
// strings ... 2   (offset: 0x3fc)
// dev strs .. 0   (offset: 0x418)
// exports ... 4   (offset: 0x240)
// cseg ...... 0x73 + 0x1cd (0x240)
// imports ... 9   (offset: 0x2e0)
// animtree1 . 0   (offset: 0x418)
// animtree2 . 0   (offset: 0x418)
#using scripts\common\callbacks;
#using scripts\mp\common\utility\musicbank_utility;
#using scripts\mp\zm\systems\zm_vo;

#namespace zm_sat_firefly_audio;

// Namespace zm_sat_firefly_audio
// Params 0
// Checksum 0xcbd9888b, Offset: 0x91
// Size: 0x2d
function main()
{
    level callback::add( "zone_changed", &on_zone_changed );
    namespace_c0b4f2882c9d100f::function_55319be40b828f47( #"eternal_perk", #"hash_c0867aed547e7e0c" );
}

// Namespace zm_sat_firefly_audio
// Params 1
// Checksum 0xe4e0ec62, Offset: 0xc6
// Size: 0x112
function on_zone_changed( params )
{
    str_player_zone_name = params.zone_struct.script_zone_name;
    var_e74a9e7fb261982 = params.previous_zone_struct.script_zone_name;
    var_518e20dbc0343c76 = issubstr( str_player_zone_name, "zone_ts" );
    var_633db7feef39209f = issubstr( var_e74a9e7fb261982, "zone_ts" );
    
    if ( var_518e20dbc0343c76 )
    {
        if ( self.var_b93c209539a70a5d )
        {
            return;
        }
        
        thread function_7861c4e858088737();
        return;
    }
    
    if ( self.var_b93c209539a70a5d )
    {
        self.var_b93c209539a70a5d = undefined;
        musicbank_utility::function_4f253fd35ec68cbc( self, #"hash_a216637255b344e6" );
        self notify( #"hash_70e9ba6cb3253236" );
        
        if ( !isdefined( self.var_1eeff51a92cd099f ) )
        {
            self.var_1eeff51a92cd099f = 0;
        }
        
        if ( ( gettime() - self.var_1eeff51a92cd099f ) / 1000 < 4 )
        {
            return;
        }
        
        self playsoundtoplayer( #"hash_d7e586e30f82b279", self );
        self.var_1eeff51a92cd099f = gettime();
    }
}

// Namespace zm_sat_firefly_audio
// Params 0
// Checksum 0x60463ca6, Offset: 0x1e0
// Size: 0x60
function function_7861c4e858088737()
{
    self notify( #"hash_77771ad82e682ffb" );
    self endon( #"hash_77771ad82e682ffb" );
    self endon( #"death_or_disconnect" );
    self endon( #"hash_70e9ba6cb3253236" );
    self.var_b93c209539a70a5d = 1;
    
    while ( self.var_b93c209539a70a5d )
    {
        musicbank_utility::function_5aca66c390aa347d( self, #"hash_a216637255b344e6" );
        wait 2;
    }
}

