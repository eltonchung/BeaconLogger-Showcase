import SwiftUI

/// 從 iBeaconLog 紀錄頁節錄的版面。以呼叫端提供的兩個 View 取代 App 內部元件。
struct DuoLogLayout<MonitoringControls: View, LogContent: View>: View {
    let monitoringControls: MonitoringControls
    let logContent: LogContent

    var body: some View {
        GeometryReader { geometry in
            // 左欄至少 240 點，右欄至少 320 點，讓完整日期有足夠的換行空間。
            let width = geometry.size.width
            let usesColumns = width >= 560
            let layout = usesColumns
                ? AnyLayout(HStackLayout(alignment: .top, spacing: 0))
                : AnyLayout(VStackLayout(spacing: 0))

            layout {
                if usesColumns {
                    HStack(spacing: 0) {
                        ScrollView {
                            monitoringControls
                                .padding(.bottom)
                        }
                        Divider()
                    }
                    .frame(width: min(320, max(240, width / 3)))
                } else {
                    monitoringControls
                }

                logContent
            }
        }
    }
}
