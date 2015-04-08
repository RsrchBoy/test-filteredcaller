package Test::FilteredCaller;

# ABSTRACT: Find your caller in a non-Test::* namespace

use strict;
use warnings;

use Carp 'confess';

# debugging...
#use Smart::Comments '###';

#use namespace::autoclean;

use Sub::Exporter -setup => {
    exports => [ nontest_caller => \&_build_nontest_caller ],
    groups  => { default        => [ 'nontest_caller' ] },
    # place-holder validation for the moment
    #collectors => [ namespaces  => sub { 1 } ],
};

sub _build_nontest_caller {
    my ($class, $name, $arg, $col) = @_;

    ### @_
    my @namespaces = ( qr/^Test::/ );
    my $default_depth = 0;

    return sub {
        ### @_
        my ($depth) = defined $_[0] ? shift : $default_depth;

        ### starting: $depth
        while (my @info = caller($depth)) {

            ### @info
            my $pkg = $info[0];
            return @info
                unless scalar map { $pkg =~ $_ } @namespaces;

            $depth++;
        }

        confess 'Congrats!  You managed to filter ALL THE NAMESPACES.';
    };
}

!!42;
__END__

=head1 SYNOPSIS

=head1 DESCRIPTION

=head1 SEE ALSO

=cut
