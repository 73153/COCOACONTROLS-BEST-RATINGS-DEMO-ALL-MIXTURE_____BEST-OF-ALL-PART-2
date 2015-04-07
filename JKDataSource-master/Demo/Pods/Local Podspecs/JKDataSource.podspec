#
# Be sure to run `pod spec lint JKDataSource.podspec' to ensure this is a
# valid spec and remove all comments before submitting the spec.
#
# To learn more about the attributes see http://docs.cocoapods.org/specification.html
#
Pod::Spec.new do |s|
  s.name         = "JKDataSource"
  s.version      = "0.0.1"
  s.platform     = :ios
  s.summary      = "Helper class to make managing TableView Delegate/Datasource easier."
  s.homepage     = "https://github.com/flippinjoe21/JKDataSource"
  s.license      = 'MIT'
  s.author       = { "Joseph Ridenour" => "joe@joesapps.net" }
  s.source       = { :git => "https://github.com/flippinjoe21/JKDataSource.git", :branch => "master" }
  s.ios.deployment_target = '4.3'
  s.source_files = 'JKDataSource/**/*.{h,m}'

  s.requires_arc = true
end
