//
//  PullToRefreshConst.swift
//  PullToRefreshSwift
//
//  Created by Yuji Hato on 12/11/14.
//
import Foundation
import UIKit

extension UIScrollView {

    private var pullToRefreshView: PullToRefreshView? {
        get {
            let pullToRefreshView = viewWithTag(PullToRefreshConst.tag)
            return pullToRefreshView as? PullToRefreshView
        }
    }

    func addPullToRefresh(refreshCompletion :(() -> ())) {
        let refreshViewFrame = CGRectMake(0, -PullToRefreshConst.height, self.frame.size.width, PullToRefreshConst.height)
        let refreshView = PullToRefreshView(refreshCompletion: refreshCompletion, frame: refreshViewFrame)
        refreshView.tag = PullToRefreshConst.tag
        addSubview(refreshView)
    }

    func startPullToRefresh() {
        pullToRefreshView?.state = .Refreshing
    }
    
    func stopPullToRefresh() {
        pullToRefreshView?.state = .Normal
    }
    
    // If you want to PullToRefreshView fixed top potision, Please call this function in scrollViewDidScroll
    func fixedPullToRefreshViewForDidScroll() {
        if PullToRefreshConst.fixedTop {
            if self.contentOffset.y < -PullToRefreshConst.height {
                if var frame = pullToRefreshView?.frame {
                    frame.origin.y = self.contentOffset.y
                    pullToRefreshView?.frame = frame
                }
            } else {
                if var frame = pullToRefreshView?.frame {
                    frame.origin.y = -PullToRefreshConst.height
                    pullToRefreshView?.frame = frame
                }
            }
        }
    }
}

// Copyright belongs to original author
// http://code4app.net (en) http://code4app.com (cn)
// From the most professional code share website: Code4App.net 
