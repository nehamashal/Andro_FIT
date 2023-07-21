# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'Andro Fit App' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!
    pod 'IQKeyboardManagerSwift'
    #pod 'AWSIoT'
   # pod 'AWSMobileClient' #, '~>2.6.5'
   # pod 'AWSS3'
    #pod 'AWSRekognition'
    pod 'FaceSDK'
    pod 'SideMenu'
  # Pods for Andro Fit App

  target 'Andro Fit AppTests' do
    inherit! :search_paths
    # Pods for testing
  end

  target 'Andro Fit AppUITests' do
    # Pods for testing
  end

end



post_install do |installer|
    installer.generated_projects.each do |project|
          project.targets.each do |target|
              target.build_configurations.each do |config|
                  config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '12.0'
               end
          end
   end
end
