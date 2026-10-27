// script_7aa10af485333391  (hash_7aa10af485333391.gscc) (size: 1545 Bytes / 0x609 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x1fcdc932 (533580082)
// size ...... 1545 (0x609)
// includes .. 1   (offset: 0x5dd)
// strings ... 3   (offset: 0x5e5)
// dev strs .. 0   (offset: 0x609)
// exports ... 9   (offset: 0x31d)
// cseg ...... 0x95 + 0x288 (0x31d)
// imports ... 12  (offset: 0x485)
// animtree1 . 0   (offset: 0x609)
// animtree2 . 0   (offset: 0x609)
#using scripts\common\callbacks;

#namespace specialty_alertness;

// Namespace specialty_alertness
// Params 0, eflags: 0x1
// Checksum 0x1f894220, Offset: 0xb3
// Size: 0x18
function autoexec preinit()
{
    level callback::add( #"register_perk", &registerperk );
}

// Namespace specialty_alertness
// Params 1
// Checksum 0x6ef024bb, Offset: 0xd3
// Size: 0x3a
function registerperk( params )
{
    if ( isdefined( params.var_bf34439fc0ca3cec ) )
    {
        level [[ params.var_bf34439fc0ca3cec ]]( "specialty_alertness", &setalertness, &unsetalertness, [] );
    }
}

// Namespace specialty_alertness
// Params 0
// Checksum 0x9b474e67, Offset: 0x115
// Size: 0x5e
function setalertness()
{
    self.var_813e4174cae72151 = self.var_9842326056fd7207.var_813e4174cae72151 ?? "alertness";
    self.var_e5b7242ae94cb06e = self.var_9842326056fd7207.var_e5b7242ae94cb06e ?? 1;
    
    if ( function_779f1002427d5440() )
    {
        thread watchfortriggerchange();
    }
    
    thread alertnesssfx();
}

// Namespace specialty_alertness
// Params 0
// Checksum 0x4437941d, Offset: 0x17b
// Size: 0xa7
function watchfortriggerchange()
{
    self notify( #"hash_56670dff2c55482e" );
    self endon( #"hash_56670dff2c55482e" );
    self endon( #"disconnect" );
    self endon( #"unset_alertness" );
    level endon( #"game_ended" );
    rumbleon = 0;
    var_20dc6de3780d4b13 = function_51fc7bb4ac70e7e();
    
    while ( true )
    {
        if ( !function_779f1002427d5440() )
        {
            break;
        }
        
        shouldrumble = self.var_a092fe8c52d848ba || self.var_84860fb3139916f9;
        
        if ( shouldrumble )
        {
            self playrumbleonentity( self.var_813e4174cae72151 );
        }
        
        wait var_20dc6de3780d4b13;
    }
}

// Namespace specialty_alertness
// Params 0
// Checksum 0x4d442468, Offset: 0x22a
// Size: 0x3a
function unsetalertness()
{
    self notify( #"unset_alertness" );
    
    if ( function_779f1002427d5440() )
    {
        self stoprumble( self.var_813e4174cae72151 );
    }
    
    self.var_813e4174cae72151 = undefined;
    self.var_e5b7242ae94cb06e = undefined;
}

// Namespace specialty_alertness
// Params 0
// Checksum 0xc39bf37e, Offset: 0x26c
// Size: 0xb
function function_51fc7bb4ac70e7e()
{
    return self.var_e5b7242ae94cb06e;
}

// Namespace specialty_alertness
// Params 0
// Checksum 0x5933c4a4, Offset: 0x280
// Size: 0x21, Type: bool
function function_779f1002427d5440()
{
    return self.var_813e4174cae72151 && getdvarint( @"hash_a61cdd8ae638c4da", 1 ) != 1;
}

// Namespace specialty_alertness
// Params 0, eflags: 0x4
// Checksum 0x874cef51, Offset: 0x2aa
// Size: 0x73
function private alertnesssfx()
{
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    self endon( #"unset_alertness" );
    sfxplayed = 0;
    
    while ( true )
    {
        var_233b4cd3a6ac8d90 = istrue( self.var_84860fb3139916f9 );
        
        if ( var_233b4cd3a6ac8d90 )
        {
            if ( !sfxplayed )
            {
                self playlocalsound( "perk_wz2_alertness_on" );
                sfxplayed = 1;
                wait 5;
            }
        }
        else
        {
            sfxplayed = 0;
        }
        
        waitframe();
    }
}

