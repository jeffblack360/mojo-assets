package MojoAssets::Controller;
use Mojo::Base 'Mojolicious::Controller';
use URI::Escape;
use Carp;

# Get the currently logged in user
sub auth_get_username {
    my $user = shift->session('user') or return;
    return $user->name;
}

# Takes a user role and returns a boolean indicating whether current user
# has this role
sub auth_has_role {
    my ($self, $role) = @_;
    my $user = $self->session('user') or return;
    return $user->roles->{$role};
}

# Requires user to have a certain role. On failure, false is returned
# and the user redirected to login
sub auth_require_role {
    my ($self, $role) = @_;
    return unless $self->auth_require_login;
    return 1 if $self->auth_has_role($role);
    # TODO flash() "Insufficient privileges" or something?
    $self->redirect_to(named => 'login', redirect => $self->url_with);
    return;
}

# Require that user be logged in. Redirect to login if not.
sub auth_require_login {
    my $self = shift;
    my $user = $self->session('user');
    return 1 if defined($user) && defined($user->name);
    $self->redirect_to(named => 'login', redirect => $self->url_with);
    return;
}

# Takes a user name and a password and returns a user object
# or undef on verification failure
sub verify_account {
    my ($self, $user, $pass) = @_;
    my $u;
    return unless defined $user and defined $pass;

    $u = { username => $user, password => $pass };
    # $u = $self->model('admin')->load($user)
        # and $self->_compare_passwords($pass, $u->password) and return $u;
    # $u = $self->model('mailbox')->load($user)
        # and $self->_compare_passwords($pass, $u->password) and return $u;
    return $u;
}
1;
