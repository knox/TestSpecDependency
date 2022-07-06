Pod::Spec.new do |s|
  s.name = 'TestSpecDependencyBase'
  s.version = '0.0.1'
  s.summary = 'A short description of TestSpecDependencyBase.'

  s.homepage = 'https://github.com/knox/TestSpecDependency'
  s.license = { :type => 'MIT' }
  s.author = 'Mickey Knox'
  s.source = { :git => 'https://github.com/Knox/TestSpecDependency.git', :tag => s.version.to_s }

  s.ios.deployment_target = '14.1'
  s.swift_version = '5.4'

  s.source_files = [
    'TestSpecDependencyBase/Classes/**/*',
    'TestSpecDependencyBase/Extensions/**/*'
  ]
  
end
