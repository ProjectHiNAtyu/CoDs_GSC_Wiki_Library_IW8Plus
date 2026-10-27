// scripts\common\stackablehitmarker.gsc  (hash_09337dd648535689.gscc) (size: 11568 Bytes / 0x2d30 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xee3ee0ef (3997098223)
// size ...... 11568 (0x2d30)
// includes .. 5   (offset: 0x29c0)
// strings ... 6   (offset: 0x29e8)
// dev strs .. 59  (offset: 0x2a30)
// exports ... 43  (offset: 0x19d0)
// cseg ...... 0x14e + 0x1882 (0x19d0)
// imports ... 73  (offset: 0x2088)
// animtree1 . 0   (offset: 0x2d30)
// animtree2 . 0   (offset: 0x2d30)
#using script_16ea1b94f0f381b3;
#using scripts\common\callbacks;
#using scripts\common\devgui;
#using scripts\common\ui;
#using scripts\common\utility;

#namespace stackablehitmarker;

// Namespace stackablehitmarker
// Params 0, eflags: 0x1
// Checksum 0xf22e38b0, Offset: 0x16c
// Size: 0xd4
function autoexec init()
{
    utility::registersharedfunc( #"hud", #"initstackablehitmarker", &initstackablehitmarker );
    utility::registersharedfunc( #"hud", #"hash_82fe4f75d53751e1", &function_58319ead445cea90 );
    utility::registersharedfunc( #"hud", #"hash_43bff838e7c0cf81", &function_4b0d6c761edcad8 );
    utility::registersharedfunc( #"hud", #"hash_84d4f784de00c6af", &function_bdc354bab03394ce );
    utility::registersharedfunc( #"hud", #"hash_eb86447382b1de03", &function_cd971c7b846f69e8 );
    utility::registersharedfunc( #"hud", #"hash_c8c81e6b434c4313", &function_ea26d70758b3a166 );
    utility::registersharedfunc( #"hud", #"hash_785d65fc31ffd85", &function_6156498227616d88 );
}

// Namespace stackablehitmarker
// Params 3
// Checksum 0xc5f732e5, Offset: 0x248
// Size: 0xd8
function function_58319ead445cea90( omnvarname, flag, iskillingblow )
{
    switch ( omnvarname ?? "" )
    {
        case #"hash_e242f25739127d9f":
            var_a804030c1c40f173 = "damage_feedback_weapon_notify";
            break;
        case #"hash_3e06e6c0a0e00af9":
            var_a804030c1c40f173 = "damage_feedback_equipment_notify";
            break;
        case #"hash_1cb96e49c1e03381":
            var_a804030c1c40f173 = "damage_feedback_hardobject_notify";
            break;
    }
    
    now = gettime();
    
    if ( iskillingblow || self.var_37b8c52eeea01de5[ var_a804030c1c40f173 ] != now || getdvarint( @"hash_605c8c06483a99ac", 1 ) != 1 )
    {
        self setclientomnvar( omnvarname, flag );
        self setclientomnvar( var_a804030c1c40f173, now );
        self.var_37b8c52eeea01de5[ var_a804030c1c40f173 ] = now;
    }
}

// Namespace stackablehitmarker
// Params 0
// Checksum 0x31d8afeb, Offset: 0x328
// Size: 0x33
function initstackablehitmarker()
{
    /#
        level thread init_damage_feedback_devgui();
    #/
    
    if ( function_3f246fcb668b2e7b() )
    {
        function_44d79c5d14c93b48();
        level callback::add( #"player_connect", &function_5a7f52267fb53d52 );
    }
}

// Namespace stackablehitmarker
// Params 3
// Checksum 0x8a2bf201, Offset: 0x363
// Size: 0x11e
function function_bdc354bab03394ce( hitmarkersoundtype, var_795e8a31194a39ac, killingblow )
{
    if ( !function_3f246fcb668b2e7b() )
    {
        return;
    }
    
    victim = var_795e8a31194a39ac.victimentity;
    
    if ( isdefined( victim ) && function_773423a0f51dc31e( victim ) )
    {
        if ( isdefined( victim.var_1f5c3835df679814 ) )
        {
            alias = victim.var_1f5c3835df679814;
        }
        else if ( isdefined( victim.var_2a0bcfaae7400f6f ) && !killingblow )
        {
            alias = victim.var_2a0bcfaae7400f6f;
        }
        else if ( isdefined( victim.var_959d9bf0d800e404 ) && killingblow )
        {
            alias = victim.var_959d9bf0d800e404;
        }
    }
    
    if ( !isdefined( alias ) )
    {
        alias = function_6156498227616d88( hitmarkersoundtype );
    }
    
    if ( !isdefined( alias ) )
    {
        return;
    }
    
    if ( isdefined( victim ) )
    {
        result = namespace_9d8e359c3b1041e5::playsoundtoplayersharedfunc( alias, self, victim );
        
        if ( isinfrontend() && !result )
        {
            playsoundatpos( victim.origin, alias );
        }
        
        return;
    }
    
    self playlocalsound( alias );
}

// Namespace stackablehitmarker
// Params 1, eflags: 0x4
// Checksum 0x5daa3b1e, Offset: 0x489
// Size: 0x17
function private function_773423a0f51dc31e( victim )
{
    return victim.var_aab5beb67c1704ec;
}

// Namespace stackablehitmarker
// Params 1
// Checksum 0xdb202533, Offset: 0x4a9
// Size: 0x3f
function function_6156498227616d88( hitmarkersoundtype )
{
    if ( !isdefined( level.var_f8f3ff001f9b39ca ) )
    {
        function_44d79c5d14c93b48();
    }
    
    return level.var_f8f3ff001f9b39ca[ ( self.var_928fdcf0c3bebba3 ?? 1 ) - 1 ][ hitmarkersoundtype ];
}

// Namespace stackablehitmarker
// Params 8
// Checksum 0xf5eb0259, Offset: 0x4f1
// Size: 0x11f
function function_4b0d6c761edcad8( killingblow, isfriendlyhit, headshot, isenemydown, isarmorhit, isarmorbreak, var_8582969205d20a3b, var_b60f6b5bf306f37b )
{
    if ( isfriendlyhit )
    {
        if ( killingblow )
        {
            return 5;
        }
        else
        {
            return 4;
        }
    }
    else if ( headshot && killingblow )
    {
        return 8;
    }
    else if ( headshot && !var_b60f6b5bf306f37b )
    {
        if ( isarmorhit )
        {
            return 10;
        }
        else if ( isarmorbreak )
        {
            return 11;
        }
        else
        {
            return 7;
        }
    }
    else if ( isenemydown )
    {
        return 9;
    }
    else if ( killingblow )
    {
        return 3;
    }
    else if ( var_b60f6b5bf306f37b && !isarmorbreak )
    {
        return ( [ 3:25, 2:24, 1:23 ][ var_b60f6b5bf306f37b ] ?? 10 );
    }
    else if ( var_b60f6b5bf306f37b && isarmorbreak )
    {
        return ( [ 3:28, 2:27, 1:26 ][ var_b60f6b5bf306f37b ] ?? 10 );
    }
    else if ( isarmorhit )
    {
        return 10;
    }
    else if ( isarmorbreak )
    {
        return 11;
    }
    else if ( var_8582969205d20a3b )
    {
        return 21;
    }
    
    return 2;
}

// Namespace stackablehitmarker
// Params 2
// Checksum 0xd4737446, Offset: 0x619
// Size: 0x3f
function function_cd971c7b846f69e8( killingblow, stackablehitmarkerdata )
{
    if ( isdefined( stackablehitmarkerdata.soundtypeoverride ) )
    {
        return function_665ce5417676c728( stackablehitmarkerdata.soundtypeoverride );
    }
    
    if ( killingblow )
    {
        return 1;
    }
    
    return 0;
}

// Namespace stackablehitmarker
// Params 2
// Checksum 0x50df5702, Offset: 0x661
// Size: 0x3a
function function_ea26d70758b3a166( killingblow, var_795e8a31194a39ac )
{
    if ( var_795e8a31194a39ac.var_3e13d05260eee4e1 )
    {
        return ( killingblow ? 19 : 18 );
    }
    
    if ( killingblow )
    {
        return 17;
    }
    
    return 16;
}

// Namespace stackablehitmarker
// Params 1, eflags: 0x4
// Checksum 0x6f131078, Offset: 0x6a4
// Size: 0x5f
function private function_665ce5417676c728( var_3406319376dc2514 )
{
    switch ( var_3406319376dc2514 )
    {
        case 1:
            return 12;
        case 2:
            return 13;
        case 3:
            return 14;
        case 4:
            return 15;
        default:
            return;
    }
}

// Namespace stackablehitmarker
// Params 0, eflags: 0x4
// Checksum 0xf935ee81, Offset: 0x70b
// Size: 0x6a
function private function_44d79c5d14c93b48()
{
    level.var_f8f3ff001f9b39ca = [];
    configlist = getscriptbundle( level.gamemodebundle.var_acb3274dd686326 );
    level.var_f8f3ff001f9b39ca[ 0 ] = function_af9ea8a4fe22dd81( configlist.defaultset );
    level.var_f8f3ff001f9b39ca[ 1 ] = function_af9ea8a4fe22dd81( configlist.classicset );
}

// Namespace stackablehitmarker
// Params 1, eflags: 0x4
// Checksum 0x826f816b, Offset: 0x77d
// Size: 0x71
function private function_5a7f52267fb53d52( params )
{
    level endon( #"game_ended" );
    self endon( #"death_or_disconnect" );
    
    if ( isdefined( self ) )
    {
        if ( isbot( self ) )
        {
            var_928fdcf0c3bebba3 = randomintrange( 1, 3 );
        }
        else
        {
            var_928fdcf0c3bebba3 = utility::requestgamerprofile( "sndHitmarkerPreset" );
            ui::lui_registercallback( "hitmarker_sound_preset_update", &hitmarker_sound_preset_update );
        }
        
        self.var_928fdcf0c3bebba3 = var_928fdcf0c3bebba3;
    }
}

// Namespace stackablehitmarker
// Params 1, eflags: 0x4
// Checksum 0xa889a7f, Offset: 0x7f6
// Size: 0x17
function private hitmarker_sound_preset_update( val )
{
    self.var_928fdcf0c3bebba3 = val;
}

// Namespace stackablehitmarker
// Params 1, eflags: 0x4
// Checksum 0x4ae44c08, Offset: 0x815
// Size: 0x16a
function private function_af9ea8a4fe22dd81( configbundlename )
{
    configbundle = getscriptbundle( configbundlename );
    config = [];
    config[ 0 ] = configbundle.equiphit;
    config[ 1 ] = configbundle.equipkill;
    config[ 12 ] = configbundle.equipmentburn;
    config[ 13 ] = configbundle.equipmentgas;
    config[ 14 ] = configbundle.equipmentelectric;
    config[ 15 ] = configbundle.equipmentblunt;
    config[ 2 ] = configbundle.var_14b4e5782406eb3b;
    config[ 3 ] = configbundle.var_86e5942268956a2e;
    config[ 4 ] = configbundle.friendlyhit;
    config[ 5 ] = configbundle.friendlykill;
    config[ 7 ] = configbundle.headshotregular;
    config[ 8 ] = configbundle.headshotkill;
    config[ 9 ] = configbundle.enemydowned;
    config[ 10 ] = configbundle.armorhit;
    config[ 11 ] = configbundle.armordestroy;
    config[ 21 ] = configbundle.var_9643a60ce906b1eb;
    config[ 16 ] = configbundle.var_b669562b251d2b33;
    config[ 17 ] = configbundle.var_edc1b76ab0f250ac;
    config[ 18 ] = configbundle.hardobjecthit;
    config[ 19 ] = configbundle.hardobjectdestroy;
    return config;
}

// Namespace stackablehitmarker
// Params 0, eflags: 0x4
// Checksum 0x6c591a35, Offset: 0x988
// Size: 0x20, Type: bool
function private function_3f246fcb668b2e7b()
{
    return istrue( level.gamemodebundle.var_c94c36b93b3c2863.var_41a7d1d90d2f9424 );
}

/#

    // Namespace stackablehitmarker
    // Params 0
    // Checksum 0x533ccc25, Offset: 0x9b1
    // Size: 0x2ec, Type: dev
    function init_damage_feedback_devgui()
    {
        if ( level.gamemodebundle.var_ff5875c91bf48d60 )
        {
            devgui::function_9082edeb5db93280( "<dev string:x24>" );
            devgui::add_devgui_func( "<dev string:x3a>", "<dev string:x4a>", &function_5b411e590a03f868 );
            devgui::add_devgui_func( "<dev string:x69>", "<dev string:x7a>", &function_b2b8038e3dd76b87 );
            devgui::add_devgui_func( "<dev string:x9a>", "<dev string:xb3>", &function_bfe4bcc4e64ee077 );
            devgui::add_devgui_func( "<dev string:xda>", "<dev string:xf4>", &function_4fe985ea5d63364a );
            devgui::add_devgui_func( "<dev string:x11c>", "<dev string:x135>", &function_f7c06326d39830d9 );
            devgui::add_devgui_func( "<dev string:x15c>", "<dev string:x176>", &function_142ce1a8c6eb7974 );
            devgui::add_devgui_func( "<dev string:x19e>", "<dev string:x1c0>", &function_ed096b768fd8c535 );
            devgui::add_devgui_func( "<dev string:x1eb>", "<dev string:x20e>", &function_f2688d0272c12980 );
            devgui::add_devgui_func( "<dev string:x23a>", "<dev string:x250>", &function_3e27a77f375049ff );
            devgui::add_devgui_func( "<dev string:x274>", "<dev string:x28c>", &function_5945399f04853b55 );
            devgui::add_devgui_func( "<dev string:x2b2>", "<dev string:x2c9>", &function_c88f2526206f9e45 );
            devgui::add_devgui_func( "<dev string:x2ee>", "<dev string:x30a>", &function_c06f056d291f2df4 );
            devgui::add_devgui_func( "<dev string:x333>", "<dev string:x342>", &function_6d0a3adbbc7be108 );
            devgui::add_devgui_func( "<dev string:x360>", "<dev string:x370>", &function_4c5016fcc0619fa7 );
            devgui::add_devgui_func( "<dev string:x38f>", "<dev string:x3a7>", &function_b328138b77d07579 );
            devgui::add_devgui_func( "<dev string:x3cd>", "<dev string:x3e6>", &function_717a2efdeea9d894 );
            devgui::add_devgui_func( "<dev string:x40d>", "<dev string:x421>", &function_7ecc5ccb4dc7f292 );
            devgui::add_devgui_func( "<dev string:x444>", "<dev string:x45c>", &function_145f6f48b36d02ed );
            devgui::add_devgui_func( "<dev string:x483>", "<dev string:x4a6>", &function_23de81655e8da825 );
            devgui::add_devgui_func( "<dev string:x4dd>", "<dev string:x4f7>", &function_f8f713aecfc22d5c );
            devgui::add_devgui_func( "<dev string:x525>", "<dev string:x544>", &function_9285f95b96669b14 );
            devgui::add_devgui_func( "<dev string:x577>", "<dev string:x590>", &function_377dd24de7f87340 );
            devgui::add_devgui_func( "<dev string:x5bd>", "<dev string:x5d7>", &function_303bb46c6128dffe );
            devgui::add_devgui_func( "<dev string:x605>", "<dev string:x61f>", &function_42884c79675224e0 );
            devgui::add_devgui_func( "<dev string:x64e>", "<dev string:x66c>", &function_e5fa03c8651f32d7 );
            devgui::function_77df7fe7dd273e10();
            devgui::function_9082edeb5db93280( "<dev string:x69e>" );
            listbundle = getscriptbundle( level.gamemodebundle.hitmarkericonlist );
            list = listbundle.hitmarkericonlist;
            
            for ( i = 0; i < list.size ; i++ )
            {
                typename = list[ i ].typename;
                devgui::function_cd4e263c1f3018ae( "<dev string:x6b8>" + typename, "<dev string:x6be>" + typename, &function_5c75837c70153bd7 );
            }
            
            devgui::function_77df7fe7dd273e10();
        }
    }

    // Namespace stackablehitmarker
    // Params 0
    // Checksum 0xdacf8faf, Offset: 0xca5
    // Size: 0x97, Type: dev
    function function_5b411e590a03f868()
    {
        markerflag = 0;
        markerflag |= 1;
        
        foreach ( player in level.players )
        {
            player function_58319ead445cea90( "<dev string:x6de>", markerflag );
        }
    }

    // Namespace stackablehitmarker
    // Params 0
    // Checksum 0xeb286377, Offset: 0xd44
    // Size: 0xa0, Type: dev
    function function_b2b8038e3dd76b87()
    {
        markerflag = 0;
        markerflag |= 1;
        markerflag |= 2;
        
        foreach ( player in level.players )
        {
            player function_58319ead445cea90( "<dev string:x6de>", markerflag, 1 );
        }
    }

    // Namespace stackablehitmarker
    // Params 0
    // Checksum 0x4e7df43a, Offset: 0xdec
    // Size: 0x9e, Type: dev
    function function_bfe4bcc4e64ee077()
    {
        markerflag = 0;
        markerflag |= 1;
        markerflag |= 8;
        
        foreach ( player in level.players )
        {
            player function_58319ead445cea90( "<dev string:x6de>", markerflag );
        }
    }

    // Namespace stackablehitmarker
    // Params 0
    // Checksum 0xedf337da, Offset: 0xe92
    // Size: 0xa7, Type: dev
    function function_4fe985ea5d63364a()
    {
        markerflag = 0;
        markerflag |= 1;
        markerflag |= 8;
        markerflag |= 2;
        
        foreach ( player in level.players )
        {
            player function_58319ead445cea90( "<dev string:x6de>", markerflag, 1 );
        }
    }

    // Namespace stackablehitmarker
    // Params 0
    // Checksum 0x724a0c3a, Offset: 0xf41
    // Size: 0x9e, Type: dev
    function function_f7c06326d39830d9()
    {
        markerflag = 0;
        markerflag |= 1;
        markerflag |= 4;
        
        foreach ( player in level.players )
        {
            player function_58319ead445cea90( "<dev string:x6de>", markerflag );
        }
    }

    // Namespace stackablehitmarker
    // Params 0
    // Checksum 0x15172a4f, Offset: 0xfe7
    // Size: 0xa7, Type: dev
    function function_142ce1a8c6eb7974()
    {
        markerflag = 0;
        markerflag |= 1;
        markerflag |= 4;
        markerflag |= 2;
        
        foreach ( player in level.players )
        {
            player function_58319ead445cea90( "<dev string:x6de>", markerflag, 1 );
        }
    }

    // Namespace stackablehitmarker
    // Params 0
    // Checksum 0x66a13029, Offset: 0x1096
    // Size: 0xa5, Type: dev
    function function_ed096b768fd8c535()
    {
        markerflag = 0;
        markerflag |= 1;
        markerflag |= 4;
        markerflag |= 8;
        
        foreach ( player in level.players )
        {
            player function_58319ead445cea90( "<dev string:x6de>", markerflag );
        }
    }

    // Namespace stackablehitmarker
    // Params 0
    // Checksum 0x7ec6cdf3, Offset: 0x1143
    // Size: 0xae, Type: dev
    function function_f2688d0272c12980()
    {
        markerflag = 0;
        markerflag |= 1;
        markerflag |= 4;
        markerflag |= 8;
        markerflag |= 2;
        
        foreach ( player in level.players )
        {
            player function_58319ead445cea90( "<dev string:x6de>", markerflag, 1 );
        }
    }

    // Namespace stackablehitmarker
    // Params 0
    // Checksum 0x4d462727, Offset: 0x11f9
    // Size: 0x9f, Type: dev
    function function_c06f056d291f2df4()
    {
        markerflag = 0;
        markerflag |= 1;
        markerflag |= 256;
        
        foreach ( player in level.players )
        {
            player function_58319ead445cea90( "<dev string:x6de>", markerflag );
        }
    }

    // Namespace stackablehitmarker
    // Params 0
    // Checksum 0x41e03b72, Offset: 0x12a0
    // Size: 0x9e, Type: dev
    function function_3e27a77f375049ff()
    {
        markerflag = 0;
        markerflag |= 1;
        markerflag |= 16;
        
        foreach ( player in level.players )
        {
            player function_58319ead445cea90( "<dev string:x6de>", markerflag );
        }
    }

    // Namespace stackablehitmarker
    // Params 0
    // Checksum 0x2e01c6bd, Offset: 0x1346
    // Size: 0x9e, Type: dev
    function function_5945399f04853b55()
    {
        markerflag = 0;
        markerflag |= 1;
        markerflag |= 32;
        
        foreach ( player in level.players )
        {
            player function_58319ead445cea90( "<dev string:x6de>", markerflag );
        }
    }

    // Namespace stackablehitmarker
    // Params 0
    // Checksum 0xd3f41581, Offset: 0x13ec
    // Size: 0x9e, Type: dev
    function function_c88f2526206f9e45()
    {
        markerflag = 0;
        markerflag |= 1;
        markerflag |= 64;
        
        foreach ( player in level.players )
        {
            player function_58319ead445cea90( "<dev string:x6de>", markerflag );
        }
    }

    // Namespace stackablehitmarker
    // Params 0
    // Checksum 0x212d2f37, Offset: 0x1492
    // Size: 0x97, Type: dev
    function function_6d0a3adbbc7be108()
    {
        markerflag = 0;
        markerflag |= 1;
        
        foreach ( player in level.players )
        {
            player function_58319ead445cea90( "<dev string:x6f5>", markerflag );
        }
    }

    // Namespace stackablehitmarker
    // Params 0
    // Checksum 0x8d3830a8, Offset: 0x1531
    // Size: 0xa0, Type: dev
    function function_4c5016fcc0619fa7()
    {
        markerflag = 0;
        markerflag |= 1;
        markerflag |= 2;
        
        foreach ( player in level.players )
        {
            player function_58319ead445cea90( "<dev string:x6f5>", markerflag, 1 );
        }
    }

    // Namespace stackablehitmarker
    // Params 0
    // Checksum 0xf175c229, Offset: 0x15d9
    // Size: 0x9e, Type: dev
    function function_b328138b77d07579()
    {
        markerflag = 0;
        markerflag |= 1;
        markerflag |= 4;
        
        foreach ( player in level.players )
        {
            player function_58319ead445cea90( "<dev string:x6f5>", markerflag );
        }
    }

    // Namespace stackablehitmarker
    // Params 0
    // Checksum 0x912a545f, Offset: 0x167f
    // Size: 0xa7, Type: dev
    function function_717a2efdeea9d894()
    {
        markerflag = 0;
        markerflag |= 1;
        markerflag |= 4;
        markerflag |= 2;
        
        foreach ( player in level.players )
        {
            player function_58319ead445cea90( "<dev string:x6f5>", markerflag, 1 );
        }
    }

    // Namespace stackablehitmarker
    // Params 0
    // Checksum 0x90e60091, Offset: 0x172e
    // Size: 0x97, Type: dev
    function function_7ecc5ccb4dc7f292()
    {
        markerflag = 0;
        markerflag |= 1;
        
        foreach ( player in level.players )
        {
            player function_58319ead445cea90( "<dev string:x70b>", markerflag );
        }
    }

    // Namespace stackablehitmarker
    // Params 0
    // Checksum 0x90ff9483, Offset: 0x17cd
    // Size: 0xa0, Type: dev
    function function_145f6f48b36d02ed()
    {
        markerflag = 0;
        markerflag |= 1;
        markerflag |= 2;
        
        foreach ( player in level.players )
        {
            player function_58319ead445cea90( "<dev string:x70b>", markerflag, 1 );
        }
    }

    // Namespace stackablehitmarker
    // Params 0
    // Checksum 0xa84626f7, Offset: 0x1875
    // Size: 0x13, Type: dev
    function function_23de81655e8da825()
    {
        function_145f6f48b36d02ed();
        function_4c5016fcc0619fa7();
    }

    // Namespace stackablehitmarker
    // Params 0
    // Checksum 0xde68e5c0, Offset: 0x1890
    // Size: 0x13, Type: dev
    function function_f8f713aecfc22d5c()
    {
        function_5b411e590a03f868();
        function_4c5016fcc0619fa7();
    }

    // Namespace stackablehitmarker
    // Params 0
    // Checksum 0xc9028b89, Offset: 0x18ab
    // Size: 0x13, Type: dev
    function function_9285f95b96669b14()
    {
        function_b2b8038e3dd76b87();
        function_7ecc5ccb4dc7f292();
    }

    // Namespace stackablehitmarker
    // Params 0
    // Checksum 0xec738d82, Offset: 0x18c6
    // Size: 0x13, Type: dev
    function function_377dd24de7f87340()
    {
        function_6d0a3adbbc7be108();
        function_3e27a77f375049ff();
    }

    // Namespace stackablehitmarker
    // Params 0
    // Checksum 0x12e46c42, Offset: 0x18e1
    // Size: 0x13, Type: dev
    function function_303bb46c6128dffe()
    {
        function_6d0a3adbbc7be108();
        function_b2b8038e3dd76b87();
    }

    // Namespace stackablehitmarker
    // Params 0
    // Checksum 0xb61746bc, Offset: 0x18fc
    // Size: 0x13, Type: dev
    function function_42884c79675224e0()
    {
        function_6d0a3adbbc7be108();
        function_b2b8038e3dd76b87();
    }

    // Namespace stackablehitmarker
    // Params 0
    // Checksum 0x6e185c20, Offset: 0x1917
    // Size: 0x13, Type: dev
    function function_e5fa03c8651f32d7()
    {
        function_6d0a3adbbc7be108();
        function_7ecc5ccb4dc7f292();
    }

    // Namespace stackablehitmarker
    // Params 1
    // Checksum 0xc9a20eb2, Offset: 0x1932
    // Size: 0x9e, Type: dev
    function function_5c75837c70153bd7( param )
    {
        foreach ( player in level.players )
        {
            player setclientomnvar( "<dev string:x726>", param[ 0 ] );
            player setclientomnvar( "<dev string:x73b>", gettime() );
        }
    }

#/
