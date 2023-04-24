#!/usr/bin/perl
use strict;
use warnings;

my $In = $ARGV[0];
my $PATH = $ARGV[1];
my $adap = $ARGV[2]; 
my $Res = $ARGV[3];
my $Res1 = $ARGV[4];

open(INPUT,$In);
        while (my $rawData =<INPUT>){
        chomp($rawData);
        chomp($rawData);
        my ($ID,$pair1,$pair2) = split /\t/,$rawData;

my $OUTpair1 = join("_","OutputPaired",$pair1);
my $OUTUnpair1 = join("_","OutputUnpaired",$pair1);
my $OUTpair2 = join("_","OutputPaired",$pair2);
my $OUTUnpair2 = join("_","OutputUnpaired",$pair2);

system "java -jar /staff/res498/Soft/Trimmomatic-0.36/trimmomatic-0.36.jar PE -phred33 $PATH/$pair1 $PATH/$pair2 $Res/$OUTpair1 $Res/$OUTUnpair1 $Res/$OUTpair2 $Res/$OUTUnpair2 ILLUMINACLIP:$adap:2:30:10\n";

system "fastqc $Res/$OUTpair1 $Res/$OUTpair2 -o $Res1 -f fastq\n";
}
