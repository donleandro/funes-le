

######################################################################
#
# validate_eprint( $eprint, $session, $for_archive ) 
#
######################################################################
#
# $eprint 
# - EPrint object
# $session 
# - Session object (the current session)
# $for_archive
# - boolean (see comments at the start of the validation section)
#
# returns: @problems
# - ARRAY of DOM objects (may be null)
#
######################################################################
# Validate the whole eprint, this is the last part of a full 
# validation so you don't need to duplicate tests in 
# validate_eprint_meta, validate_field or validate_document.
#
######################################################################

$c->{validate_eprint} = sub
{
	my( $eprint, $session, $for_archive ) = @_;

	my @problems = ();

	# If we don't have creators (eg. for a book) then we 
	# must have editor(s). To disable that rule, remove the 
	# following block.	
	if( !$eprint->is_set( "creators" ) && 
		!$eprint->is_set( "editors" ) )
	{
		my $fieldname = $session->make_element( "span", class=>"ep_problem_field:creators" );
		push @problems, $session->html_phrase( 
				"validate:need_creators_or_editors",
				fieldname=>$fieldname );
	}


	return( @problems );
};
