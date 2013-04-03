package MojoAssets::Controller::Main;
use Mojo::Base 'MojoAssets::Controller';
use Data::Dumper;

sub index {
    # just render
}

# This action will render a template
sub welcome {
  my $self = shift;

  # Render template "example/welcome.html.ep" with message
  $self->render(template => 'example/welcome',
                message => 'Welcome to the Mojolicious real-time web framework!');
}

1;
