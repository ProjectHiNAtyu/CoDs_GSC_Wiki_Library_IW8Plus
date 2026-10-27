// script_83dd54a7e2c8711  (hash_083dd54a7e2c8711.gscc) (size: 2386 Bytes / 0x952 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x20386580 (540566912)
// size ...... 2386 (0x952)
// includes .. 3   (offset: 0x90a)
// strings ... 4   (offset: 0x922)
// dev strs .. 0   (offset: 0x952)
// exports ... 11  (offset: 0x4ae)
// cseg ...... 0x87 + 0x427 (0x4ae)
// imports ... 23  (offset: 0x666)
// animtree1 . 0   (offset: 0x952)
// animtree2 . 0   (offset: 0x952)
#using script_16ea1b94f0f381b3;
#using scripts\common\callbacks;
#using scripts\common\utility;

#namespace visionsets;

// Namespace visionsets
// Params 0, eflags: 0x1
// Checksum 0x4e4fc732, Offset: 0xa5
// Size: 0x2e
function autoexec preinit()
{
    level callback::add( #"register_fullscreenfx", &function_5afd63dbfb26da35 );
    
    if ( !isdefined( level.fullscreenfx ) )
    {
        level.fullscreenfx = {};
    }
}

// Namespace visionsets
// Params 1
// Checksum 0xd47c298d, Offset: 0xdb
// Size: 0x142
function function_5afd63dbfb26da35( params )
{
    fullscreenfxtechnique = level.gamemodebundle.fullscreenfxtechnique ?? #"visionset";
    
    if ( fullscreenfxtechnique != #"visionset" )
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
    level.var_e074450cda2222d1 = fullscreenfxtechnique;
}

// Namespace visionsets
// Params 1
// Checksum 0x5fb4e17c, Offset: 0x225
// Size: 0x58
function setpain( params )
{
    if ( isdefined( params.visionsetname ) )
    {
        if ( isdefined( params.transitiontime ) )
        {
            visionsetpain( params.visionsetname, params.transitiontime );
            return;
        }
        
        visionsetpain( params.visionsetname );
    }
}

// Namespace visionsets
// Params 1
// Checksum 0x9e5d73e3, Offset: 0x285
// Size: 0x2b
function setdeath( params )
{
    if ( isdefined( params.visionsetname ) )
    {
        visionsetdeath( params.visionsetname );
    }
}

// Namespace visionsets
// Params 1
// Checksum 0xf2888239, Offset: 0x2b8
// Size: 0x2b
function setdamagecolor( params )
{
    if ( isdefined( params.visionsetname ) )
    {
        function_6b12ecc764eb6d2e( params.visionsetname );
    }
}

// Namespace visionsets
// Params 1
// Checksum 0xe14455e8, Offset: 0x2eb
// Size: 0x2b
function setdamagedistortion( params )
{
    if ( isdefined( params.visionsetname ) )
    {
        function_d5fa91c604007c78( params.visionsetname );
    }
}

// Namespace visionsets
// Params 0
// Checksum 0xb9b16dba, Offset: 0x31e
// Size: 0xd3
function function_211a3eda70958666()
{
    if ( isdefined( level.var_9f4dbac8a741d0a4 ) )
    {
        deathvision = level.var_9f4dbac8a741d0a4;
    }
    else
    {
        deathvision = level.gamemodebundle.visionset_death ?? "death";
    }
    
    setpain( { #visionsetname:level.gamemodebundle.visionset_pain } );
    setdeath( { #visionsetname:deathvision } );
    setdamagecolor( { #visionsetname:level.gamemodebundle.var_5d3483afb22992d9 ?? "damage_severe" } );
    setdamagedistortion( { #visionsetname:level.gamemodebundle.var_4fb6ffe844bd36b9 ?? "damage_radial" } );
}

// Namespace visionsets
// Params 1
// Checksum 0xb13038d1, Offset: 0x3f9
// Size: 0x42
function senddamageevent( damageevent )
{
    damageevent.player function_2c28e7684376dcc6( damageevent.eventtype );
    damageevent.player function_190b2e3379f9a500( damageevent.eventtype );
}

// Namespace visionsets
// Params 1
// Checksum 0x477053b0, Offset: 0x443
// Size: 0x41
function function_66ecfca4f507c47d( params )
{
    if ( isdefined( params.visionsetname ) )
    {
        namespace_9d8e359c3b1041e5::killstreak_setmainvisionsharedfunc( params.visionsetname );
        self.currentvisionset = params.visionsetname;
    }
}

// Namespace visionsets
// Params 1
// Checksum 0x8e898c59, Offset: 0x48c
// Size: 0x22
function function_50b3e738efd3cd3e( params )
{
    namespace_9d8e359c3b1041e5::killstreak_setmainvisionsharedfunc( "" );
    self.currentvisionset = undefined;
}

