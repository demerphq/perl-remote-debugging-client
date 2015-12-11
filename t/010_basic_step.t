#!/usr/bin/perl

use t::lib::Test;

run_debugger('t/scripts/base.pl');

command_is(['step_into'], {
    reason      => 'ok',
    status      => 'break',
    command     => 'step_into',
    filename    => undef,
    lineno      => undef,
}) for 1 .. ($] < 5.008 ? 14 : 9);

command_is(['step_into'], {
    reason      => 'ok',
    status      => 'stopping',
    command     => 'step_into',
    filename    => undef,
    lineno      => undef,
});

is(wait_line(), "STDOUT 15\n");
is(wait_line(), "STDERR 15\n");

command_is(['step_into'], {
    apperr  => 4,
    code    => 6,
    message => 'Command \'step_into\' not valid at end of run.',
    command => 'step_into',
});

done_testing();
