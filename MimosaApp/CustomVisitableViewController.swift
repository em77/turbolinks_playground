//
//  CustomVisitableViewController.swift
//  MimosaApp
//
//  Created by Eric Marchese on 2019-02-25.
//  Copyright © 2019 Acquisio. All rights reserved.
//

import Turbolinks

class CustomVisitableViewController: VisitableViewController {
    override func visitableDidRender() {
        // So the tab bar item text doesn't change to the web view's title.
        navigationItem.title = visitableView.webView?.title
    }
}
