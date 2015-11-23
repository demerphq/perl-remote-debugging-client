#!/usr/bin/perl

use t::lib::Test;

use MIME::Base64 qw(encode_base64);

run_debugger('t/scripts/base.pl');

command_is(['eval', encode_base64('$i')], {
    command => 'eval',
    result  => {
        name        => '$i',
        fullname    => '$i',
        type        => 'string',
        constant    => '0',
        children    => '0',
        value       => undef,
    },
});

command_is(['eval', encode_base64('"a"')], {
    command => 'eval',
    result  => {
        name        => '"a"',
        fullname    => '"a"',
        type        => 'string',
        constant    => '0',
        children    => '0',
        value       => 'a',
    },
});

command_is(['eval', encode_base64('$i + 0')], {
    command => 'eval',
    result  => {
        name        => '$i + 0',
        fullname    => '$i + 0',
        type        => 'int',
        constant    => '0',
        children    => '0',
        value       => '0',
    },
});

command_is(['eval', encode_base64('{a => [1, 2], b => 7}')], {
    command => 'eval',
    result  => {
        name        => '{a => [1, 2], b => 7}',
        fullname    => '{a => [1, 2], b => 7}',
        type        => 'HASH',
        constant    => '0',
        children    => '1',
        numchildren => '2',
        value       => undef,
        childs      => [
            {
                name        => '->{a}',
                fullname    => '{a => [1, 2], b => 7}->{a}',
                type        => 'ARRAY',
                constant    => '0',
                children    => '1',
                numchildren => '2',
                value       => undef,
            },
            {
                name        => '->{b}',
                fullname    => '{a => [1, 2], b => 7}->{b}',
                type        => 'int',
                constant    => '0',
                children    => '0',
                value       => '7',
            },
        ],
    },
});

done_testing();
