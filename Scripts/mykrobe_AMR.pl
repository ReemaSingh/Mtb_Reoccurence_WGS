#!/usr/bin/perl
use strict;
use warnings;

my $file = $ARGV[0];
my $PATH = $ARGV[1];
my $PATH1 = $ARGV[2];

open(FILE,$file);
while ( my $line =<FILE>){
chomp($line);
my($ID,$pair1,$pair2) = split /\t/,$line;
my $Ofile = $ID;

system "mykrobe predict -S tb -s $Ofile -i $PATH/$pair1 $PATH/$pair2 --format json_and_csv -o $PATH1/$Ofile -t 35\n"; 
}

