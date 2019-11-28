package Data::Sah::Coerce::perl::To_str::From_str::to_isbn;

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
        summary => 'Check and format ISBN 10 or ISBN 13 number from string',
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
        "  if    (length \$digits == 10) { unless (Algorithm::CheckDigits::CheckDigits('ISBN')->is_valid(\$digits)) { \$res = ['Invalid ISBN 10 checksum digit']; last } \$res = [undef, \$digits] } ",
        "  elsif (length \$digits == 13) { unless (Algorithm::CheckDigits::CheckDigits('ean') ->is_valid(\$digits)) { \$res = ['Invalid ISBN 13 checksum digit']; last } \$res = [undef, \$digits] } ",
        "  else  { \$res = ['ISBN must be 10 or 13 digits']; last } ",
        "} ",
        "\$res }",
    );

    $res;
}

1;
# ABSTRACT:

=for Pod::Coverage ^(meta|coerce)$
