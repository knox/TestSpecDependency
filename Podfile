platform :ios, '14.1'

target 'TestSpecDependency' do

  pod 'TestSpecDependencyBase', :path => 'TestSpecDependencyBase'
  pod 'TestSpecDependencyLib', :path => 'TestSpecDependencyLib', :testspecs => [ 'Tests' ]

  target 'TestSpecDependencyTests' do
      inherit! :search_paths
  end
  
end
