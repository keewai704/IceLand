import Quickshell
import Quickshell.Io
import qs.components
import qs.core

ShellRoot {
    Variants {
        model: Quickshell.screens

        IslandWindow {
            required property var modelData
            screen: modelData
        }
    }

    IpcHandler {
        target: "island"

        function ping(): string {
            return "IceLand is running";
        }

        function demo(): void {
            ActivityController.showActivity(
                "demo",
                "Building IceLand",
                "128 / 347",
                "✦",
                0.37,
                5000,
                50,
                false
            );
        }

        function showActivity(activityId: string, title: string, detail: string, icon: string, progress: real, timeoutMs: int, priority: int, pinned: bool): bool {
            return ActivityController.showActivity(
                activityId,
                title,
                detail,
                icon,
                progress,
                timeoutMs,
                priority,
                pinned
            );
        }

        function updateProgress(activityId: string, progress: real): bool {
            return ActivityController.updateProgress(activityId, progress);
        }

        function clearActivity(activityId: string): bool {
            return ActivityController.clearActivity(activityId);
        }

        function setExpanded(expanded: bool): bool {
            return ActivityController.setExpanded(expanded);
        }
    }
}
