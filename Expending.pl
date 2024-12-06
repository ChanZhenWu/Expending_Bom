print "\n";
print "*******************************************************************************\n";
print "  Expending Bom <v1.0>\n";
print "  Author: Noon Chen\n";
print "  A Professional Tool for Test.\n";
print "  ",scalar localtime;
print "\n*****************************************************************************\n";
print "\n";

use strict;
use warnings;

print "  Please specify source file here: ";
   my $source=<STDIN>;
   chomp $source;

print $source;

############################### source file process ######################################

print  "\n	>>> Expending ... \n";
my $number = 0;

open (Export, "> new_$source"); 
open (Import, "< $source"); 
	while(my $array = <Import>)
	{
	chomp $array;
	$array =~ s/\s+//g;	   #clear head of line spacing
	if ($array =~ "\," and $array !~ "\-")
		{
		my @list = split(/,/, $array);
		#print scalar@list."\n";
		for (my $num = 0; $num < scalar@list; $num++)
			{
				printf Export $list[$num]."\n";
				print $list[$num]."\n";
				$number++;
			}
		}
	elsif ($array =~ "\-")
	{
	my @fields = split(/,/, $array);
		# print " * ".$array."\n";
		for (my $num = 0; $num < scalar@fields; $num++)
		{
			#print scalar@fields."\n";
			#print "	".$fields[$num]."\n";
		if ($fields[$num] =~ "\-")
		{
		my $string = "";
		my $suffix = "";
		my $begin = "";
		my $final = "";
		my $style = "";  # C for character, D for digit	
			# print "	".$fields[$num]."\n";
	my @Comps = split(/-/, $fields[$num]);
		
		my @Comp = split(/([a-z]+)/i, $Comps[0]);
			if ($Comp[1] =~ /([a-z]+)/i and scalar@Comp == 3)
				{$style = "CD"; $begin = $Comp[scalar@Comp - 1];}  # begin

			if ($Comp[1] =~ /([a-z]+)/i and scalar@Comp == 4)
				{$style = "CDC"; $begin = $Comp[scalar@Comp - 2]; $suffix = $Comp[scalar@Comp - 1];}  # begin

			if ($Comp[1] =~ /([a-z]+)/i and scalar@Comp == 5)
				{$style = "CDCD"; $begin = $Comp[scalar@Comp - 1];}  # begin

		@Comp = split(/([a-z]+)/i, $Comps[1]);
			$final = $Comp[scalar@Comp - 1];  # final
			#print $final."\n";
			if ($Comp[1] =~ /([a-z]+)/i and scalar@Comp == 4)
				{$final = $Comp[scalar@Comp - 2];}  # final
			
			# @fields(,) > @Comps(-) > @Comp(c)
			#-----------------------------------------------------------------------------ok
			if ($style eq "CD")
			{
			#print "CD\n";
			for (my $num = $begin; $num < $final+1; $num++)
				{
					$string = substr($Comps[1],0,length($Comps[0])-length($begin)).$num;
					if(length($Comps[0]) - length($string) == 1){$string = substr($Comps[0],0,length($Comps[0])-length($begin))."0".$num;}
					if(length($Comps[0]) - length($string) == 2){$string = substr($Comps[0],0,length($Comps[0])-length($begin))."00".$num;}
					if(length($Comps[0]) - length($string) == 3){$string = substr($Comps[0],0,length($Comps[0])-length($begin))."000".$num;}
					if(length($Comps[0]) - length($string) == 4){$string = substr($Comps[0],0,length($Comps[0])-length($begin))."0000".$num;}
					
					printf Export $string."\n";
					print $string."\n";
					$number++;
				}
			}

			#-----------------------------------------------------------------------------
			if ($style eq "CDC")
			{
			#print "CDC\n";
			for (my $num = $begin; $num < $final+1; $num++)
				{
					$string = substr($Comps[0],0,index($Comps[0],$begin)).$num.$suffix;
					if(length($Comps[0]) - length($string) == 1){$string = substr($Comps[0],0,index($Comps[0],$begin))."0".$num.$suffix;}
					if(length($Comps[0]) - length($string) == 2){$string = substr($Comps[0],0,index($Comps[0],$begin))."00".$num.$suffix;}
					if(length($Comps[0]) - length($string) == 3){$string = substr($Comps[0],0,index($Comps[0],$begin))."000".$num.$suffix;}
					if(length($Comps[0]) - length($string) == 4){$string = substr($Comps[0],0,index($Comps[0],$begin))."0000".$num.$suffix;}
					
					printf Export $string."\n";
					print $string."\n";
					$number++;
				}
			}

			#-----------------------------------------------------------------------------
			if ($style eq "CDCD")
			{
			#print "CDCD\n";
			for (my $num = $begin; $num < $final+1; $num++)
				{
					$string = substr($Comps[0],0,length($Comps[0])-length($begin)).$num;
					if(length($Comps[0]) - length($string) == 1){$string = substr($Comps[0],0,length($Comps[0])-length($begin))."0".$num;}
					if(length($Comps[0]) - length($string) == 2){$string = substr($Comps[0],0,length($Comps[0])-length($begin))."00".$num;}
					if(length($Comps[0]) - length($string) == 3){$string = substr($Comps[0],0,length($Comps[0])-length($begin))."000".$num;}
					if(length($Comps[0]) - length($string) == 4){$string = substr($Comps[0],0,length($Comps[0])-length($begin))."0000".$num;}
					
					printf Export $string."\n";
					print $string."\n";
					$number++;
				}
			}
		}
		else
		{
		printf Export $fields[$num]."\n";
		print $fields[$num]."\n";
		$number++;
			}
		}
	}
	else
		{
			print Export $array,"\n";
			print $array,"\n";
			$number++;
		}
	}
	
print "\n	BOM count: ".$number."\n";
close Import;
close Export;

print "	>>>done ...\n\n";


########################################################@#################################


