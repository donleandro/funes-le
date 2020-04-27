$c->{theme} = "greenspring";
$c->{plugins}->{"Screen::Login"}->{appears}->{key_tools} = undef;
$c->{plugins}->{"Screen::Logout"}->{appears}->{key_tools} = undef;

$c->{dynamic_template}->{function} = sub {
        my( $session, $parts ) = @_;

	my $screen_processor = EPrints::ScreenProcessor->new(
                session => $session,
                screenid => "FirstTool",
        );

        my $user = $session->current_user;
        if( defined $user )
        {
                $parts->{login_status} = $session->html_phrase(
                        "dynamic:logged_in",
                        user => $user->render_description,
                        tools => $session->make_doc_fragment );
                $parts->{login_status_header} = $session->html_phrase(
                        "dynamic:logged_in_header" );
                $parts->{toolbar} = $screen_processor->render_toolbar;
        }
        else
        {
                $parts->{login_status} = $session->html_phrase(
                        "dynamic:not_logged_in" );
                $parts->{login_status_header} = $session->html_phrase(
                        "dynamic:logged_in_header" );
        }
};

