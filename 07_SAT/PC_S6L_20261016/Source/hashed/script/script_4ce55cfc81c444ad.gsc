// script_4ce55cfc81c444ad  (hash_4ce55cfc81c444ad.gscc) (size: 15950 Bytes / 0x3e4e / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xbc335908 (3157481736)
// size ...... 15950 (0x3e4e)
// includes .. 4   (offset: 0x394e)
// strings ... 22  (offset: 0x396e)
// dev strs .. 74  (offset: 0x3aa2)
// exports ... 45  (offset: 0x27e2)
// cseg ...... 0x2aa + 0x2538 (0x27e2)
// imports ... 81  (offset: 0x2eea)
// animtree1 . 0   (offset: 0x3e4e)
// animtree2 . 0   (offset: 0x3e4e)
#using scripts\anim\dialogue;
#using scripts\common\linked_list;
#using scripts\common\utility;
#using scripts\mp\zm\ztron\ztron_debug;

#namespace ztron_dialog;

// Namespace ztron_dialog
// Params 4
// Checksum 0x10c37185, Offset: 0x2c8
// Size: 0x72
function function_7e3f6329d9afcdc1( var_a2c05fda49042ea7, bimmediately = 0, var_b8e0344ea474d895 = 1, var_581de4f4991f612e = undefined )
{
    assert( isdefined( var_a2c05fda49042ea7 ), "<dev string:x24>" );
    params = function_d9a24392dff52881( var_a2c05fda49042ea7, 0, bimmediately, var_b8e0344ea474d895, var_581de4f4991f612e );
    function_e6affa10849b8c4c( params );
}

// Namespace ztron_dialog
// Params 4
// Checksum 0x6f52201c, Offset: 0x342
// Size: 0x75
function function_927bb94feca983e8( var_be48a7aade39eff0, bimmediately = 0, var_b8e0344ea474d895 = 1, var_47951a26435d742f = 0 )
{
    assert( isdefined( var_be48a7aade39eff0 ), "<dev string:x5f>" );
    params = function_d9a24392dff52881( var_be48a7aade39eff0, 1, bimmediately, var_b8e0344ea474d895, undefined, var_47951a26435d742f );
    function_e6affa10849b8c4c( params );
}

// Namespace ztron_dialog
// Params 0
// Checksum 0xb67d3049, Offset: 0x3bf
// Size: 0x32
function init_ztron_dialog()
{
    if ( !function_db9e7cc7d5158a7f() )
    {
        return;
    }
    
    function_76083a00596e3d1e();
    initdialogentries();
    namespace_b1af77fe7f803de7::function_833f4a6ea426b5fb();
    level thread function_f6d7ff8d93b5527e();
    level thread function_b55363345742a7d2();
}

// Namespace ztron_dialog
// Params 0, eflags: 0x4
// Checksum 0x53151f1e, Offset: 0x3f9
// Size: 0x4, Type: bool
function private function_db9e7cc7d5158a7f()
{
    return true;
}

