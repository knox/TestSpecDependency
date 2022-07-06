Pod::Spec.new do |s|
  s.name = 'TestSpecDependencyLib'
  s.version = '0.0.1'
  s.summary = 'A short description of TestSpecDependencyLib.'

  s.homepage = 'https://github.com/knox/TestSpecDependency'
  s.license = { :type => 'MIT' }
  s.author = 'Mickey Knox'
  s.source = { :git => 'https://github.com/Knox/TestSpecDependency.git', :tag => s.version.to_s }

  s.ios.deployment_target = '14.1'
  s.swift_version = '5.4'

  s.source_files = 'TestSpecDependencyLib/Classes/**/*'
  
  s.dependency 'TestSpecDependencyBase'

  s.test_spec 'Tests' do |t|
    t.source_files = 'TestSpecDependencyLib/Tests/**/*'
    t.requires_app_host = true
    t.app_host_name = 'TestSpecDependencyLib/AppHost'
    t.dependency 'TestSpecDependencyLib/AppHost'
  end

  s.app_spec 'AppHost' do |a|
    a.source_files = 'TestSpecDependencyLib/AppHost/**'
  end

end
