package Sah::Schema::isbn10;

# DATE
# VERSION

our $schema = [str => {
    summary => 'ISBN 10 number',
    description => <<'_',

Nondigits [^0-9Xx] will be removed during coercion.

"x" will be converted to uppercase.

Checksum digit must be valid.

_
    match => '\A[0-9]{9}[0-9Xx]\z',
    'x.perl.coerce_rules' => ['str_to_isbn10'],
}, {}];

1;
# ABSTRACT:
