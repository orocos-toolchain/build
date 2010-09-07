gitorious_long_doc = [
    "Access method to gitorious (git, http or ssh)",
    "Use 'ssh' only if you have a gitorious account and have commit rights",
    "on the Orocos projects. Otherwise, we advise you to use 'git'"]

configuration_option 'GITORIOUS', 'string',
    :default => "git",
    :values => ["http", "ssh"],
    :doc => gitorious_long_doc do |value|

    if value == "git"
        Autoproj.change_option("GITORIOUS_ROOT", "git://gitorious.org/")
    elsif value == "http"
        Autoproj.change_option("GITORIOUS_ROOT", "http://git.gitorious.org/")
    elsif value == "ssh"
        Autoproj.change_option("GITORIOUS_ROOT", "git@gitorious.com:")
    end

    value
end

Autoproj.user_config('GITORIOUS')

corba_impl_long_doc = [ "Set the CORBA implementation: TAO or OMNIORB" ]

configuration_option 'rtt_corba_implementation', 'string',
    :default => "OMNIORB",
    :values => ["TAO"],
    :doc => corba_impl_long_doc do |value|

    if value == "TAO"
        Autoproj.change_option("rtt_corba_implementation", "TAO")
    elsif value == "OMNIORB"
        Autoproj.change_option("rtt_corba_implementation", "OMNIORB")
    end

    value
end

Autoproj.user_config('rtt_corba_implementation')

