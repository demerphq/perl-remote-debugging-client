#!/usr/bin/perl

use t::lib::Test;

$ENV{DBGP_PERL_IGNORE_PADWALKER} = 1;

run_debugger($] < 5.012 ? 't/scripts/variables_complex_510.pl' : 't/scripts/variables_complex.pl');

send_command('run');

command_is(['context_get'], {
    command => 'context_get',
    values  => [
        { name  => '$foo', value => 1 },
        { name  => '@foo', numchildren => 2 },
        { name  => '%roo', numchildren => 1 },
        { name  => '@roo', numchildren => 1 },
    ],
});

send_command('run');

command_is(['context_get'], {
    command => 'context_get',
    values  => [
        { name  => '$foo', value => 1 },
    ],
});

done_testing();