#!/usr/bin/perl
use strict;
use warnings;
use 5.010;
use English qw( -no_match_vars );

use Test::More;
use File::Basename;
my $topdir      = $ENV{TOPDIR} || (dirname($0) . '/..');
my $testdatadir = "$topdir/t/testdata";
my $arcmd       = $ENV{AUTOPKGTEST_TMP} ?
    '/usr/sbin/aptitude-robot' :
    "$topdir/aptitude-robot";

require_ok( $arcmd );

my $aptitude_command;

$aptitude_command = Aptitude::Robot::Command->new(config_dir => "$testdatadir/empty-config");
is_deeply(
    [ $aptitude_command->options() ],
    [ ],
    'options method returns empty array on non-existing options file'
);

$aptitude_command = Aptitude::Robot::Command->new(config_dir => "$testdatadir/extra-options");
is_deeply(
    [ $aptitude_command->options() ],
    [qw[ --download-only --without-recommends ]],
    'options method of Aptitude::Robot::Command'
);
is_deeply(
    [ $aptitude_command->command() ],
    [qw[ aptitude --download-only --without-recommends full-upgrade ], '~U !~ahold'],
    'command with options'
);
done_testing();
