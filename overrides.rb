# oroGen packages optionally depend on ocl
Autobuild::Package.each do |pkg_name, pkg|
    next if !pkg.kind_of?(Autobuild::Orogen)
    pkg.optional_dependency 'ocl'
end

