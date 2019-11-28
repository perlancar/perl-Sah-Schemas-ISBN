package Data::Sah::Coerce::perl::To_str::From_str::to_isbn10;

# AUTHOR
# DATE
# DIST
# VERSION

use 5.010001;
use strict;
use warnings;

sub meta {
    +{
        v => 4,
        summary => 'Check and format ISBN 10 number from string',
        might_fail => 1,
        prio => 50,
    };
}

sub coerce {
    my %args = @_;

    my $dt = $args{data_term};

    my $res = {};

    $res->{expr_match} = "!ref($dt)";
    $res->{modules}{"Algorithm::CheckDigits"} = 0;
    $res->{modules}{"Algorithm::CheckDigits::M10_004"} = 0;
    $res->{modules}{"Algorithm::CheckDigits::M11_001"} = 0;
    $res->{expr_coerce} = join(
        "",
        "do { my \$digits = $dt; \$digits =~ s/[^0-9Xx]//g; \$digits = uc \$digits; ",
        "my \$res; ",
        "{ ",
        "  if (length \$digits == 13) { if (substr(\$digits, 0, 3) ne '978') { \$res = ['Can only convert from ISBN 13 with 978 prefix']; last } \$digits = Algorithm::CheckDigits::CheckDigits('ISBN')->complete(substr(\$digits, 3, 9)); \$res = [undef, \$digits]; last } ", # convert from ISBN 13
        "  if (length \$digits != 10) { \$res = ['ISBN 10 must have 10 digits']; last } ",
        "  unless (Algorithm::CheckDigits::CheckDigits('ISBN')->is_valid(\$digits)) { \$res = ['Invalid checksum digit']; last } ",
        "  \$res = [undef, \$digits]; ",
        "} ",
        "\$res }",
    );

    $res;
}

1;
# ABSTRACT:

=for Pod::Coverage ^(meta|coerce)$
