Pod::Spec.new do |s|
    s.platform              = :ios
    s.ios.deployment_target = '11.0'
    s.name                  = "WZImagePickerSDK"
    s.summary               = "iOS SDK for ImagePicker"
    s.requires_arc          = true
    
    
    s.version               = "1.0.0"
    
    s.license               = { :type => "MIT", :file => "LICENSE" }
    
    
    s.author                = { "Whizpool" => "whizpool" }
    
    s.homepage              = "https://github.com/whizpool/WzImagePicker.git"
    
    
    s.source                = {
    :git => "https://github.com/whizpool/WzImagePicker.git",
    :tag => "#{s.version}"
    }
    
    s.framework             = "UIKit"
    s.framework             = "Photos"
    
    s.source_files          = "WZImagePickerSDK/**/*.{h,m,swift, xib, storyboard}"
    s.resources             = 'WZImagePickerSDK/Resources/*.storyboard'
    
    s.swift_version         = "4.2"
    
end
