// IW8 GSC SOURCE
// Generated by https://github.com/xensik/gsc-tool

initgameflags()
{
    if ( !isdefined( game["flags"] ) )
        game["flags"] = [];
}

gameflaginit( var_0, var_1 )
{
    game["flags"][var_0] = var_1;
}

lootcachespawncontents( var_0 )
{
    return isdefined( game["flags"][var_0] );
}

gameflag( var_0 )
{
    return game["flags"][var_0];
}

gameflagset( var_0 )
{
    game["flags"][var_0] = 1;
    level notify( var_0 );
}

gameflagclear( var_0 )
{
    game["flags"][var_0] = 0;
}

gameflagwait( var_0 )
{
    while ( !gameflag( var_0 ) )
        level waittill( var_0 );
}

initlevelflags()
{
    if ( !isdefined( level.levelflags ) )
        level.levelflags = [];
}

levelflaginit( var_0, var_1 )
{
    level.levelflags[var_0] = var_1;
}

levelflag( var_0 )
{
    return level.levelflags[var_0];
}

levelflagset( var_0 )
{
    level.levelflags[var_0] = 1;
    level notify( var_0 );
}

levelflagclear( var_0 )
{
    level.levelflags[var_0] = 0;
    level notify( var_0 );
}

levelflagwait( var_0 )
{
    while ( !levelflag( var_0 ) )
        level waittill( var_0 );
}

levelflagwaitopen( var_0 )
{
    while ( levelflag( var_0 ) )
        level waittill( var_0 );
}
