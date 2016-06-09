BEGIN {
  use Path::Class qw/file dir/;
  $Bin = file($0)->parent->stringify; # Like FindBin  
}

use Plack::Builder;
use Plack::Util;
sub load_psgi { Plack::Util::load_psgi(@_) }

builder {
  mount '/slides/'    => load_psgi("$Bin/slides/app.psgi");

  # Redirect root requests to the slideshow:
  mount '/' => sub {[307,['Location', "$_[0]->{SCRIPT_NAME}/slides/"],[]]};
};
