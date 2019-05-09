platform :ios, '9.0'

#去掉pod警告
inhibit_all_warnings!
#use_frameworks!

target 'PacificSchool' do
    # 自动布局
    pod 'Masonry', '~> 1.1.0'
    #网络框架
    pod 'AFNetworking', '~> 3.2.1'
    pod 'MJExtension', '~> 3.0.15.1'
    #YYKit
    #pod 'YYKit'
    pod 'YYModel', '~> 1.0.4'
    # 刷新控件
    pod 'MJRefresh', '~> 3.1.12'
    # 提示器
    pod 'MBProgressHUD', '~> 0.9.2'
    # 分栏控制器
    pod 'HMSegmentedControl'
    #回调块
    pod 'BlocksKit'
    #键盘
    pod 'IQKeyboardManager'
    #图片加载
    pod 'SDWebImage', '~> 4.3.2'
    # 数据库
    #pod 'BGFMDB'
    #UI基础框架
    pod 'QMUIKit', '~> 2.9.0'
    #网页JavaScript控制
    #pod 'WebViewJavascriptBridge', '~> 6.0.3'
    #页面滑动控制
    #pod 'SGPagingView'
    #websocke
    pod 'SocketRocket', '~> 0.5.1'
end





post_install do |installer|
    installer.pods_project.targets.each do |target|
        target.build_configurations.each do |config|
            config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '9.0'
        end
    end
end
