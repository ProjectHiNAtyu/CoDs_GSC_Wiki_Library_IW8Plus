// IW9 GSC SOURCE
// Generated by https://github.com/xensik/gsc-tool

marktarget_init()
{

}

marktarget_run( victim, objweapon, smeansofdeath )
{
    if ( scripts\engine\utility::isbulletdamage( smeansofdeath ) && isplayer( victim ) && scripts\mp\utility\player::isreallyalive( victim ) && victim.team != self.team && isdefined( objweapon ) && !objweapon.isalternate )
        thread marktarget_execute( victim );
}

marktarget_execute( target )
{
    target notify( "delayHealing_started" );
    target endon( "delayHealing_started" );
    target.healthregendisabled = 1;
    tagmarkedplayer( target );

    if ( isdefined( target ) )
        target removemarkfromtarget();
}

tagmarkedplayer( target )
{
    self endon( "death_or_disconnect" );
    target endon( "death_or_disconnect" );
    _id_97384B887AB6A3C0 = gettime() + 3500;

    while ( gettime() < _id_97384B887AB6A3C0 )
        waitframe();
}

removemarkfromtarget()
{
    self.healthregendisabled = undefined;
}
