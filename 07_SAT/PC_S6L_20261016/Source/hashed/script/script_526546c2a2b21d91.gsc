// script_526546c2a2b21d91  (hash_526546c2a2b21d91.gscc) (size: 3432 Bytes / 0xd68 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xfa3f205d (4198441053)
// size ...... 3432 (0xd68)
// includes .. 2   (offset: 0xd38)
// strings ... 2   (offset: 0xd48)
// dev strs .. 0   (offset: 0xd68)
// exports ... 16  (offset: 0x738)
// cseg ...... 0x65 + 0x6d3 (0x738)
// imports ... 30  (offset: 0x9b8)
// animtree1 . 0   (offset: 0xd68)
// animtree2 . 0   (offset: 0xd68)
#using scripts\common\callbacks;
#using scripts\common\utility;

#namespace pbgpostfx;

// Namespace pbgpostfx
// Params 0, eflags: 0x1
// Checksum 0xcc62f59c, Offset: 0x83
// Size: 0x2e
function autoexec preinit()
{
    level callback::add( #"register_fullscreenfx", &function_5c26de82747d5f67 );
    
    if ( !isdefined( level.fullscreenfx ) )
    {
        level.fullscreenfx = {};
    }
}

// Namespace pbgpostfx
// Params 1
// Checksum 0xa22588cf, Offset: 0xb9
// Size: 0x17e
function function_5c26de82747d5f67( params )
{
    fullscreenfxtechnique = level.gamemodebundle.fullscreenfxtechnique ?? #"visionset";
    
    if ( fullscreenfxtechnique != #"pbgpostfxbundle" )
    {
        return;
    }
    
    utility::registersharedfunc( #"fullscreenfx", #"setpain", &setpain );
    utility::registersharedfunc( #"fullscreenfx", #"setdeath", &setdeath );
    utility::registersharedfunc( #"fullscreenfx", #"setdamagecolor", &setdamagecolor );
    utility::registersharedfunc( #"fullscreenfx", #"setdamagedistortion", &setdamagedistortion );
    utility::registersharedfunc( #"fullscreenfx", #"hash_967b2afe3d37405", &function_211a3eda70958666 );
    utility::registersharedfunc( #"fullscreenfx", #"senddamageevent", &senddamageevent );
    utility::registersharedfunc( #"fullscreenfx", #"hash_d6d2b1e7868b8f30", &function_66ecfca4f507c47d );
    utility::registersharedfunc( #"fullscreenfx", #"hash_fd9af8d6ec7cc6fb", &function_50b3e738efd3cd3e );
    utility::registersharedfunc( #"fullscreenfx", #"hash_382df7654f0561bd", &function_c97c4fe96f152b72 );
    utility::registersharedfunc( #"fullscreenfx", #"hash_494b07757cd511a5", &function_99148d585b97499c );
    level.var_e074450cda2222d1 = fullscreenfxtechnique;
}

// Namespace pbgpostfx
// Params 1
// Checksum 0xca506373, Offset: 0x23f
// Size: 0x2b
function setpain( params )
{
    if ( isdefined( params.postfxbundlename ) )
    {
        pbgpostfxbundlesetpain( params.postfxbundlename );
    }
}

// Namespace pbgpostfx
// Params 1
// Checksum 0xcb178b65, Offset: 0x272
// Size: 0x2b
function setdeath( params )
{
    if ( isdefined( params.postfxbundlename ) )
    {
        pbgpostfxbundlesetdeath( params.postfxbundlename );
    }
}

// Namespace pbgpostfx
// Params 1
// Checksum 0x611265f8, Offset: 0x2a5
// Size: 0x4a
function setdamagecolor( params )
{
    if ( isdefined( params.postfxbundlename ) )
    {
        pbgpostfxbundlesetdamagecolor( params.postfxbundlename );
        level.fullscreenfx.var_1d15dad00c480ae6 = params.postfxbundlename;
    }
}

// Namespace pbgpostfx
// Params 1
// Checksum 0x699d77f9, Offset: 0x2f7
// Size: 0x4a
function setdamagedistortion( params )
{
    if ( isdefined( params.postfxbundlename ) )
    {
        pbgpostfxbundlesetdamagedistortion( params.postfxbundlename );
        level.fullscreenfx.var_abfe459802da78a0 = params.postfxbundlename;
    }
}

// Namespace pbgpostfx
// Params 0
// Checksum 0x9623efc1, Offset: 0x349
// Size: 0x92
function function_211a3eda70958666()
{
    setpain( { #postfxbundlename:level.gamemodebundle.pbgpostfxbundle_pain } );
    setdeath( { #postfxbundlename:level.gamemodebundle.pbgpostfxbundle_death } );
    setdamagecolor( { #postfxbundlename:level.gamemodebundle.var_1d15dad00c480ae6 } );
    setdamagedistortion( { #postfxbundlename:level.gamemodebundle.var_abfe459802da78a0 } );
}

// Namespace pbgpostfx
// Params 1
// Checksum 0xd3cf57e4, Offset: 0x3e3
// Size: 0x80
function senddamageevent( damageevent )
{
    if ( isdefined( level.fullscreenfx.var_1d15dad00c480ae6 ) )
    {
        pbgpostfxbundlestart( damageevent.player, level.fullscreenfx.var_1d15dad00c480ae6 );
    }
    
    if ( isdefined( level.fullscreenfx.var_abfe459802da78a0 ) )
    {
        pbgpostfxbundlestart( damageevent.player, level.fullscreenfx.var_abfe459802da78a0 );
    }
}

// Namespace pbgpostfx
// Params 1
// Checksum 0x156aca7c, Offset: 0x46b
// Size: 0x56
function function_66ecfca4f507c47d( params )
{
    if ( isdefined( params.postfxbundlename ) )
    {
        pbgpostfxbundlestart( self, params.postfxbundlename, params.timelinescale, params.mix );
        self.var_566e878784e5fa64 = params.postfxbundlename;
    }
}

// Namespace pbgpostfx
// Params 1
// Checksum 0xc0c85ced, Offset: 0x4c9
// Size: 0x52
function function_50b3e738efd3cd3e( params )
{
    pbgpostfxbundlename = params.postfxbundlename ?? self.var_566e878784e5fa64;
    
    if ( isdefined( pbgpostfxbundlename ) )
    {
        pbgpostfxbundleend( self, pbgpostfxbundlename, params.timelinescale );
        self.var_566e878784e5fa64 = undefined;
    }
}

// Namespace pbgpostfx
// Params 3
// Checksum 0x1608d0b, Offset: 0x523
// Size: 0x52
function function_c97c4fe96f152b72( params, var_31697b9ee9d1716a, candelaystart )
{
    endstring = "_" + getxhashhexname( params.postfxbundlename ) + "_end";
    thread function_567fc5b3df22e11b( params, var_31697b9ee9d1716a, candelaystart, endstring );
}

// Namespace pbgpostfx
// Params 1
// Checksum 0x2b8d752d, Offset: 0x57d
// Size: 0x2c
function function_99148d585b97499c( params )
{
    self notify( "_" + getxhashhexname( params.postfxbundlename ) + "_end", params );
}

// Namespace pbgpostfx
// Params 4, eflags: 0x4
// Checksum 0x1747f197, Offset: 0x5b1
// Size: 0xc9
function private function_567fc5b3df22e11b( params, var_31697b9ee9d1716a, candelaystart, endstring )
{
    self endon( #"game_ended" );
    self endon( #"disconnect" );
    self endon( endstring );
    
    while ( true )
    {
        if ( var_31697b9ee9d1716a && utility::isusingremote() )
        {
            if ( candelaystart )
            {
                self waittill( #"stopped_using_remote" );
            }
            else
            {
                return;
            }
        }
        
        pbgpostfxbundlestart( self, params.postfxbundlename, params.timelinescale, params.mix );
        thread function_3a8bbf37d69ef7e8( endstring );
        thread function_15172970497aa733( params, endstring );
        self waittill( #"using_remote" );
        pbgpostfxbundlekill( self, params.postfxbundlename );
    }
}

// Namespace pbgpostfx
// Params 1, eflags: 0x4
// Checksum 0x1190b0a5, Offset: 0x682
// Size: 0x5e
function private function_3a8bbf37d69ef7e8( endstring )
{
    self endon( #"game_ended" );
    self endon( #"disconnect" );
    self endon( #"using_remote" );
    self waittill( endstring, params );
    pbgpostfxbundleend( self, params.postfxbundlename, params.timelinescale );
}

// Namespace pbgpostfx
// Params 2, eflags: 0x4
// Checksum 0xe16abccb, Offset: 0x6e8
// Size: 0x50
function private function_15172970497aa733( params, endstring )
{
    self endon( #"disconnect" );
    self endon( #"using_remote" );
    self endon( endstring );
    level waittill( #"winners_circle_start" );
    pbgpostfxbundlekill( self, params.postfxbundlename );
}

