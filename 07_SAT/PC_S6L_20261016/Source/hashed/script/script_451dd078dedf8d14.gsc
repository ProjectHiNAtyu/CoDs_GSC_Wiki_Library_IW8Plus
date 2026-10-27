// script_451dd078dedf8d14  (hash_451dd078dedf8d14.gscc) (size: 2613 Bytes / 0xa35 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x4a6389e0 (1248037344)
// size ...... 2613 (0xa35)
// includes .. 5   (offset: 0x9b5)
// strings ... 6   (offset: 0x9dd)
// dev strs .. 0   (offset: 0xa35)
// exports ... 10  (offset: 0x5c5)
// cseg ...... 0xec + 0x4d9 (0x5c5)
// imports ... 21  (offset: 0x755)
// animtree1 . 0   (offset: 0xa35)
// animtree2 . 0   (offset: 0xa35)
#using scripts\common\callbacks;
#using scripts\common\utility;
#using scripts\mp\common\perks\perks;
#using scripts\mp\damage;
#using scripts\mp\playerhealth;

#namespace specialty_reduce_regen_delay_on_objective;

// Namespace specialty_reduce_regen_delay_on_objective
// Params 0, eflags: 0x1
// Checksum 0x6b0cef4b, Offset: 0x10a
// Size: 0x41
function autoexec preinit()
{
    callback::add( #"register_perk", &function_ce1e2f9ce2d79701 );
    callback::add( #"hash_3c955b1e6fcd76eb", &function_66e3da5d24a1fcd5 );
    callback::add( #"hash_45277be78cb54c51", &function_20ab0332234bd341 );
}

// Namespace specialty_reduce_regen_delay_on_objective
// Params 1
// Checksum 0xf0c30e64, Offset: 0x153
// Size: 0x46
function function_ce1e2f9ce2d79701( params )
{
    if ( isdefined( params.var_bf34439fc0ca3cec ) )
    {
        level [[ params.var_bf34439fc0ca3cec ]]( "specialty_reduce_regen_delay_on_objective", &setreduceregendelayonobjective, &unsetreduceregendelayonobjective, [] );
    }
    
    damage::function_e91c31c1d200656d( &modifyhittype );
}

// Namespace specialty_reduce_regen_delay_on_objective
// Params 0
// Checksum 0x2ec9881b, Offset: 0x1a1
// Size: 0xb1
function setreduceregendelayonobjective()
{
    perks::function_70e4256c5fb41ada( "specialty_reduce_regen_delay_on_objective" );
    self.var_8bef479521df7de = self.var_9842326056fd7207.var_8bef479521df7de ?? getdvarfloat( @"hash_396fbb6db81e3ff6", 1 );
    self.var_73164b66e87bec80 = self.var_9842326056fd7207.var_73164b66e87bec80 ?? 0.5;
    self.var_8238f0b84bcdf85 = self.var_9842326056fd7207.var_8238f0b84bcdf85;
    self.var_947440e6e2ce47a0 = self.var_9842326056fd7207.var_947440e6e2ce47a0 ?? 1;
    updatereduceregendelayonobjective();
    thread monitorreduceregendelayonobjective();
}

// Namespace specialty_reduce_regen_delay_on_objective
// Params 0
// Checksum 0xb38677a7, Offset: 0x25a
// Size: 0x24
function unsetreduceregendelayonobjective()
{
    self notify( #"hash_7565d38c6b22f448" );
    updatereduceregendelayonobjective( 1 );
    perks::function_ef056eae4d523635( "specialty_combat_medic", 0 );
}

// Namespace specialty_reduce_regen_delay_on_objective
// Params 0
// Checksum 0x38729724, Offset: 0x286
// Size: 0x3f
function monitorreduceregendelayonobjective()
{
    level endon( #"game_ended" );
    self endon( #"death_or_disconnect" );
    self endon( #"hash_7565d38c6b22f448" );
    
    while ( true )
    {
        wait self.var_73164b66e87bec80;
        updatereduceregendelayonobjective();
    }
}

// Namespace specialty_reduce_regen_delay_on_objective
// Params 1
// Checksum 0x1ed10074, Offset: 0x2cd
// Size: 0x24a
function updatereduceregendelayonobjective( forceoff )
{
    carryinggameobject = isdefined( self.carryobject );
    touchinggameobject = self.touchinggameobjects.size > 0;
    usinggameobject = self.usinggameobjects.size > 0 || self.usinggameobject;
    var_fb8cc8065a72ee7f = level.flagcarrier == self;
    reduceregendelay = carryinggameobject || touchinggameobject || usinggameobject || var_fb8cc8065a72ee7f;
    atfullhealth = self.health / self.maxhealth >= 1;
    
    if ( reduceregendelay && !atfullhealth && !forceoff )
    {
        if ( !self.var_d75a4a100db13ec5 )
        {
            if ( self.var_5244874f5ae962e0 )
            {
                var_f58b83e445f53d6f = utility::function_2a082dafe6f4bd5b();
                usingnvgs = self isnightvisionon();
                var_c6a607bf90f35dc8 = var_f58b83e445f53d6f && usingnvgs;
                fx = var_c6a607bf90f35dc8 ? utility::getfx( "super_sprint_refresh_night" ) : utility::getfx( "super_sprint_refresh" );
                playfxontagforclients( fx, self, "tag_eye", self );
            }
            
            self.var_d75a4a100db13ec5 = 1;
            self notify( #"hash_ef7f109740445b24" );
            self notify( #"hash_c4700f9ace6b3e19" );
            playerhealth::function_fd91e6d94cab77e7( #"specialty_reduce_regen_delay_on_objective", self.var_8bef479521df7de );
            self.var_e6a8138052022574 = self.var_947440e6e2ce47a0;
            
            if ( isdefined( self.var_773b81cf576594e5[ "specialty_reduce_regen_delay_on_objective" ] ) )
            {
                if ( level.gamemodebundle.var_7aa3d55e72a5c0d1 == #"right" )
                {
                    perks::function_ef056eae4d523635( self.var_773b81cf576594e5[ "specialty_reduce_regen_delay_on_objective" ], 1 );
                }
                else if ( level.gamemodebundle.var_7aa3d55e72a5c0d1 == #"center" )
                {
                    perks::activateperk( self.var_773b81cf576594e5[ "specialty_reduce_regen_delay_on_objective" ] );
                }
            }
        }
        
        return;
    }
    
    if ( self.var_d75a4a100db13ec5 )
    {
        self.var_d75a4a100db13ec5 = 0;
        playerhealth::function_b1fb4d148779580e( #"specialty_reduce_regen_delay_on_objective" );
        self.var_e6a8138052022574 = 1;
    }
}

// Namespace specialty_reduce_regen_delay_on_objective
// Params 1
// Checksum 0x8f8c8794, Offset: 0x51f
// Size: 0x24
function function_66e3da5d24a1fcd5( params )
{
    params.player.usinggameobject = 1;
}

// Namespace specialty_reduce_regen_delay_on_objective
// Params 1
// Checksum 0xe976fb16, Offset: 0x54b
// Size: 0x23
function function_20ab0332234bd341( params )
{
    params.player.usinggameobject = 0;
}

// Namespace specialty_reduce_regen_delay_on_objective
// Params 2
// Checksum 0x576eb976, Offset: 0x576
// Size: 0x4f
function modifyhittype( hittype, params )
{
    if ( hittype != "standard" )
    {
        return;
    }
    
    if ( params.victim.var_d75a4a100db13ec5 )
    {
        return params.victim.var_8238f0b84bcdf85;
    }
}

