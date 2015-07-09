pod 'AVOSCloud'
pod 'AVOSCloudIM'
pod 'AVOSCloudSNS'
pod 'MJRefresh'
pod 'RongCloudIMKit'
pod 'RSKImageCropper'

post_install do |installer| installer.project.targets.each do |target| target.build_configurations.each do |config| config.build_settings['ARCHS'] = "armv7 arm64" end end end
