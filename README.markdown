# Testing OmniAuth

This is just a little sample Rails 3.2 application that includes [OmniAuth][] and has integration tests (using [RSpec][] and [Capybara][]).

Nothing magical here.  Simply followed the instructions in the [OmniAuth Integration Testing wiki page][wiki].

Here's my spec: [omniauth_login_spec.rb](https://github.com/remi/testing-omniauth/blob/master/spec/acceptance/omniauth_login_spec.rb)

Another little useful gem is the [auth-response-samples][] which contains real samples of `env["omniauth.auth"]` for easy reference.

[OmniAuth]:              https://github.com/intridea/omniauth
[RSpec]:                 http://rspec.info
[Capybara]:              https://github.com/jnicklas/capybara
[wiki]:                  https://github.com/intridea/omniauth/wiki/Integration-Testing
[auth-response-samples]: https://github.com/remi/testing-omniauth/tree/master/auth-response-samples
