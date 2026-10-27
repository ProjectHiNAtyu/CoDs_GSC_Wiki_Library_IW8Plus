// script_f1ba085fef9f2b6  (hash_0f1ba085fef9f2b6.gscc) (size: 2356 Bytes / 0x934 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x670ed1b9 (1729024441)
// size ...... 2356 (0x934)
// includes .. 4   (offset: 0x860)
// strings ... 12  (offset: 0x880)
// dev strs .. 0   (offset: 0x934)
// exports ... 7   (offset: 0x528)
// cseg ...... 0x1d6 + 0x352 (0x528)
// imports ... 18  (offset: 0x640)
// animtree1 . 0   (offset: 0x934)
// animtree2 . 0   (offset: 0x934)
#using script_16ea1b94f0f381b3;
#using scripts\common\callbacks;
#using scripts\common\utility;
#using scripts\mp\common\utility\perk;

#namespace specialty_berserker_kill_buff;

// Namespace specialty_berserker_kill_buff
// Params 0, eflags: 0x5
// Checksum 0xbfc91ae4, Offset: 0x1f4
// Size: 0x47
function private autoexec preinit()
{
    level callback::add( #"register_perk", &function_d6dab95bb79eb659 );
    level callback::add( #"player_death", &onplayerdeath );
    level._effect[ "perk_berserker_rage" ] = loadfxasset( "vfx_saw_gameplay_perk_berserker_camera_overlay" );
}

// Namespace specialty_berserker_kill_buff
// Params 1, eflags: 0x4
// Checksum 0xd440384a, Offset: 0x243
// Size: 0x32
function private function_d6dab95bb79eb659( params )
{
    if ( isdefined( params.var_bf34439fc0ca3cec ) )
    {
        level [[ params.var_bf34439fc0ca3cec ]]( "specialty_berserker_kill_buff", undefined, undefined, [] );
    }
}

// Namespace specialty_berserker_kill_buff
// Params 1, eflags: 0x4
// Checksum 0xadfb27b5, Offset: 0x27d
// Size: 0x71
function private onplayerdeath( params )
{
    attacker = params.attacker;
    victim = params.victim;
    
    if ( !isplayer( attacker ) || !isdefined( victim ) || attacker == victim )
    {
        return;
    }
    
    if ( isdefined( attacker.perks[ "specialty_berserker_kill_buff" ] ) )
    {
        attacker thread function_3ba25057c5e7514c();
    }
}

// Namespace specialty_berserker_kill_buff
// Params 0, eflags: 0x4
// Checksum 0x48dd4432, Offset: 0x2f6
// Size: 0x118
function private function_3ba25057c5e7514c()
{
    attacker = self;
    bundle = self.var_9842326056fd7207;
    attacker endon( #"disconnect" );
    level endon( #"game_ended" );
    
    if ( !attacker.var_6c302df3253ce2c8 )
    {
        attacker.var_6c302df3253ce2c8 = 1;
        attacker perk::giveperk( "specialty_faster_reload_speed" );
        attacker perk::giveperk( "specialty_faster_tactical_lethal_deploy" );
        attacker perk::giveperk( "specialty_faster_weapon_swap" );
        attacker perk::giveperk( "specialty_faster_plating" );
        
        if ( getdvarint( @"hash_407b8351e6d3282a", 0 ) )
        {
            attacker function_9c7f75a1abc7b65e();
        }
        
        wait bundle.var_e589bb763ef042ae ?? 7;
        
        if ( getdvarint( @"hash_407b8351e6d3282a", 0 ) )
        {
            attacker function_559472a1ebb00e6();
        }
        
        attacker perk::removeperk( "specialty_faster_reload_speed" );
        attacker perk::removeperk( "specialty_faster_tactical_lethal_deploy" );
        attacker perk::removeperk( "specialty_faster_weapon_swap" );
        attacker perk::removeperk( "specialty_faster_plating" );
        attacker.var_6c302df3253ce2c8 = undefined;
    }
}

// Namespace specialty_berserker_kill_buff
// Params 0, eflags: 0x4
// Checksum 0xb2d7ede1, Offset: 0x416
// Size: 0x8e
function private function_9c7f75a1abc7b65e()
{
    attacker = self;
    attacker [[ level.sharedfuncs[ #"fullscreenfx" ][ #"hash_382df7654f0561bd" ] ]]( { #postfxbundlename:%"saw_perk_berserker" }, 1, 1 );
    playfxontagforclients( utility::getfx( "perk_berserker_rage" ), attacker, "tag_eye", attacker );
    attacker playsoundtoplayer( "chr_saw_perk_berserker_activate", attacker );
    attacker setsoundsubmix( "chr_saw_perk_berserker_active", 0.5 );
    attacker namespace_9d8e359c3b1041e5::activateperksharedfunc( "specialty_bomb_squad" );
}

// Namespace specialty_berserker_kill_buff
// Params 0, eflags: 0x4
// Checksum 0xe7702a02, Offset: 0x4ac
// Size: 0x7c
function private function_559472a1ebb00e6()
{
    attacker = self;
    attacker [[ level.sharedfuncs[ #"fullscreenfx" ][ #"hash_494b07757cd511a5" ] ]]( { #postfxbundlename:%"saw_perk_berserker" } );
    stopfxontagforclients( utility::getfx( "perk_berserker_rage" ), attacker, "tag_eye", attacker );
    attacker playsoundtoplayer( "chr_saw_perk_berserker_deactivate", attacker );
    attacker clearsoundsubmix( "chr_saw_perk_berserker_active", 2 );
}

