//
//  PFAnimatedImage.swift
//  Hurricanes
//

import SwiftUI

struct PFAnimatedImage: UIViewRepresentable {
    let link: String
    
    init(_ link: String) {
        self.link = link
    }

    func makeUIView(context: Context) -> UIView {
        let path = "/System/Library/PrivateFrameworks/PhotosPlayer.framework/PhotosPlayer"
        dlopen(path, RTLD_NOW)

        guard let gifURL = URL(string: link), let gifData = try? Data(contentsOf: gifURL) else {
            return UIView()
        }

        let animClass = NSClassFromString("PFAnimatedImage") as! NSObject.Type
        let animInstance = animClass.perform(NSSelectorFromString("alloc"))!.takeUnretainedValue()
        _ = animInstance.perform(NSSelectorFromString("initWithData:"), with: gifData)

        let controller = NSClassFromString("ISAnimatedImageView") as! UIView.Type
        let controllerInstance = controller.perform(NSSelectorFromString("alloc"))!.takeUnretainedValue()
        let instance = controllerInstance.perform(NSSelectorFromString("initWithAnimatedImage:"), with: animInstance).takeUnretainedValue() as! UIView

        instance.setValue(true, forKey: "playing")
        
        return instance
    }

    func updateUIView(_ uiView: UIView, context: Context) {}
}