// Namespace ztron_dialog
// Params 0
// Checksum 0xd94fba1c, Offset: 0x406
// Size: 0x225
function function_76083a00596e3d1e()
{
    level.ztron.dialog_aliases = [];
    level.ztron.dialog_aliases[ "papaback" ][ #"badass" ] = "dx_ztron_gibberish_papaback_badass";
    level.ztron.dialog_aliases[ "papaback" ][ #"angry" ] = "dx_ztron_gibberish_papaback_angry";
    level.ztron.dialog_aliases[ "papaback" ][ #"roar" ] = "dx_ztron_gibberish_papaback_roar";
    
    for ( i = 0; i < 4 ; i++ )
    {
        level.ztron.dialog_aliases[ "player" + i ][ #"angry" ] = "dx_ztron_gibberish_angry_player_" + i;
        level.ztron.dialog_aliases[ "player" + i ][ #"badass" ] = "dx_ztron_gibberish_badass_player_" + i;
        level.ztron.dialog_aliases[ "player" + i ][ #"cheering" ] = "dx_ztron_gibberish_cheering_player_" + i;
        level.ztron.dialog_aliases[ "player" + i ][ #"excited" ] = "dx_ztron_gibberish_excited_player_" + i;
        level.ztron.dialog_aliases[ "player" + i ][ #"happy" ] = "dx_ztron_gibberish_happy_player_" + i;
        level.ztron.dialog_aliases[ "player" + i ][ #"sad" ] = "dx_ztron_gibberish_sad_player_" + i;
        level.ztron.dialog_aliases[ "player" + i ][ #"scared" ] = "dx_ztron_gibberish_scared_player_" + i;
        level.ztron.dialog_aliases[ "player" + i ][ #"sexy" ] = "dx_ztron_gibberish_sexy_player_" + i;
    }
}

// Namespace ztron_dialog
// Params 0, eflags: 0xc
// Checksum 0x21b700d0, Offset: 0x633
// Size: 0x73
function private function_f6d7ff8d93b5527e()
{
    self notify( #"hash_31960aae22aef5fa" );
    self endon( #"hash_31960aae22aef5fa" );
    level endon( #"ztron_game_is_over" );
    level.ztron.var_2f80297343a70a56 = [];
    
    while ( true )
    {
        level utility::waittill_any( "arena_completed", "ztron_exit_taken", "bonus_room_completed", "start_game_ended" );
        level function_afe4d4047083053a();
        level notify( #"hash_5763d316a84acc41" );
    }
}

// Namespace ztron_dialog
// Params 0, eflags: 0xc
// Checksum 0x3396272c, Offset: 0x6ae
// Size: 0x49
function private function_b55363345742a7d2()
{
    self notify( #"hash_2fab58bb030888fa" );
    self endon( #"hash_2fab58bb030888fa" );
    level endon( #"ztron_game_is_over" );
    
    while ( true )
    {
        level waittill( #"hash_5763d316a84acc41" );
        level namespace_b1af77fe7f803de7::function_9d21db100d2cacd( 0, "force_clean" );
    }
}

// Namespace ztron_dialog
// Params 6, eflags: 0x4
// Checksum 0x41a767f4, Offset: 0x6ff
// Size: 0xb5
function private function_d9a24392dff52881( entryref, var_9f8d10b8a1f9d323, bimmediately, var_b8e0344ea474d895, var_581de4f4991f612e, var_47951a26435d742f )
{
    entryref = isxhash( entryref ) ? entryref : getxhash( entryref );
    params = spawnstruct();
    params.var_24f7b0881d1278af = entryref;
    params.var_9f8d10b8a1f9d323 = var_9f8d10b8a1f9d323;
    params.bimmediately = bimmediately;
    params.var_b8e0344ea474d895 = var_b8e0344ea474d895;
    params.var_581de4f4991f612e = var_581de4f4991f612e;
    params.var_47951a26435d742f = var_47951a26435d742f;
    return params;
}

// Namespace ztron_dialog
// Params 0
// Checksum 0xd2617695, Offset: 0x7bd
// Size: 0xb
function ispapaback()
{
    return self.ispapaback;
}

// Namespace ztron_dialog
// Params 0
// Checksum 0x2d381444, Offset: 0x7d1
// Size: 0x29, Type: bool
function isfemale()
{
    return isdefined( self.operatorcustomization ) && self.operatorcustomization.gender == "female";
}

// Namespace ztron_dialog
// Params 1, eflags: 0x4
// Checksum 0x7bb253a3, Offset: 0x803
// Size: 0xf9, Type: bool
function private function_e6affa10849b8c4c( sparams )
{
    assert( sparams, "<dev string:x99>" );
    var_24f7b0881d1278af = sparams.var_24f7b0881d1278af;
    var_9f8d10b8a1f9d323 = sparams.var_9f8d10b8a1f9d323 ?? 0;
    bimmediately = sparams.bimmediately ?? 0;
    var_b8e0344ea474d895 = sparams.var_b8e0344ea474d895 ?? 0;
    var_581de4f4991f612e = sparams.var_581de4f4991f612e;
    var_47951a26435d742f = sparams.var_47951a26435d742f;
    
    if ( !function_ce393f2584273bce( var_24f7b0881d1278af, var_9f8d10b8a1f9d323, var_b8e0344ea474d895 ) )
    {
        return false;
    }
    
    if ( function_188736db3c58c06b( bimmediately ) )
    {
        function_bf8d1d20b24fe451( sparams );
        return false;
    }
    
    if ( bimmediately )
    {
        function_527dcbd33d507d22();
    }
    
    var_5f14402a2e931ff1 = function_51c8a1c4bba55ed2( var_24f7b0881d1278af, var_9f8d10b8a1f9d323, var_47951a26435d742f );
    thread function_37e9d11846abae5( var_5f14402a2e931ff1, var_581de4f4991f612e );
    return true;
}

// Namespace ztron_dialog
// Params 1
// Checksum 0xe9c402ca, Offset: 0x905
// Size: 0x93, Type: bool
function function_9ca700a54013c5a8( var_5f14402a2e931ff1 )
{
    profilestart();
    
    if ( ispapaback() )
    {
        base = "papaback";
        emote = #"angry";
    }
    else if ( isplayer( self ) )
    {
        base = "player";
        emote = #"happy";
        base += self getentitynumber();
    }
    
    if ( isdefined( base ) )
    {
        if ( isdefined( var_5f14402a2e931ff1.alias ) )
        {
            emote = var_5f14402a2e931ff1.alias;
        }
        
        function_96a3d84c152cc60e( base, emote );
        profilestop();
        return true;
    }
    
    profilestop();
    return false;
}

// Namespace ztron_dialog
// Params 2
// Checksum 0xcd683982, Offset: 0x9a2
// Size: 0xd0
function function_96a3d84c152cc60e( base, emote )
{
    profilestart();
    alias = level.ztron.dialog_aliases[ base ][ emote ];
    
    if ( isdefined( alias ) )
    {
        foreach ( player in level.players )
        {
            if ( player.ztron.enabletextbubble )
            {
                self playsoundtoplayer( alias, player );
            }
        }
    }
    
    profilestop();
}

// Namespace ztron_dialog
// Params 1, eflags: 0x4
// Checksum 0x7dcfee36, Offset: 0xa7a
// Size: 0xbe, Type: bool
function private function_208eccbc5eb93ada( sparams )
{
    assert( sparams, "<dev string:xce>" );
    var_24f7b0881d1278af = sparams.var_24f7b0881d1278af;
    var_9f8d10b8a1f9d323 = sparams.var_9f8d10b8a1f9d323 ?? 0;
    var_b8e0344ea474d895 = sparams.var_b8e0344ea474d895 ?? 0;
    var_581de4f4991f612e = sparams.var_581de4f4991f612e;
    var_47951a26435d742f = sparams.var_47951a26435d742f;
    
    if ( !function_ce393f2584273bce( var_24f7b0881d1278af, var_9f8d10b8a1f9d323, var_b8e0344ea474d895 ) )
    {
        return false;
    }
    
    var_5f14402a2e931ff1 = function_51c8a1c4bba55ed2( var_24f7b0881d1278af, var_9f8d10b8a1f9d323, var_47951a26435d742f );
    thread function_37e9d11846abae5( var_5f14402a2e931ff1, var_581de4f4991f612e );
    return true;
}

// Namespace ztron_dialog
// Params 3, eflags: 0x4
// Checksum 0x576eeab2, Offset: 0xb41
// Size: 0x8f
function private function_ce393f2584273bce( var_24f7b0881d1278af, var_9f8d10b8a1f9d323, var_b8e0344ea474d895 )
{
    assert( isxhash( var_24f7b0881d1278af ), "<dev string:x10a>" );
    
    if ( isplayer( self ) )
    {
        if ( self.sessionstate != "playing" )
        {
            return 0;
        }
        
        if ( var_b8e0344ea474d895 && !isalive( self ) )
        {
            return;
        }
    }
    
    if ( !function_3c4a32f62549ea23( var_24f7b0881d1278af, var_9f8d10b8a1f9d323 ) )
    {
        assertmsg( "<dev string:x14a>" + getxhashsourcename( var_24f7b0881d1278af ) + "<dev string:x18b>" );
        return 0;
    }
    
    initdialogdata();
    return 1;
}

// Namespace ztron_dialog
// Params 0, eflags: 0x4
// Checksum 0x7b43a486, Offset: 0xbd9
// Size: 0x31
function private initdialogdata()
{
    if ( self.var_2dc2b57535e42267 )
    {
        return;
    }
    
    self.var_2dc2b57535e42267 = spawnstruct();
    self.var_2dc2b57535e42267.var_9375b591ac6dc396 = 0;
}

// Namespace ztron_dialog
// Params 0, eflags: 0x4
// Checksum 0x4f7471d6, Offset: 0xc12
// Size: 0x25
function private function_69dd3b512da6233f()
{
    if ( !self.var_2dc2b57535e42267 )
    {
        return;
    }
    
    self.var_2dc2b57535e42267.var_9375b591ac6dc396 = 0;
}

// Namespace ztron_dialog
// Params 1, eflags: 0x4
// Checksum 0x3ff726c4, Offset: 0xc3f
// Size: 0x53, Type: bool
function private function_188736db3c58c06b( bimmediately )
{
    if ( bimmediately )
    {
        return false;
    }
    
    var_9375b591ac6dc396 = self.var_2dc2b57535e42267.var_9375b591ac6dc396 ?? 0;
    isplaying = gettime() <= var_9375b591ac6dc396;
    return isplaying || function_ec146f61efd74f5b();
}

// Namespace ztron_dialog
// Params 2, eflags: 0xc
// Checksum 0x3bf1ecb9, Offset: 0xc9b
// Size: 0x104
function private function_37e9d11846abae5( var_5f14402a2e931ff1, var_581de4f4991f612e )
{
    self notify( #"hash_c0e1ab5cee128c1b" );
    self endon( #"hash_c0e1ab5cee128c1b" );
    level endon( #"ztron_game_is_over", #"hash_5763d316a84acc41" );
    self endon( #"death_or_disconnect" );
    waittimes = var_5f14402a2e931ff1.textduration;
    
    if ( !isdefined( waittimes ) )
    {
        waittimes = 4;
    }
    
    durationms = waittimes * 1000;
    entnum = self getentitynumber();
    omnvar = undefined;
    
    while ( true )
    {
        omnvar = level namespace_b1af77fe7f803de7::allocchannel( entnum );
        self.var_2dc2b57535e42267.var_9375b591ac6dc396 = gettime() + durationms;
        
        if ( omnvar )
        {
            break;
        }
        
        waitframe();
    }
    
    if ( !function_9ca700a54013c5a8( var_5f14402a2e931ff1 ) )
    {
        thread function_b3c840cf3998d4c( var_5f14402a2e931ff1.alias );
    }
    
    level thread function_7a3a5fa44ae1d185( omnvar, entnum, var_5f14402a2e931ff1, var_581de4f4991f612e );
    function_b0928ce57663583f( var_5f14402a2e931ff1 );
}

// Namespace ztron_dialog
// Params 4, eflags: 0x4
// Checksum 0x8712efeb, Offset: 0xda7
// Size: 0x68
function private function_7a3a5fa44ae1d185( omnvar, entnum, var_5f14402a2e931ff1, var_581de4f4991f612e )
{
    level endon( #"ztron_game_is_over", #"hash_7dd4681806f8bc0a" );
    omnvarvalue = function_8a410eb6172e5584( entnum, var_5f14402a2e931ff1, var_581de4f4991f612e, omnvar );
    setomnvar( omnvar, omnvarvalue );
    waitframe();
    level namespace_b1af77fe7f803de7::freechannel( omnvar, entnum );
}

// Namespace ztron_dialog
// Params 4, eflags: 0x4
// Checksum 0x236aee80, Offset: 0xe17
// Size: 0x1ae
function private function_8a410eb6172e5584( entitynum, var_5f14402a2e931ff1, var_581de4f4991f612e, omnvar )
{
    omnvarvalue = 0;
    omnvarvalue += entitynum << 0;
    omnvarvalue += var_5f14402a2e931ff1.var_c0430db0e766e6d5 << 16;
    
    if ( var_581de4f4991f612e && var_581de4f4991f612e.size > 0 )
    {
        if ( var_5f14402a2e931ff1.var_c2108016fbbd237f.size > 0 )
        {
            shift = 25;
            
            foreach ( paramindex, sparam in var_5f14402a2e931ff1.var_c2108016fbbd237f )
            {
                if ( paramindex >= var_581de4f4991f612e.size )
                {
                    break;
                }
                
                bits = sparam.bits ?? 0;
                mask = ( 1 << bits ) - 1;
                value = var_581de4f4991f612e[ paramindex ];
                assert( value <= mask, "<dev string:x18d>" + getxhashsourcename( var_5f14402a2e931ff1.entryref.ref ) + "<dev string:x1c3>" + paramindex + "<dev string:x1d1>" + value + "<dev string:x1da>" + mask + "<dev string:x1e2>" + bits );
                value &= mask;
                omnvarvalue += value << shift;
                shift += bits;
            }
        }
    }
    
    pulsebit = namespace_b1af77fe7f803de7::function_7a0f0d0ef897e6e8( omnvar );
    omnvarvalue += pulsebit << 31;
    return omnvarvalue;
}

// Namespace ztron_dialog
// Params 1, eflags: 0x4
// Checksum 0x2d989aa2, Offset: 0xfce
// Size: 0xe6
function private function_b3c840cf3998d4c( soundalias )
{
    if ( !isdefined( soundalias ) )
    {
        return;
    }
    
    self.vo_audience = [];
    
    foreach ( player in level.players )
    {
        if ( player.ztron.enabletextbubble )
        {
            if ( !isdefined( self.vo_audience ) )
            {
                self.vo_audience = [];
            }
            
            self.vo_audience[ self.vo_audience.size ] = player;
        }
    }
    
    dialogue::say( soundalias );
    self.vo_audience = undefined;
}

// Namespace ztron_dialog
// Params 1, eflags: 0x4
// Checksum 0x5c503f59, Offset: 0x10bc
// Size: 0x6d
function private function_bf8d1d20b24fe451( sparams )
{
    var_deb8bcb863ab37e9 = function_e6d9cc46f83202b0();
    
    if ( var_deb8bcb863ab37e9 linked_list::getsize() >= 512 )
    {
        var_24f7b0881d1278af = sparams.var_24f7b0881d1278af;
        assertmsg( "<dev string:x1ea>" + getxhashsourcename( var_24f7b0881d1278af ) + "<dev string:x216>" );
        return;
    }
    
    function_9e0cce3f764d0699( sparams );
    thread function_b37bd73bc88b3401();
}

// Namespace ztron_dialog
// Params 0, eflags: 0xc
// Checksum 0x7db26ca4, Offset: 0x1131
// Size: 0xba
function private function_b37bd73bc88b3401()
{
    self notify( #"hash_57c574a7881d477a" );
    self endon( #"hash_57c574a7881d477a" );
    level endon( #"ztron_game_is_over", #"hash_5763d316a84acc41" );
    self endon( #"death_or_disconnect", #"hash_3bfe8194e575fe4b" );
    
    while ( true )
    {
        waitframe();
        
        if ( gettime() <= self.var_2dc2b57535e42267.var_9375b591ac6dc396 )
        {
            continue;
        }
        
        if ( !function_ec146f61efd74f5b() )
        {
            return;
        }
        
        sparams = function_9fa9f126f8f660c4();
        
        if ( !isdefined( sparams ) )
        {
            assertmsg( "<dev string:x228>" + ( self.name ?? "<dev string:x289>" ) );
            continue;
        }
        
        function_208eccbc5eb93ada( sparams );
    }
}

// Namespace ztron_dialog
// Params 1, eflags: 0x4
// Checksum 0xcd690479, Offset: 0x11f3
// Size: 0x161
function private function_b0928ce57663583f( var_5f14402a2e931ff1 )
{
    level.ztron.var_2f80297343a70a56[ self getentitynumber() ] = 1;
    
    /#
        if ( getdvarint( @"hash_5624655ac83baf4e", 0 ) == 1 )
        {
            if ( !isdefined( level.ztron.var_1510ee92983742e3 ) )
            {
                level.ztron.var_1510ee92983742e3 = [];
            }
            
            if ( !isdefined( level.ztron.var_6d1901e6ada3e712 ) )
            {
                level.ztron.var_6d1901e6ada3e712 = 0;
            }
            
            if ( level.ztron.var_1510ee92983742e3.size >= 4095 )
            {
                function_d83c9c101bdeb1a0( "<dev string:x293>" );
                level.ztron.var_1510ee92983742e3 = [];
            }
            
            level.ztron.var_1510ee92983742e3[ level.ztron.var_1510ee92983742e3.size ] = "<dev string:x29d>" + level.ztron.var_6d1901e6ada3e712 + "<dev string:x29f>" + ( self.name ?? self.model ) + "<dev string:x2a7>" + self getentitynumber() + "<dev string:x2b1>" + var_5f14402a2e931ff1.var_c0430db0e766e6d5;
            level.ztron.var_6d1901e6ada3e712++;
        }
    #/
}

// Namespace ztron_dialog
// Params 0, eflags: 0x4
// Checksum 0xc8c66200, Offset: 0x135c
// Size: 0x109
function private function_afe4d4047083053a()
{
    foreach ( entnumber, unused in level.ztron.var_2f80297343a70a56 )
    {
        ent = getentbynum( entnumber );
        
        if ( !ent )
        {
            continue;
        }
        
        ent function_69dd3b512da6233f();
        ent function_527dcbd33d507d22();
    }
    
    level.ztron.var_2f80297343a70a56 = [];
    
    /#
        if ( getdvarint( @"hash_5624655ac83baf4e", 0 ) == 1 )
        {
            function_d83c9c101bdeb1a0( "<dev string:x2c0>" );
            level.ztron.var_1510ee92983742e3 = [];
            level.ztron.var_6d1901e6ada3e712 = 0;
        }
    #/
}

/#

    // Namespace ztron_dialog
    // Params 1, eflags: 0x4
    // Checksum 0x83200a8, Offset: 0x146d
    // Size: 0xad, Type: dev
    function private function_d83c9c101bdeb1a0( reason )
    {
        iprintln( "<dev string:x2c9>" + reason + "<dev string:x2da>" );
        
        foreach ( info in level.ztron.var_1510ee92983742e3 )
        {
            iprintln( info );
        }
        
        iprintln( "<dev string:x2dc>" );
    }

#/

// Namespace ztron_dialog
// Params 0, eflags: 0x4
// Checksum 0xfcbb4f6f, Offset: 0x1522
// Size: 0x73
function private function_e6d9cc46f83202b0()
{
    assert( isent( self ), "<dev string:x2ef>" );
    
    if ( !isdefined( self.var_2dc2b57535e42267 ) )
    {
        assertmsg( "<dev string:x320>" );
        return;
    }
    
    if ( !isdefined( self.var_2dc2b57535e42267.var_deb8bcb863ab37e9 ) )
    {
        self.var_2dc2b57535e42267.var_deb8bcb863ab37e9 = linked_list::createstruct_linkedlist();
    }
    
    return self.var_2dc2b57535e42267.var_deb8bcb863ab37e9;
}

// Namespace ztron_dialog
// Params 1, eflags: 0x4
// Checksum 0xb47cef6b, Offset: 0x159e
// Size: 0x7c
function private function_9e0cce3f764d0699( queuedata )
{
    assert( isent( self ), "<dev string:x353>" );
    
    if ( !isdefined( self.var_2dc2b57535e42267 ) )
    {
        assertmsg( "<dev string:x381>" );
        return;
    }
    
    if ( !isdefined( self.var_2dc2b57535e42267.var_deb8bcb863ab37e9 ) )
    {
        assertmsg( "<dev string:x3b1>" );
        return;
    }
    
    self.var_2dc2b57535e42267.var_deb8bcb863ab37e9 linked_list::addnode( queuedata );
}

// Namespace ztron_dialog
// Params 0, eflags: 0x4
// Checksum 0xcb1b8049, Offset: 0x1622
// Size: 0x97
function private function_9fa9f126f8f660c4()
{
    assert( isent( self ), "<dev string:x3e1>" );
    
    if ( !isdefined( self.var_2dc2b57535e42267 ) )
    {
        assertmsg( "<dev string:x40e>" );
        return;
    }
    
    if ( !isdefined( self.var_2dc2b57535e42267.var_deb8bcb863ab37e9 ) )
    {
        assertmsg( "<dev string:x43d>" );
        return;
    }
    
    head = self.var_2dc2b57535e42267.var_deb8bcb863ab37e9 linked_list::getstartnode();
    self.var_2dc2b57535e42267.var_deb8bcb863ab37e9 linked_list::removestartnode();
    return head;
}

// Namespace ztron_dialog
// Params 0, eflags: 0x4
// Checksum 0x661ff451, Offset: 0x16c2
// Size: 0x66, Type: bool
function private function_ec146f61efd74f5b()
{
    assert( isent( self ), "<dev string:x46c>" );
    
    if ( !isdefined( self.var_2dc2b57535e42267 ) )
    {
        assertmsg( "<dev string:x49a>" );
        return false;
    }
    
    if ( !isdefined( self.var_2dc2b57535e42267.var_deb8bcb863ab37e9 ) )
    {
        return false;
    }
    
    return self.var_2dc2b57535e42267.var_deb8bcb863ab37e9 linked_list::getsize() > 0;
}

// Namespace ztron_dialog
// Params 0, eflags: 0x4
// Checksum 0x6a117eed, Offset: 0x1731
// Size: 0x61
function private function_527dcbd33d507d22()
{
    assert( isent( self ), "<dev string:x4ca>" );
    
    if ( !isdefined( self.var_2dc2b57535e42267 ) )
    {
        return;
    }
    
    if ( !self.var_2dc2b57535e42267.var_deb8bcb863ab37e9 )
    {
        return;
    }
    
    self.var_2dc2b57535e42267.var_deb8bcb863ab37e9 linked_list::clearlinkedlist();
    self notify( #"hash_3bfe8194e575fe4b" );
}

// Namespace ztron_dialog
// Params 0, eflags: 0x4
// Checksum 0x760aec5, Offset: 0x179a
// Size: 0x293
function private initdialogentries()
{
    level.ztron.uibundles.var_578a1f7578baa222 = [];
    level.ztron.uibundles.var_29e23ba720709fca = [];
    var_f9454fb0f8bd0670 = getscriptbundle( %"hash_4f37322f291b8500" );
    assert( var_f9454fb0f8bd0670, "<dev string:x4f9>" );
    var_8f64ecd8b9cb29a4 = var_f9454fb0f8bd0670.dialogentries;
    var_bdf3ad88269c9116 = var_8f64ecd8b9cb29a4.size;
    assert( var_bdf3ad88269c9116 <= 511, "<dev string:x527>" );
    
    for ( i = 0; i < var_bdf3ad88269c9116 ; i++ )
    {
        var_211795a90064bd57 = var_8f64ecd8b9cb29a4[ i ];
        assert( !isdefined( level.ztron.uibundles.var_578a1f7578baa222[ var_211795a90064bd57.entryref.ref ] ), "<dev string:x540>" + getxhashsourcename( var_211795a90064bd57.entryref.ref ) + "<dev string:x561>" + getxhashsourcename( %"hash_4f37322f291b8500" ) );
        level.ztron.uibundles.var_578a1f7578baa222[ var_211795a90064bd57.entryref.ref ] = var_211795a90064bd57;
        
        /#
            function_fb184fcf50f46052( i, var_211795a90064bd57 );
        #/
        
        var_211795a90064bd57.var_c0430db0e766e6d5 = i + 1;
    }
    
    var_dadc3e6a53d645ae = var_f9454fb0f8bd0670.var_3b8371df0d3ee7bd;
    var_d4381dcac0330720 = var_dadc3e6a53d645ae.size;
    
    for ( i = 0; i < var_d4381dcac0330720 ; i++ )
    {
        structgroup = var_dadc3e6a53d645ae[ i ];
        assert( !isdefined( level.ztron.uibundles.var_29e23ba720709fca[ structgroup.var_e10ccaf63b1cd856 ] ), "<dev string:x540>" + getxhashsourcename( structgroup.var_e10ccaf63b1cd856 ) + "<dev string:x561>" + getxhashsourcename( %"hash_4f37322f291b8500" ) );
        level.ztron.uibundles.var_29e23ba720709fca[ structgroup.var_e10ccaf63b1cd856 ] = structgroup;
    }
    
    /#
        function_a815bad1eb87c09d( var_dadc3e6a53d645ae, level.ztron.uibundles.var_578a1f7578baa222 );
    #/
    
    utility::flag_set( "ztron_dialog_ready" );
    assert( -1, "<dev string:x572>" );
}

/#

    // Namespace ztron_dialog
    // Params 2, eflags: 0x4
    // Checksum 0x8b7fdb8b, Offset: 0x1a35
    // Size: 0x1d1, Type: dev
    function private function_fb184fcf50f46052( entryindex, var_a989f69b0da3379d )
    {
        if ( !isdefined( var_a989f69b0da3379d.var_c2108016fbbd237f ) || var_a989f69b0da3379d.var_c2108016fbbd237f.size <= 0 )
        {
            return;
        }
        
        var_ee18ef677c2bc908 = 0;
        
        foreach ( index, sparam in var_a989f69b0da3379d.var_c2108016fbbd237f )
        {
            assert( isdefined( sparam.paramtype ), "<dev string:x595>" + entryindex + "<dev string:x18b>" + getxhashsourcename( var_a989f69b0da3379d.entryref.ref ) );
            assert( isdefined( sparam.bits ), "<dev string:x5de>" + entryindex + "<dev string:x18b>" + getxhashsourcename( var_a989f69b0da3379d.entryref.ref ) );
            assert( sparam.bits > 0, "<dev string:x627>" + entryindex + "<dev string:x18b>" + getxhashsourcename( var_a989f69b0da3379d.entryref.ref ) );
            var_ee18ef677c2bc908 += sparam.bits ?? 0;
            assert( var_ee18ef677c2bc908 <= 6, "<dev string:x66f>" + entryindex + "<dev string:x18b>" + getxhashsourcename( var_a989f69b0da3379d.entryref.ref ) + "<dev string:x6c7>" + index + "<dev string:x6d6>" + var_ee18ef677c2bc908 + "<dev string:x6e8>" + 6 );
        }
    }

    // Namespace ztron_dialog
    // Params 2, eflags: 0x4
    // Checksum 0x2b2f91a2, Offset: 0x1c0e
    // Size: 0x120, Type: dev
    function private function_a815bad1eb87c09d( groupsarray, var_1e972b3b005f4f0e )
    {
        for ( groupindex = 0; groupindex < groupsarray.size ; groupindex++ )
        {
            groupref = groupsarray[ groupindex ].var_e10ccaf63b1cd856;
            var_8f64ecd8b9cb29a4 = groupsarray[ groupindex ].var_c8b5177ece248ceb;
            
            if ( !isdefined( var_8f64ecd8b9cb29a4 ) )
            {
                continue;
            }
            
            foreach ( sentry in var_8f64ecd8b9cb29a4 )
            {
                assert( isdefined( var_1e972b3b005f4f0e[ sentry.ref ] ), "<dev string:x6ef>" + getxhashsourcename( sentry.ref ) + "<dev string:x713>" + getxhashsourcename( groupref ) + "<dev string:x720>" + getxhashsourcename( %"hash_4f37322f291b8500" ) );
            }
        }
    }

#/

// Namespace ztron_dialog
// Params 3, eflags: 0x4
// Checksum 0x744df63d, Offset: 0x1d36
// Size: 0x313
function private function_51c8a1c4bba55ed2( var_82a6135e65e724da, var_9f8d10b8a1f9d323, var_47951a26435d742f )
{
    assert( isxhash( var_82a6135e65e724da ), "<dev string:x74a>" );
    
    if ( !isdefined( level.ztron.uibundles.var_578a1f7578baa222 ) )
    {
        assertmsg( "<dev string:x785>" );
        return;
    }
    
    if ( !var_9f8d10b8a1f9d323 )
    {
        entry = level.ztron.uibundles.var_578a1f7578baa222[ var_82a6135e65e724da ];
        
        if ( !isdefined( entry ) )
        {
            assertmsg( "<dev string:x7b9>" + getxhashsourcename( var_82a6135e65e724da ) + "<dev string:x18b>" );
            return;
        }
        
        return entry;
    }
    
    if ( !isdefined( level.ztron.uibundles.var_29e23ba720709fca ) )
    {
        assertmsg( "<dev string:x7f5>" );
        return;
    }
    
    var_4f8e48f73fba98ce = level.ztron.uibundles.var_29e23ba720709fca[ var_82a6135e65e724da ];
    
    if ( !isdefined( var_4f8e48f73fba98ce ) )
    {
        assertmsg( "<dev string:x828>" + getxhashsourcename( var_82a6135e65e724da ) + "<dev string:x18b>" );
        return;
    }
    
    if ( !isdefined( var_4f8e48f73fba98ce.var_c8b5177ece248ceb ) || var_4f8e48f73fba98ce.var_c8b5177ece248ceb.size <= 0 )
    {
        return;
    }
    
    var_4f8e48f73fba98ce.runtimesequence = var_47951a26435d742f ? [] : var_4f8e48f73fba98ce.runtimesequence;
    
    if ( !isdefined( var_4f8e48f73fba98ce.runtimesequence ) )
    {
        var_4f8e48f73fba98ce.runtimesequence = [];
    }
    
    if ( var_4f8e48f73fba98ce.runtimesequence.size <= 0 )
    {
        entriessize = var_4f8e48f73fba98ce.var_c8b5177ece248ceb.size;
        
        for ( var_46813b089673099f = entriessize; var_46813b089673099f >= 0 ; var_46813b089673099f-- )
        {
            var_4f8e48f73fba98ce.runtimesequence[ var_4f8e48f73fba98ce.runtimesequence.size ] = var_4f8e48f73fba98ce.var_c8b5177ece248ceb[ var_46813b089673099f ].ref;
        }
        
        if ( !var_4f8e48f73fba98ce.sequential )
        {
            var_4f8e48f73fba98ce.runtimesequence = arrayrandomize( var_4f8e48f73fba98ce.runtimesequence );
        }
    }
    
    entryref = var_4f8e48f73fba98ce.runtimesequence[ var_4f8e48f73fba98ce.runtimesequence.size - 1 ];
    var_4f8e48f73fba98ce.runtimesequence[ var_4f8e48f73fba98ce.runtimesequence.size - 1 ] = undefined;
    
    if ( !isdefined( entryref ) )
    {
        assertmsg( "<dev string:x85d>" + getxhashsourcename( entryref.ref ) + "<dev string:x87d>" + getxhashsourcename( var_82a6135e65e724da ) + "<dev string:x561>" + getxhashsourcename( %"hash_4f37322f291b8500" ) );
        return;
    }
    
    if ( !isdefined( level.ztron.uibundles.var_578a1f7578baa222[ entryref ] ) )
    {
        assertmsg( "<dev string:x88a>" + getxhashsourcename( entryref ) + "<dev string:x18b>" );
        return;
    }
    
    return level.ztron.uibundles.var_578a1f7578baa222[ entryref ];
}

// Namespace ztron_dialog
// Params 2, eflags: 0x4
// Checksum 0x5fee043e, Offset: 0x2052
// Size: 0x14f, Type: bool
function private function_3c4a32f62549ea23( var_b721dad0e8a7243e, var_9f8d10b8a1f9d323 )
{
    if ( !isxhash( var_b721dad0e8a7243e ) )
    {
        assertmsg( "<dev string:x8be>" );
        return false;
    }
    
    if ( !var_9f8d10b8a1f9d323 )
    {
        if ( !isdefined( level.ztron.uibundles.var_578a1f7578baa222 ) )
        {
            assertmsg( "<dev string:x8fd>" );
            return false;
        }
        
        if ( !isdefined( level.ztron.uibundles.var_578a1f7578baa222[ var_b721dad0e8a7243e ] ) )
        {
            assertmsg( "<dev string:x935>" + getxhashsourcename( var_b721dad0e8a7243e ) + "<dev string:x18b>" );
            return false;
        }
        
        return true;
    }
    
    if ( !isdefined( level.ztron.uibundles.var_29e23ba720709fca ) )
    {
        assertmsg( "<dev string:x975>" );
        return false;
    }
    
    var_4f8e48f73fba98ce = level.ztron.uibundles.var_29e23ba720709fca[ var_b721dad0e8a7243e ];
    
    if ( !isdefined( var_4f8e48f73fba98ce ) )
    {
        assertmsg( "<dev string:x9ac>" + getxhashsourcename( var_b721dad0e8a7243e ) + "<dev string:x18b>" );
        return false;
    }
    
    if ( !isdefined( var_4f8e48f73fba98ce.var_c8b5177ece248ceb ) || var_4f8e48f73fba98ce.var_c8b5177ece248ceb.size <= 0 )
    {
        return false;
    }
    
    return true;
}

/#

    // Namespace ztron_dialog
    // Params 1, eflags: 0xc
    // Checksum 0xa07d2e27, Offset: 0x21aa
    // Size: 0xd6, Type: dev
    function private function_d45ef94f56b43275( textdurations )
    {
        self notify( #"hash_ce34411df254df08" );
        self endon( #"hash_ce34411df254df08" );
        
        if ( !( getdvarint( @"hash_5624655ac83baf4e", 0 ) == 1 ) )
        {
            return;
        }
        
        level endon( #"ztron_game_is_over" );
        endtimems = gettime() + textdurations * 1000;
        
        while ( gettime() <= endtimems )
        {
            if ( !self || !isent( self ) )
            {
                return;
            }
            
            print3d( self.origin + ( 0, 0, 50 ), "<dev string:x9e5>" + int( ( endtimems - gettime() ) / 1000 ) );
            print3d( self.origin + ( 0, 0, 20 ), "<dev string:x9e6>" + self getentitynumber() );
            waitframe();
        }
    }

#namespace namespace_b1af77fe7f803de7;

#/

// Namespace namespace_b1af77fe7f803de7
// Params 0
// Checksum 0x8e4c8009, Offset: 0x2288
// Size: 0xc2
function function_833f4a6ea426b5fb()
{
    level.ztron.var_f89269b18eddaa2d = [];
    level.ztron.var_bc1312e5d472dcb1 = [];
    maxchannels = getdvarint( @"hash_65d3f6af268a42cf", 4 );
    
    for ( i = 0; i < maxchannels ; i++ )
    {
        omnvar = "ui_ztron_dialog_channel_" + i;
        level.ztron.var_f89269b18eddaa2d[ omnvar ] = 1;
        level.ztron.var_bc1312e5d472dcb1[ omnvar ] = 0;
    }
    
    /#
        level.ztron.var_eef8df312c1aec2d = [];
        level thread function_fbdcbee1eef90769();
    #/
}

// Namespace namespace_b1af77fe7f803de7
// Params 1
// Checksum 0x9b3207e5, Offset: 0x2352
// Size: 0xc1
function allocchannel( debuginfo )
{
    foreach ( omnvar, isfree in level.ztron.var_f89269b18eddaa2d )
    {
        if ( isfree )
        {
            level.ztron.var_f89269b18eddaa2d[ omnvar ] = 0;
            
            /#
                level.ztron.var_eef8df312c1aec2d[ omnvar ] = debuginfo;
            #/
            
            return omnvar;
        }
    }
}

// Namespace namespace_b1af77fe7f803de7
// Params 2
// Checksum 0x8c05043b, Offset: 0x241b
// Size: 0x14c
function freechannel( omnvar, debuginfo )
{
    /#
        assert( level.ztron.var_eef8df312c1aec2d[ omnvar ] == debuginfo, "<dev string:x9ee>" + omnvar + "<dev string:xa2f>" + debuginfo + "<dev string:xa43>" + level.ztron.var_eef8df312c1aec2d[ omnvar ] );
        
        foreach ( _omnvar, isfree in level.ztron.var_f89269b18eddaa2d )
        {
            if ( _omnvar == omnvar && isfree )
            {
                var_566591abe15ab4fa = level.ztron.var_eef8df312c1aec2d[ omnvar ];
                assertmsg( "<dev string:xa55>" + omnvar + "<dev string:xa80>" + debuginfo + "<dev string:xa8f>" + var_566591abe15ab4fa );
                break;
            }
        }
    #/
    
    level.ztron.var_f89269b18eddaa2d[ omnvar ] = 1;
}

// Namespace namespace_b1af77fe7f803de7
// Params 2
// Checksum 0xa9cfdb03, Offset: 0x256f
// Size: 0xd7
function function_9d21db100d2cacd( bits, debuginfo )
{
    foreach ( channelomnvar, isfree in level.ztron.var_f89269b18eddaa2d )
    {
        setomnvar( channelomnvar, bits );
        level.ztron.var_f89269b18eddaa2d[ channelomnvar ] = 1;
        
        /#
            level.ztron.var_eef8df312c1aec2d[ channelomnvar ] = debuginfo;
        #/
    }
    
    level notify( #"hash_7dd4681806f8bc0a" );
}

// Namespace namespace_b1af77fe7f803de7
// Params 1
// Checksum 0x9d74bb18, Offset: 0x264e
// Size: 0x82
function function_7a0f0d0ef897e6e8( omnvar )
{
    level.ztron.var_bc1312e5d472dcb1[ omnvar ] += 1;
    level.ztron.var_bc1312e5d472dcb1[ omnvar ] &= 1;
    return level.ztron.var_bc1312e5d472dcb1[ omnvar ];
}

/#

    // Namespace namespace_b1af77fe7f803de7
    // Params 0, eflags: 0xc
    // Checksum 0x2e6adb28, Offset: 0x26d9
    // Size: 0x109, Type: dev
    function private function_fbdcbee1eef90769()
    {
        self notify( #"hash_8f866f1878e12963" );
        self endon( #"hash_8f866f1878e12963" );
        
        if ( !( getdvarint( @"hash_5624655ac83baf4e", 0 ) == 1 ) )
        {
            return;
        }
        
        lineheight = 20;
        color = ( 1, 1, 1 );
        duration = 0.1;
        scale = 2;
        
        while ( true )
        {
            if ( !level.ztron )
            {
                waitframe();
                continue;
            }
            
            liney = 200;
            
            if ( level.ztron.var_f89269b18eddaa2d )
            {
                poolinfo = "<dev string:xaa6>" + level.ztron.var_f89269b18eddaa2d.size + "<dev string:xab5>" + getdvarint( @"hash_65d3f6af268a42cf", 4 ) + "<dev string:x18b>";
                ztron_debug::function_7a494955e7b24aa3( 0, liney, poolinfo, color, duration, scale );
                liney += lineheight;
            }
            
            wait 0.1;
        }
    }

#/
