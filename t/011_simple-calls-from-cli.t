#!/usr/bin/perl
use strict;
use warnings;
use 5.010;
use English qw( -no_match_vars );

use Test::More;
use File::Basename;
my $topdir      = $ENV{TOPDIR} || (dirname($0) . '/..');
my $testdatadir = "$topdir/t/testdata";

use IPC::Run qw( run );

my $in = '';
my $out;
my $err;
my $cmd;

$cmd = [
    "$topdir/aptitude-robot",
    '--config-dir=/dev/null',
    '--show-cmdline',
];
ok(
    not(run( $cmd, \$in, \$out, \$err )),
    'should complain about non-existant config dir'
);

$cmd = [
    "$topdir/aptitude-robot",
    "--config-dir=$testdatadir/empty-config",
    '--show-cmdline',
];
ok(
    run( $cmd, \$in, \$out, \$err ),
    'empty config dir should give only `aptitude install ~U`'
);

is( $out, "aptitude -y install ~U\n",
    'command line should be `aptitude -y install ~U`');

done_testing();