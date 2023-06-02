import SwiftUI

struct ScrollViewRTL<Content: View>: View {
    @ViewBuilder var content: Content
    @Environment(\.layoutDirection) private var layoutDirection
    
    @ViewBuilder var body: some View {
        
        ScrollView(.horizontal, showsIndicators: false) {
            content
                .rotation3DEffect(Angle(degrees: layoutDirection == .rightToLeft ? -180 : 0), axis: (x: CGFloat(0), y: CGFloat(layoutDirection == .rightToLeft ? -10 : 0), z: CGFloat(0)))
        }
        .rotation3DEffect(Angle(degrees: layoutDirection == .rightToLeft ? 180 : 0), axis: (x: CGFloat(0), y: CGFloat(layoutDirection == .rightToLeft ? 10 : 0), z: CGFloat(0)))
    }
}

public struct ScrollSegmentControl: View {
    @Environment(\.layoutDirection) private var layoutDirection

    let segments: [Segment]
    var spacing: CGFloat = 16
    @Binding var activeSegment: Int
    
    let style: SegmentControlStyler
    
    var segmentTapped:((Segment) -> Void)?

    public init(segments: [Segment],
                spacing: CGFloat = 16,
                activeSegment: Binding<Int>,
                style: SegmentControlStyler,
                segmentTapped: ((Segment) -> Void)? = nil) {
        
        self.segments      = segments
        self.spacing       = spacing
        self._activeSegment = activeSegment
        self.style         = style
        self.segmentTapped = segmentTapped
    }
    
    public var body: some View {
        ZStack {
            VStack {
                Spacer()
                RoundedRectangle(cornerRadius: PublicTheme.inputTextCornerRadius)
                    .foregroundColor(Color.segmentLineColor)
                    .frame(height: 2)
            }
            .frame(height: 34)
            
            ScrollViewRTL()  {
                HSTackSegmentedControl(
                    spacing: spacing,
                    segments: segments,
                    style: style,
                    activeSegment: $activeSegment,
                    segmentTapped: self.segmentTapped
                )
            }
            .frame(height: 30)
        }
    }
}

// MARK: - HSTackSegmentedControl

private struct HSTackSegmentedControl: View {
    
    let spacing: CGFloat
    let segments: [Segment]
    let style: SegmentControlStyler
    
    @Binding var activeSegment: Int
    
    var segmentTapped:((Segment) -> Void)?
    
    var body: some View {
        HStack(spacing: spacing) {
            ForEach(Array(segments.enumerated()), id: \.offset) { (idx, segment) in
                withAnimation {
                    SegmentButtonView(
                        segment: segment,
                        style: style,
                        activeSegment: $activeSegment,
                        segmentTapped: segmentTapped
                    )
                }
            }
            Spacer()
        }
        .padding()
        .padding(.leading)
    }
}

// MARK: - SegmentButtonView

private struct SegmentButtonView: View {
    
    let segment: Segment
    let style: SegmentControlStyler
    
    @Binding var activeSegment: Int
    
    var segmentTapped:((Segment) -> Void)?
    
    var body: some View {
        Button {
            activeSegment = segment.index
            segmentTapped?(segment)
            
        } label: {
            VStack(spacing: 4) {
                Text(segment.title)
                    .applyStyle(style: .mediumTitle)
                ((segment.index == activeSegment) ? style.activeBarColor : Color.clear)
                    .cornerRadius(style.activeBarWidth / 2)
                    .frame(height: style.activeBarWidth)
            }
        }
        .buttonStyle(PlainButtonStyle())
    }
}

// MARK: - Preview

struct ScrollSegmentControl_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            ScrollSegmentControl(
                segments: [
                    Segment(title: "Section One", index: 0),
                    Segment(title: "Section Two", index: 1),
                    Segment(title: "Section Three", index: 2)
                ],
                activeSegment: .constant(0),
                style: SegmentControlStyler(
                    font: Font.system(size: 22, weight: .bold),
                    textColor: (Color.black, Color.gray),
                    activeBarColor: Color.blue)
            )
            
            ScrollSegmentControl(
                segments: [
                    Segment(title: "Section One", index: 0),
                    Segment(title: "Section Two", index: 1),
                    Segment(title: "Section Three", index: 2),
                    Segment(title: "Section Four", index: 3),
                    Segment(title: "Section Five", index: 4),
                    Segment(title: "Section Six", index: 5),
                ],
                activeSegment: .constant(2),
                style: SegmentControlStyler(
                    font: Font.system(size: 22, weight: .bold),
                    textColor: (Color.black, Color.gray),
                    activeBarColor: Color.blue)
            )
            Spacer()
        }
        .environment(\.layoutDirection, .rightToLeft)
        .previewDevice(PreviewDevice(rawValue: "iPhone 11 Pro"))
        .previewInterfaceOrientation(.portraitUpsideDown)
    }
}


