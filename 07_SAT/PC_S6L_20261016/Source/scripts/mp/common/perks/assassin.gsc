// scripts\mp\common\perks\assassin.gsc  (hash_67a10655a8a01b15.gscc) (size: 5450 Bytes / 0x154a / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x28373b45 (674708293)
// size ...... 5450 (0x154a)
// includes .. 2   (offset: 0x14f6)
// strings ... 5   (offset: 0x1506)
// dev strs .. 0   (offset: 0x154a)
// exports ... 18  (offset: 0xe12)
// cseg ...... 0xb6 + 0xd5c (0xe12)
// imports ... 34  (offset: 0x10e2)
// animtree1 . 0   (offset: 0x154a)
// animtree2 . 0   (offset: 0x154a)
#using scripts\common\callbacks;
#using scripts\mp\objidpoolmanager;

#namespace assassin;

// Namespace assassin
// Params 0, eflags: 0x1
// Checksum 0x8df1ad18, Offset: 0xd4
// Size: 0x18
function autoexec preinit()
{
    level callback::add( #"register_perk", &function_f31ce4140ed08fc2 );
}

// Namespace assassin
// Params 1
// Checksum 0x31d6290c, Offset: 0xf4
// Size: 0x6b
function function_f31ce4140ed08fc2( params )
{
    bundle = level.perkbundles[ "specialty_assassin" ];
    
    if ( !isdefined( bundle ) )
    {
        return;
    }
    
    if ( isdefined( params.var_bf34439fc0ca3cec ) )
    {
        level [[ params.var_bf34439fc0ca3cec ]]( "specialty_assassin", &setassassin, &unsetassassin, [ "specialty_vendetta" ], &initassassin );
    }
}

// Namespace assassin
// Params 0
// Checksum 0x9e361c5a, Offset: 0x167
// Size: 0x9f
function initassassin()
{
    bundle = level.perkbundles[ "specialty_assassin" ];
    level.var_6f47ece75eebb413 = spawnstruct();
    level_info = level.var_6f47ece75eebb413;
    assert( isstruct( level_info ) );
    level_info.assassins = [];
    level_info.assassintargets = [];
    level_info.bundle = bundle;
    level_info.var_7cf5f5c633c1bf5a = { #objids:[] };
    callback::add( #"player_death", &assassinonkill );
}

// Namespace assassin
// Params 0
// Checksum 0x39257dc1, Offset: 0x20e
// Size: 0x5d
function setassassin()
{
    level_info = level.var_6f47ece75eebb413;
    
    if ( !isdefined( level_info ) )
    {
        return;
    }
    
    var_b64cad84f5b9226d = level_info.assassins.size == 0;
    level_info.assassins[ self getentitynumber() ] = self;
    
    if ( var_b64cad84f5b9226d )
    {
        function_87941df9d391c5bf();
    }
    
    function_28654279ff13d2d7();
}

// Namespace assassin
// Params 0
// Checksum 0x7ba84af7, Offset: 0x273
// Size: 0x37
function unsetassassin()
{
    level_info = level.var_6f47ece75eebb413;
    
    if ( !isdefined( level_info ) )
    {
        return;
    }
    
    level_info.assassins[ self getentitynumber() ] = undefined;
    function_abb054b2a5bbd34f();
}

// Namespace assassin
// Params 1
// Checksum 0x3464f005, Offset: 0x2b2
// Size: 0x17d
function assassinonkill( deathdata )
{
    level_info = level.var_6f47ece75eebb413;
    
    if ( level_info.assassins.size == 0 )
    {
        return;
    }
    
    attacker = deathdata.attacker;
    
    if ( !isplayer( attacker ) )
    {
        return;
    }
    
    victim = deathdata.victim;
    
    if ( !isplayer( victim ) )
    {
        return;
    }
    
    if ( attacker == victim )
    {
        return;
    }
    
    if ( attacker.killcountthislife >= level_info.bundle.var_941c09a372f0c22e )
    {
        function_704d402fd2e0b1d1( attacker );
    }
    
    var_4ce87cc797f1469d = victim getentitynumber();
    
    if ( isdefined( level_info.assassintargets[ var_4ce87cc797f1469d ] ) )
    {
        if ( isdefined( level_info.assassins[ attacker getentitynumber() ] ) )
        {
            bundle = level_info.bundle;
            model = attacker function_280dbc267d75edb4( bundle, victim.killcountthislife );
            
            if ( isdefined( model ) )
            {
                victim dropassassinbag( attacker, model );
            }
            
            if ( isxhash( bundle.assassin_target_killed_bonus_score ) )
            {
                var_dbd43a8b925f566f = level.sharedfuncs[ #"player" ][ #"doScoreEvent" ];
                
                if ( isdefined( var_dbd43a8b925f566f ) )
                {
                    attacker thread [[ var_dbd43a8b925f566f ]]( bundle.assassin_target_killed_bonus_score );
                }
            }
        }
        
        function_5c2bcbf1d014e0c6( var_4ce87cc797f1469d );
    }
}

// Namespace assassin
// Params 0
// Checksum 0xe08bb57b, Offset: 0x437
// Size: 0x131
function function_28654279ff13d2d7()
{
    level_info = level.var_6f47ece75eebb413;
    
    if ( level_info.assassintargets.size == 0 )
    {
        return;
    }
    
    var_5956efc838d66a3a = level.sharedfuncs[ #"objective" ][ #"showtoplayer" ];
    
    if ( isdefined( var_5956efc838d66a3a ) )
    {
        assassinteam = self.team;
        
        foreach ( assassintarget in level_info.assassintargets )
        {
            if ( !isplayer( assassintarget ) )
            {
                continue;
            }
            
            if ( assassinteam == assassintarget.team )
            {
                continue;
            }
            
            iconobjid = level_info.var_7cf5f5c633c1bf5a.objids[ assassintarget getentitynumber() ];
            
            if ( !isdefined( iconobjid ) )
            {
                continue;
            }
            
            [[ var_5956efc838d66a3a ]]( iconobjid, self );
        }
    }
}

// Namespace assassin
// Params 0
// Checksum 0xe399d0e8, Offset: 0x570
// Size: 0x10a
function function_abb054b2a5bbd34f()
{
    level_info = level.var_6f47ece75eebb413;
    
    if ( level_info.assassintargets.size == 0 )
    {
        return;
    }
    
    var_560f3d69cba3cac2 = level.sharedfuncs[ #"objective" ][ #"hidefromplayer" ];
    
    if ( isdefined( var_560f3d69cba3cac2 ) )
    {
        foreach ( assassintarget in level_info.assassintargets )
        {
            if ( !isplayer( assassintarget ) )
            {
                continue;
            }
            
            iconobjid = level_info.var_7cf5f5c633c1bf5a.objids[ assassintarget getentitynumber() ];
            
            if ( !isdefined( iconobjid ) )
            {
                continue;
            }
            
            [[ var_560f3d69cba3cac2 ]]( iconobjid, self );
        }
    }
}

// Namespace assassin
// Params 0
// Checksum 0x82c47e2a, Offset: 0x682
// Size: 0x99
function function_87941df9d391c5bf()
{
    level_info = level.var_6f47ece75eebb413;
    
    foreach ( target in level_info.assassintargets )
    {
        if ( isplayer( target ) )
        {
            function_704d402fd2e0b1d1( target );
        }
    }
}

// Namespace assassin
// Params 1
// Checksum 0x4066e3f2, Offset: 0x723
// Size: 0x202
function function_704d402fd2e0b1d1( target )
{
    level_info = level.var_6f47ece75eebb413;
    targetentnum = target getentitynumber();
    
    if ( !isdefined( level_info.assassintargets[ targetentnum ] ) )
    {
        level_info.assassintargets[ targetentnum ] = target;
    }
    
    if ( level_info.assassins.size == 0 )
    {
        return;
    }
    
    if ( isdefined( level_info.var_7cf5f5c633c1bf5a.objids[ targetentnum ] ) )
    {
        return;
    }
    
    var_d099a4b088c802e5 = level.sharedfuncs[ #"game" ][ #"createobjectivehidden" ];
    
    if ( isfunction( var_d099a4b088c802e5 ) )
    {
        iconobjid = target [[ var_d099a4b088c802e5 ]]( level_info.bundle.assassin_minimap_icon, 1, 1, "icon_regular" );
        level_info.var_7cf5f5c633c1bf5a.objids[ targetentnum ] = iconobjid;
        var_6c42a8f7d5d26fea = level.sharedfuncs[ #"objective" ][ #"setminimapalphafromentity" ];
        
        if ( isdefined( var_6c42a8f7d5d26fea ) )
        {
            [[ var_6c42a8f7d5d26fea ]]( iconobjid, 1 );
        }
    }
    
    if ( isdefined( iconobjid ) )
    {
        objidpoolmanager::function_e4d6a71507372662( iconobjid, 0 );
        targetteam = target.team;
        
        foreach ( assassin in level_info.assassins )
        {
            if ( !isplayer( assassin ) )
            {
                continue;
            }
            
            if ( targetteam == assassin.team )
            {
                continue;
            }
            
            objidpoolmanager::objective_playermask_addshowplayer( iconobjid, assassin );
            target.var_1425551d5d50527a[ assassin getentitynumber() ] = 1;
        }
    }
}

// Namespace assassin
// Params 1
// Checksum 0x59a35d86, Offset: 0x92d
// Size: 0xfd
function function_5c2bcbf1d014e0c6( targetentnum )
{
    level_info = level.var_6f47ece75eebb413;
    iconobjid = level_info.var_7cf5f5c633c1bf5a.objids[ targetentnum ];
    
    if ( isdefined( iconobjid ) )
    {
        var_84d98283324fa83e = level.sharedfuncs[ #"objective" ][ #"hidefromall" ];
        
        if ( isfunction( var_84d98283324fa83e ) )
        {
            [[ var_84d98283324fa83e ]]( iconobjid );
        }
        
        var_4bae1d302a2a086a = level.sharedfuncs[ #"game" ][ #"returnobjectiveid" ];
        
        if ( isfunction( var_4bae1d302a2a086a ) )
        {
            [[ var_4bae1d302a2a086a ]]( iconobjid );
        }
        
        level_info.var_7cf5f5c633c1bf5a.objids[ targetentnum ] = undefined;
    }
    
    level_info.assassintargets[ targetentnum ] = undefined;
    target = getentbynum( targetentnum );
    
    if ( target )
    {
        target.var_1425551d5d50527a = [];
    }
}

// Namespace assassin
// Params 2
// Checksum 0x9f19552, Offset: 0xa32
// Size: 0x6c
function dropassassinbag( attacker, model )
{
    bag = spawn( "script_model", self.origin );
    bag setmodel( model );
    bag.angles = ( 0, 0, 0 );
    bag.owner = self;
    bag thread function_24e6ba3bf0515c29( attacker, self );
}

// Namespace assassin
// Params 2
// Checksum 0xd9b5b968, Offset: 0xaa6
// Size: 0x16a
function function_24e6ba3bf0515c29( attacker, victim )
{
    self endon( #"death_or_disconnect" );
    self endon( #"bag_timeout" );
    level_info = level.var_6f47ece75eebb413;
    bundle = level_info.bundle;
    self.trigger = spawn( "trigger_radius", self.origin, 0, 36, 36 );
    self showonlytoplayer( attacker );
    thread assassinbag_timeout();
    var_ad74393df579cd03 = victim.killcountthislife;
    
    while ( true )
    {
        self.trigger waittill( #"trigger", player );
        
        if ( player == attacker )
        {
            self notify( #"assassinbag_pickedup" );
            var_dbd43a8b925f566f = level.sharedfuncs[ #"player" ][ #"doScoreEvent" ];
            
            if ( isdefined( var_dbd43a8b925f566f ) )
            {
                if ( isxhash( bundle.var_527138a550e65fc1 ) )
                {
                    attacker thread [[ var_dbd43a8b925f566f ]]( bundle.var_527138a550e65fc1 );
                }
                
                if ( isxhash( bundle.var_26b3a363aad41e29 ) )
                {
                    var_2b8e8a392ecc38ce = var_ad74393df579cd03 - bundle.var_941c09a372f0c22e;
                    
                    if ( var_2b8e8a392ecc38ce > 0 )
                    {
                        attacker thread function_e5676fdb09f91f17( var_2b8e8a392ecc38ce, bundle, var_dbd43a8b925f566f );
                    }
                }
            }
            
            assassinbag_delete();
        }
    }
}

// Namespace assassin
// Params 3, eflags: 0x4
// Checksum 0xf1d67e05, Offset: 0xc18
// Size: 0x66
function private function_e5676fdb09f91f17( var_2b8e8a392ecc38ce, bundle, var_dbd43a8b925f566f )
{
    if ( var_2b8e8a392ecc38ce <= 0 )
    {
        return;
    }
    
    self endon( #"disconnect" );
    waitframe();
    
    for ( i = 0; i < var_2b8e8a392ecc38ce ; i++ )
    {
        waitframe();
        
        if ( !isdefined( self ) )
        {
            return;
        }
        
        self thread [[ var_dbd43a8b925f566f ]]( bundle.var_26b3a363aad41e29 );
    }
}

// Namespace assassin
// Params 2, eflags: 0x4
// Checksum 0xaff3bf18, Offset: 0xc86
// Size: 0x104
function private function_280dbc267d75edb4( bundle, kills )
{
    if ( !isdefined( bundle.var_bae8957cbf51547a ) )
    {
        return;
    }
    
    pickedpack = undefined;
    
    foreach ( packinfo in bundle.var_bae8957cbf51547a )
    {
        if ( isdefined( packinfo.var_4ee8bb58e5eab5c9 ) )
        {
            if ( kills >= packinfo.kills )
            {
                if ( !isdefined( pickedpack ) || pickedpack.kills < packinfo.kills )
                {
                    pickedpack = packinfo;
                }
            }
        }
    }
    
    if ( isdefined( pickedpack.var_4ee8bb58e5eab5c9 ) )
    {
        return pickedpack.var_4ee8bb58e5eab5c9;
    }
}

// Namespace assassin
// Params 0
// Checksum 0x42a32634, Offset: 0xd93
// Size: 0x61
function assassinbag_timeout()
{
    self endon( #"death_or_disconnect" );
    self endon( #"assassinbag_pickedup" );
    bag_lifetime = level.var_6f47ece75eebb413.bundle.assassin_bag_lifetime;
    
    if ( !isdefined( bag_lifetime ) )
    {
        return;
    }
    
    wait bag_lifetime;
    self notify( #"bag_timeout" );
    assassinbag_delete();
}

// Namespace assassin
// Params 0
// Checksum 0x16b12149, Offset: 0xdfc
// Size: 0x16
function assassinbag_delete()
{
    self.trigger delete();
    self delete();
}

