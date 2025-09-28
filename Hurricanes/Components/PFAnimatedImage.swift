//
//  PFAnimatedImage.swift
//  Hurricanes
//

import SwiftUI

struct PFAnimatedImage: UIViewRepresentable {
    let data: Data
    
    init(data: Data) {
        self.data = data
    }
    
    func makeUIView(context: Context) -> UIView {
        let path = "/System/Library/PrivateFrameworks/PhotosPlayer.framework/PhotosPlayer"
        dlopen(path, RTLD_NOW)
        
        let animClass = NSClassFromString("PFAnimatedImage") as! NSObject.Type
        let animInstance = animClass.perform(NSSelectorFromString("alloc"))!.takeUnretainedValue()
        _ = animInstance.perform(NSSelectorFromString("initWithData:"), with: data)
        
        let controller = NSClassFromString("ISAnimatedImageView") as! UIView.Type
        let controllerInstance = controller.perform(NSSelectorFromString("alloc"))!.takeUnretainedValue()
        let instance = controllerInstance.perform(NSSelectorFromString("initWithAnimatedImage:"), with: animInstance).takeUnretainedValue() as! UIView
        
        instance.setValue(true, forKey: "playing")
        
        return instance
    }
    
    func updateUIView(_ uiView: UIView, context: Context) {}
}

struct PFAnimatedImageLoader: View {
    let link: String
    @State private var data: Data? = nil
    @State private var isLoading = true
    
    var body: some View {
        Group {
            if let data = data {
                PFAnimatedImage(data: data)
            } else if isLoading {
                ProgressView("Loading…")
                    .frame(width: 100)
            } else {
                ContentUnavailableView("Failed to load", systemImage: "exclamationmark.triangle.fill")
            }
        }
        .task {
            await loadData()
        }
    }
    
    private func loadData() async {
        do {
            guard let url = URL(string: link) else { return }
            let (fetchedData, _) = try await URLSession.shared.data(from: url)
            self.data = fetchedData
        } catch {
            print("Failed to fetch GIF from URL:", error)
        }
        self.isLoading = false
    }
}
