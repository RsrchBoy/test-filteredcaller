use strict;
use warnings;

use Test::More;
use Test::FilteredCaller;

# test with defaults
my @info = nontest_caller;
note explain \@info;
is $info[0], 'main'      => 'package correct';
is $info[1], 't/basic.t' => 'filename correct';
is $info[2], __LINE__-4  => 'line correct';

{
    package Test::Frobnip;

    use Test::FilteredCaller;
    sub bar { nontest_caller }
}

@info = Test::Frobnip::bar;
note explain \@info;
is $info[0], 'main'      => 'package correct';
is $info[1], 't/basic.t' => 'filename correct';
is $info[2], __LINE__-4  => 'line correct';

done_testing;
