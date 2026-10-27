// scripts\vehicle\pluto\zm_firefly_pluto_pap.gsc  (hash_41bf656103df6290.gscc) (size: 2370 Bytes / 0x942 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x268dcf6 (40426742)
// size ...... 2370 (0x942)
// includes .. 4   (offset: 0x852)
// strings ... 13  (offset: 0x872)
// dev strs .. 0   (offset: 0x942)
// exports ... 9   (offset: 0x4ba)
// cseg ...... 0xf8 + 0x3c2 (0x4ba)
// imports ... 19  (offset: 0x622)
// animtree1 . 0   (offset: 0x942)
// animtree2 . 0   (offset: 0x942)
#using scripts\common\utility;
#using scripts\common\vehicle;
#using scripts\mp\interaction;
#using scripts\mp\pack_a_punch;

#namespace pluto_veh;

// Namespace pluto_veh
// Params 6
// Checksum 0x55ca86cb, Offset: 0x116
// Size: 0x52
function pluto_pap_use( instance, part, state, player, bautouse, usestring )
{
    if ( instance )
    {
        instance.entity pack_a_punch::on_use_pap_machine( player );
    }
}

// Namespace pluto_veh
// Params 1, eflags: 0x4
// Checksum 0xbbe38db6, Offset: 0x170
// Size: 0x59
function private function_6965a67190e085ef( var_9f9d02833d988898 )
{
    isvehicle = vehicle::is_vehicle();
    
    if ( !isvehicle )
    {
        return;
    }
    
    b_success = utility::function_7c10ea82c1e305b8( "pap_fxanim", "pap_activate_" + var_9f9d02833d988898 );
    
    if ( !b_success )
    {
        utility::function_7c10ea82c1e305b8( "pap_fxanim", "pap_activate" );
    }
}

// Namespace pluto_veh
// Params 0
// Checksum 0x50a3d6a0, Offset: 0x1d1
// Size: 0x3e
function function_fe3cf3e8a93a2d13()
{
    vehicle = self;
    vehicle utility::function_7c10ea82c1e305b8( "pap_fxanim", "pap_idle" );
    vehicle utility::function_7c10ea82c1e305b8( "pap_usable", "pap_on" );
    vehicle thread function_dfe58334a81769d2();
}

// Namespace pluto_veh
// Params 0
// Checksum 0xd97a23a4, Offset: 0x217
// Size: 0x48
function function_1c1ac2d157fe5c4e()
{
    vehicle = self;
    vehicle utility::function_7c10ea82c1e305b8( "pap_fxanim", "pap_static" );
    vehicle utility::function_7c10ea82c1e305b8( "pap_usable", "pap_off" );
    vehicle utility::function_32b24db3127bff40( "boost_fx", "off" );
}

// Namespace pluto_veh
// Params 0
// Checksum 0xe7e07a15, Offset: 0x267
// Size: 0x96
function function_d05d285928ed6ea()
{
    vehicle = self;
    vehicle.var_370acb837a3a86c3 = vehicle;
    scriptable = vehicle getlinkedscriptableinstance();
    scriptable interaction::set_interact_hint_callback( &pack_a_punch::pap_per_player_hint );
    function_1c1ac2d157fe5c4e();
    vehicle.s_pap = vehicle;
    vehicle.s_pap_menu = pack_a_punch::function_870d519a9b809a9c( vehicle.origin );
    vehicle thread pack_a_punch::function_d9ce48cca2ff225b();
    vehicle utility::callsharedfunc( #"zombie", #"hash_896b88a46f6a4c15", "pap" );
}

// Namespace pluto_veh
// Params 11
// Checksum 0xb810fb22, Offset: 0x305
// Size: 0xe2
function function_e6841f5e49f1eb39( einflictor, eattacker, instance, idamage, idflags, smeansofdeath, objweapon, vdir, vpoint, modelindex, partname )
{
    if ( instance.type != %"veh_sat_firefly_pluto_pap_part_invisible" )
    {
        return;
    }
    
    if ( isplayer( eattacker ) )
    {
        if ( smeansofdeath == "MOD_MELEE" && !eattacker.var_2bbc37a986db6306 )
        {
            if ( !eattacker.b_disable_pap_camo )
            {
                eattacker.b_disable_pap_camo = 1;
            }
            else
            {
                eattacker.b_disable_pap_camo = 0;
            }
            
            eattacker thread pack_a_punch::pap_melee_cooldown();
            instance thread function_f778f84265349129();
        }
    }
}

// Namespace pluto_veh
// Params 0, eflags: 0x4
// Checksum 0xb0da3a7c, Offset: 0x3ef
// Size: 0x48
function private function_f778f84265349129()
{
    self endon( #"death" );
    self.linkedparent utility::function_7c10ea82c1e305b8( "pap_fxanim", "pap_idle" );
    wait 0.5;
    self.linkedparent utility::function_7c10ea82c1e305b8( "pap_fxanim", "pap_activate" );
}

// Namespace pluto_veh
// Params 0, eflags: 0xc
// Checksum 0xfa1fb803, Offset: 0x43f
// Size: 0x7b
function private function_dfe58334a81769d2()
{
    self notify( #"hash_8fe3e4e8811dec46" );
    self endon( #"hash_8fe3e4e8811dec46" );
    level endon( #"game_ended" );
    self endon( #"death" );
    
    while ( true )
    {
        if ( self isboosting() )
        {
            utility::function_32b24db3127bff40( "pap_fxanim", "pap_boost" );
        }
        else if ( self getscriptablepartstate( "pap_fxanim" ) == "pap_boost" )
        {
            utility::function_32b24db3127bff40( "pap_fxanim", "pap_idle" );
        }
        
        waitframe();
    }
}

