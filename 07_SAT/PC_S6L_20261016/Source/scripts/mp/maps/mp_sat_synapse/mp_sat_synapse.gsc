// scripts\mp\maps\mp_sat_synapse\mp_sat_synapse.gsc  (hash_0f35ce17ba644aff.gscc) (size: 2585 Bytes / 0xa19 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x17ff6565 (402613605)
// size ...... 2585 (0xa19)
// includes .. 7   (offset: 0x92d)
// strings ... 15  (offset: 0x965)
// dev strs .. 0   (offset: 0xa19)
// exports ... 4   (offset: 0x679)
// cseg ...... 0x154 + 0x525 (0x679)
// imports ... 18  (offset: 0x719)
// animtree1 . 0   (offset: 0xa19)
// animtree2 . 0   (offset: 0xa19)
#using scripts\mp\animation_suite;
#using scripts\mp\common\utility\entity;
#using scripts\mp\compass;
#using scripts\mp\load;
#using scripts\mp\maps\mp_sat_synapse\gen\mp_sat_synapse_art;
#using scripts\mp\maps\mp_sat_synapse\mp_sat_synapse_fx;
#using scripts\mp\maps\mp_sat_synapse\mp_sat_synapse_lighting;

#namespace mp_sat_synapse;

// Namespace mp_sat_synapse
// Params 0
// Checksum 0xf3d64cfb, Offset: 0x172
// Size: 0x109
function main()
{
    mp_sat_synapse_art::main();
    mp_sat_synapse_fx::main();
    namespace_a361ff019ddf942d::main();
    load::main();
    level.kill_border_triggers = getentarray( "kill_border_trigger", #targetname );
    level.outofboundstriggers = getentarray( "OutOfBounds", #targetname );
    level.var_750dbf45607817fd = getentarray( "Drone_OutOfBounds", #targetname );
    level.var_f11fa8013d4e241c = getentarray( "VTOL_OutOfBounds", #targetname );
    compass::setupminimap( "compass_map_mp_sat_synapse" );
    game[ "attackers" ] = "allies";
    game[ "defenders" ] = "axis";
    game[ "allies_outfit" ] = "urban";
    game[ "axis_outfit" ] = "woodland";
    level.var_409cf34875e21eb5 = 0.2;
    level.var_75d8bf80bd40a615 = 175;
    level.var_6dd339a918cc7198 = 64;
    level.var_5ac924e35a6a476 = 4;
    level thread animation_suite::animationsuite();
    level thread door_start();
}

// Namespace mp_sat_synapse
// Params 0
// Checksum 0xe50292f0, Offset: 0x283
// Size: 0x90
function door_start()
{
    var_5774d181dd3d6933 = getentarray( "sliding_trigger", #targetname );
    
    foreach ( var_4138f4709bceabde in var_5774d181dd3d6933 )
    {
        var_4138f4709bceabde thread function_97d21f729110b1ab();
    }
}

// Namespace mp_sat_synapse
// Params 0
// Checksum 0x79f92c52, Offset: 0x31b
// Size: 0x35e
function function_97d21f729110b1ab()
{
    level endon( #"game_ended" );
    a_sliding_doors = getentarray( self.target, #targetname );
    var_ef220494db29bccd = abs( self.origin[ 0 ] - a_sliding_doors[ 0 ].origin[ 0 ] );
    var_ef220394db29ba9a = abs( self.origin[ 1 ] - a_sliding_doors[ 0 ].origin[ 1 ] );
    n_delay = 0.001;
    self.var_ae740a76f0c8ef99 = 0;
    vehiclecontents = physics_createcontents( [ "physicscontents_vehicle" ] );
    
    while ( true )
    {
        var_f4bea452949ccd87 = arraycombine( getplayersinradius( self.origin, level.var_75d8bf80bd40a615, level.var_6dd339a918cc7198 ), getaiarrayinradius( self.origin, level.var_75d8bf80bd40a615 ), entity::getentitiesinradius( self.origin, level.var_75d8bf80bd40a615, undefined, undefined, vehiclecontents ) );
        var_ae740a76f0c8ef99 = var_f4bea452949ccd87.size > 0;
        
        if ( var_ae740a76f0c8ef99 && !self.var_ae740a76f0c8ef99 )
        {
        }
        
        self.var_ae740a76f0c8ef99 = 1;
        
        foreach ( e_sliding_door in a_sliding_doors )
        {
            e_sliding_door.var_bfda56491906b9f4 = self.origin;
            var_b78a4d168d50058a = self.origin[ 0 ];
            var_b78a4e168d5007bd = self.origin[ 1 ];
            e_sliding_door connectpaths();
            
            if ( var_f4bea452949ccd87.size > 0 )
            {
                if ( e_sliding_door.origin[ 0 ] < self.origin[ 0 ] )
                {
                    var_b78a4d168d50058a = self.origin[ 0 ] - var_ef220494db29bccd * 2;
                }
                else
                {
                    var_b78a4d168d50058a = self.origin[ 0 ] + var_ef220494db29bccd * 2;
                }
                
                if ( e_sliding_door.origin[ 1 ] < self.origin[ 1 ] )
                {
                    var_b78a4e168d5007bd = self.origin[ 1 ] - var_ef220394db29ba9a * 2;
                }
                else
                {
                    var_b78a4e168d5007bd = self.origin[ 1 ] + var_ef220394db29ba9a * 2;
                }
                
                n_delay = level.var_5ac924e35a6a476;
            }
            else
            {
                if ( e_sliding_door.origin[ 0 ] < self.origin[ 0 ] )
                {
                    var_b78a4d168d50058a = self.origin[ 0 ] - var_ef220494db29bccd;
                }
                else
                {
                    var_b78a4d168d50058a = self.origin[ 0 ] + var_ef220494db29bccd;
                }
                
                if ( e_sliding_door.origin[ 1 ] < self.origin[ 1 ] )
                {
                    var_b78a4e168d5007bd = self.origin[ 1 ] - var_ef220394db29ba9a;
                }
                else
                {
                    var_b78a4e168d5007bd = self.origin[ 1 ] + var_ef220394db29ba9a;
                }
                
                n_delay = 0.001;
            }
            
            e_sliding_door.var_bfda56491906b9f4 = ( var_b78a4d168d50058a, var_b78a4e168d5007bd, self.origin[ 2 ] );
            e_sliding_door moveto( e_sliding_door.var_bfda56491906b9f4, level.var_409cf34875e21eb5 );
        }
        
        wait n_delay;
    }
}

