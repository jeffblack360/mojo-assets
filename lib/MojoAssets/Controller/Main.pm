package MojoAssets::Controller::Main;
use Mojo::Base 'MojoAssets::Controller';
use Data::Dumper;

sub index {
    my $self = shift;
    print STDERR "Welcome to index\n";
    print STDERR "$self\n";    
    # just render
    #$self->render;
    $self->render(template => 'example/welcome',
                  message => 'Hello from the index method!');
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
    my $name = $self->param('username');
    my $pass = $self->param('password');
    my $redir = $self->param('redirect');
    my $message = 'Welcome to the Mojolicious real-time web framework!';

    return $self->render(template => 'example/login') 
        unless defined $name and defined $pass;
    
    my $user = $self->verify_account($name, $pass);

    if($user) {
        # Login successful
        $self->session('user', $user);
        print STDERR "stuff $user->{username}\n";
        print STDERR "stuff $redir\n";
        $self->redirect_to($redir || 'index');
    } else {
        # Login failed
        #$self->show_error_l('pLogin_failed');
        #$self->redirect_to($redir || 'index');
        $message = "login: Your login failed. $name must match $pass";
    }

    # Render template "example/welcome.html.ep" with message
    $self->render(template => 'example/welcome', message => $message);
}

sub logout {
    my $self = shift;
    $self->session(expires => 1); # invalidate
	my $message = "You have successfully logged out.";
    $self->redirect_to('welcome', message => $message );
}

1;
