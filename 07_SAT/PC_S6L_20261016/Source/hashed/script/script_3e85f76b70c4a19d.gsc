// script_3e85f76b70c4a19d  (hash_3e85f76b70c4a19d.gscc) (size: 2039 Bytes / 0x7f7 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xed5c3ed6 (3982245590)
// size ...... 2039 (0x7f7)
// includes .. 1   (offset: 0x7bf)
// strings ... 3   (offset: 0x7c7)
// dev strs .. 1   (offset: 0x7eb)
// exports ... 8   (offset: 0x407)
// cseg ...... 0x90 + 0x377 (0x407)
// imports ... 22  (offset: 0x547)
// animtree1 . 0   (offset: 0x7f7)
// animtree2 . 0   (offset: 0x7f7)
#using scripts\common\callbacks;

#namespace specialty_stowed_ammo_regen;

// Namespace specialty_stowed_ammo_regen
// Params 0, eflags: 0x1
// Checksum 0x5759d556, Offset: 0xae
// Size: 0x18
function autoexec preinit()
{
    level callback::add( #"register_perk", &register_specialty );
}

// Namespace specialty_stowed_ammo_regen
// Params 1
// Checksum 0x91105c6d, Offset: 0xce
// Size: 0x38
function register_specialty( params )
{
    if ( params.var_bf34439fc0ca3cec )
    {
        level [[ params.var_bf34439fc0ca3cec ]]( "specialty_stowed_ammo_regen", &set_stowed_ammo_regen, &function_eed5af4c97dfd5ed );
    }
}

// Namespace specialty_stowed_ammo_regen
// Params 1
// Checksum 0x42a6eb66, Offset: 0x10e
// Size: 0x3b, Type: bool
function set_stowed_ammo_regen( params )
{
    exotic_weapon = self getcurrentweapon();
    reload_time = calculate_reload_time( exotic_weapon );
    thread function_3585ab4039daf8e6( exotic_weapon, reload_time );
    return true;
}

// Namespace specialty_stowed_ammo_regen
// Params 0
// Checksum 0x9685d702, Offset: 0x152
// Size: 0x2
function function_eed5af4c97dfd5ed()
{
    
}

// Namespace specialty_stowed_ammo_regen
// Params 2
// Checksum 0x7340c013, Offset: 0x15c
// Size: 0x1a4
function function_3585ab4039daf8e6( exotic_weapon, reload_time )
{
    self endon( #"death_or_disconnect" );
    reload_time *= 1000;
    last_time_fired = gettime();
    
    while ( true )
    {
        time_remaining = gettime() - last_time_fired;
        
        if ( time_remaining > reload_time )
        {
            last_time_fired = gettime();
            weapons = self getweaponslist( "primary" );
            var_89a9c41aa7f09b84 = 0;
            
            foreach ( weapon in weapons )
            {
                current_weapon = self getcurrentweapon();
                
                if ( current_weapon.basename != weapon.basename && exotic_weapon == weapon )
                {
                    do_ammo_regen( weapon );
                    
                    if ( weapon.hasalternate )
                    {
                        alt_weapon = weapon getaltweapon();
                        
                        if ( isdefined( alt_weapon ) && alt_weapon != weapon )
                        {
                            var_c0a84c871f4165a7 = isdefined( weapon.underbarrel ) && getattachmentbasetype( weapon, weapon.underbarrel ) == "selectfire";
                            
                            if ( !var_c0a84c871f4165a7 )
                            {
                                do_ammo_regen( alt_weapon );
                            }
                        }
                    }
                }
                
                if ( weapon == exotic_weapon )
                {
                    var_89a9c41aa7f09b84 = 1;
                }
            }
            
            if ( !var_89a9c41aa7f09b84 )
            {
                return 0;
            }
        }
        
        wait 0.2;
    }
}

// Namespace specialty_stowed_ammo_regen
// Params 1
// Checksum 0x9ade22a2, Offset: 0x308
// Size: 0x9e
function do_ammo_regen( weapon )
{
    n_stock_max = weaponmaxammo( weapon );
    var_b11feea92c35d08e = weaponclipsize( weapon );
    
    if ( n_stock_max > 0 && var_b11feea92c35d08e > 0 )
    {
        var_83e55048826dcd05 = self getweaponammoclip( weapon );
        n_stock_current = self getweaponammostock( weapon );
        
        if ( var_83e55048826dcd05 < var_b11feea92c35d08e )
        {
            var_83e55048826dcd05++;
            self setweaponammoclip( weapon, var_83e55048826dcd05 );
        }
        
        if ( n_stock_current < n_stock_max )
        {
            n_stock_current++;
            self setweaponammostock( weapon, n_stock_current );
        }
        
        assert( !weapon.isdualwield, "<dev string:x24>" );
    }
}

// Namespace specialty_stowed_ammo_regen
// Params 1
// Checksum 0x74ddf970, Offset: 0x3ae
// Size: 0x58
function calculate_reload_time( exotic_weapon )
{
    base_reload_time = self.var_9842326056fd7207.var_504bab49d5bd51b1;
    current_reload_time = base_reload_time - weaponmaxammo( exotic_weapon ) / 100;
    reload_time = max( 0.8, current_reload_time );
    return reload_time;
}

