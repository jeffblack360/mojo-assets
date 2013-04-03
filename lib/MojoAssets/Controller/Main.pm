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

sub login {
    my $self = shift;
    my $name = 'jeff'; #$self->param('username');
    my $pass = 'jeff'; #$self->param('password');
    my $redir = $self->param('redirect');

    return $self->render unless defined $name and defined $pass;

    my $user = $self->verify_account($name, $pass);
    if($user) {
        # Login successful
        $self->session('user', $user);
        $self->redirect_to($redir || 'index');
    } else {
        # Login failed
        #$self->show_error_l('pLogin_failed');
        $self->redirect_to($redir || 'index');
    }
}

sub logout {
    my $self = shift;
    $self->session(expires => 1); # invalidate
    $self->redirect_to('index');
};

1;
