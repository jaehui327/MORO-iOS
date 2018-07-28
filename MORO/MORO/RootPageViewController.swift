//
//  RootPageViewController.swift
//  MORO
//
//  Created by 김재희 on 2018. 7. 28..
//  Copyright © 2018년 김재희. All rights reserved.
//

import UIKit

class RootPageViewController: UIPageViewController, UIPageViewControllerDataSource {
    
    //MARK: properties
    var viewControllerList : [UIViewController] = {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc1 = storyboard.instantiateViewController(withIdentifier: "MainViewController")
        let vc2 = storyboard.instantiateViewController(withIdentifier: "RoomListViewController")
        
        return [vc1, vc2]
    }()

    //MARK: life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.dataSource = self
        
        //첫번째 뷰컨트롤러 설정
        if let firstViewController = viewControllerList.first{
            self.setViewControllers([firstViewController], direction: .forward, animated: true, completion: nil)
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: Methods
    override func viewDidLayoutSubviews() {
        
        for view in self.view.subviews {
            if view is UIPageControl {
                //view를 UIPageControl로 캐스팅
                let appearance = view as! UIPageControl
                appearance.backgroundColor = UIColor.white
                //페이지 dot(선택되지 않았을 떄)의 색상
                appearance.pageIndicatorTintColor = UIColor.gray
                //선택된 페이지뷰 컨트롤러의 도트색상
                appearance.currentPageIndicatorTintColor = UIColor.red
            }
        }
        
    }
    
    //이전 페이지에 나타날 뷰 컨트롤러 객체를 반환
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        //현재 뷰에 보여지고 있는 뷰컨트롤러 객체 참조
        guard let vcIndex = viewControllerList.index(of: viewController) else {
            return nil
        }
        
        let previousIndex = vcIndex - 1
        
        guard previousIndex >= 0 else {
            return nil
        }
        
        guard viewControllerList.count > previousIndex else {
            return nil
        }
        
        return viewControllerList[previousIndex]
        
    }
    

    
    //다음 페이지에 나타날 뷰 컨트롤러 객체를 반환
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        //현재 뷰에 보여지고 있는 뷰컨트롤러 객체 참조
        guard let vcIndex = viewControllerList.index(of: viewController) else {
            return nil
        }
        
        let nextIndex = vcIndex + 1
        
        guard viewControllerList.count != nextIndex else {
            return nil
        }
        
        guard viewControllerList.count > nextIndex else {
            return nil
        }
        
        return viewControllerList[nextIndex]
    }
    
    //인디케이터 갯수
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return viewControllerList.count
    }
    
    //첫 페이지가 될 인디케이터의 인덱스 값 반환
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        return 0
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
