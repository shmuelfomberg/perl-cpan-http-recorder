#!/usr/bin/perl

use strict;
use warnings;

use HTTP::Proxy;
use HTTP::Recorder;
use Getopt::Long;
use Pod::Usage;

my $port = 8080;
my $filename = "http_traffic";
my $show_help = '';

GetOptions ("port=i" => \$port, "file=s" => \$filename, "help" => \$show_help);
pod2usage(1) if ($show_help);

print "httprecorder - quick script for recording HTTP traffic\n";
print "Starting Proxy Server on Port $port\n";
print "Recording to file: $filename\n";

my $proxy = HTTP::Proxy->new( port => $port );

# create a new HTTP::Recorder object
my $agent = new HTTP::Recorder;

# set the log file (optional)
$agent->file($filename);

# set HTTP::Recorder as the agent for the proxy
$proxy->agent( $agent );

# start the proxy
$proxy->start();

sub Usage {
	print <<"USAGE";
HTTP::Recorder quick script
Usage:
	httprecorder [ --port=8080 ] [ --file=http_traffic ] [ --help ]

By default, will start a HTTP Proxy server on port 8080, and will record 
all traffic to "http_traffic" file in the current directory
USAGE
	exit(0);
}

=head1 NAME

httprecorder - quick script for recording HTTP traffic

=head1 SYNOPSIS

	httprecorder [ --port=8080 ] [ --file=http_traffic ] [ --help ]

	Options:
	--help    brief help message
	--port    Port number to use for the proxy server (default 8080)
	--file    filename to record the traffic to (default "http_traffic")

=head1 Author

Shmuel Fomberg <semuelf@cpan.org>

=head1 COPYRIGHT AND LICENSE

Copyright 2011 Shmuel Fomberg.

This program is free software; you can redistribute it and/or modify it 
under the same terms as Perl itself.

=cut
