#!/usr/bin/perl
use strict;
use warnings;

my $file = $ARGV[0];
my $ref = $ARGV[1];
my $PATH = $ARGV[2];
my $OUT = $ARGV[3];

open(FILE,$file);
while ( my $line =<FILE>){
chomp($line);
my($ID,$pair1,$pair2) = split /\t/,$line;
my $Ofile = $ID;
my $log = $ID;
system "bowtie2-build -f $ref $ref\n";
system "bowtie2 -x $ref -1 $PATH/$pair1 -2 $PATH/$pair2 -S $OUT/$Ofile.sam --threads 25 2> $OUT/$log.log\n";
system "rm -rf $OUT/$Ofile.sam\n";
}
