#!/usr/bin/perl
#
# @File report_html_db.pl
# @Author Wendel Hime Lino Castro
# @Created Jul 19, 2016 10:45:01 AM
#

use strict;
use warnings;
use Getopt::Long;

my $nameProject;
my $help;
my $optret = GetOptions("h|help" => \$help, 
                                        "name=s" => \$nameProject);
my $helpMessage = <<HELP;

##### report_html_db.pl - In development stage 19/06/2016 - Wendel Hime #####

Project of scientific iniciation used to generate site based on content of evidences and results of analysis.

Usage:  report_html_db.pl -name <Name site>


Mandatory parameters:

-name       Name of the site/project to be created

Optional parameters:

-h              Print this help message and exit

HELP

if($help || !$nameProject)
{
    print $helpMessage;
    exit;
}

#path catalyst file
my $pathCatalyst = `which catalyst.pl`;
chomp $pathCatalyst;
#give permission to execute catalyst.pl
chmod("0755", $pathCatalyst);
#create project
print `$pathCatalyst $nameProject`;
my $lowCaseName = $nameProject;
lc $lowCaseName;
#give permission to execute files script
#chmod("111", "$nameProject/script/".$lowCaseName."_server.pl");
#chmod("111", "$nameProject/script/".$lowCaseName."_create.pl");
#create view
`./$nameProject/script/"$lowCaseName"_create.pl view TT TT`;

open(my $fileHandler, "<", "$nameProject/lib/$lowCaseName/View/TT.pm");
my $contentToBeChanged = "__PACKAGE__->config(\n     TEMPLATE_EXTENSION  => '.tt',\n     TIMER   =>  0,\n    WRAPPER     =>  '$lowCaseName/_layout.tt',\n);";
my $data = do { local $/; <$fileHandler>};
$data =~ s/__\w+->config\(([\w\s=>''"".,\/]*)\s\);/$contentToBeChanged/igm;
close($fileHandler);
open(my $fileHandler, ">", "$nameProject/lib/$lowCaseName/View/TT.pm");
print $fileHandler $data;
close($fileHandler);

#inicialize server project
#`./$nameProject/script/"$lowCaseName"_server.pl -r`;
