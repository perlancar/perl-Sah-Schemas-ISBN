package Sah::Schema::isbn;

# AUTHOR
# DATE
# DIST
# VERSION

our $schema = [str => {
    summary => 'ISBN 10 or ISBN 13 number',
    description => <<'_',

Nondigits [^0-9Xx] will be removed during coercion.

Checksum digit must be valid.

_
    match => '\A(?:[0-9]{13}|[0-9]{9}[0-9Xx])\z',
    'x.perl.coerce_rules' => ['From_str::to_isbn'],
}, {}];

1;
# ABSTRACT:
