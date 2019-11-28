package Sah::Schema::isbn13;

# AUTHOR
# DATE
# DIST
# VERSION

our $schema = [str => {
    summary => 'ISBN 13 number',
    description => <<'_',

Nondigits [^0-9] will be removed during coercion.

Checksum digit must be valid.

Basically EAN-13, except with additional coercion rule to coerce it from
ISBN 10.

_
    match => '\A[0-9]{13}\z',
    'x.perl.coerce_rules' => ['From_str::to_isbn13'],
}, {}];

1;
# ABSTRACT:
