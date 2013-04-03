package MojoAssets;
use Mojo::Base 'Mojolicious';
use Schema;
use Carp;
use MojoAssets::Controller;
#use Mojolicious::Plugin::Config;
#use Data::Dumper;
#use Crypt::PasswdMD5 ();
#use Digest::MD5 ();
#use MojoX::Renderer::TT;
#use Template::Constants;
#use Ashafix::Model;
#use FindBin;
#use lib "$FindBin::Bin/../lib";
my $VERSION = '0.0.1';

has schema => sub {
  return Schema->connect('dbi:SQLite:' . ($ENV{TEST_DB} || 'db/assets.db'));
};

# This method will run once at server start
sub startup {
  my $self = shift;
  $Carp::Verbose = 1; # TODO debugging only
  $self->setup_plugins;
  $self->setup_routing;
  $self->setup_hooks;
}

# Perform system plugin configuration.
sub setup_plugins {
    my $self = shift;

    # Load config, keep a copy of the data structure for now
    my $config = $self->plugin(Config => {file => 'mojoassets.conf' });

    # Set our own controller
    $self->controller_class('MojoAssets::Controller');
    
    # Cross Site Request Forgery protection interferes with testing so
    # only enable it in production
    $self->plugin('Mojolicious::Plugin::CSRFDefender') if('production' eq $self->mode);

    # Documentation browser under "/perldoc"
    $self->plugin('PODRenderer');
};

# Define system routes.
sub setup_routing {
    my $self = shift;

    # Router
    my $r = $self->routes;
    
    $r->namespaces(['MojoAssets::Controller']);

    # Authentication conditions
    $r->add_condition(login => sub { $_[1]->auth_require_login });
    $r->add_condition(role => sub { $_[1]->auth_require_role($_[3]) });
    
    # Normal route to controller
    #$r->route('/')->to('main#welcome');
    $r->route('/') ->to('main#login') ->name('login');
    $r->route('/logout') ->to('main#logout') ->name('logout');
    $r->route('/main') ->over('login') ->to('main#index') ->name('index');    
    
};

sub setup_hooks {
    my ($self) = @_;
    
    # Define system hooks.
    $self->hook(before_dispatch => sub {
        my $c = shift;
        # As "defaults" values are not deep-copied, setting a hashref there
        # would just copy that hashref and stash modifications would actually
        # modify the defaults.
        $c->stash(info => []);
        $c->stash(error => []);

        # Debug request logging
        my $req = $c->req;
        my $method = $req->method;
        my $path = $req->url->path->to_abs_string;
        my $params = $req->params->to_string;
        print STDERR "REQ : $method $path [$params]\n";
        });
};

1;
