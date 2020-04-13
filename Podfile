def import_pods
    use_frameworks!
    pod 'Locksmith'
    
    #pod 'SwiftMatrixSDK'
    #pod 'SwiftMatrixSDK', :git => 'https://github.com/matrix-org/matrix-ios-sdk.git', :branch => 'develop'
    pod 'SwiftMatrixSDK', :git => 'https://github.com/matrix-org/matrix-ios-sdk.git', :branch => 'xcode11'

    #pod 'SwiftMatrixSDK', :path => '../matrix-ios-sdk/SwiftMatrixSDK.podspec'
end

target 'Messagerie' do
    platform :ios, '10.0'
    import_pods
end

target 'MacMessagerie' do
    platform :osx, '10.15'
    import_pods
end
