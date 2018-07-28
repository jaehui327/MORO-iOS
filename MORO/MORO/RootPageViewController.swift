//
//  RootPageViewController.swift
//  MORO
//
//  Created by 김재희 on 2018. 7. 28..
//  Copyright © 2018년 김재희. All rights reserved.
//

import UIKit
import SnapKit

class RootPageViewController: UIPageViewController {
    //MARK: properties
    private var roomView: WhiteLabelView = {
        let view: WhiteLabelView = WhiteLabelView()
        return view
    }()
    
    private var levelView: WhiteImageView = {
        let view: WhiteImageView = WhiteImageView()
        return view
    }()
    
    private var backgroundImageView: UIImageView = {
        let imageView: UIImageView = UIImageView()
        imageView.contentMode = .scaleToFill
        imageView.image = #imageLiteral(resourceName: "BGFULL")
        
        return imageView
    }()
    
    private var scrollView: UIScrollView?
    
    private var pageControl: UIPageControl = UIPageControl()
    
    private var viewControllerList : [UIViewController] = {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc1 = storyboard.instantiateViewController(withIdentifier: "MainViewController")
        let vc2 = storyboard.instantiateViewController(withIdentifier: "RoomListViewController")
        
        return [vc1, vc2]
    }()
    
    //MARK: life cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        dataSource = self
        delegate = self
        
        addSubViews()
        addConstraints()
        setBackground()
        initPageViewController()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //MARK: Methods
    private func addSubViews() {
        view.addSubview(levelView)
        view.addSubview(roomView)
    }
    
    private func addConstraints() {
        levelView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(15)
            $0.leading.equalToSuperview().offset(20)
        }
        
        roomView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(15)
            $0.trailing.equalToSuperview().offset(20)
            $0.leading.greaterThanOrEqualTo(levelView.snp.trailing).offset(35)
        }
    }
    
    private func setBackground() {
        view.addSubview(backgroundImageView)
        
        backgroundImageView.snp.makeConstraints {
            $0.bottom.leading.trailing.equalToSuperview()
        }
        backgroundImageView.layer.zPosition = -100
    }
    private func initPageViewController() {
        configurePageControl()
        
        //첫번째 뷰컨트롤러 설정
        if let firstViewController = viewControllerList.first{
            setViewControllers([firstViewController], direction: .forward, animated: true, completion: nil)
        }
    }
    
    private func configurePageControl() {
        pageControl = UIPageControl(frame: CGRect(x: 0,y: UIScreen.main.bounds.maxY - 20,width: UIScreen.main.bounds.width,height: 11))
        pageControl.numberOfPages = viewControllerList.count
        pageControl.currentPage = 0
        pageControl.tintColor = UIColor.black
        pageControl.pageIndicatorTintColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.8)
        pageControl.currentPageIndicatorTintColor = UIColor(red: 85/255, green: 64/255, blue: 147/255, alpha: 1)
        view.addSubview(pageControl)
    }
}

extension RootPageViewController: UIPageViewControllerDelegate {
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        let pageContentViewController = pageViewController.viewControllers![0]
        pageControl.currentPage = viewControllerList.index(of: pageContentViewController)!
        
        UIView.animate(withDuration: 0.5) { [weak self] in
            if let index = self?.viewControllerList.index(of: pageContentViewController) {
                if index == 0 {
                    self?.roomView.alpha = 1
                } else {
                    self?.roomView.alpha = 0
                }
                self?.view.layoutIfNeeded()
            }
        }
    }
}

extension RootPageViewController: UIPageViewControllerDataSource {
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
        UIView.animate(withDuration: 0.5) { [weak self] in
            self?.roomView.alpha = 0
            self?.view.layoutIfNeeded()
        }
        return viewControllerList[nextIndex]
    }
}
