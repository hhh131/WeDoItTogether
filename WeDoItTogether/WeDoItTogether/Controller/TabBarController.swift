//
//  MainTabBarController.swift
//  WeDoItTogether
//
//  Created by 최하늘 on 2023/07/14.
//

import UIKit
import CoreLocation
import Firebase

//메인탭바 컨트롤러
class TabBarController: UITabBarController {
    
    let locationManager = CLLocationManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        configureTabBar()
        configureMapView()
    }
    
    private func configureTabBar() {
        //홈뷰 네비게이션 컨트롤러로 생성
        let homeVC = UINavigationController.init(rootViewController: HomeViewController(title: "Home"))
        let chattingVC = UINavigationController.init(rootViewController: ChatListViewController(title: "Chatting"))
        let notificationVC = UINavigationController.init(rootViewController: NotificationViewController(title: "Notification"))
        let profileVC = UINavigationController.init(rootViewController: ProfileViewController(title: "Profile"))
        
        //네비게이션 타이틀 설정
        homeVC.navigationBar.prefersLargeTitles = true
        chattingVC.navigationBar.prefersLargeTitles = true
        notificationVC.navigationBar.prefersLargeTitles = true
        profileVC.navigationBar.prefersLargeTitles = true
        
        //탭바에 컨트롤러 추가
        self.viewControllers = [homeVC, chattingVC, notificationVC, profileVC]
        
        //탭바 아이콘 설정
        let homeTabBarItem = UITabBarItem(title: "Home", image: UIImage(systemName: "house.fill"), tag: 0)
        let chattingTabBarItem = UITabBarItem(title: "Chatting", image: UIImage(systemName: "message.fill"), tag: 1)
        let notificationTabBarItem = UITabBarItem(title: "Notification", image: UIImage(systemName: "bell.fill"), tag: 2)
        let profileTabBarItem = UITabBarItem(title: "Profile", image: UIImage(systemName: "person.fill"), tag: 3)
        //탭바 아이콘 추가
        homeVC.tabBarItem = homeTabBarItem
        chattingVC.tabBarItem = chattingTabBarItem
        notificationVC.tabBarItem = notificationTabBarItem
        profileVC.tabBarItem = profileTabBarItem
    }
    
    private func configureMapView() {
        locationManager.delegate = self
        self.locationManager.requestWhenInUseAuthorization()
        
        DispatchQueue.global().async {
            if CLLocationManager.locationServicesEnabled() {
                print("위치 서비스 On 상태")
                self.locationManager.startUpdatingLocation() //위치 정보 받아오기 시작
            } else {
                print("위치 서비스 Off 상태")
            }
        }
    }
}

//위치 설정
extension TabBarController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            print("위도: \(location.coordinate.latitude)")
            print("경도: \(location.coordinate.longitude)")
            UserDefaultsData.shared.setLocation(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
            saveUserLocation()
        }
        
        locationManager.stopUpdatingLocation()
    }
    
    //사용자의 위치를 못가지고 온 경우
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(#function)
    }
    
    func checkUserDeviceLocationServiceAuthorization(){
        let authorizationStatus: CLAuthorizationStatus
        //ios 14.0 이상이라면
        if #available(iOS 14.0, *){
            authorizationStatus = locationManager.authorizationStatus
        } else {
            authorizationStatus = CLLocationManager.authorizationStatus()
        }
        
        //"iOS 위치서비스 활성화" 여부 체크 : locationServicesEnabled()
        if CLLocationManager.locationServicesEnabled(){
            //위치 서비스가 활성화돼 있으므로 위치권한 요청이 가능해서 위치 권한을 요청
            checkUserCurrentLocationAuthorization(authorizationStatus)
        } else {
            print("위치서비스가 꺼져있습니다")
        }
    }
    
    //사용자의 위치권한 상태 확인
    func checkUserCurrentLocationAuthorization(_ authorizationStatus: CLAuthorizationStatus) {
        switch authorizationStatus {
        case .notDetermined:
            print("NotDetermined")
            //정확도 : kCLLocationAccuracy
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.requestWhenInUseAuthorization()
            
        case .restricted, .denied:
            print("Denied, 아이폰 설정으로 유도")
            self.showAlert(message: "위치 서비스를 사용할 수 없습니다. 기기의 '설정>개인정보 보호'에서 위치 서비스를 켜주세요") {
                if let appSetting = URL(string: UIApplication.openSettingsURLString){
                    UIApplication.shared.open(appSetting)
                }
            }
        case .authorizedWhenInUse:
            print("When In Use")
            locationManager.startUpdatingLocation()
            
        default:
            print("Default")
        }
    }
    
    private func saveUserLocation() {
        let user = UserDefaultsData.shared.getUser()
        let currentLocation = UserDefaultsData.shared.getLocation()
        let userLocation = CurrentLocation(latitude: currentLocation.latitude, longitude: currentLocation.longitude)
        
        let ref = Database.database().reference()

        guard let userId = user?.userId else {
            return
        }
        ref.child("location")
            .child(userId)
            .setValue(userLocation.asDictionary())
        
    }
}

