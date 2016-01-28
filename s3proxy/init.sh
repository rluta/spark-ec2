#!/bin/bash

PACKAGES="httpd24 mod24_ssl mod24_perl mod24_proxy perl-CPAN perl-XML-Parser"

if ! rpm --quiet -q $PACKAGES; then
  yum install -q -y $PACKAGES;
fi

cpan install Apache2::S3
